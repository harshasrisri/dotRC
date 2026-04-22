# Global Agent Lessons

Cross-project patterns learned from corrections. Format: `- [pattern]: [rule and why]`

<!-- Add entries below as they accumulate -->

- [macOS compatibility]: macOS is the primary dev env. Always use macOS-compatible commands — avoid grep -P (use grep -E or rg), avoid GNU-only flags. macOS ships BSD coreutils with different options. Homebrew paths differ on ARM (/opt/homebrew) vs Intel (/usr/local).
- [MR review workflow]: When reviewing MRs, fetch diff from remote (glab mr diff, GitLab API) — never assume the branch is checked out locally. Use sub-agents for parallel file-level review of large diffs.
