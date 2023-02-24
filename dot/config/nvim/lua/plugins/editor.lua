return {
    { 'chaoren/vim-wordmotion', event = 'BufReadPost' },

    { 'ojroques/nvim-osc52', lazy = true },

    { "kylechui/nvim-surround", config = true, event = 'BufReadPost' },

    { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } },

    { 'folke/which-key.nvim', config = true, event = 'VeryLazy' },

    { 'windwp/nvim-autopairs', event = 'BufReadPost', config = true, },

    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        config = function () require('mini.ai').setup() end
    },

    {
        'ahmedkhalf/project.nvim',
        event = 'VeryLazy',
        -- Telescope extension and mapping loaded in Telescope config
        config = function() require('project_nvim').setup() end
    },

    {
        'AckslD/nvim-neoclip.lua',
        event = 'TextYankPost',
        dependencies = { 'tami5/sqlite.lua' },
        -- Telescope extension and mapping loaded in Telescope config
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
        end
    },

    {
        'yorickpeterse/nvim-window',
        lazy = true,
        keys = { { '-', function () require('nvim-window').pick() end }, },
        config = function ()
            require('nvim-window').setup({
                chars = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', },
                normal_hl = 'Cursor',
                hint_hl = 'Bold',
                border = 'rounded',
            })
        end
    },

    {
        'Rrethy/vim-illuminate',
        event = 'BufReadPost',
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true, underline = true })
            require('illuminate').configure({
                filetypes_denylist = { 'dirvish', 'fugitive', 'NvimTree' },
            })
        end
    },

    {
        'ggandor/leap.nvim',
        keys = { 's', 'S', 'gs' },
        config = function ()
            vim.api.nvim_set_hl(0, 'LeapBackDrop', { link = 'Comment' })
            require('leap').add_default_mappings()
        end
    },

    {
        'ggandor/leap-spooky.nvim',
        lazy = true,
        dependencies = 'leap.nvim',
        config = function () require('leap-spooky').setup({}) end
    },

    {
        'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        keys = {
            { '<leader>et', '<cmd>NvimTreeToggle<CR>', desc = "Toggle NvimTree" }
        },
        dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
        config = function()
            require('nvim-tree').setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
                view = {
                    width = 36,
                },
                renderer = {
                    highlight_git = true,
                    highlight_opened_files = "all",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        git_placement = 'signcolumn',
                    }
                },
                actions = {
                    open_file = {
                        window_picker = {
                            enable = false,
                        }
                    }
                }
            })
        end
    },

    {
        'echasnovski/mini.map',
        lazy = true,
        keys = {
            { "<leader>mm", "<cmd>lua require('mini.map').toggle()<CR>", desc = "Open Mini Map" },
        },
        config = function () require('mini.map').setup() end
    },
}
