# Utility Scripts

Collection of shell scripts for workflow automation, clipboard management, and FZF integration. All scripts are shellcheck-validated with proper error handling.

## Scripts Overview

### FZF Integration

#### fzf-tab-previewer
Smart file previewer for fzf-tab completions.

**Features:**
- Automatic MIME type detection
- Syntax highlighting via `bat` for text files
- Image dimensions and metadata display
- Archive content listing (zip, tar, etc.)
- PDF text extraction
- Binary file hex preview
- Size limits (10MB max) to prevent hanging
- Fallback handling for large/binary files

Used by fzf-tab for automatic preview generation.

### Clipboard Management

#### tmux-clipboard
Universal clipboard integration for tmux.

**Features:**
- **SSH-aware**: Detects SSH sessions and uses OSC 52 sequences
- **Cross-platform**: Works on macOS (pbcopy), Linux (xclip/xsel), and Wayland (wl-copy)
- **Seamless integration**: Set as tmux's `copy-command`
- **Fallback handling**: Uses OSC 52 when native clipboard unavailable

Referenced in [../config/tmux/tmux.conf](../config/tmux/tmux.conf:4).

### Git Utilities

#### gdtab
Opens git diffs in Neovim's Diffview plugin.

**Usage:**
```sh
gdtab              # View working directory changes
gdtab HEAD~1       # View changes in last commit
gdtab main..HEAD   # View range
```

Wrapper around `nvim "+DiffviewOpen"` with error checking.

### File Operations

#### swapmv
Atomically swap two files/directories.

**Usage:**
```sh
swapmv path1 path2
```

**Features:**
- Atomic operation with rollback on failure
- Secure temporary file handling
- Validates both paths exist
- Error messages at each step

#### rmbg
Delete large files/directories in background.

**Usage:**
```sh
rmbg file1 [file2...]
```

**How it works:**
1. Moves files to temporary directory (instant)
2. Deletes in background process
3. Returns immediately

Useful for large directories where `rm -rf` would block the terminal.

#### nvimdiff
Wrapper for nvim diff mode.

**Usage:**
```sh
nvimdiff file1 file2 [file3...]
```

Simple wrapper around `nvim -d` with error checking.

### Tmux Utilities

#### tmpp
Create tmux popup in current pane's directory.

**Usage:**
```sh
tmpp [command]
```

Creates centered popup (80% width/height) at current pane's working directory. Referenced in [../config/tmux/tmux.conf](../config/tmux/tmux.conf:65).

#### tmxception
Manage nested tmux sessions and popups.

Handles complex tmux nesting scenarios, allowing tmux within tmux popups.

Referenced in [../config/tmux/tmux.conf](../config/tmux/tmux.conf:64).

#### tabmux
Launch tabmux configuration (alternative tmux config).

Uses separate config file for tab-like tmux session management.

### SSH Utilities

#### sshnopass
Share SSH keys to remote server and create connection alias.

Automates SSH key setup for passwordless authentication.

#### vxd
Quick diff viewer utility.

Lightweight diff tool for quick comparisons.

## Error Handling

All scripts follow consistent error handling patterns:
- Input validation with usage messages
- Command availability checks
- Meaningful error messages to stderr
- Non-zero exit codes on failure
- Rollback on partial failures (where applicable)

## Shellcheck Compliance

All scripts have been validated and sanitized with shellcheck for:
- Quote safety
- Variable scoping
- Command existence checks
- Exit code handling
- POSIX compatibility (where applicable)

## Integration

These scripts integrate with:
- **fzf-tab**: Custom previewer for completions
- **tmux**: Clipboard and popup management
- **neovim**: Git diff viewing
- **zsh**: Custom functions in [../myenv](../myenv)

## Quick Access

Scripts are in `$PATH` via `~/.local/bin` and can be called directly from the shell.
