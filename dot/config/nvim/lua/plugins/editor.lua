return {
    { "kylechui/nvim-surround", opts = {}, event = 'BufReadPost' },
    { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {}, },
    { 'echasnovski/mini.align', event = 'BufReadPost', opts = {}, version = '*', },
    { 'mzlogin/vim-markdown-toc', ft = 'markdown'},

    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = function ()
            require('lazy').load({ plugins = {'markdown-preview.nvim'}})
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            -- vim.g.mkdp_auto_start = 1
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_combine_preview = 1
            vim.g.mkdp_theme = 'light'
            vim.g.mkdp_refresh_slow = 1
            -- if vim.loop.os_uname().sysname == 'Darwin' then
            --     vim.g.mkdp_browser = 'safari'
            -- end
            vim.g.mkdp_preview_options = {
                maid = {
                    diagramMarginX = 10,
                    actorMargin = 10,
                    boxMargin = 10,
                    boxTextMargin = 10,
                    messageMargin = 10,
                }
            }
        end,
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
            preset = 'obsidian',
        },
    },

    {
        'echasnovski/mini.ai',
        event = 'BufReadPost',
        opts = function ()
            local ai = require("mini.ai")
            return {
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({
                        a = { "@function.outer" },
                        i = { "@function.inner" },
                    }),
                    C = ai.gen_spec.treesitter({
                        a = { "@class.outer" },
                        i = { "@class.inner" },
                    }),
                    c = ai.gen_spec.treesitter({
                        a = { "@comment.outer" },
                        i = { "@comment.inner" },
                    }),
                }
            }
        end
    },

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
                    { "<leader>d", group = "[D]ebugger" },
                    { "<leader>f", group = "[F]uzzy find/search" },
                    { "<leader>g", group = "[G]it" },
                    { "<leader>l", group = "[L]SP" },
                    { "<leader>s", group = "[S]ome more" },
                    { "<leader>t", group = "[T]erminal" },
                    { "g", group = "[G]oto" },
                    { "z", group = "Fold" },
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
        dependencies = { 'tami5/sqlite.lua', 'nvim-telescope/telescope.nvim' },
        keys = {
            { "<leader>fy", function () require('telescope').extensions.neoclip.default() end, desc = "Clipboard History" }
        },
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
        opts = { large_file_overrides = { delay = 200, providers = { "lsp" } } },
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true, underline = true })
        end
    },

    {
        'ggandor/leap.nvim',
        event = 'BufReadPost',
        keys = {
            { 'gl', '<Plug>(leap-anywhere)', desc = "Go leap anywhere", mode = "n" },
            { 'gl', '<Plug>(leap)', desc = "Leap in buffer", mode = {"o", "x"}},
        },
        config = function ()
            vim.api.nvim_set_hl(0, 'LeapBackDrop', { link = 'Comment' })
        end
    },
}
