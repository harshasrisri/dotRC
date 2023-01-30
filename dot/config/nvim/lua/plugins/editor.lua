return {
    'chaoren/vim-wordmotion',

    { 'ojroques/nvim-osc52', lazy = true },

    { "kylechui/nvim-surround", config = true, event = 'VeryLazy' },

    { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } },

    { 'folke/which-key.nvim', config = true, },

    { 'windwp/nvim-autopairs', event = 'VeryLazy', config = true, },

    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        config = function () require('mini.ai').setup() end
    },

    {
        't9md/vim-choosewin',
        cmd = 'ChooseWin',
        keys = {
            { '-', '<cmd>ChooseWin<CR>' },

        },
        config = function()
            vim.api.nvim_exec([[
                let g:choosewin_overlay_enable = 1
                let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
                let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }
            ]], false)
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
        lazy = true,
    },
}
