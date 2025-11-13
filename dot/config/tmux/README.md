# Tmux Configuration

Terminal multiplexer configuration with WezTerm-aligned keybindings and SSH-aware clipboard integration.

## Features

- **Backtick (`) prefix key** - ergonomic and consistent with WezTerm leader
- **WezTerm-style splits and resize** - familiar muscle memory across tools
- **SSH-aware clipboard** via custom [tmux-clipboard](../../local/bin/tmux-clipboard) script
- **50k line history** for extensive scrollback
- **Mouse support** with enhanced interaction
- **Vi-mode copy/paste** with visual selection
- **Auto-renumber windows** for clean numbering
- **Truecolor support** for modern color schemes

## Keybindings

### Prefix Key
- **Backtick (`)** - Prefix key (press twice to send backtick to terminal)
- `` ` + r `` - Reload tmux config

### Split Management
Enter split mode with `` ` + s ``, then:
- **k** - Split above current pane
- **j** - Split below current pane
- **h** - Split left of current pane
- **l** - Split right of current pane
- **K/J/H/L** - Split full window (vertical/horizontal)

All splits preserve current working directory.

### Resize Mode
Enter resize mode with `` ` + r ``, then:
- **h/j/k/l** - Resize pane (repeatable)
- **Escape** - Exit resize mode

Resizes in increments of 5 lines/columns.

### Window Management
- `` ` + c `` - Create new window
- `` ` + n `` - Next window
- `` ` + p `` - Previous window
- `` ` + 1-9 `` - Jump to specific window
- `` ` + , `` - Rename window

### Copy Mode (Vi-style)
- `` ` + Escape `` - Enter copy mode
- **v** - Begin selection
- **V** - Select line
- **C-v** - Rectangle toggle
- **y** - Copy selection
- `` ` + p `` - Paste buffer

### Utilities
- `` ` + g `` - Synchronize panes (send commands to all panes)
- `` ` + o `` - Tmux popup (via [tmxception](../../local/bin/tmxception))
- `` ` + t `` - Temporary popup (via [tmpp](../../local/bin/tmpp))
- `` ` + z `` - Toggle pane zoom

## Configuration Details

### Terminal Settings
- Passthrough enabled for advanced features
- Clipboard integration via custom script
- 10ms escape time for fast response
- Window titles set to session name
- True color (24-bit) support

### Mouse Support
- Mouse mode enabled
- Click to select panes
- Drag to resize panes
- Scroll wheel for history

### SSH Integration

The clipboard integration works both locally and over SSH through the [tmux-clipboard](../../local/bin/tmux-clipboard) script, which:
- Detects SSH vs local sessions
- Routes clipboard operations appropriately
- Works with OSC 52 sequences for remote clipboard

## Quick Access

Edit config from anywhere: `.t` (alias in [../../myenv](../../myenv))

Opens neovim with tmux config ready to edit.

## Session Management

Use the `tm` function from [myenv](../../myenv):
```sh
tm <session_name>  # Create or attach to session
```

This provides automatic session creation/attachment with error handling.
