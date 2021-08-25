call plug#begin('~/.config/nvim/plugins')
    Plug 'itchyny/lightline.vim'
    Plug 't9md/vim-choosewin'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'chaoren/vim-wordmotion'
    Plug 'm-pilia/vim-ccls', { 'for' : ['c', 'cpp']}
    Plug 'godlygeek/tabular', {'on' : 'Tab'}
    Plug 'euclio/vim-markdown-composer', { 'for' : 'markdown'}
    Plug 'mzlogin/vim-markdown-toc', { 'for' : 'markdown'}
    
    "" Lua based config
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'hrsh7th/nvim-compe'
    Plug 'onsails/lspkind-nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'simrat39/symbols-outline.nvim'
    Plug 'folke/zen-mode.nvim'
    Plug 'folke/twilight.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'windwp/nvim-autopairs'
    Plug 'karb94/neoscroll.nvim'
    Plug 'mizlan/iswap.nvim'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'sunjon/shade.nvim'
call plug#end()

"" Initializations
    let mapleader="\<Space>"               " Setting the global leader key

    set number                             " Display line numbers on the left side
    set hidden                             " Hide closed buffers instead of closing them.
    set noshowmode                         " Don't show mode on command line
    set splitbelow                         " Open a new split below the current one
    set splitright                         " Open a new vertical split to the right of the current one
    set scrolloff=5                        " Nun lines to keep top and bottom of a window while scrolling
    set updatetime=500                     " Time interval to update windows
    set backspace=indent,eol,start        " Backspace works over whitespaces also
    set formatoptions+=rn                  " Auto comment new comment lines, indents for numbered lists
    set pastetoggle=<F2>                   " Toggle prevent unnecessary autoindent on mouse click paste
    set autoread                           " Auto reload files changed outside vim
    set mouse=a                            " Enable Mouse in all modes
    set wildmenu                           " Pressing tab in command mode shows options on status bar
    set wildmode=longest:full,full         " Longest completion in wildmenu
    set tabstop=4                          " Show a tabstop as 4 spaces
    set shiftwidth=4                       " Auto indent shifts 4 spaces
    set expandtab                          " Insert 4 spaces when Tab is pressed
    set ignorecase                         " Ignore case while searching
    set smartcase                          " Ignore case if searching lowercase, not otherwise
    set inccommand=nosplit                 " Interactive search and replace
    set backupdir-=.                       " Don't store backup files in a file's $PWD
    set undofile                           " Remember undo history for closed files
    set cursorline                         " Horizontal line to indicate cursor
    set termguicolors                      " Set terminal to true colors
    set fillchars+=vert:▎                  " make the vertical split bar a slim line with no background

    hi VertSplit ctermbg=NONE guibg=NONE   " Set split background color to NONE
    let g:vimsyn_embed = 'l'               " Enable syntax highlighting for embedded lua

    augroup Initializations
        autocmd!
        "" Vim jumps to the last known position when reopening a file
        au! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END

"" Copy Paste
    " Cut/Copy/Replace selection to clipboard in visual mode
    vnoremap <leader>d "+d
    vnoremap <leader>y "+y
    vnoremap <leader>p "+p
    vnoremap <leader>P "+P
    " Paste from clipboard before/after position in normal mode
    nnoremap <leader>P "+P
    nnoremap <leader>p "+p
    " Place cursor after copy/paste position in Normal/Visual mode
    " and automatically indent the pasted region as per context
    vnoremap <silent>y y`]
    nnoremap <silent>p p`[v`]=
    nnoremap <silent>P P`[v`]=
    nnoremap Y y$
    nnoremap x "_x

"" Navigation
    " Go between lines in wrapped lines.
    nnoremap j gj
    nnoremap k gk
    " Go to first/last non-blank character
    nnoremap 0 ^
    nnoremap $ g_
    " Maps Leader+[h,j,k,l] to move between window splits
    nnoremap <leader>h <C-w>h
    nnoremap <leader>j <C-w>j
    nnoremap <leader>k <C-w>k
    nnoremap <leader>l <C-w>l

"" Miscellaneous
    " Easy save as sudo
    cnoremap w!! w !sudo tee %
    "" Easy <ESC> in INSERT mode
    inoremap jj <Esc>
    inoremap jk <Esc>
    inoremap kj <Esc>
    "" Easy enter command mode
    nnoremap ; :

"" Lightline
    let g:lightline = {
        \ 'colorscheme': 'nightfox',
        \ 'active': { 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'modified' , 'fugitive', 'filename', 'method' ] ] },
        \ 'component': { 'lineinfo': ' %3l:%-2v' },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' },
        \ 'component_function': {
        \     'readonly': 'LightlineReadonly',
        \     'fugitive': 'LightlineFugitive',
        \     'method'  : 'NearestMethodOrFunction',
        \   },
        \ 'tabline': { 'left': [['buffers']], 'right': [['close']] },
        \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
        \ 'component_type': { 'buffers': 'tabsel', },
        \ }

    function! LightlineReadonly()
        return &readonly ? '' : ''
    endfunction

    function! LightlineFugitive()
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endfunction

"" ChooseWin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

lua << EOF
require('config/telescope')
require('config/lsp')
require('config/misc')
require('config/compe')
require('config/luasnip')
EOF
