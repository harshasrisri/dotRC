return {
    {
        'tpope/vim-fugitive',
        cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" }
    },

    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
                current_line_blame_formatter = '▶️▶️ <author>, <author_time:%R>: <summary>'
            }
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
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
