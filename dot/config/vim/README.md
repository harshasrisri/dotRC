# Vim Configuration

## Standalone installation
- Download [vimrc](vimrc) as `~/.vimrc`
- install [vim-plug](https://github.com/junegunn/vim-plug) to `~/.vim/autoload`
- Run `vim +PlugInstall` to setup all the below plugins

## List of Plugins
| Name                                                                          | Description                                     |
|-------------------------------------------------------------------------------|-------------------------------------------------|
| [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim   ) | LSP provider with a Rust backend                |
| [fzf                  ](https://github.com/junegunn/fzf                     ) | Vim-only Fuzzy finder installer                 |
| [fzf.vim              ](https://github.com/junegunn/fzf.vim                 ) | Plugin to use the fuzzy finder                  |
| [indentLine           ](https://github.com/Yggdroot/indentLine              ) | Show a visual indent line                       |
| [lexima.vim           ](https://github.com/cohama/lexima.vim                ) | Auto close quotes/brackets                      |
| [lightline-bufferline ](https://github.com/mengelbrecht/lightline-bufferline) | Buffer line addon to the status line            |
| [lightline.vim        ](https://github.com/itchyny/lightline.vim            ) | Light weight, fancy status line                 |
| [onedark.vim          ](https://github.com/joshdick/onedark.vim             ) | Truecolor compatible Onedark Colorscheme        |
| [tabular              ](https://github.com/godlygeek/tabular                ) | Text alignment                                  |
| [targets.vim          ](https://github.com/wellle/targets.vim               ) | More target definitions for compound actions    |
| [vim-ccls             ](https://github.com/m-pilia/vim-ccls                 ) | Browse class/function hierarchies using ccls    |
| [vim-choosewin        ](https://github.com/t9md/vim-choosewin               ) | Overlay hints to choose a window among many     |
| [vim-commentary       ](https://github.com/tpope/vim-commentary             ) | Bulk commenting with repeat support             |
| [vim-expand-region    ](https://github.com/terryma/vim-expand-region        ) | Incrementally expand scope of visual selection  |
| [vim-fugitive         ](https://github.com/tpope/vim-fugitive               ) | Fantastic git integration                       |
| [vim-lsp-cxx-highlight](https://github.com/jackguo380/vim-lsp-cxx-highlight ) | Semantic highlighting for C++ code using LSP    |
| [vim-markdown-toc     ](https://github.com/mzlogin/vim-markdown-toc         ) | Create/Update table of contents for Markdown    |
| [vim-mucomplete       ](https://github.com/lifepillar/vim-mucomplete        ) | LSP aware light weight completion               |
| [vim-peekaboo         ](https://github.com/junegunn/vim-peekaboo            ) | Peek at registers before running macro or paste |
| [vim-plug             ](https://github.com/junegunn/vim-plug                ) | Plugin Manager. Bootstrapped at setup           |
| [vim-rsi              ](https://github.com/tpope/vim-rsi                    ) | Use readline shortcuts in insert/command modes  |
| [vim-signify          ](https://github.com/mhinz/signify                    ) | Show VCS change-hints in the gutter of a buffer |
| [vim-surround         ](https://github.com/tpope/vim-surround               ) | Insert quotes/brackets around vim objects       |
| [vim-wordmotion       ](https://github.com/chaoren/vim-wordmotion           ) | Handle CamelCase, snake_case or pascalCase      |
| [vimspector           ](https://github.com/puremourning/vimspector          ) | Debugger interface using LSP-like DAP           |
| [vista.vim            ](https://github.com/liuchengxu/vista.vim             ) | Async tagbar plugin with ctags/LSP backend      |

## Additional recommended tools
- [ripgrep](https://github.com/BurntSushi/ripgrep) for text search using fzf
- [fd](https://github.com/sharkdp/fd) for listing files in fzf
