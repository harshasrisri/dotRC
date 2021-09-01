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
    Plug 'ahmedkhalf/project.nvim'
call plug#end()

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

lua << EOF
require('config')
require('config/telescope')
require('config/lsp')
require('config/misc')
require('config/compe')
require('config/luasnip')
EOF
