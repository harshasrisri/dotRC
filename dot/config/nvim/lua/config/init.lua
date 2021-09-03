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

vim.opt.shell = "/bin/sh"
vim.opt.lazyredraw = true

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
set guifont=MesloLGS\ NF:h11.5         " Use MesloLGS NF font at 11.5pt height for GUIs
hi VertSplit ctermbg=NONE guibg=NONE   " Set split background color to NONE
let g:vimsyn_embed = 'l'               " Enable syntax highlighting for embedded lua

augroup Initializations
autocmd!
"" Vim jumps to the last known position when reopening a file
au! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
]], false)
