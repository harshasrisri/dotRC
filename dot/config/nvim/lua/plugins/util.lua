return {
    {
        'tpope/vim-fugitive',
        cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" }
    },

    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        keys = {
            -- Navigation
            { ']c', '<cmd>Gitsigns next_hunk<CR>' },
            { '[c', '<cmd>Gitsigns prev_hunk<CR>' },
            -- Actions
            { '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>' },
            { '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>' },
            { '<leader>hd', '<cmd>Gitsigns diffthis<CR>' },
            { '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>' },
            { '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>' },
            { '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>' },
            { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>' },
            { '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>' },
            -- Text object
            { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = 'o' },
            { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = 'x'},
        },
        opts = {
            current_line_blame = true,
            current_line_blame_formatter = ' <author>, <author_time:%R>: <summary>'
        },
    },

    {
        'sindrets/diffview.nvim',
        config = true,
        cmd = { "DiffviewOpen" },
        keys = {
            {'<leader>dvo', ':DiffviewOpen ' },
            {'<leader>dvh', ':DiffviewFileHistory ' },
            {'<leader>dvc', '<cmd>DiffviewClose<CR>' },
        },
    },

    {
        'akinsho/toggleterm.nvim',
        lazy = true,
        keys = {
            {'<leader>tf', '<cmd>ToggleTerm direction=float name=" Scratch "<CR>'},
            {'<leader>th', '<cmd>ToggleTerm direction=horizontal name=" Scratch "<CR>'},
            {'<leader>tv', '<cmd>ToggleTerm direction=vertical name=" Scratch "<CR>'},
            {'<leader><Esc>', [[<C-\><C-n>]], mode = 't', desc = "Normal mode" },
            {'<Esc><Esc>', '<cmd>ToggleTerm<CR>', mode = 't', desc = "Hide terminal" },
        },
        opts = {
            size = function(term)
                if term.direction == 'horizontal' then return vim.o.lines * 0.4
                elseif term.direction == 'vertical' then return vim.o.columns * 0.4
                end
            end,
            float_opts = {
                width = function() return math.floor(vim.o.columns * 0.9) end,
                height = function() return math.floor(vim.o.lines * 0.9) end,
                border = 'curved',
                title_pos = 'center',
            },
        },
    },

    {
        "narutoxy/silicon.lua",
        lazy = true,
        keys = {
            { '<leader>ss', '<cmd>lua require("silicon").visualise_api({})<CR>', mode = 'v' },
            { '<leader>sb', '<cmd>lua require("silicon").visualise_api({show_butrue})<CR>', mode = 'v' },
            { '<leader>sy', '<cmd>lua require("silicon").visualise_api({to_cliprue})<CR>', mode = 'v' },
        },
        opts = {
            font = "MesloLGS NF",
            output = string.format("~/Downloads/nvim_silicon_%s%s%s_%s%s%s.png",
                os.date("%Y"),os.date("%m"),os.date("%d"),
                os.date("%H"),os.date("%M"),os.date("%S")),
        },
    },

    {
        'simondrake/decorated_yank',
        lazy = true,
        requires = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>yd', function() require('decorated_yank').decorated_yank() end, mode = 'v' },
            { '<leader>yl', function() require('decorated_yank').decorated_yank_with_link() end, mode = 'v' },
        },
        opts = {
            domains = {
                github = {
                    url = "github.com",
                    blob = "/blob/",
                    line_format = "#L%s-L%s",
                },
            }
        },
    },

    { 'nvim-lua/plenary.nvim', lazy = true },
}
