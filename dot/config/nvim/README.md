# Neovim Config

## Standalone installation
[Download this folder](https://downgit.github.io/#/home?url=https://github.com/harshasrisri/dotRC/tree/main/dot/config/nvim) and extract it to `~/.config/nvim`.

## Structure
```
~/.config/nvim/
├── README.md              => This README
├── init.lua               => Top level config file sourced by Neovim
└── lua                    => Default module lookup directory
    ├── mappings.lua       => Key mappings
    ├── plugins            => Submodule containing plugin list and additional plugin configs
    │   ├── cmp.lua        => Completion config for nvim-compe
    │   ├── init.lua       => Top level config for the plugins submodule
    │   ├── lsp.lua        => LSP config and langservers mappings
    │   └── luasnip.lua    => Snippet completion config for nvim-compe
    ├── settings.lua       => Global/Window/Buffer level settings
    └── utils.lua          => Lua utility functions
```

## List of Plugins
<!-- `! urls=$(rg -uuIg config url ~/.local/share/nvim/site/pack/packer \
                | cut -f 2 -d = | sed -e 's/\.git//g' -e 's/^\ //g' | rg -v jsregexp)` -->
<!-- `> echo -e "| Plugin | Description |\n| -- | -- |" && for url in $urls; do \
            api_url=$(echo $url | awk -F / '{ print $1 "//api." $3 "/repos/" $4 "/" $5 }') ;\
            descr=$(curl $api_url | jq .description | sed -e 's/"//g') ;\
            echo $url | awk -F / '{ print "| [" $5 "](" $0 ") | " descr " | " }' descr="$descr" ;\
        done \
        | sort -f` -->
<!-- BEGIN mdsh -->
| Plugin | Description |
| -- | -- |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | A snazzy bufferline for Neovim | 
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | nvim-cmp source for buffer words | 
| [cmp-calc](https://github.com/hrsh7th/cmp-calc) | nvim-cmp source for math calculation | 
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | nvim-cmp source for vim's cmdline | 
| [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) | nvim-cmp source for emoji | 
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | luasnip completion source for nvim-cmp | 
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source for neovim builtin LSP client | 
| [cmp-path](https://github.com/hrsh7th/cmp-path) | nvim-cmp source for path | 
| [codewindow.nvim](https://github.com/gorbit99/codewindow.nvim) | null | 
| [feline.nvim](https://github.com/feline-nvim/feline.nvim) | A minimal, stylish and customizable statusline for Neovim written in Lua | 
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Set of preconfigured snippets for different languages.  | 
| [FTerm.nvim](https://github.com/numtostr/FTerm.nvim) | :fire: No-nonsense floating terminal plugin for neovim :fire: | 
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration for buffers | 
| [impatient.nvim](https://github.com/lewis6991/impatient.nvim) | Improve startup time for Neovim | 
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides  for Neovim | 
| [iswap.nvim](https://github.com/mizlan/iswap.nvim) | Interactively select and swap function arguments, list elements, and more. Powered by tree-sitter. | 
| [kmonad-vim](https://github.com/kmonad/kmonad-vim) | Vim editing support for kmonad config files | 
| [lspkind-nvim](https://github.com/onsails/lspkind-nvim) | vscode-like pictograms for neovim lsp completion items | 
| [leap.nvim](https://github.com/ggandor/leap.nvim) | 🦘 Neovim's answer to the mouse: a clairvoyant interface that makes on-screen jumps quicker and more natural than ever | 
| [leap-spooky.nvim](https://github.com/ggandor/leap-spooky.nvim) | 👻 Actions at a distance | 
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet Engine for Neovim written in Lua. | 
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users. | 
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters. | 
| [material.nvim](https://github.com/marko-cerovac/material.nvim) | :trident: Material colorscheme for NeoVim written in Lua with built-in support for native LSP, TreeSitter and many more plugins | 
| [move.nvim](https://github.com/fedepujol/move.nvim) | Gain the power to move lines and blocks and auto-indent them! | 
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling neovim plugin written in lua | 
| [noice.nvim](https://github.com/folke/noice.nvim) | 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu. | 
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI Component Library for Neovim. | 
| [numb.nvim](https://github.com/nacro90/numb.nvim) | Peek lines just when you intend | 
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | autopairs for neovim written by lua | 
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | A completion plugin for neovim coded in Lua. | 
| [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu) | Pop-up menu for code actions to show meta-information and diff preview | 
| [nvim-comment](https://github.com/terrortylor/nvim-comment) | A comment toggler for Neovim, written in Lua | 
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Nvim LSP | 
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua) | Clipboard manager neovim plugin with telescope integration | 
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | A fancy, configurable, notification manager for NeoVim | 
| [nvim-osc52](https://github.com/ojroques/nvim-osc52) | A Neovim plugin to copy text through SSH with OSC52 | 
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding delimiter pairs with ease. Written with :heart: in Lua. | 
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | A file explorer tree for neovim written in lua | 
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | null | 
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Nvim Treesitter configurations and abstraction layer | 
| [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | lua `fork` of vim-web-devicons for neovim | 
| [packer.nvim](https://github.com/wbthomason/packer.nvim) | A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config | 
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice. | 
| [popup.nvim](https://github.com/nvim-lua/popup.nvim) | [WIP] An implementation of the Popup API from vim in Neovim. Hope to upstream when complete | 
| [project.nvim](https://github.com/ahmedkhalf/project.nvim) | The superior project management solution for neovim. | 
| [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | Tools for better development in rust using neovim's builtin lsp | 
| [sqlite.lua](https://github.com/tami5/sqlite.lua) | SQLite LuaJIT binding with a very simple api. | 
| [silicon.lua](https://github.com/narutoxy/silicon.lua) | Beautiful code snippet images right in the most epic editor :chef_kiss: | 
| [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim) | A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages. | 
| [tabular](https://github.com/godlygeek/tabular) | Vim script for text filtering and alignment | 
| [targets.vim](https://github.com/wellle/targets.vim) | Vim plugin that provides additional text objects | 
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim) | A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history. | 
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorter for telescope written in c | 
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Find, Filter, Preview, Pick. All lua, all the time. | 
| [twilight.nvim](https://github.com/folke/twilight.nvim) | 🌅  Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter. | 
| [vim-ccls](https://github.com/m-pilia/vim-ccls) | Vim plugin for the ccls language server | 
| [vim-choosewin](https://github.com/t9md/vim-choosewin) | Land on window you chose like tmux's 'display-pane' | 
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | fugitive.vim: A Git wrapper so awesome, it should be illegal | 
| [vim-illuminate](https://github.com/Rrethy/vim-illuminate) | illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching. | 
| [vim-jsonnet](https://github.com/google/vim-jsonnet) | Jsonnet filetype plugin for Vim. | 
| [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer) | An asynchronous markdown preview plugin for Vim and Neovim. | 
| [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc) | A vim 7.4+ plugin to generate table of contents for Markdown files. | 
| [vim-rsi](https://github.com/tpope/vim-rsi) | rsi.vim: Readline style insertion | 
| [vim-startuptime](https://github.com/dstein64/vim-startuptime) | ⏲️ A Vim plugin for profiling Vim's startup time. | 
| [vim-terraform](https://github.com/hashivim/vim-terraform) | basic vim/terraform integration | 
| [vim-wordmotion](https://github.com/chaoren/vim-wordmotion) | More useful word motions for Vim | 
| [which-key.nvim](https://github.com/folke/which-key.nvim) | 💥   Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing. | 
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | 🧘  Distraction-free coding for Neovim | 
<!-- END mdsh -->
