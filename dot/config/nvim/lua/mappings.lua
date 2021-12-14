local map = require('utils').map

-- Cut/Copy/Replace selection to clipboard in visual mode
map('v', '<leader>d', '"+d')
map('v', '<leader>y', '"+y')
map('v', '<leader>p', '"+p')
map('v', '<leader>P', '"+P')

-- Paste from clipboard before/after position in normal mode
map('n', '<leader>p', '"+p')
map('n', '<leader>P', '"+P')

-- Place cursor after copy/paste position in Normal/Visual mode 
-- and automatically indent the pasted region as per context
map('v', 'y', 'y`]')
map('n', 'p', 'p`[v`]=')
map('n', 'P', 'P`[v`]=')

-- Go between lines in wrapped lines.
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Go to first/last non-blank character
map('n', '0', '^')
map('n', '$', 'g_')

-- Maps Leader+[h,j,k,l] to move between window splits
map('n', '<leader>h', '<C-w>h')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')

-- Preserve visual selection during indentation
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Misc
map('c', 'w!!', 'w !sudo tee %') -- Easy save as sudo
map('n', 'Y', 'y$')              -- Yank till end of line
map('n', 'x', '"_x')             -- Ignore single char cuts
map('i', 'jj' , '<Esc>')         -- Easy escape to normal mode

map('n', '-', ':ChooseWin<CR>')

map('n', '<Tab>', ':BufferLineCycleNext<CR>')
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')

map('n', ';', ':')

---------------------------- Telescope -------------------------
map('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>f:', '<cmd>Telescope commands<CR>')
map('n', '<leader>f?', '<cmd>Telescope search_history<CR>')
map('n', '<leader>fK', '<cmd>Telescope man_pages<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fe', '<cmd>Telescope file_browser<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fh', '<cmd>Telescope frecency<CR>')
map('n', '<leader>fj', '<cmd>Telescope jumplist<CR>')
map('n', '<leader>fl', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fm', '<cmd>Telescope builtin<CR>')
map('n', '<leader>fo', '<cmd>Telescope vim_options<CR>')
map('n', '<leader>fp', '<cmd>Telescope projects<CR>')
map('n', '<leader>fq', '<cmd>Telescope command_history<CR>')
map('n', '<leader>fr', '<cmd>Telescope resume<CR>')
map('n', '<leader>ft', '<cmd>TodoTelescope<CR>')
map('n', '<leader>gC', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
map('n', '<leader>gc', '<cmd>Telescope git_bcommits<CR>')

--------------------------- LSP ---------------------------
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>la', '<cmd>Telescope lsp_code_actions<CR>')
map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<CR>')
map('n', '<leader>li', '<cmd>Telescope lsp_implementations<CR>')
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<CR>')
map('n', '<leader>lx', '<cmd>Telescope lsp_references<CR>')

-- FTerm.nvim
vim.cmd('command! FTermToggle lua require("FTerm").toggle()')
map('n', '<leader>t', '<cmd>FTermToggle<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n><cmd>FTermToggle<CR>')
