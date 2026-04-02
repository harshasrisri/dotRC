#!/usr/bin/env bash
# Fires on Stop event. Reminds agent to capture lessons if corrections were made.
# Used by both Claude Code and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null || true)

global_lessons="$HOME/.agents/lessons/global.md"

if [[ -n "$cwd" ]]; then
  project_lessons="$cwd/.agents/lessons.md"
  msg="Before finishing: if you received any corrections or changed approach during this session, "
  msg+="append the lesson to $project_lessons (project-specific) or $global_lessons (general/cross-project). "
  msg+="Format: '- [pattern]: [what to do instead and why]'. Skip if no corrections were made."
else
  msg="Before finishing: if you received any corrections or changed approach during this session, "
  msg+="append the lesson to $global_lessons (general/cross-project). "
  msg+="Format: '- [pattern]: [what to do instead and why]'. Skip if no corrections were made."
fi

printf '{"decision": "approve", "systemMessage": %s}' "$(printf '%s' "$msg" | jq -Rs .)"
