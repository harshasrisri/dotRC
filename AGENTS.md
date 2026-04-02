# AGENTS.md

This file provides guidance to AI models/harnesses when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository (`~/.rc`). Files under `dot/` mirror the home directory structure and are symlinked into place.

Key mapping: `dot/` → `~/`
- `dot/zshrc` → `~/.zshrc`
- `dot/myenv` → `~/.myenv`
- `dot/myshrc` → `~/.myshrc`
- `dot/zshenv` → `~/.zshenv`
- `dot/config/` → `~/.config/`
- `dot/local/bin/` → `~/.local/bin/`

## Configuration Areas

### Shell (Zsh)
- **`dot/zshrc`** — Zsh options, history, zim init, autosuggestions, keybindings, p10k, zoxide
- **`dot/myenv`** — Env vars, PATH, aliases (ls/eza, git, fzf, bat), shell functions (`gri`, `tm`, `frg`, `frgv`, `wezcopy`, `nv`, `nvr`)
- **`dot/myshrc`** — Sources `~/.myenv` and `~/.myshrc.local`; deduplicates PATH
- **`dot/zshenv`** — Sets `skip_global_compinit=1`
- **`dot/config/zim/zimrc`** — Zim plugin list (fzf-tab, F-Sy-H, autosuggestions, history-substring-search, autopair, you-should-use, p10k, zoxide, ugit)
- **`dot/config/zim/custom/`** — Custom zim module: `init.zsh` (completions for gri/frg/frgv/tm), `zstyle.zsh` (fzf-tab preview config)

### Tmux
- **`dot/config/tmux/tmux.conf`** — Prefix is backtick. TPM with plugins: powerbreeze (colorscheme), sensible, pain-control, yank, logging, extrakto, thumbs, fzf, resurrect, continuum. Vi copy mode. Custom split mode (`prefix+s`) and resize mode (`prefix+r`). Popup helpers via `tmxception` and `tmpp` scripts.

### WezTerm (Lua)
- **`dot/config/wezterm/wezterm.lua`** — Entry point: loads `fancy_ui`, `keymap`, optional `local` module, handles `wezcopy` user-var event
- **`dot/config/wezterm/lua/ui_common.lua`** — Shared module: base config (font: IosevkaTerm Nerd Font, color scheme: Oxide from `oxide.toml`), tab styling, window title, status bar segments, SSH title parsing, CWD resolution
- **`dot/config/wezterm/lua/fancy_ui.lua`** — Fancy tab bar with custom format, left/right status via `ui_common`
- **`dot/config/wezterm/lua/retro_ui.lua`** — Alternate retro UI (currently commented out in `wezterm.lua`)
- **`dot/config/wezterm/lua/keymap.lua`** — Keybindings and quick-select patterns
- **`dot/config/wezterm/lua/util.lua`** — `basename`, `smart_cwd` utilities
- **`dot/config/wezterm/oxide.toml`** — Custom Oxide color scheme loaded at module level (cached)
- Local overrides: `dot/config/wezterm/lua/local.lua` (gitignored, not in repo)

### Neovim (Lua)
- **`dot/config/nvim/init.lua`** — Bootstraps lazy.nvim, loads `plugins/` directory, defers `autocmds` and `mappings` to `VeryLazy`
- **`dot/config/nvim/lua/settings.lua`** — Neovim options
- **`dot/config/nvim/lua/mappings.lua`** — Keymaps
- **`dot/config/nvim/lua/autocmds.lua`** — Autocommands
- **`dot/config/nvim/lua/plugins/`** — Plugin specs split by category: `code.lua`, `lsp.lua`, `dap.lua`, `ui.lua`, `editor.lua`, `util.lua`
- **`dot/config/nvim/lazy-lock.json`** — Locked plugin versions (commit this when updating plugins)
- Plugin manager: lazy.nvim. Notable plugins: snacks.nvim (picker), blink.cmp, LSP via mason, rustaceanvim, go.nvim, copilot + CopilotChat, nvim-dap, treesitter, lualine, noice.

### Scripts (`dot/local/bin/`)
- `tmxception` — Tmux popup session manager
- `tmpp` — Tmux popup helper
- `tmux-clipboard` — Universal clipboard (local/remote/SSH via OSC 52)
- `fzf-tab-previewer` — Preview handler for fzf-tab completions
- `gdtab`, `nvimdiff`, `swapmv`, `rmbg`, `sshnopass`, `ssh-keepalive`, `vxd` — Utility scripts (all shellcheck-compliant)

### Other
- **`dot/config/git/config`** — Git config (performance flags, aliases)
- **`dot/config/kmonad/`** — KMonad keyboard remapping config + systemd service
- **`dot/config/vim/vimrc`** — Legacy vim config

## Working with AI

- Make small edits directly if there are no uncommitted changes; otherwise confirm first.
- Keep commits small and tool-specific (one config area per commit).
- Machine-specific or work-specific config lives in `~/.myshrc.local` and `~/.config/git/config.local` — never committed.
- Primary languages: C++, Rust, Go, Python, Shell.

## Local Docs Cache

`.docs/` (gitignored) stores fetched documentation for offline reference. Before fetching external docs, check if they're already cached here. When fetching new docs for a tool, save them to `.docs/<toolname>.md` for reuse across sessions.

## Session Context

`.session/` (gitignored) stores session summaries across AI sessions:
- `.session/dotrc-session.md` — Running log of what has been reviewed/changed
- Update this file when making significant changes so future sessions can resume quickly

## Agent State

`.agents/` (gitignored by convention) stores per-project persistent agent state:
- `.agents/todo.md` — Persistent backlog (survives across sessions). Use sections `## Current`, `## Discovered`, `## Done`.
- `.agents/lessons.md` — Project-specific lessons from past corrections.
- Create on first write: `mkdir -p .agents`
- Global lessons (cross-project) live in `~/.agents/lessons/global.md` (tracked in dotfiles via `dot/agents/lessons/global.md`)

## Setup

To bootstrap on a new machine:
```sh
git clone <repo> ~/.rc && cd ~/.rc && ./setup
```

`./setup` — pulls latest, symlinks all tracked files under `dot/` to `~/`, checks dependencies (git zsh nvim rg fzf bat eza tmux vim fd delta zoxide jq).

`./setup clean` — dry-run scan for stale symlinks pointing into `dot/` but no longer tracked by git.

`./setup clean --force` — actually removes stale symlinks.

Required tools (checked by setup): `git zsh nvim rg fzf bat eza tmux vim fd delta zoxide jq`

## Testing Changes

| Config | How to reload |
|--------|--------------|
| Zsh (`dot/zshrc`, `dot/myenv`, etc.) | `.x` (alias for `exec zsh -l`) or open new shell |
| Tmux (`dot/config/tmux/tmux.conf`) | `<prefix>R` inside tmux |
| WezTerm (`dot/config/wezterm/`) | Auto-reloads on save |
| Neovim (`dot/config/nvim/`) | Restart nvim |
| New zim plugins | `zimfw install` after editing `zimrc` |

## Validation

- Shell scripts: `shellcheck <file>`
- WezTerm Lua syntax: `wezterm --config-file ~/.config/wezterm/wezterm.lua --version`
- Neovim plugins: `:Lazy sync` inside nvim

## Commits

Freeform messages, kept small and tool-specific (e.g. one commit per config area: zsh, tmux, wezterm, nvim).
