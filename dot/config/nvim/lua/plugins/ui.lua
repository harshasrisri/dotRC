return {
    { "MunifTanjim/nui.nvim", lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'karb94/neoscroll.nvim', event = 'BufReadPost', opts = {} },

    {
        "sho-87/kanagawa-paper.nvim",
        lazy = false,
        opts = {},
        config = function ()
            vim.cmd('colorscheme kanagawa-paper')
        end
    },

    {
        'freddiehaddad/feline.nvim',
        opts = { disable = { filetypes = { '^dapui_*', '^dap%-repl$', '^help$', } } },
    },

    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        keys = {
            { '<Tab>', '<cmd>BufferLineCycleNext<CR>' },
            { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>' },
        },
        opts = {
            options = {
                show_tab_indicators = true,
                separator_style = 'slant',
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = false,
                        text_align = 'left',
                    }
                },
            }
        }
    },

    {
        'utilyre/barbecue.nvim',
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = { exclude_filetypes = { 'gitcommit', 'fterm', 'dapui*', 'dap-repl', 'nvimtree' } },
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        keys = {
            { '<leader>fn', '<cmd>Noice telescope<CR>' },
        },
        opts = {
            views = {
                cmdline_popup = {
                    position = { row = "33%", col = "50%", },
                    size = { width = "auto", height = "auto", },
                },
            },
            routes = {
                {
                    filter = { event = "msg_show", kind = "search_count", },
                    view = "mini",
                },
            },
        },
    },

    -- {
    --     "rcarriga/nvim-notify",
    --     lazy = true,
    --     opts = {
    --         timeout = 3000,
    --         render = "wrapped-compact",
    --         stages = "fade",
    --         max_height = function()
    --             return math.floor(vim.o.lines * 0.75)
    --         end,
    --         max_width = function()
    --             return math.floor(vim.o.columns * 0.75)
    --         end,
    --     },
    -- },

    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPost',
        version = "2.20.8",
        opts = {
            use_tresitter = true,
            char_list = { '┊' , '┆' , '¦', '|' },
            show_first_indent_level = false,
            show_current_context = true,
            show_current_context_start = true,
            show_current_context_start_on_current_line = false,
            show_end_of_line = true,
        },
    },
}
