local leet_arg = "leetcode.nvim"

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
        build = ':TSUpdate',
        lazy = vim.fn.argc(-1) == 0, -- load early when opening file on CLI
        keys = { "<CR>", desc = "Initiate treesitter incremental selecion" },
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects'},
        event = 'BufReadPost',
        opts = {
            ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'go', 'hcl', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'printf', 'rust', 'toml', 'vim', 'vimdoc', 'yaml' },
            hightlight = {
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
        event = { 'InsertEnter', 'CmdLineEnter' },
        dependencies = {
            "rafamadriz/friendly-snippets",
            { 'onsails/lspkind-nvim', dependencies = 'nvim-lspconfig' },
        },
        version = "1.*",
        opts_extend = { "sources.default" },
        opts = {
            fuzzy = { implementation = 'prefer_rust' },
            signature = { enabled = true },
            cmdline = {
                completion = { menu = { auto_show = true }},
            },
            keymap = {
                preset = 'none',
                ['<C-e>'] = { 'hide', 'show', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' },
                ['<Tab>'] = {
                    function (cmp)
                        local has_words_before = function()
                            local col = vim.api.nvim_win_get_cursor(0)[2]
                            return col ~= 0 and vim.api.nvim_get_current_line():sub(col, col):match("%s") == nil
                        end
                        if cmp.is_visible() and has_words_before() then return cmp.select_next() end
                    end,
                    'snippet_forward',
                    'fallback',
                },
                ['<S-Tab>'] = {
                    function (cmp)
                        if cmp.is_visible() then return cmp.select_prev()
                        elseif cmp.snippet_active() then return cmp.snippet_backward()
                        else return cmp.fallback() end
                    end,
                },
                ['<Up>']    = { 'select_prev', 'fallback' },
                ['<Down>']  = { 'select_next', 'fallback' },
                ['<Right>'] = { 'show_documentation', 'fallback' },
                ['<Left>']  = { 'hide_documentation', 'fallback' },
                ['<C-d>']   = { 'scroll_documentation_down', 'fallback' },
                ['<C-u>']   = { 'scroll_documentation_up', 'fallback' },
                ['<C-k>']   = { 'show_signature', 'hide_signature', 'fallback' },
            },
            completion = {
                keyword = { range = 'full' },
                ghost_text = { enabled = true },
                documentation = { auto_show = true, window = { max_height = 33 } },
                menu = {
                    draw = {
                        treesitter = { 'lsp' },
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then icon = dev_icon end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol", })
                                    end
                                    return icon .. ctx.icon_gap
                                end,

                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then hl = dev_hl end
                                    end
                                    return hl
                                end,
                            }
                        }
                    }
                },
            },
        },
    }
}
