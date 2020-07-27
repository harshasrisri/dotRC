# dotRC
My shell environment to setup and manage The Text Triumvirate : Vim + Tmux + Zsh.

## Install
1. Updates this repository if necessary.
2. Makes links to the [dot files](dot) in the $HOME directory.
3. Installs plugin managers and plugins for each tool.

~~~
git clone http://github.com/harshasrisri/dotRC.git
cd dotRC
./setup
~~~

Please Backup whatever is important ALWAYS!

## Plugins

### Vim Plugins
| Name                                                                          | Description                                     |
|-------------------------------------------------------------------------------|-------------------------------------------------|
| [vim-plug             ](https://github.com/junegunn/vim/plug                ) | Plugin Manager. Bootstrapped at setup           |
| [vim--solarized8      ](https://github.com/lifepillar/vim--solarized8       ) | Truecolor compatible Solarized Colorscheme      |
| [lightline.vim        ](https://github.com/itchyny/lightline.vim            ) | Light weight, fancy status line                 |
| [lightline-bufferline ](https://github.com/mengelbrecht/lightline-bufferline) | Buffer line addon to the status line            |
| [vim-peekaboo         ](https://github.com/junegunn/vim-peekaboo            ) | Peek at registers before running macro or paste |
| [fzf                  ](https://github.com/junegunn/fzf                     ) | Vim-only Fuzzy finder installer                 |
| [fzf.vim              ](https://github.com/junegunn/fzf.vim                 ) | Plugin to use the fuzzy finder                  |
| [tabular              ](https://github.com/godlygeek/tabular                ) | Text alignment                                  |
| [vim-fugitive         ](https://github.com/tpope/vim-fugitive               ) | Fantastic git integration                       |
| [vim-wordmotion       ](https://github.com/chaoren/vim-wordmotion           ) | Handle CamelCase, snake_case or pascalCase      |
| [vim-rsi              ](https://github.com/tpope/vim-rsi'                   ) | Use readline shortcuts in insert/command modes  |
| [targets.vim          ](https://github.com/wellle/targets.vim'              ) | More target definitions for compound actions    |
| [vim-expand-region    ](https://github.com/terryma/vim-expand-region'       ) | Incrementally expand scope of visual selection  |
| [sexy_scroller        ](https://github.com/joeytwiddle/sexy_scroller.vim'   ) | Smooth scrolling in terminal buffers            |
| [vim-commentary       ](https://github.com/tpope/vim-commentary             ) | Bulk commenting with repeat support             |
| [vim-surround         ](https://github.com/tpope/vim-surround               ) | Insert quotes/brackets around vim objects       |
| [lexima.vim           ](https://github.com/cohama/lexima.vim                ) | Auto close quotes/brackets                      |
| [indentLine           ](https://github.com/Yggdroot/indentLine              ) | Show a visual indent line                       |
| [vim-mucomplete       ](https://github.com/lifepillar/vim-mucomplete        ) | LSP aware light weight completion               |
| [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim   ) | LSP provider with a Rust backend                |
| [tagbar               ](https://github.com/majutsushi/tagbar                ) | Ctags based tag sidebar                         |
| [vimspector           ](https://github.com/puremourning/vimspector          ) | Debugger interface using LSP-like DAP           |

### TMUX Plugins
| Name                                                                   | Description                              |
|------------------------------------------------------------------------|------------------------------------------|
| [tpm              ](https://github.com/tmux-plugins/tpm              ) | Plugin Manager. Bootstrapped at setup    |
| [tmux-powerbreeze ](https://github.com/harshasrisri/tmux-powerbreeze ) | Colorscheme                              |
| [tmux-sensible    ](https://github.com/tmux-plugins/tmux-sensible    ) | Sensible defaults                        |
| [tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control) | Vi-like keybindings for pane control     |
| [tmux-copycat     ](https://github.com/tmux-plugins/tmux-copycat     ) | Improved searching with search templates |
| [tmux-logging     ](https://github.com/tmux-plugins/tmux-logging     ) | Control console logging and save to file |

### ZSH Plugins
| Name                                                                                       | Description                           |
|--------------------------------------------------------------------------------------------|---------------------------------------|
| [zimfw                       ](https://github.com/zimfw/zimfw                            ) | Plugin Manager. Bootstrapped manually |
| [eriner                      ](https://github.com/zimfw/eriner                           ) | Prompt style                          |
| [environment                 ](https://github.com/zimfw/environment                      ) | Sensible defaults for ZSH             |
| [input                       ](https://github.com/zimfw/input                            ) | Handle quirks in keyboard input       |
| [termtitle                   ](https://github.com/zimfw/termtitle                        ) | Set a dynamic terminal title          |
| [git-info                    ](https://github.com/zimfw/git-info                         ) | Git status info on the prompt         |
| [zsh-completions             ](https://github.com/zsh-users/zsh-completions              ) | Collection of completion scripts      |
| [completion                  ](https://github.com/zimfw/completion                       ) | Tweaks to Completion behavior         |
| [zsh-autosuggestions         ](https://github.com/zsh-users/zsh-autosuggestions          ) | Fish-shell like auto suggestions      |
| [zsh-syntax-highlighting     ](https://github.com/zsh-users/zsh-syntax-highlighting      ) | Syntax highlighting on the CLI        |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search ) | Search history based on substring     |
| [fzf-tab                     ](https://github.com/Aloxaf/fzf-tab                         ) | Integrate FZF into completion         |
