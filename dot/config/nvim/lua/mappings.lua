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
map('v', '<silent>y', 'y`]')
map('n', '<silent>p', 'p`[v`]=')
map('n', '<silent>P', 'P`[v`]=')

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
map('n', ';', ':')               -- Easy jump to command mode

map('n', '-', ':ChooseWin<CR>')

map('n', '<C-n>', ':BufferLineCycleNext<CR>')
map('n', '<C-p>', ':BufferLineCyclePrev<CR>')

---------------------------- Telescope -------------------------
map('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
map('n', '<leader>f:', '<cmd>Telescope commands<cr>')
map('n', '<leader>f?', '<cmd>Telescope search_history<cr>')
map('n', '<leader>fK', '<cmd>Telescope man_pages<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fe', '<cmd>Telescope file_browser<cr>')
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>')
map('n', '<leader>fl', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fm', '<cmd>Telescope builtin<cr>')
map('n', '<leader>fo', '<cmd>Telescope vim_options<cr>')
map('n', '<leader>fq', '<cmd>Telescope command_history<cr>')
map('n', '<leader>fr', '<cmd>Telescope grep_string<cr>')
map('n', '<leader>ft', '<cmd>TodoTelescope<cr>')
map('n', '<leader>gC', '<cmd>Telescope git_commits<cr>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>')
map('n', '<leader>gc', '<cmd>Telescope git_bcommits<cr>')

--------------------------- LSP ---------------------------
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<cr>')
map('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<cr>')
map('n', '<leader>la', '<cmd>Telescope lsp_code_actions<cr>')
map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>')
map('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>')
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
map('n', '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
map('n', '<leader>lx', '<cmd>Telescope lsp_references<cr>')
map('v', '<leader>la', '<cmd>Telescope lsp_range_code_actions<cr>')
