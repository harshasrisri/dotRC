# Kanata Configuration

A keyboard remapping configuration using [Kanata](https://github.com/jtroo/kanata), a cross-platform software keyboard remapper written in Rust.

## Features

- **Tap-hold modifiers**: All number row and symbol keys have tap-hold functionality for quick access to shifted symbols
- **Navigation layer**: Dedicated layer with arrow keys, page navigation, and function keys accessible via Caps Lock hold
- **Tap-hold escape/control**: Space-efficient Esc/RCtrl combo on the right Alt position
- **Optimized for productivity**: Quick access to commonly used symbols and navigation without leaving home row

## Installation

### Setup Systemd Service (Recommended)

1. Create systemd service file at `~/.config/systemd/user/kanata.service`:
```ini
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Type=simple
ExecStart=/usr/bin/kanata --cfg %h/.config/kanata/config.kbd
Restart=on-failure
RestartSec=3

[Install]
WantedBy=default.target
```

Or for system-wide service at `/etc/systemd/system/kanata.service`:
```ini
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Type=simple
User=YOUR_USERNAME
ExecStart=/usr/bin/kanata --cfg /home/YOUR_USERNAME/.config/kanata/config.kbd
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
```

2. Enable and start the service:
```bash
# For user service
systemctl --user enable kanata
systemctl --user start kanata
systemctl --user status kanata

# For system service
sudo systemctl enable kanata
sudo systemctl start kanata
sudo systemctl status kanata
```

## Linux Permissions Setup

Kanata requires access to `/dev/input` and `/dev/uinput` to function.

### Step 1: Create uinput group

```bash
sudo groupadd uinput
```

### Step 2: Add your user to required groups

```bash
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
```

Verify group membership:
```bash
groups
```

You may need to log out and log back in for group changes to take effect.

### Step 3: Configure udev rules

Create a udev rule at `/etc/udev/rules.d/99-uinput.rules`:
```bash
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
```

Reload udev rules:
```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### Step 4: Load uinput kernel module

```bash
sudo modprobe uinput
```

To load automatically on boot, add to `/etc/modules-load.d/uinput.conf`:
```bash
echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
```

## Configuration Overview

### Default Layer

The default layer provides tap-hold functionality on the number row and symbol keys:

- **Tap**: Regular key (e.g., `1`, `[`, `;`)
- **Hold (222ms)**: Shifted version (e.g., `!`, `{`, `:`)

Special key positions:
- **Caps Lock**: Hold to activate Navigation layer
- **Right Alt position**: Tap for Esc, hold for Right Control

### Navigation Layer (NaviLay)

Activated by holding Caps Lock:

- **Function keys**: F1-F12 on number row
- **Arrow keys**: H, J, K, L positions (Vim-style) on home row
- **Page navigation**: Home, PgDn, PgUp, End on U, I, O, P positions

## Testing Your Configuration

### Interactive Testing

Run Kanata in the foreground to see debug output:
```bash
sudo kanata --cfg ~/.config/kanata/config.kbd
```

### Online Simulator

Test your configuration without running Kanata using the [online simulator](https://jtroo.github.io/).

### Useful Commands

```bash
# Check service status
systemctl --user status kanata

# View logs
journalctl --user -u kanata -f

# Reload configuration (restart service)
systemctl --user restart kanata

# Stop service
systemctl --user stop kanata
```

## Troubleshooting

### Kanata not intercepting keys

1. Verify your keyboard device path is correct in `config.kbd`
2. Check permissions: ensure you're in `input` and `uinput` groups
3. Verify uinput module is loaded: `lsmod | grep uinput`
4. Check service logs: `journalctl --user -u kanata -n 50`

### Keys not working as expected

1. Test with `sudo evtest /dev/input/by-id/YOUR-KEYBOARD` to see raw events
2. Use Kanata's verbose mode: `kanata --cfg config.kbd --debug`
3. Check for conflicting keyboard remappers (xcape, xmodmap, etc.)

### Permission denied errors

1. Ensure udev rules are properly configured
2. Verify group membership: `groups | grep -E "(input|uinput)"`
3. Log out and back in after adding groups
4. Check file permissions: `ls -l /dev/uinput`

### Service fails to start

1. Check configuration syntax: `kanata --cfg ~/.config/kanata/config.kbd --check`
2. Verify kanata binary path in service file
3. Ensure device file path is correct and accessible

## Migrating from KMonad

This configuration was converted from KMonad. Key differences:

- Kanata uses 4-parameter `tap-hold` syntax vs KMonad's 3-parameter
- `layer-toggle` in KMonad → `layer-while-held` in Kanata
- `tap-next` in KMonad → `tap-hold-press` in Kanata
- Compose key must be configured at system level, not in Kanata config

## Resources

- [Kanata GitHub Repository](https://github.com/jtroo/kanata)
- [Configuration Guide](https://github.com/jtroo/kanata/wiki/Configuration-guide)
- [Online Simulator](https://jtroo.github.io/)
- [Example Configurations](https://github.com/jtroo/kanata/tree/main/cfg_samples)
- [Comparison with KMonad](https://github.com/jtroo/kanata/blob/main/docs/kmonad_comparison.md)

## License

This configuration is provided as-is for personal use. Kanata is licensed under LGPL-3.0.
