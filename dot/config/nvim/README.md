# Neovim Configuration

<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/plugin-manager?style=for-the-badge" /></a>

Modern Neovim setup with LSP, TreeSitter, and lazy-loaded plugins optimized for fast startup.

## Structure

```
nvim/
├── init.lua              # Entry point - loads settings, lazy.nvim, plugins
├── lua/
│   ├── settings.lua      # Core vim options and settings
│   ├── mappings.lua      # Key mappings
│   ├── autocmds.lua      # Autocommands (refactored)
│   └── plugins/          # Modular plugin specs
│       ├── code.lua      # Coding tools (Copilot, CopilotChat)
│       ├── dap.lua       # Debug Adapter Protocol
│       ├── editor.lua    # Editing enhancements
│       ├── lsp.lua       # Language Server Protocol
│       ├── ui.lua        # UI components (Snacks.nvim)
│       └── util.lua      # Utility plugins
```

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) with lazy loading and automatic updates
- **LSP**: Full language server support with diagnostics, completion, and code actions
- **TreeSitter**: Advanced syntax highlighting and code navigation
- **Debugging**: nvim-dap with UI for Go, Python, and Rust
- **AI Pair Programming**: GitHub Copilot with interactive chat
- **Git Integration**: Gitsigns, diffview, and git commands
- **Fast Startup**: Disabled unused plugins, lazy-loaded configs

## Quick Access

Edit config from anywhere: `.n` (alias in [../../myenv](../../myenv))

Opens neovim in config directory with Snacks file picker ready.

## Standalone Installation

```sh
curl https://downgit.github.io/#/home?url=https://github.com/harshasrisri/dotRC/tree/main/dot/config/nvim -o ~/Downloads/harshasrisri-nvim.zip
unzip ~/Downloads/harshasrisri-nvim.zip -d ~/.config/harshasrisri-nvim
alias nvim='NVIM_APPNAME=harshasrisri-nvim nvim'
```

## List of Plugins
<!-- `> sh plugin-info.sh 2>/dev/null` -->

