# Global Agent Instructions

This file is symlinked to `~/.agents/AGENTS.md` and provides instructions to AI agents
running outside of any specific project context.

## Identity

`~/.agents/` is managed in the dotfiles repo (`~/.rc/dot/agents/`) and bootstrapped via `./setup`.
It contains shared hook scripts and lessons used by both Claude Code and Codex.

## Hook Scripts

Scripts in `~/.agents/scripts/` are invoked by the harness on hook events:

- `inject-lessons.sh` — `UserPromptSubmit`: injects global + project lessons into context
- `inject-todos.sh` — `UserPromptSubmit`: injects pending project todos into context
- `inject-tools.sh` — `SessionStart`: probes installed tool versions and injects the list into context (once per session)
- `inject-git-context.sh` — `SessionStart`: injects current branch, uncommitted file status, and recent commits (once per session)
- `remind-lessons.sh` — `Stop`: reminds agent to capture lessons before finishing
- `remind-todos.sh` — `Stop`: reminds agent to update todo status before finishing

## Global Lessons

`~/.agents/lessons/global.md` stores cross-project lessons from past corrections.
Append entries in the format: `- [pattern]: [what to do instead and why]`

## Per-Project Agent State

Each project may have a `.agents/` directory (gitignored by convention) containing:
- `.agents/todo.md` — persistent backlog across sessions
- `.agents/lessons.md` — project-specific lessons

See the project's `AGENTS.md` or `CLAUDE.md` for project-specific guidance.
