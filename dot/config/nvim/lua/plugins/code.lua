local leet_arg = "leetcode.nvim"
local icon_cache = {}

return {
    { 'echasnovski/mini.comment', event = 'BufReadPost', opts = {} },

    {
        'mizlan/iswap.nvim',
        cmd = { "ISwapWith", "ISwapNodeWith" },
        keys = {
            { '<leader>sw', '<cmd>ISwapWith<CR>', desc = "Swap current item with another" },
            { '<leader>sn', '<cmd>ISwapNodeWith<CR>', desc = "Swap current treesitter node with another" },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = { ':TSUpdate', function()
            dofile(vim.fn.stdpath('config') .. '/lua/plugins/patches/nvim-treesitter-query-predicates.lua')
        end },
        lazy = vim.fn.argc(-1) == 0, -- load early when opening file on CLI
        keys = { "<CR>", desc = "Initiate treesitter incremental selecion" },
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects'},
        event = 'BufReadPost',
        opts = {
            ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'go', 'hcl', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'printf', 'rust', 'toml', 'vim', 'vimdoc', 'yaml' },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 1024 * 1024 -- 1 MB
                    local filename = vim.api.nvim_buf_get_name(buf)
                    local ok, stats = pcall(vim.uv.fs_stat, filename)
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                },
            },
        },
        config = function (_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    },

    {
        'hedyhli/outline.nvim',
        cmd = 'Outline',
        keys = {
            { '<leader>lo', '<cmd>Outline<CR>', desc = "Toggle symbols outline" },
        },
        opts = {
            outline_window = { relative_width = false, width = 40 },
            outline_items = { show_symbol_details = false }
        },
    },

    {
        'wansmer/treesj',
        cmd = 'TSJToggle',
        keys = { { '<leader>sj', '<cmd>TSJToggle<CR>', desc = "Toggle Split/Join" } },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = { use_default_keymaps = false },
    },

    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        branch = "dev",
        lazy = leet_arg ~= vim.fn.argv()[1],
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            lang = "rust",
            arg = leet_arg,
        },
    },

    {
        "saghen/blink.cmp",
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        version = "1.*",
        opts_extend = { "sources.default" },
        opts = {
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            signature = { enabled = true },
            cmdline = {
                completion = {
                    menu = { auto_show = true },
                    list = { selection = { preselect = false, auto_insert = false } },
                },
                keymap = {
                    preset = 'none',
                    ['<CR>']    = { 'accept', 'fallback' },
                    ['<Tab>']   = { 'select_next', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                },
            },
            snippets = { preset = "luasnip" },
            keymap = {
                preset = 'enter',
                ['<Tab>']   = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
                ['<C-e>']   = { 'hide', 'show', 'fallback' },
                ['<C-k>']   = { 'show_documentation', 'hide_documentation', 'fallback' },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    buffer = {
                        min_keyword_length = 3,
                        opts = {
                            get_bufnrs = function()
                                return { vim.api.nvim_get_current_buf() }
                            end,
                        },
                    },
                },
            },
            completion = {
                ghost_text = { enabled = true },
                documentation = { auto_show = true, window = { max_height = 33 } },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    if ctx.source_name == "Path" then
                                        local entry = icon_cache[ctx.label] or { require("nvim-web-devicons").get_icon(ctx.label) }
                                        icon_cache[ctx.label] = entry
                                        local dev_icon = entry[1]
                                        if dev_icon then return dev_icon .. ctx.icon_gap end
                                    end
                                    return ctx.kind_icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    if ctx.source_name == "Path" then
                                        local entry = icon_cache[ctx.label] or { require("nvim-web-devicons").get_icon(ctx.label) }
                                        icon_cache[ctx.label] = entry
                                        local dev_hl = entry[2]
                                        if dev_hl then return dev_hl end
                                    end
                                    return ctx.kind_hl
                                end,
                            },
                        },
                    },
                },
            },
        },
    }
}
