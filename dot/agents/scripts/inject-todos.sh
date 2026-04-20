#!/usr/bin/env bash
# Injects pending todos into agent context at session start.
# Reads <cwd>/.agents/todo.md if it exists and has unchecked items.
# Used by both Claude Code (UserPromptSubmit hook) and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null || true)
[[ -z "$cwd" ]] && exit 0

todo_file="$cwd/.agents/todo.md"

if [[ -f "$todo_file" && -s "$todo_file" ]]; then
  pending=$(grep -c '^[[:space:]]*- \[ \]' "$todo_file" 2>/dev/null || echo 0)
  if [[ "$pending" -gt 0 ]]; then
    msg=$'## Pending todos for this project ('"$pending"$' open):\n'
    msg+="$(head -100 "$todo_file")"$'\n\n'
    msg+="Review these todos. Mark items complete with [x] as you finish them. "
    msg+="Update $todo_file as work progresses."
    printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":%s}}' "$(printf '%s' "$msg" | jq -Rs .)"
  fi
fi
