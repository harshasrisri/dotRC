local cmp_config = function ()
    vim.opt.shortmess:append({ c = true })
    vim.o.completeopt = "menuone,noselect,noinsert"

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require('luasnip')
    local cmp = require('cmp')

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        mapping = {
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }, { 'i', 'c', 's' }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "c", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "c", "s" }),
        },

        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'luasnip', keyword_length = 3 },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'calc' },
            {
                name = 'buffer',
                keyword_length = 3,
                option = {
                    get_bufnrs = function ()
                        return vim.api.nvim_list_bufs()
                    end
                }
            },
        }),

        window = {
            completion = {
                border = { '', '', '', '', '', '', '', '▎' },
                col_offset = 1,
                side_padding = 0,
            },
            documentation = {
                border = { '', '', '', '▎', '', '', '', '▎' },
            }
        },

        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                })(entry, vim_item)

                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = " (" .. (strings[2] or "") .. ")"

                return kind
            end,
        },

        sorting = {
            comparators = {
                function (...) return require('cmp_buffer'):compare_locality(...) end,
            },
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'cmdline' },
            { name = 'path' },
            { name = 'buffer' },
        })
    })

    require('cmp').event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done()
    )
end

return {
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-calc' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-emoji' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp', dependencies = 'nvim-lspconfig' },
            { 'onsails/lspkind-nvim', dependencies = 'nvim-lspconfig' },
            { 'saadparwaiz1/cmp_luasnip' },
        },
        config = cmp_config,
    },

    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
}
