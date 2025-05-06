local map = vim.keymap.set

-- Copy to OS clipboard via OSCYank
map('n', '<leader>y', require('osc52').copy_operator, {expr = true, desc = "Yank to system clipboard" })
map('n', '<leader>yy', '<leader>y_', {remap = true}, { desc = "Yank line to system clipboard" })
map('x', '<leader>y', require('osc52').copy_visual, { desc = "Yank selection to system clipboard" })

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
map('n', '<leader>h', '<C-w>h', { desc = "Window: Go left"})
map('n', '<leader>j', '<C-w>j', { desc = "Window: Go down"})
map('n', '<leader>k', '<C-w>k', { desc = "Window: Go up"})
map('n', '<leader>l', '<C-w>l', { desc = "Window: Go right"})

-- Preserve visual selection during indentation
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Misc
map('n', 'x', '"_x')             -- Ignore single char cuts
map('i', 'jj' , '<Esc>')         -- Easy escape to normal mode

map('n', '<Tab>', '<cmd>bnext<CR>')
map('n', '<S-Tab>', '<cmd>bprevious<CR>')

map('n', ';', ':')
map('v', ';', ':')

-- Search within visual block
map("x", "/", "<Esc>/\\%V")
