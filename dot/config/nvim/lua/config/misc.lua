local utils = require('utils')

------------------------- Git Signs -----------------------
require('gitsigns').setup({ current_line_blame = true, current_line_blame_delay = 500 })
vim.api.nvim_exec([[ hi! link GitSignsCurrentLineBlame Comment ]], false)

--------------------- Indent Blankline --------------------
require('indent_blankline').setup({ 
    use_tresitter = true, 
    char_list = {'|', '¦', '┆', '┊'} 
})

----------------------- ToDo Comments ---------------------
require('todo-comments').setup()

------------------------- TreeSitter ----------------------
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
}
