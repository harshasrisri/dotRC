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
<!-- `> rg -uuIg config url ~/.local/share/nvim/site/pack/packer \
        | cut -f 2 -d = \
        | sed -e 's/\.git//g' -e 's/^\ //g' \
        | awk -F / '{ print "- ["$5"]("$0")" }' \
        | sort -f` -->
<!-- BEGIN mdsh -->
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-calc](https://github.com/hrsh7th/cmp-calc)
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [codewindow.nvim](https://github.com/gorbit99/codewindow.nvim)
- [feline.nvim](https://github.com/feline-nvim/feline.nvim)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [FTerm.nvim](https://github.com/numtostr/FTerm.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [impatient.nvim](https://github.com/lewis6991/impatient.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [iswap.nvim](https://github.com/mizlan/iswap.nvim)
- [jsregexp](https://github.com/kmarius/jsregexp/)
- [jsregexp](https://github.com/kmarius/jsregexp/)
- [kmonad-vim](https://github.com/kmonad/kmonad-vim)
- [lspkind-nvim](https://github.com/onsails/lspkind-nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [material.nvim](https://github.com/marko-cerovac/material.nvim)
- [move.nvim](https://github.com/fedepujol/move.nvim)
- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [numb.nvim](https://github.com/nacro90/numb.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)
- [nvim-comment](https://github.com/terrortylor/nvim-comment)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-osc52](https://github.com/ojroques/nvim-osc52)
- [nvim-surround](https://github.com/kylechui/nvim-surround)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [packer.nvim](https://github.com/wbthomason/packer.nvim)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [popup.nvim](https://github.com/nvim-lua/popup.nvim)
- [project.nvim](https://github.com/ahmedkhalf/project.nvim)
- [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)
- [sqlite.lua](https://github.com/tami5/sqlite.lua)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- [tabular](https://github.com/godlygeek/tabular)
- [targets.vim](https://github.com/wellle/targets.vim)
- [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [twilight.nvim](https://github.com/folke/twilight.nvim)
- [vim-ccls](https://github.com/m-pilia/vim-ccls)
- [vim-choosewin](https://github.com/t9md/vim-choosewin)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-illuminate](https://github.com/Rrethy/vim-illuminate)
- [vim-jsonnet](https://github.com/google/vim-jsonnet)
- [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer)
- [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)
- [vim-rsi](https://github.com/tpope/vim-rsi)
- [vim-startuptime](https://github.com/dstein64/vim-startuptime)
- [vim-terraform](https://github.com/hashivim/vim-terraform)
- [vim-wordmotion](https://github.com/chaoren/vim-wordmotion)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)
<!-- END mdsh -->
