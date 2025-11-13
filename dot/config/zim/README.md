# Zsh + Zim Configuration

Modern Zsh configuration managed by [Zim](https://github.com/zimfw/zimfw) framework with enhanced completions and FZF integration.

## Structure

```
zim/
├── zimrc                 # Zim module configuration
└── custom/
    ├── init.zsh          # Custom initialization
    └── zstyle.zsh        # FZF-tab styling and preview rules
```

Also see:
- [dot/zshrc](../../zshrc) - Main Zsh configuration
- [dot/myenv](../../myenv) - Custom aliases, functions, environment variables

## Zim Modules (zimrc)

### Core Modules
- **environment** - Sane Zsh built-in environment options
- **input** - Correct bindkeys for input events
- **termtitle** - Custom terminal title
- **completion** - Smart and extensive tab completion

### Enhancement Plugins
- **[fzf-tab](https://github.com/Aloxaf/fzf-tab)** - FZF-powered completions with tmux popups
- **[F-Sy-H](https://github.com/z-shell/F-Sy-H)** - Fast syntax highlighting
- **[zsh-completions](https://github.com/zsh-users/zsh-completions)** - Additional completion definitions
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** - Fish-like suggestions
- **[zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)** - Up-arrow history search
- **[zsh-autopair](https://github.com/hlissner/zsh-autopair)** - Auto-close brackets/quotes
- **[zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)** - Alias reminders

### Utilities
- **[powerlevel10k](https://github.com/romkatv/powerlevel10k)** - Fast, customizable theme
- **[ugit](https://github.com/Bhupesh-V/ugit)** - Interactive git undo operations
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smart directory jumping
- **fzf** - FZF integration and wrappers

## FZF-Tab Features

Powerful completion previews configured in [custom/zstyle.zsh](./custom/zstyle.zsh):

- **File/Directory previews** - Uses `fzf-tab-previewer` for smart file previews
- **Git command previews** - Shows diffs, logs, and help with syntax highlighting
- **Process previews** - Shows full command for `kill`/`ps` completions
- **Environment variable previews** - Shows variable contents
- **Tmux popup integration** - Completions appear in centered tmux popups
- **Directory previews** - Uses `eza` for colorized directory listings

### Optimization
- 40 line minimum height when not in tmux
- 240x160 popup size for tmux
- Disabled sorting for `git checkout` (faster)
- Group switching with `<` and `>`

## Custom Functions (myenv)

See [../../myenv](../../myenv) for the complete list. Highlights:

### File Navigation
- `fvi` - FZF file picker with preview, opens in editor
- `fcd` - FZF directory picker for navigation
- `fzp` - FZF file preview with bat

### Search
- `frg <pattern>` - Interactive ripgrep with FZF preview
- `frgv <pattern>` - Search and open results in editor

### Git
- `gri <n>` - Interactive rebase last n commits
- Extensive git aliases: `gl`, `gs`, `gd`, `gdf`, `glf`

### Tmux
- `tm <session>` - Quick session creation/attachment

### Neovim
- `nv` - Launch neovide GUI
- `nvr <host>` - Launch neovide connected to remote neovim over SSH

## Performance Features

- Optimized plugin loading order
- Syntax highlighting loads after completion
- History search loads after syntax highlighting
- Custom completion caching
- Fast theme rendering (powerlevel10k)

## Aliases & Environment

Key aliases and environment variables in [../../myenv](../../myenv):

- **Editor**: `nvim` (falls back to `vim`)
- **File listing**: `eza` (falls back to `exa`, then `ls`)
- **Cat**: `bat` with line numbers and git changes
- **FZF**: Custom defaults with preview window
- **Git**: Performance-optimized configuration

## Quick Access

- `.z` - Edit ~/.zshrc
- `.zm` - Edit zimrc (plugin configuration)
- `.me` - Edit myenv (aliases and functions)
- `.x` - Reload Zsh session

## Shell Options

Configured in [../../zshrc](../../zshrc) and Zim modules:

- Case-insensitive completion with smart matching
- Shared history across sessions
- No beep on errors
- Ignore window change events (performance)
- Optimized for fast startup
