# dotRC

My shell environment to setup and manage my CLI IDE.

![Screenshot](screenshot.png)

## How do I get it?

```sh
git clone http://github.com/harshasrisri/dotRC.git ~/.rc
cd ~/.rc
./setup
```

Running `./setup` does the following:
1. Clones / updates this repository if possible/necessary.
2. Makes links to the various [dot files](dot) in the $HOME directory.
3. Installs plugin managers and plugins for each vim, neovim and tmux.

Needless to say, please Backup whatever is important.

## What's in the package?
- [Lua config](./dot/config/wezterm/wezterm.lua) for [Wezterm](https://github.com/wez/wezterm) terminal emulator.
- Zsh is managed by [Zim](https://github.com/zimfw/zimfw) framework.
    - Plugins are listed in [zimrc](./dot/config/zim/zimrc)
    - [My config](./dot/config/zim/custom) containing useful aliases/functions/environment variables.
    - [Zstyle rules](./dot/config/zim/custom/zstyle.zsh) for [fzf-tab](https://github.com/Aloxaf/fzf-tab), a zsh wrapper integrating autocompletion, fzf and tmux popups
- Tmux is managed by [TPM](https://github.com/tmux-plugins/tpm). [tmux.conf](./dot/config/tmux/tmux.conf) is my primary config for single sessions.
- [My Vim config](./dot/config/vim) managed by [vim-plug](https://github.com/junegunn/vim-plug) - not used much anymore.
- My hand-tuned [Neovim config](./dot/config/nvim) managed by [lazy.nvim](https://github.com/folke/lazy.nvim)
    - On demand plugin loading
    - LSP and TreeSitter aware setup
    - Mainly used to work with C++/Rust
- [KMonad](https://github.com/kmonad/kmonad) config to define custom keyboard layouts and overlapping layers like QMK firmware.
- Various small [utility scripts](./bin).
