local lsp_config = function ()
    local nvim_lsp = require('lspconfig')

    -- populate completion engine with language specific LSP capabilities
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- ccls not managed by Mason. configuring it manually
    nvim_lsp.ccls.setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        init_options = {
            index = {
                threads = 16;
            };
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
        ["rust_analyzer"] = function ()
            require("rust-tools").setup {}
        end,
        ["sumneko_lua"] = function ()
            nvim_lsp.sumneko_lua.setup {
                settings = {
                    Lua = {
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
    },

    {
        'williamboman/mason.nvim',
        lazy = true,
        config = true,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "gopls", "jdtls", "jsonls", "jsonnet_ls", "marksman", "pylsp",
                    "rust_analyzer", "sumneko_lua", "terraformls", "tflint", "yamlls",
                },
                automatic_installation = true,
            })
        end
    },

    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        config = lsp_config,
    },

    {
        'simrat39/rust-tools.nvim',
        ft = { "rust" },
    },

    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu'
    },
}
