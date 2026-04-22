#!/usr/bin/env bash
# Injects git repository context into agent context at session start.
# Uses pwd (SessionStart provides no cwd) — works when Claude is launched
# from within a git repo. Silent no-op if not in a git repo.
# Used by both Claude Code (SessionStart hook) and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0
command -v git >/dev/null 2>&1 || exit 0

# Must be inside a git repo
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
repo_name=$(basename "$repo_root")
branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "detached")

# Uncommitted changes summary (porcelain for reliable parsing)
status_lines=$(git status --short 2>/dev/null)
if [[ -n "$status_lines" ]]; then
  changed_count=$(echo "$status_lines" | wc -l | tr -d ' ')
  status_summary="$changed_count uncommitted file(s)"$'\n'"$(echo "$status_lines" | head -10)"
else
  status_summary="clean (no uncommitted changes)"
fi

# Recent commits
recent_commits=$(git log --oneline -5 2>/dev/null || echo "(no commits)")

msg=$'## Git context:\n'
msg+="- repo: $repo_name ($repo_root)"$'\n'
msg+="- branch: $branch"$'\n'
msg+="- status: $status_summary"$'\n'
msg+=$'- recent commits:\n'
msg+="$(echo "$recent_commits" | sed 's/^/  /')"$'\n'

printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":%s}}' \
  "$(printf '%s' "$msg" | jq -Rs .)"
