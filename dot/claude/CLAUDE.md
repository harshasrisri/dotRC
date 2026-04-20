## Workflow Orchestration

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction from the user: update `.agents/lessons.md` with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes - don't over-engineer
- Challenge your own work before presenting

### 6. Autonomous Bug Fixing
- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests - then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

### 7. Offload Large External Payloads
- For MCP/CLI queries likely to return >100 lines (Slack threads, Jira tickets, Outlook email, SharePoint docs, MR/pipeline output), use a subagent to fetch and extract
- The subagent returns a structured block — key facts, IDs, decisions, and verbatim quotes for any ambiguous parts — not a lossy prose summary
- If re-querying the source may be needed, write the full extraction to `.session/extraction-<slug>.md` and read sections on demand via `Read` with offset/limit
- Main context only receives the structured output
- In the same vein, try to use pre-existing command line tools like JQ instead of writing ad-hoc Python scripts.
    - Check for other similar tools that could make the job easier or do the task better.
    - Ask for it to be installed and made available if not already present.

### Context Efficiency
- When running bash commands, pipe output through grep/head/tail where possible
- Use Read with offset/limit instead of reading entire large files

## Task Management

1. **Plan First**: Write plan to `.agents/todo.md` with checkable items
2. **Verify Plan**: Check before starting implementation
3. **Track Progress**: Mark items complete as you go
4. **Explain Changes**: High-level summary at each step
5. **Document Results**: Add review section to `.agents/todo.md`
6. **Capture Lessons**: Update `.agents/lessons.md` after corrections

### Todo Tracking

Persistent todos (backlog items that survive across sessions) live in `<project>/.agents/todo.md`.
Ephemeral session tasks (work breakdown for the current session) use built-in task tracking tools.

- All persistent agent state goes in `<project>/.agents/` (gitignored by convention)
- Todos in `.agents/todo.md`, lessons in `.agents/lessons.md` — flat, no subdirectories
- Create `.agents/` on first write if it doesn't exist (`mkdir -p .agents`)
- When reading `.md` documentation files, if you find actionable items not already tracked → append to `.agents/todo.md` under `## Discovered` (skip code files, check for duplicates first)
- Format discovered items as: `- [ ] description`
- Don't interrupt current work to do this — append quickly and continue

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.
- **Uncertainty is valid**: "I don't know" is always a valid answer, preferred over confident guesses.

## New Machine Setup

`~/.agents/` is managed in dotfiles (`dot/agents/`) — bootstrapped automatically via `./setup`.
It contains shared scripts and lessons used by both CC and Codex.

`~/.claude/settings.json` is not in dotfiles (contains work-specific auth/endpoints).
After bootstrapping, add the hooks block pointing to `~/.agents/scripts/`:

```json
"hooks": {
  "UserPromptSubmit": [
    {
      "matcher": "*",
      "hooks": [
        {"type": "command", "command": "bash ~/.agents/scripts/inject-lessons.sh", "timeout": 10},
        {"type": "command", "command": "bash ~/.agents/scripts/inject-todos.sh", "timeout": 10}
      ]
    }
  ],
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {"type": "command", "command": "bash ~/.agents/scripts/deny-destructive.sh", "timeout": 5}
      ]
    }
  ],
  "Stop": [
    {
      "matcher": "*",
      "hooks": [
        {"type": "command", "command": "bash ~/.agents/scripts/remind-lessons.sh", "timeout": 10},
        {"type": "command", "command": "bash ~/.agents/scripts/remind-todos.sh", "timeout": 10}
      ]
    }
  ]
}
```

`deny-destructive.sh` — a `PreToolUse` hook that hard-blocks destructive Bash patterns
(`rm -rf /~.`, `git reset --hard`, `git push --force` to main/master, `dd of=/dev/`, piped
execution, fork bombs, SQL `DROP/TRUNCATE`, system power commands). Safe-by-default: a script
failure results in passthrough to `defaultMode: "plan"` approval, not auto-allow.

Also add the following `permissions` block manually after bootstrapping:

```json
"permissions": {
  "allow": [
    "Read",
    "Glob",
    "Grep",
    "Bash(ls:*)", "Bash(ls)", "Bash(pwd)", "Bash(cd:*)",
    "Bash(find:*)", "Bash(cat:*)", "Bash(head:*)", "Bash(tail:*)",
    "Bash(wc:*)", "Bash(echo:*)", "Bash(which:*)", "Bash(type:*)",
    "Bash(file:*)", "Bash(stat:*)", "Bash(du:*)", "Bash(df:*)",
    "Bash(env)", "Bash(printenv:*)", "Bash(uname:*)", "Bash(date)",
    "Bash(whoami)", "Bash(id)",
    "Bash(git status)", "Bash(git log:*)", "Bash(git diff:*)",
    "Bash(git show:*)", "Bash(git branch:*)", "Bash(git remote:*)",
    "Bash(git stash list)", "Bash(git ls-files:*)",
    "Bash(jq:*)", "Bash(python3 -m json.tool:*)", "Bash(python3 -c:*)",
    "Bash(yq:*)", "Bash(rg:*)", "Bash(fzf:*)", "Bash(bat:*)",
    "Bash(eza:*)", "Bash(fd:*)", "Bash(delta:*)"
  ]
}
```
