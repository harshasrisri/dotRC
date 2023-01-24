local luasnip_config = function ()
    local present, luasnip = pcall(require, "luasnip")
    if not present then
        return
    end

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col "." - 1
        if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
            return true
        else
            return false
        end
    end

    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
        elseif luasnip and luasnip.expand_or_jumpable() then
            return t "<Plug>luasnip-expand-or-jump"
        elseif check_back_space() then
            return t "<Tab>"
        else
            return vim.fn["compe#complete"]()
        end
    end

    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
        elseif luasnip and luasnip.jumpable(-1) then
            return t "<Plug>luasnip-jump-prev"
        else
            return t "<S-Tab>"
        end
    end

    _G.completions = function()
        local npairs
        if not pcall(function() npairs = require "nvim-autopairs" end) then
            return
        end

        if vim.fn.pumvisible() == 1 then
            if vim.fn.complete_info()["selected"] ~= -1 then
                return vim.fn["compe#confirm"] "<CR>"
            end
        end
        return npairs.check_break_line_char()
    end

    vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", { expr = true })
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })

    luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    }
    require("luasnip/loaders/from_vscode").load()
end

local cmp_config = function ()
    vim.cmd [[set shortmess+=c]]
    vim.o.completeopt = "menuone,noselect,noinsert"

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local cmp = require('cmp')

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        mapping = {
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
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'calc' },
        }),

        formatting = {
            format = lspkind.cmp_format({
                with_text = true,
                menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    path = "[Path]",
                })
            }),
        },
    })

    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' },
        }
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'cmdline' },
            { name = 'path' },
            { name = 'buffer' },
        })
    })
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
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path' },
            { 'onsails/lspkind-nvim' },
            {
                'L3MON4D3/LuaSnip',
                config = luasnip_config,
            },
            { 'rafamadriz/friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip' },
        },
        config = cmp_config,
    },
}
