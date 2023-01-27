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

map('n', '-', ':ChooseWin<CR>')

map('n', '<leader>s', '<cmd>ISwapWith<CR>')

map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>')
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<leader>bd', '<cmd>bdelete<CR>')

map('n', ';', ':')
map('v', ';', ':')

---------------------------- Telescope -------------------------
vim.cmd('command! TelescopeGrepOpenBuffers lua require("telescope.builtin").live_grep({ prompt_title = "Find string in open buffers", grep_open_files = true })')
vim.cmd('command! TelescopeGrepInPWD lua local input_string = vim.fn.input("Search For > ") if (input_string == "") then return end require("telescope.builtin").grep_string({ prompt_title = "Find in Files: " .. input_string, search = input_string, }) ')
map('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>f:', '<cmd>Telescope command_history<CR>')
map('n', '<leader>f?', '<cmd>Telescope search_history<CR>')
map('n', '<leader>fB', '<cmd>TelescopeGrepOpenBuffers<CR>')
map('n', '<leader>fK', '<cmd>Telescope man_pages<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands<CR>')
map('n', '<leader>fe', '<cmd>Telescope file_browser<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>TelescopeGrepInPWD<CR>')
map('n', '<leader>fh', '<cmd>Telescope frecency<CR>')
map('n', '<leader>fj', '<cmd>Telescope jumplist<CR>')
map('n', '<leader>fl', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fm', '<cmd>Telescope builtin<CR>')
map('n', '<leader>fn', '<cmd>Noice telescope<CR>')
map('n', '<leader>fo', '<cmd>Telescope vim_options<CR>')
map('n', '<leader>fp', '<cmd>Telescope projects<CR>')
map('n', '<leader>fr', '<cmd>Telescope resume<CR>')
map('n', '<leader>fy', '<cmd>Telescope neoclip<CR>')
map('n', '<leader>gC', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>gb', '<cmd>Telescope git_branches<CR>')
map('n', '<leader>gc', '<cmd>Telescope git_bcommits<CR>')
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')

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

-- FTerm.nvim
map('n', '<leader>t', function() require('FTerm').toggle() end)
map('t', '<Esc><Esc>', function() require('FTerm').toggle() end)

--NvimTree
map('n', '<leader>et', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>ef', '<cmd>NvimTreeFocus<CR>')
map('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>')

-- Git Signs
    -- Navigation
    map('n', ']c', '<cmd>Gitsigns next_hunk<CR>')
    map('n', '[c', '<cmd>Gitsigns prev_hunk<CR>')

    -- Actions
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
    map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
    map('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

-- Silicon
map('v', '<leader>ss', '<cmd>lua require("silicon").visualise_api({})<CR>')
map('v', '<leader>sb', '<cmd>lua require("silicon").visualise_api({show_buf = true})<CR>')
map('v', '<leader>sy', '<cmd>lua require("silicon").visualise_api({to_clip = true})<CR>')
