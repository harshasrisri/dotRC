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
- [Yaml config](./dot/config/alacritty/alacritty.yml) for the simple and minimilastic [Alacritty](https://github.com/alacritty/alacritty) terminal emulator.
- Zsh is managed by [Zim](https://github.com/zimfw/zimfw) framework. 
    - Plugins are listed in [zimrc](./dot/zimrc)
    - [My config](./dot/zim/modules/custom) containing useful aliases/functions/environment variables.
    - [Zstyle rules](./dot/zim/modules/custom/zstyle.zsh) for [fzf-tab](https://github.com/Aloxaf/fzf-tab), a zsh wrapper integrating autocompletion, fzf and tmux popups
- Tmux is managed by [TPM](https://github.com/tmux-plugins/tpm). Config is split into 2 parts:
    - [tmux.conf](./dot/tmux.conf) is my primary config for single sessions.
    - [tabmux.conf](./dot/tabmux.conf) is my higher level config used to simulate terminal tabs by nesting single sessions.
- [My Vim config](./dot/vim) managed by [vim-plug](https://github.com/junegunn/vim-plug) - not used much anymore.
- My hand-tuned [Neovim config](./dot/config/nvim) managed by [packer.nvim](https://github.com/wbthomason/packer.nvim)
    - On demand plugin loading
    - Pre-compiled and cached configs
    - LSP and TreeSitter aware setup
    - Mainly used to work with C++/Rust
    - Loads in ~15ms on a 11th Gen i7 (Linux) / ~40ms on a 2019 Macbook Pro
- [KMonad](https://github.com/kmonad/kmonad) config to define custom keyboard layouts and overlapping layers like QMK firmware.
    - Keeping it close to the [config](https://configure.zsa.io/ergodox-ez/layouts/L5RJR/latest/0) of my [ErgodoxEZ](https://ergodox-ez.com).
- Various small [utility scripts](./bin).
