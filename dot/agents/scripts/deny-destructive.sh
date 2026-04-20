#!/usr/bin/env bash
# PreToolUse hook: hard-block known destructive Bash commands.
# Only inspects Bash tool calls; all other tools pass through silently.
# On deny: emits JSON with permissionDecision=deny and a reason.
# On pass: exits 0 with no output (falls through to allow-list / plan-mode).
# On error (jq missing, parse failure): exits 0 silently — safe passthrough.
# Uses only POSIX ERE (grep -E), compatible with macOS and Linux.
# Used by Claude Code.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // ""' 2>/dev/null || true)

# Only inspect Bash calls
[[ "$tool" == "Bash" ]] || exit 0

cmd=$(echo "$input" | jq -r '.tool_input.command // ""' 2>/dev/null || true)
[[ -n "$cmd" ]] || exit 0

deny() {
  local reason="$1"
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny"},"reason":%s}' \
    "$(printf '%s' "$reason" | jq -Rs .)"
  exit 0
}

SP='[[:space:]]'   # whitespace character class
SEP="(^|[|;&${SP}])"  # command separator: start, pipe, semicolon, ampersand, or space

# ── Catastrophic recursive deletes ──────────────────────────────────────────
# Matches: rm -rf /, rm -fr ~/, rm -rf ., rm -rf /*, etc.
if echo "$cmd" | grep -qE "${SEP}rm${SP}+(-[a-zA-Z]*f[a-zA-Z]*r[a-zA-Z]*|-[a-zA-Z]*r[a-zA-Z]*f[a-zA-Z]*)${SP}+(/${SP}*$|~\/?${SP}*$|\.${SP}*$|\/\*|~\/\*)"; then
  deny "Blocked: rm -rf on / ~ . or /* is catastrophic"
fi

# ── Device writes via dd ─────────────────────────────────────────────────────
if echo "$cmd" | grep -qE "${SEP}dd${SP}" && echo "$cmd" | grep -qE 'of=/dev/'; then
  deny "Blocked: dd with of=/dev/... writes directly to a device"
fi

# ── Filesystem/partition tools ───────────────────────────────────────────────
# mkfs may appear as mkfs, mkfs.ext4, mkfs.vfat, etc.
if echo "$cmd" | grep -qE "${SEP}(mkfs[. ]|fdisk${SP}|parted${SP})"; then
  deny "Blocked: command uses a partition/filesystem tool"
fi

# ── Recursive permission/ownership nukes ────────────────────────────────────
if echo "$cmd" | grep -qE "${SEP}chmod${SP}+-R${SP}+777"; then
  deny "Blocked: chmod -R 777 removes all access control"
fi
if echo "$cmd" | grep -qE "${SEP}chown${SP}+-R${SP}"; then
  deny "Blocked: chown -R changes ownership recursively"
fi

# ── Destructive git ops ──────────────────────────────────────────────────────
# Force push to main/master
if echo "$cmd" | grep -qE "${SEP}git${SP}+push${SP}+.*(--force|-f)${SP}" && \
   echo "$cmd" | grep -qE "${SP}(main|master)${SP}*$"; then
  deny "Blocked: force push to main/master — use a feature branch"
fi
if echo "$cmd" | grep -qE "${SEP}git${SP}+push${SP}+.*--force-with-lease${SP}" && \
   echo "$cmd" | grep -qE "${SP}(main|master)${SP}*$"; then
  deny "Blocked: force-with-lease push to main/master"
fi
# Hard reset
if echo "$cmd" | grep -qE "${SEP}git${SP}+reset${SP}+--hard"; then
  deny "Blocked: git reset --hard discards uncommitted changes"
fi
# Clean (delete untracked files) — allow -n (dry-run) and -e (exclude patterns)
if echo "$cmd" | grep -qE "${SEP}git${SP}+clean${SP}+-[a-zA-Z]*[fdx]"; then
  deny "Blocked: git clean -fd/-xfd deletes untracked files"
fi
# Discard all changes
if echo "$cmd" | grep -qE "${SEP}git${SP}+checkout${SP}+--${SP}+\."; then
  deny "Blocked: git checkout -- . discards all working tree changes"
fi
if echo "$cmd" | grep -qE "${SEP}git${SP}+restore${SP}+\."; then
  deny "Blocked: git restore . discards all working tree changes"
fi

# ── Piped execution from network ─────────────────────────────────────────────
if echo "$cmd" | grep -qE "\|${SP}*(bash|sh|zsh|fish)${SP}*$"; then
  deny "Blocked: piping into a shell — unsafe remote execution"
fi

# ── Fork bomb ────────────────────────────────────────────────────────────────
# Match core structural pattern regardless of spacing
if echo "$cmd" | grep -qE ":\(\)\{${SP}*:${SP}*\|"; then
  deny "Blocked: fork bomb pattern detected"
fi

# ── System power/state control ───────────────────────────────────────────────
# Match with optional trailing space or end-of-string (bare command with no args)
if echo "$cmd" | grep -qE "${SEP}(shutdown|reboot|halt|poweroff)(${SP}|$)"; then
  deny "Blocked: system control command"
fi

# ── SQL destructive statements ───────────────────────────────────────────────
if echo "$cmd" | grep -qiE "(DROP${SP}+(TABLE|DATABASE)|TRUNCATE${SP}+TABLE)"; then
  deny "Blocked: destructive SQL statement in command"
fi

exit 0
