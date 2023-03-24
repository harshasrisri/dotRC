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
        dependencies = 'nvim-lspconfig',
    },

    {
        'folke/neodev.nvim',
        ft = 'lua',
        dependencies = 'nvim-lspconfig',
        config = function ()
            require('neodev').setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end
    },

    {
        'simrat39/rust-tools.nvim',
        ft = { "rust" },
        dependencies = 'nvim-lspconfig',
    },

    {
        'hashivim/vim-terraform',
        ft = { 'terraform', 'hcl', 'terraform-vars' },
        dependencies = 'nvim-lspconfig',
        config = function()
            vim.g.terraform_fmt_on_save = 1
            vim.g.terraform_align = 1
        end
    },

    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        keys = {
            { '<leader>la', '<cmd>CodeActionMenu<CR>' },
        },
    },

    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
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
        ft = { 'go', 'json', 'jsonnet', 'markdown', 'python', 'yaml'},
        config = lsp_config,
        dependencies = { 'mason.nvim', 'mason-lspconfig.nvim', 'lsp_lines.nvim' },
        keys = {
            -- { '<leader>la', '<cmd>lua vim.lsp.buf.range_code_action()<CR>' },
            { '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>' },
            { '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>' },
            { '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>' },
            { '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>' },
            { '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>' },
            { '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>' },
            { '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<CR>' },
            { '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<CR>' },
            { '<leader>ld', '<cmd>Telescope lsp_definitions<CR>' },
            { '<leader>li', '<cmd>Telescope lsp_implementations<CR>' },
            { '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>' },
            { '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<CR>' },
            { '<leader>lx', '<cmd>Telescope lsp_references<CR>' },
        },
    },

    {
        'ErichDonGubler/lsp_lines.nvim',
        lazy = true,
        config = function ()
            require('lsp_lines').setup()
            vim.diagnostic.config({ virtual_text = false })
            vim.keymap.set(
                '',
                '<leader>ll',
                function ()
                    local new_value = not vim.diagnostic.config().virtual_text
                    vim.diagnostic.config({ virtual_text = new_value })
                    require('lsp_lines').toggle()
                end,
                { desc = "Toggle lsp_lines" }
            )
        end
    }
}
