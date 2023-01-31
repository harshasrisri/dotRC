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
            { '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>' },
            -- Text object
            { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = 'o' },
            { 'ih', ':<C-U>Gitsigns select_hunk<CR>' , mode = 'x'},
        },
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                current_line_blame_formatter = '▶️▶️ <author>, <author_time:%R>: <summary>'
            }
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
        end
    },

    {
        'numtostr/FTerm.nvim',
        lazy = true,
        keys = {
            {'<leader>t', function() require('FTerm').toggle() end },
            {'<Esc><Esc>', function() require('FTerm').toggle() end, mode = 't' },
        },
        config = function()
            require('FTerm').setup({
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            })
        end
    },

    {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        config = function()
            require('zen-mode').setup {
                plugins = {
                    gitsigns = { enabled = true } -- disables git signs
                },
            }
        end
    },

    {
        'folke/twilight.nvim',
        cmd = 'TwilightEnable',
        config = function() require('twilight').setup { context = 0 } end
    },

    {
        "narutoxy/silicon.lua",
        lazy = true,
        keys = {
            { '<leader>ss', '<cmd>lua require("silicon").visualise_api({})<CR>', mode = 'v' },
            { '<leader>sb', '<cmd>lua require("silicon").visualise_api({show_butrue})<CR>', mode = 'v' },
            { '<leader>sy', '<cmd>lua require("silicon").visualise_api({to_cliprue})<CR>', mode = 'v' },
        },
        config = function()
            require("silicon").setup({
                font = "MesloLGS NF",
                output = string.format("~/Downloads/nvim_silicon_%s%s%s_%s%s%s.png",
                    os.date("%Y"),os.date("%m"),os.date("%d"),
                    os.date("%H"),os.date("%M"),os.date("%S")),
            })
        end
    },

    { 'godlygeek/tabular', cmd = 'Tab' },

    { 'nvim-lua/plenary.nvim', lazy = true },
}
