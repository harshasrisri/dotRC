local utils = require('utils')

------------------------- Git Signs -----------------------
require('gitsigns').setup { 
    current_line_blame = true, 
    current_line_blame_delay = 500,
}
vim.api.nvim_exec([[ hi! link GitSignsCurrentLineBlame Comment ]], false)

--------------------- Indent Blankline --------------------
require('indent_blankline').setup { 
    use_tresitter = true, 
    char_list = { '┊' , '┆' , '¦', '|' },
    show_first_indent_level = false,
}

----------------------- ToDo Comments ---------------------
require('todo-comments').setup()

------------------------- TreeSitter ----------------------
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
}

-------------------------- LSP Kind -----------------------
require('lspkind').init()

--------------------- Symbols Outline ---------------------
require('symbols-outline').setup()

---------------------- LSP Signature ----------------------
require('lsp_signature').setup()

--------------------- Nvim Bufferline ---------------------
vim.opt.termguicolors = true
require('bufferline').setup {
    options = {
        show_tab_indicators = true,
        separator_style = 'slant'
    }
}
utils.map('n', 'C-n', ':BufferLineCycleNext<CR>')
utils.map('n', 'C-p', ':BufferLineCyclePrev<CR>')

------------------- Zen Mode & Twilight -------------------
require('twilight').setup { context = 0 }

require('zen-mode').setup {
    window = {
        backdrop = 1,
        width = 0.8,
        height = 0.9,
        options = {
            number = false,         -- disable number column
            relativenumber = false, -- disable relative numbers
            foldcolumn = "0",       -- disable fold column
            list = false,           -- disable whitespace characters
        },
    },
    plugins = {
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = false }     -- disables tmux statusline
    },
}

----------------------- Which Key -------------------------
require('which-key').setup()

------------------Treesitter Context ----------------------
require('treesitter-context').setup()

----------------------- Auto Pairs ------------------------
require('nvim-autopairs').setup()
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false,  -- auto select first item
})

--------------------- Smooth Scroll -----------------------
require('neoscroll').setup()

----------------------- ISwap Nvim ------------------------
utils.map('n', '<leader>gS', ':ISwap<CR>')
utils.map('n', '<leader>gs', ':ISwapWith<CR>')
