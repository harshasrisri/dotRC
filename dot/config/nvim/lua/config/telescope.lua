local utils = require('utils')
require('telescope').load_extension('projects')
---------------------------- Telescope -------------------------
utils.map('n', '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
utils.map('n', '<leader>f:', '<cmd>Telescope commands<cr>')
utils.map('n', '<leader>f?', '<cmd>Telescope search_history<cr>')
utils.map('n', '<leader>fK', '<cmd>Telescope man_pages<cr>')
utils.map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
utils.map('n', '<leader>fe', '<cmd>Telescope file_browser<cr>')
utils.map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
utils.map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>')
utils.map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>')
utils.map('n', '<leader>fl', '<cmd>Telescope live_grep<cr>')
utils.map('n', '<leader>fm', '<cmd>Telescope builtin<cr>')
utils.map('n', '<leader>fo', '<cmd>Telescope vim_options<cr>')
utils.map('n', '<leader>fq', '<cmd>Telescope command_history<cr>')
utils.map('n', '<leader>fr', '<cmd>Telescope grep_string<cr>')
utils.map('n', '<leader>ft', '<cmd>TodoTelescope<cr>')
utils.map('n', '<leader>gC', '<cmd>Telescope git_commits<cr>')
utils.map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>')
utils.map('n', '<leader>gc', '<cmd>Telescope git_bcommits<cr>')
