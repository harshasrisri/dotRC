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
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'ayu_dark',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                lualine_a = {'branch', {'filename', path = 1}},
                lualine_b = {{'filetype', icon_only = true}, 'lsp_status'},
                lualine_c = {{'diagnostics', sources = {'nvim_lsp', 'nvim_diagnostic'}}},
                lualine_x = {'searchcount', 'filesize'},
                lualine_y = {'progress', 'location'},
                lualine_z = {'mode'},
            },
            tabline = {
                lualine_a = {{'buffers', padding = 2, use_mode_colors = true}},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {{'datetime', style = '%m/%d %H:%M'}},
                lualine_z = {'tabs', 'hostname'},
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {'nvim-tree', 'symbols-outline', 'toggleterm'},
        },
        config = true,
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
