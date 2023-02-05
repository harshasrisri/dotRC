return {
    {
        'marko-cerovac/material.nvim',
        priority = 1000,
        name = 'colorscheme',
        config = function()
            vim.g.material_style = "deep ocean"
            require('material').setup ({
                contrast = { floating_windows = true, terminal = true, cursor_line = true, sidebars = true },
                styles = {
                    comments = { italic = true, },
                    keywords = { bold = true, },
                },
                high_visibility = { darker = true, lighter = true, },
                disable = { eob_lines = true, },
                plugins = { "gitsigns", "indent-blankline", "nvim-tree", "telescope", "which-key", }
            })
            vim.cmd[[colorscheme material]]
        end
    },

    {
        'feline-nvim/feline.nvim',
        config = function ()
            require('feline').setup({
                disable = {
                    filetypes = {
                        '^dapui',
                        '^dap%-repl$',
                        '^NvimTree$',
                        '^packer$',
                        '^fugitive$',
                        '^fugitiveblame$',
                        '^qf$',
                        '^help$',
                    }
                }
            })
        end
    },

    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        keys = {
            { '<Tab>', '<cmd>BufferLineCycleNext<CR>' },
            { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>' },
        },
        config = function()
            require('bufferline').setup {
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
        end
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        keys = {
            { '<leader>fn', '<cmd>Noice telescope<CR>' },
        },
        config = function()
            require("noice").setup({
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
            })
        end,
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Delete all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },

    { "MunifTanjim/nui.nvim", lazy = true },

    { 'nvim-tree/nvim-web-devicons', lazy = true },

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        'karb94/neoscroll.nvim',
        event = 'BufReadPost',
        config = true,
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPost',
        config = function()
            require('indent_blankline').setup {
                use_tresitter = true,
                char_list = { '┊' , '┆' , '¦', '|' },
                show_first_indent_level = false,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            }
        end
    },
}
