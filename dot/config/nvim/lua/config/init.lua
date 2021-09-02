local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin",
  "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.api.nvim_exec([[
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
"" Preserve visual selection during indentation
xnoremap < <gv
xnoremap > >gv

"" ChooseWin
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }

augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
]], false)
