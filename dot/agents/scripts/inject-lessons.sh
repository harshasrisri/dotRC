#!/usr/bin/env bash
# Injects lessons content into agent context at session start.
# Reads ~/.agents/lessons/global.md and <cwd>/.agents/lessons.md if they exist.
# Used by both Claude Code (UserPromptSubmit hook) and Codex.

set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // ""' 2>/dev/null || true)

global_lessons="$HOME/.agents/lessons/global.md"

msg=""

if [[ -f "$global_lessons" && -s "$global_lessons" ]]; then
  msg+=$'## Global lessons from past sessions:\n'
  msg+="$(head -100 "$global_lessons")"$'\n\n'
fi

if [[ -n "$cwd" && -f "$cwd/.agents/lessons.md" && -s "$cwd/.agents/lessons.md" ]]; then
  msg+=$'## Project-specific lessons for this repo:\n'
  msg+="$(cat "$cwd/.agents/lessons.md")"$'\n\n'
fi

if [[ -n "$msg" ]]; then
  msg+="Apply these lessons proactively throughout this session."
  printf '{"systemMessage": %s}' "$(printf '%s' "$msg" | jq -Rs .)"
fi
