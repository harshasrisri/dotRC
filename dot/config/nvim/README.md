# Neovim Config

## Standalone installation
[Download this folder](https://downgit.github.io/#/home?url=https://github.com/harshasrisri/dotRC/tree/main/dot/config/nvim) and extract it to `~/.config/nvim`.

## Structure
```
~/.config/nvim/
├── README.md
├── init.lua                => Top level config file sourced by Neovim
└── lua                     => Default module lookup directory
    ├── plugins             => Submodule containing plugin list and additional plugin configs
    │   ├── init.lua        => Top level config for the plugins submodule
    │   ├── compe.lua       => Completion config for nvim-compe
    │   ├── lsp.lua         => LSP config and langservers mappings
    │   └── luasnip.lua     => Snippet completion config for nvim-compe
    ├── mappings.lua        => Key mappings
    ├── settings.lua        => Global/Window/Buffer level settings
    └── utils.lua           => Lua utility functions
```

## List of Plugins
| Name                                                                             | Description                                                    |
|----------------------------------------------------------------------------------|----------------------------------------------------------------|
| [LuaSnip               ](https://github.com/L3MON4D3/LuaSnip                   ) | Snippets Engine                                                |
| [feline.nvim           ](https://github.com/famiu/feline.nvim                  ) | Minimal, functional status line                                |
| [friendly-snippets     ](https://github.com/rafamadriz/friendly-snippets       ) | Snippets collection for popular languages                      |
| [gitsigns.nvim         ](https://github.com/lewis6991/gitsigns.nvim            ) | Git status indicators in gutter                                |
| [impatient.nvim        ](https://github.com/lewis6991/impatient.nvim           ) | Pre-compile lua files for faster startup times                 |
| [indent-blankline.nvim ](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides                                                  |
| [lsp_signature.nvim    ](https://github.com/ray-x/lsp_signature.nvim           ) | Show function signatures in call sites                         |
| [lspkind-nvim          ](https://github.com/onsails/lspkind-nvim               ) | Show dev-icons in completion menus                             |
| [neoscroll.nvim        ](https://github.com/karb94/neoscroll.nvim              ) | Smooth scrolling in terminal vim                               |
| [nightfox.nvim         ](https://github.com/EdenEast/nightfox.nvim             ) | Tresitter aware colorscheme                                    |
| [nvim-autopairs        ](https://github.com/windwp/nvim-autopairs              ) | Auto close quotes/brackets/braces/parentheses                  |
| [nvim-bufferline.lua   ](https://github.com/akinsho/nvim-bufferline.lua        ) | Bufferline plugin                                              |
| [nvim-code-action-menu ](https://github.com/weilbith/nvim-code-action-menu     ) | Show diff of code actions suggested by LSP                     |
| [nvim-comment          ](https://github.com/terrortylor/nvim-comment           ) | Comment out lines/blocks                                       |
| [nvim-compe            ](https://github.com/hrsh7th/nvim-compe                 ) | Async LSP and TreeSitter aware completion engine               |
| [nvim-lspconfig        ](https://github.com/neovim/nvim-lspconfig              ) | Preset LSP configurations for most languages                   |
| [nvim-treesitter       ](https://github.com/nvim-treesitter/nvim-treesitter    ) | Preset TreeSitter configurations for most languages            |
| [nvim-web-devicons     ](https://github.com/kyazdani42/nvim-web-devicons       ) | Fancy unicode icons for filetypes                              |
| [packer.nvim           ](https://github.com/wbthomason/packer.nvim             ) | Plugin/dependency manager                                      |
| [plenary.nvim          ](https://github.com/nvim-lua/plenary.nvim              ) | Lua library for quite a few lua-based plugins                  |
| [project.nvim          ](https://github.com/ahmedkhalf/project.nvim            ) | Project rooter with Telescope integration                      |
| [rust-tools.nvim       ](https://github.com/simrat39/rust-tools.nvim           ) | Add capabilities to LSP for Rust                               |
| [sqlite.lua            ](https://github.com/tami5/sqlite.lua                   ) | Sqlite integration for plugins when required                   |
| [symbols-outline.nvim  ](https://github.com/simrat39/symbols-outline.nvim      ) | LSP based sidebar to show document symbols                     |
| [tabular               ](https://github.com/godlygeek/tabular                  ) | Align rows of text on arbitrary text                           |
| [targets.vim           ](https://github.com/wellle/targets.vim                 ) | More target definitions for compound actions                   |
| [telescope.nvim        ](https://github.com/nvim-telescope/telescope.nvim      ) | Highly extensible fuzzy finder                                 |
| [todo-comments.nvim    ](https://github.com/folke/todo-comments.nvim           ) | Shows markers like TODO, FIXME, etc with Telescope integration |
| [twilight.nvim         ](https://github.com/folke/twilight.nvim                ) | Highlight active section of text and dim others                |
| [vim-ccls              ](https://github.com/m-pilia/vim-ccls                   ) | Add capabilities to LSP for C/C++                              |
| [vim-choosewin         ](https://github.com/t9md/vim-choosewin                 ) | Jump to split when there are a lot of them                     |
| [vim-fugitive          ](https://github.com/tpope/vim-fugitive                 ) | The Git Plugin for (Neo)Vim                                    |
| [vim-markdown-composer ](https://github.com/euclio/vim-markdown-composer       ) | Shows a live preview of a markdown file in browser             |
| [vim-markdown-toc      ](https://github.com/mzlogin/vim-markdown-toc           ) | Add a table of contents to Markdown files                      |
| [vim-repeat            ](https://github.com/tpope/vim-repeat                   ) | Support to repeat non-standard actions                         |
| [vim-rsi               ](https://github.com/tpope/vim-rsi                      ) | GNU Readline key bindings for text                             |
| [vim-surround          ](https://github.com/tpope/vim-surround                 ) | Adds custom surround verb to existing vim-verbs                |
| [vim-wordmotion        ](https://github.com/chaoren/vim-wordmotion             ) | Handle CamelCase, snake_case or pascalCase                     |
| [which-key.nvim        ](https://github.com/folke/which-key.nvim               ) | Shows a descriptive completion menu for key mapping sequences  |
| [zen-mode.nvim         ](https://github.com/folke/zen-mode.nvim                ) | Distraction free reading mode to reduce visual noise           |

## Additional recommended tools: 
- [ripgrep](https://github.com/BurntSushi/ripgrep) for live text search in Telescope
- [fd](https://github.com/sharkdp/fd) for listing files in Telescope

