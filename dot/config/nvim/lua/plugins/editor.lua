return {
    { 'ojroques/nvim-osc52', lazy = true },
    { "kylechui/nvim-surround", opts = {}, event = 'BufReadPost' },
    { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {}, },
    { 'echasnovski/mini.align', event = 'VeryLazy', opts = {}, version = '*', },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            preset = "modern",
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>d", group = "Debugger" },
                    { "<leader>f", group = "Fuzzy find/search" },
                    { "<leader>g", group = "Git" },
                    { "<leader>l", group = "LSP" },
                    { "<leader>s", group = "Some more" },
                    { "<leader>t", group = "Terminal" },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gs", group = "surround" },
                    { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "Buffers",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "Windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
        },
    },

    {
        'chrisgrieser/nvim-spider',
        lazy = true,
        keys = {
            {"w", "<cmd>lua require('spider').motion('w')<CR>", mode = {"n", "o", "x"}},
            {"e", "<cmd>lua require('spider').motion('e')<CR>", mode = {"n", "o", "x"}},
            {"b", "<cmd>lua require('spider').motion('b')<CR>", mode = {"n", "o", "x"}},
        }
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
        opts = {
            chars = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', },
            normal_hl = 'Cursor',
        },
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
}
