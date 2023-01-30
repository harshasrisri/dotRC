local map = vim.keymap.set

-- Copy to OS clipboard via OSCYank
map('n', '<leader>y', require('osc52').copy_operator, {expr = true})
map('n', '<leader>yy', '<leader>y_', {remap = true})
map('x', '<leader>y', require('osc52').copy_visual)

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
map('n', 'x', '"_x')             -- Ignore single char cuts
map('i', 'jj' , '<Esc>')         -- Easy escape to normal mode

map('n', '<leader>bd', '<cmd>bdelete<CR>')

map('n', ';', ':')
map('v', ';', ':')

--------------------------- LSP ---------------------------
map('n', '<leader>la', '<cmd>CodeActionMenu<CR>')
-- map('v', '<leader>la', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<CR>')
map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<CR>')
map('n', '<leader>li', '<cmd>Telescope lsp_implementations<CR>')
map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>')
map('n', '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<CR>')
map('n', '<leader>lx', '<cmd>Telescope lsp_references<CR>')
