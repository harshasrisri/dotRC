#!/usr/bin/env bash
# Fires on Stop event. Reminds agent to update task status before finishing.
# Used by both Claude Code and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null || true)

if [[ -n "$cwd" ]]; then
  todo_file="$cwd/.agents/todo.md"
  if [[ -f "$todo_file" ]]; then
    msg="Before finishing: update $todo_file — mark completed items with [x], "
    msg+="add any newly discovered todos under '## Discovered', "
    msg+="and note any blocked items."
  else
    msg="Before finishing: if this session involved substantial work, "
    msg+="consider creating $todo_file to track pending items for next time. "
    msg+="Use sections: '## Current', '## Discovered', '## Done'."
  fi
else
  msg="Before finishing: if this session involved substantial work, "
  msg+="consider creating .agents/todo.md in the project directory to track pending items. "
  msg+="Use sections: '## Current', '## Discovered', '## Done'."
fi

printf '{"decision": "approve", "systemMessage": %s}' "$(printf '%s' "$msg" | jq -Rs .)"
