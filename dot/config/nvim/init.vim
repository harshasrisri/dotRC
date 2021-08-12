set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
set inccommand=nosplit                 " Interactive search and replace
" highlight link NormalNC CursorColumn   " Dim inactive windows
source ~/.vimrc

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

let g:vimsyn_embed = 'l'
" -------------------- LSP ---------------------------------
lua << EOF
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<cr>', opts)
buf_set_keymap('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<cr>', opts)
buf_set_keymap('n', '<leader>la', '<cmd>Telescope lsp_code_actions<cr>', opts)
buf_set_keymap('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>', opts)
buf_set_keymap('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>', opts)
buf_set_keymap('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', opts)
buf_set_keymap('n', '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<cr>', opts)
buf_set_keymap('n', '<leader>lx', '<cmd>Telescope lsp_references<cr>', opts)
buf_set_keymap('v', '<leader>la', '<cmd>Telescope lsp_range_code_actions<cr>', opts)

if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
    end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "ccls", "rust_analyzer", "gopls", "jdtls", "pyright" }
local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end

require'nvim-treesitter.configs'.setup {
    highlight = {
    enable = true
    },
}
EOF
" -------------------- LSP ---------------------------------

" -------------------- Telescope ---------------------------------
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>f: <cmd>Telescope commands<cr>
nnoremap <leader>f? <cmd>Telescope search_history<cr>
nnoremap <leader>fK <cmd>Telescope man_pages<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fm <cmd>Telescope builtin<cr>
nnoremap <leader>fo <cmd>Telescope vim_options<cr>
nnoremap <leader>fq <cmd>Telescope command_history<cr>
nnoremap <leader>fr <cmd>Telescope grep_string<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
nnoremap <leader>gC <cmd>Telescope git_commits<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
" -------------------- Telescope ---------------------------------
