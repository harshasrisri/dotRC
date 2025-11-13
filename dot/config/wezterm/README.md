# WezTerm Configuration

GPU-accelerated terminal emulator with modular Lua configuration optimized for performance and ergonomics.

## Structure

```
wezterm/
├── wezterm.lua           # Entry point - loads modules
├── oxide.toml            # Custom color scheme
└── lua/
    ├── ui.lua            # UI customization (status bar, tabs, colors)
    ├── keymap.lua        # Keybindings and leader key setup
    └── util.lua          # Helper functions
```

## Features

- **120 FPS rendering** for smooth scrolling and animations
- **Backtick (`) leader key** - consistent with tmux configuration
- **Dimming inactive panes** for better focus
- **Lazy-loaded Nerd fonts** for performance
- **Quick select patterns** for URLs, file paths, and git hashes
- **Custom tab bar** with slanted separators and status information
- **100k scrollback lines** for extensive history
- **Unix domain sockets** for multiplexing support

## Keybindings

### Leader Key
- **Backtick (`)** - Leader key (press twice to send backtick to terminal)
- Works seamlessly with tmux (backtick prefix)

### Split Management
- `` ` + | `` - Split horizontally
- `` ` + - `` - Split vertically
- `` ` + h/j/k/l `` - Navigate between panes
- `` ` + H/J/K/L `` - Resize panes

### Tab Management
- `` ` + c `` - Create new tab
- `` ` + n `` - Next tab
- `` ` + p `` - Previous tab
- `` ` + 1-9 `` - Jump to specific tab

### Other
- `` ` + z `` - Toggle zoom pane
- `` ` + x `` - Close pane
- Quick select mode for easy text selection

See [lua/keymap.lua](./lua/keymap.lua) for complete keybinding list.

## Performance Optimizations

- High refresh rate (120 FPS)
- Lazy font loading
- Efficient tab bar rendering with caching
- Optimized window title updates
- Minimal animation delays

## Color Scheme

Custom color scheme defined in [oxide.toml](./oxide.toml) with carefully selected colors for readability.

## Quick Access

Edit config from anywhere: `.w` (alias in [../../myenv](../../myenv))

Opens neovim in wezterm config directory with Snacks file picker ready.

## SSH Integration

WezTerm works seamlessly over SSH:
- Automatic detection of SSH sessions
- Clipboard integration works locally and remotely
- Leader key bindings work consistently
