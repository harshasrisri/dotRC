local lsp_config = function ()
    vim.lsp.inlay_hint.enable(true)
    local nvim_lsp = require('lspconfig')

    -- populate completion engine with language specific LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

    -- ccls not managed by Mason. configuring it manually
    nvim_lsp.ccls.setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        init_options = {
            index = {
                threads = 16;
            },
            highlight = {
                lsRanges = true,
            },
        }
    }

    require('mason-lspconfig').setup_handlers {
        function (server_name)
            nvim_lsp[server_name].setup {
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                }
            }
        end,
        ["gopls"] = function ()
            require("go").setup {
                lsp_keymaps = false,
                lsp_cfg = {
                    capabilities = capabilities,
                }
            }
        end,
        ["lua_ls"] = function ()
            nvim_lsp.lua_ls.setup {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end,
    }

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return {
    {
        'm-pilia/vim-ccls',
        ft = { 'c', 'cpp'},
        dependencies = { 'nvim-lspconfig', 'jackguo380/vim-lsp-cxx-highlight' },
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
            require("go").setup { lsp_keymaps = false }
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
        config = lsp_config,
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim', config = function () end },
        },
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
    },

    {
        'Wansmer/symbol-usage.nvim',
        event = 'LspAttach',
        opts = {},
    }
}
