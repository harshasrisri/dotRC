-- Show little dot when recording a macro
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return '  ' .. recording_register
  end
end

return {
    { 'nvim-tree/nvim-web-devicons', lazy = true },

    {
        "sho-87/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            gutter = true,
            dim_inactive = true,
            cache = true,
        },
        config = function ()
            vim.cmd('colorscheme kanagawa-paper')
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
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
                lualine_a = {{'mode', fmt = function(s) return s:sub(1,1) end }, {'filename', path = 1}},
                lualine_b = {{'filetype', icon_only = true}, 'lsp_status'},
                lualine_c = {{'diagnostics', sources = {'nvim_lsp', 'nvim_diagnostic'}}},
                lualine_x = {'searchcount', 'filesize'},
                lualine_y = {'progress', 'location'},
                lualine_z = {{show_macro_recording}, 'branch'},
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
        event = 'BufReadPost',
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = { exclude_filetypes = { 'gitcommit', 'fterm', 'dapui*', 'dap-repl', 'nvimtree' } },
    },

    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        event = "VeryLazy",
        opts = {
            routes = { { view = "notify", filter = { event = "msg_showmode" } } },
            views = {
                cmdline_popup = {
                    border = { style = "none", padding = { 1, 1 }},
                    position = { row = "33%", col = "50%", },
                    size = { width = "auto", height = "auto", },
                    filter_options = {},
                    win_options = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
                },
            },
        },
    },
}
