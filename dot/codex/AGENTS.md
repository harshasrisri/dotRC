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
Ephemeral session tasks (work breakdown for the current session) use built-in task tools.

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

`~/.codex/config.toml` and `~/.codex/settings.yaml` are not in dotfiles (contain work-specific auth/endpoints).

The hook scripts in `~/.agents/scripts/` are invoked by Codex automatically via its hook configuration.
Add the following to `~/.codex/settings.yaml` manually after bootstrapping:

```yaml
general:
  command_allowlist:
    # Directory navigation & listing
    - ls
    - pwd
    - cd
    - find
    - eza
    - fd
    # File reading
    - cat
    - head
    - tail
    - bat
    - file
    - stat
    - wc
    # Search
    - grep
    - rg
    - fzf
    # Data transformation (read-only)
    - jq
    - yq
    - python3 -m json.tool
    - python3 -c
    # System info
    - echo
    - which
    - type
    - env
    - printenv
    - uname
    - date
    - whoami
    - id
    - du
    - df
    # Git read-only
    - git status
    - git log
    - git diff
    - git show
    - git branch
    - git remote
    - git stash list
    - git ls-files
    # Formatting/display
    - delta
```
