set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

set inccommand=nosplit                 " Interactive search and replace
let g:vimsyn_embed = 'l'

lua << EOF
require('config/telescope')
require('config/lsp')
require('config/misc')
EOF