<!-- BEGIN mdsh -->
| Plugin | Description |
| ------                                                                                        | -----------                                                                                                                                               |
| [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim)                       | Fully customizable previewer for LSP code actions.                                                                                                        |
| [barbecue.nvim](https://github.com/utilyre/barbecue.nvim)                                     | Visual Studio Code inspired breadcrumbs plugin for the Neovim editor                                                                                      |
| [blink.cmp](https://github.com/saghen/blink.cmp)                                              | Performant, batteries-included completion plugin for Neovim                                                                                               |
| [ccls.nvim](https://github.com/ranjithshegde/ccls.nvim)                                       | Neovim plugin for ccls language server. Leverages off-spec extensions to  LSP client with AST browser                                                     |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua)                                      | Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot                                               |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)                         | Chat with GitHub Copilot in Neovim                                                                                                                        |
| [decorated_yank](https://github.com/simondrake/decorated_yank)                                | decorated yank plugin for neovim                                                                                                                          |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim)                                    | Single tabpage interface for easily cycling through diffs for all modified files for any git rev.                                                         |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)                          | Set of preconfigured snippets for different languages.                                                                                                    |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                   | Git integration for buffers                                                                                                                               |
| [go.nvim](https://github.com/ray-x/go.nvim)                                                   | G'day Nvimer, Joyful Gopher: Explore the Feature-Packed Go Plugin for Neovim                                                                              |
| [hererocks](https://github.com/luarocks/hererocks)                                            | Python script for installing Lua/LuaJIT and LuaRocks into a local directory                                                                               |
| [iswap.nvim](https://github.com/mizlan/iswap.nvim)                                            | Interactively select and swap function arguments, list elements, and much more. Powered by tree-sitter.                                                   |
| [kanagawa-paper.nvim](https://github.com/sho-87/kanagawa-paper.nvim)                          |                                                                                                                                                           |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                               | 💤 A modern plugin manager for Neovim                                                                                                                     |
| [leap.nvim](https://github.com/ggandor/leap.nvim)                                             | Neovim's answer to the mouse 🦘                                                                                                                           |
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim)                                       | A Neovim plugin enabling you to solve LeetCode problems.                                                                                                  |
| [lspkind-nvim](https://github.com/onsails/lspkind-nvim)                                       |                                                                                                                                                           |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                                  | A blazing fast and easy to configure neovim statusline plugin written in pure lua.                                                                        |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)                      | markdown preview plugin for (neo)vim                                                                                                                      |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)                     | Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.                                                                            |
| [mason.nvim](https://github.com/mason-org/mason.nvim)                                         | Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.        |
| [mini.ai](https://github.com/echasnovski/mini.ai)                                             |                                                                                                                                                           |
| [mini.align](https://github.com/echasnovski/mini.align)                                       |                                                                                                                                                           |
| [mini.comment](https://github.com/echasnovski/mini.comment)                                   |                                                                                                                                                           |
| [noice.nvim](https://github.com/folke/noice.nvim)                                             | 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.                                                    |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim)                                           | UI Component Library for Neovim.                                                                                                                          |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                                    | autopairs for neovim written in lua                                                                                                                       |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap)                                          | Debug Adapter Protocol client implementation for Neovim                                                                                                   |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)                                          | An extension for nvim-dap providing configurations for launching go debugger (delve) and debugging individual tests                                       |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)                            | Mirror of https://codeberg.org/mfussenegger/nvim-dap-python                                                                                               |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)                                        | A UI for nvim-dap                                                                                                                                         |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)                   |                                                                                                                                                           |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                    | Quickstart configs for Nvim LSP                                                                                                                           |
| [nvim-navic](https://github.com/SmiteshP/nvim-navic)                                          | Simple winbar/statusline plugin that shows your current code context                                                                                      |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                | Clipboard manager neovim plugin with telescope integration                                                                                                |
| [nvim-nio](https://github.com/nvim-neotest/nvim-nio)                                          | A library for asynchronous IO in Neovim                                                                                                                   |
| [nvim-spider](https://github.com/chrisgrieser/nvim-spider)                                    | Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.                                                               |
| [nvim-surround](https://github.com/kylechui/nvim-surround)                                    | Add/change/delete surrounding delimiter pairs with ease. Written with :heart: in Lua.                                                                     |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                         | Nvim Treesitter configurations and abstraction layer                                                                                                      |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) |                                                                                                                                                           |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                           | Provides Nerd Font icons (glyphs) for use by neovim plugins                                                                                               |
| [nvim-window](https://github.com/yorickpeterse/nvim-window)                                   | Easily jump between NeoVim windows.                                                                                                                       |
| [outline.nvim](https://github.com/hedyhli/outline.nvim)                                       | Navigate code with an outline sidebar. Forked from symbols-outline.nvim.                                                                                  |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                                      | plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.                                                |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)                                        | 🦀 Supercharge your Rust experience in Neovim! A heavily modified fork of rust-tools.nvim                                                                 |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                           | 🍿 A collection of QoL plugins for Neovim                                                                                                                 |
| [sqlite.lua](https://github.com/tami5/sqlite.lua)                                             |                                                                                                                                                           |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                            | Find, Filter, Preview, Pick. All lua, all the time.                                                                                                       |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)                                 | A neovim lua plugin to help easily manage multiple terminal windows                                                                                       |
| [treesj](https://github.com/wansmer/treesj)                                                   | Neovim plugin for splitting/joining blocks of code                                                                                                        |
| [vim-illuminate](https://github.com/Rrethy/vim-illuminate)                                    | illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching. |
| [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)                               | A vim 7.4+ plugin to generate table of contents for Markdown files.                                                                                       |
| [vim-obsession](https://github.com/tpope/vim-obsession)                                       | obsession.vim: continuously updated session files                                                                                                         |
| [vim-rsi](https://github.com/tpope/vim-rsi)                                                   | rsi.vim: Readline style insertion                                                                                                                         |
| [which-key.nvim](https://github.com/folke/which-key.nvim)                                     | 💥   Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.            |
<!-- END mdsh -->
