-- populate completion engine with language specific LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

return {
    {
        'ranjithshegde/ccls.nvim',
        ft = { 'c', 'cpp'},
        dependencies = { 'nvim-lspconfig' },
        opts = {
            codelens = {
                enable = true,
                events = { 'BufWritePost', 'InsertLeave' },
            },
            lsp = {
                lspconfig = {
                    capabilities = capabilities,
                    flags = { debounce_text_changes = 150 },
                    init_options = {
                        index = { threads = 16 },
                        highlight = { lsRanges = true },
                    },
                }
            }
        }
    },

    {
        'folke/lazydev.nvim',
        ft = 'lua',
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^6',
        lazy = false,
    },

    {
        'ray-x/go.nvim',
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        dependencies = "nvim-lspconfig",
        config = function()
            local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
                group = format_sync_grp,
            })
            require("go").setup ({
                lsp_keymaps = false,
                lsp_cfg = { capabilities = capabilities },
            })
        end
    },

    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        dependencies = 'nvim-lspconfig',
        keys = {
            { '<leader>la', '<cmd>CodeActionMenu<CR>' },
        },
    },

    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {},
    },


    {
        'neovim/nvim-lspconfig',
        keys = {
            { '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>' },
            { '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
            { '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
            { '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>' },
            {
                '<leader>ll',
                function()
                    local new_config = not vim.diagnostic.config().virtual_lines
                    vim.diagnostic.config({ virtual_lines = new_config })
                    print("Neovim Diagnostic Virtual Lines: " .. (new_config and {"shown"} or {"hidden"})[1])
                end,
                desc = 'Toggle diagnostic virtual_lines',
            }
        },
        config = function ()
            vim.lsp.inlay_hint.enable(true)
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },

    {
        'Wansmer/symbol-usage.nvim',
        event = 'LspAttach',
        opts = {},
    }
}
