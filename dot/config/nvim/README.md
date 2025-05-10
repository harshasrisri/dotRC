# Neovim Config

<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim"><img src="https://dotfyle.com/harshasrisri/dotrc-dot-config-nvim/badges/plugin-manager?style=for-the-badge" /></a>

## Standalone installation
- [Download this folder](https://downgit.github.io/#/home?url=https://github.com/harshasrisri/dotRC/tree/main/dot/config/nvim) and extract it to `~/.config/harshasrisri-nvim`.
- Add an alias to make `neovim` use this config by default:
```sh
curl https://downgit.github.io/#/home?url=https://github.com/harshasrisri/dotRC/tree/main/dot/config/nvim -o ~/Downloads/harshasrisri-nvim.zip
unzip ~/Downloads/harshasrisri-nvim.zip -d ~/.config/harshasrisri-nvim
alias nvim='NVIM_APPNAME=harshasrisri-nvim nvim'
```

## List of Plugins
<!-- `! urls=$(rg -uuIg config url ~/.local/share/nvim/lazy \
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
| [barbecue.nvim](https://github.com/utilyre/barbecue.nvim) | Visual Studio Code inspired breadcrumbs plugin for the Neovim editor | 
| [blink.cmp](https://github.com/saghen/blink.cmp) | Performant, batteries-included completion plugin for Neovim  | 
| [ccls.nvim](https://github.com/ranjithshegde/ccls.nvim) | Neovim plugin for ccls language server. Leverages off-spec extensions to  LSP client with AST browser | 
| [decorated_yank](https://github.com/simondrake/decorated_yank) | decorated yank plugin for neovim | 
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Single tabpage interface for easily cycling through diffs for all modified files for any git rev. | 
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Set of preconfigured snippets for different languages.  | 
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration for buffers | 
| [go.nvim](https://github.com/ray-x/go.nvim) | G'day Nvimer, Joyful Gopher: Discover the Feature-Rich Go Plugin for Neovim | 
| [iswap.nvim](https://github.com/mizlan/iswap.nvim) | Interactively select and swap function arguments, list elements, and much more. Powered by tree-sitter. | 
| [kanagawa-paper.nvim](https://github.com/sho-87/kanagawa-paper.nvim) | 🌊 Remixed Kanagawa colourschemes with muted colors. For Neovim.  | 
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Faster LuaLS setup for Neovim | 
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 💤 A modern plugin manager for Neovim | 
| [leap.nvim](https://github.com/ggandor/leap.nvim) | Neovim's answer to the mouse 🦘 | 
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim) | A Neovim plugin enabling you to solve LeetCode problems. | 
| [lspkind-nvim](https://github.com/onsails/lspkind-nvim) | vscode-like pictograms for neovim lsp completion items | 
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | A blazing fast and easy to configure neovim statusline plugin written in pure lua. | 
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | markdown preview plugin for (neo)vim | 
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters. | 
| [mini.ai](https://github.com/echasnovski/mini.ai) | Neovim Lua plugin to extend and create `a`/`i` textobjects. Part of 'mini.nvim' library. | 
| [mini.align](https://github.com/echasnovski/mini.align) | Neovim Lua plugin to align text interactively. Part of 'mini.nvim' library. | 
| [mini.comment](https://github.com/echasnovski/mini.comment) | Neovim Lua plugin for fast and familiar per-line commenting. Part of 'mini.nvim' library. | 
| [noice.nvim](https://github.com/folke/noice.nvim) | 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu. | 
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI Component Library for Neovim. | 
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | autopairs for neovim written in lua | 
| [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu) | Pop-up menu for code actions to show meta-information and diff preview | 
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Nvim LSP | 
| [nvim-navic](https://github.com/SmiteshP/nvim-navic) | Simple winbar/statusline plugin that shows your current code context | 
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua) | Clipboard manager neovim plugin with telescope integration | 
| [nvim-spider](https://github.com/chrisgrieser/nvim-spider) | Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation. | 
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding delimiter pairs with ease. Written with :heart: in Lua. | 
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Nvim Treesitter configurations and abstraction layer | 
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Custom textobjects derived from Treesitter | 
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Provides Nerd Font icons (glyphs) for use by neovim plugins | 
| [nvim-window](https://github.com/yorickpeterse/nvim-window) | Easily jump between NeoVim windows. | 
| [outline.nvim](https://github.com/hedyhli/outline.nvim) | Navigate code with an outline sidebar. Forked from symbols-outline.nvim.  | 
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice. | 
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | 🦀 Supercharge your Rust experience in Neovim! A heavily modified fork of rust-tools.nvim | 
| [snacks.nvim](https://github.com/folke/snacks.nvim) | 🍿 A collection of QoL plugins for Neovim | 
| [sqlite.lua](https://github.com/tami5/sqlite.lua) | SQLite LuaJIT binding with a very simple api. | 
| [symbol-usage.nvim](https://github.com/Wansmer/symbol-usage.nvim) | Display references, definitions and implementations of document symbols | 
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Find, Filter, Preview, Pick. All lua, all the time. | 
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | A neovim lua plugin to help easily manage multiple terminal windows | 
| [treesj](https://github.com/wansmer/treesj) | Neovim plugin for splitting/joining blocks of code | 
| [vim-illuminate](https://github.com/Rrethy/vim-illuminate) | illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching. | 
| [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc) | A vim 7.4+ plugin to generate table of contents for Markdown files. | 
| [vim-moonfly-colors](https://github.com/bluz71/vim-moonfly-colors) | A dark charcoal theme for modern Neovim & classic Vim | 
| [vim-obsession](https://github.com/tpope/vim-obsession) | obsession.vim: continuously updated session files | 
| [vim-rsi](https://github.com/tpope/vim-rsi) | rsi.vim: Readline style insertion | 
| [which-key.nvim](https://github.com/folke/which-key.nvim) | 💥   Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type. | 
<!-- END mdsh -->
