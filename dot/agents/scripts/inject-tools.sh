#!/usr/bin/env bash
# Injects available dev tool names and versions into agent context at session start.
# Probes a fixed set of tools via `command -v` + `--version`/`version`.
# Output lets the agent know what's installed and at what version, avoiding
# unnecessary round-trips to check availability or capability.
# Used by both Claude Code (SessionStart hook) and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

# Helper: get first line of version output.
# Tries --version, then -V, then version subcommand.
# Returns empty string if the tool is not found.
tool_version() {
  local name="$1"
  local path
  path=$(command -v "$name" 2>/dev/null) || return 0
  local ver
  # Special cases for tools with non-standard version flags
  case "$name" in
    kubectl)  ver=$("$name" version --client --short 2>/dev/null | head -1 \
                || "$name" version --client 2>/dev/null | grep -E 'Client' | head -1 \
                || echo "(installed, version unknown)") ;;
    *)        ver=$("$name" --version 2>/dev/null | head -1) \
                || ver=$("$name" version 2>/dev/null | head -1) \
                || ver="(installed, version unknown)" ;;
  esac
  printf '%s' "${ver:-(installed, version unknown)}"
}

# Tools to probe: search/file, data, git tooling, languages, infra, editors
declare -a TOOLS=(
  # Search & file navigation
  rg fd fzf bat eza delta
  # Data transformation
  jq yq
  # Git & hosting CLIs
  git glab gh
  # Languages & runtimes
  python3 go node ruby
  # Infra / cloud
  kubectl terraform helm aws
  # Editors / multiplexers
  nvim
  # Shell
  zsh bash
)

lines=""
for t in "${TOOLS[@]}"; do
  ver=$(tool_version "$t")
  [[ -z "$ver" ]] && continue
  lines+="- $t: $ver"$'\n'
done

[[ -z "$lines" ]] && exit 0

msg=$'## Available dev tools (confirmed installed):\n'
msg+="$lines"
msg+=$'\nPrefer these over ad-hoc scripts. Check version before assuming feature availability.'

printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":%s}}' \
  "$(printf '%s' "$msg" | jq -Rs .)"
