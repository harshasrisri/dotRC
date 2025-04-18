local lsp_config = function ()
    vim.lsp.inlay_hint.enable(true)
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
            },
            highlight = {
                lsRanges = true,
            },
        }
    }

    nvim_lsp.gopls.setup {
        capabilities = capabilities,
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
        ["rust_analyzer"] = function () end,
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
        'folke/neodev.nvim',
        ft = 'lua',
        dependencies = 'nvim-lspconfig',
        opts = {library = { plugins = { "nvim-dap-ui" }, types = true }},
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^5',
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
            -- require('go').setup()
        end
    },

    {
        'hashivim/vim-terraform',
        ft = { 'terraform', 'hcl', 'terraform-vars' },
        dependencies = 'nvim-lspconfig',
        init = function()
            vim.g.terraform_fmt_on_save = 1
            vim.g.terraform_align = 1
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
        opts = {},
    },

    {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        opts = {
                ensure_installed = {
                    "gopls", "jdtls", "jsonls", "jsonnet_ls", "marksman", "pylsp",
                    "lua_ls", "terraformls", "tflint", "yamlls",
                },
                automatic_installation = true,
            },
    },

    {
        'neovim/nvim-lspconfig',
        ft = { 'json', 'jsonnet', 'markdown', 'python', 'yaml'},
        config = lsp_config,
        dependencies = { 'mason.nvim', 'mason-lspconfig.nvim', 'lsp_lines.nvim', 'symbol-usage.nvim', 'nvim-navbuddy' },
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
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        keys = {
            { '<leader>lo', '<cmd>Navbuddy<CR>', desc = "See overview of source file" },
        },
        opts = {
            windows = { border = "rounded", size = "80%" },
            lsp = { auto_attach = true },
            source_buffer = { follow_node = false },
        },
    },

    {
        'ErichDonGubler/lsp_lines.nvim',
        lazy = true,
        opts = {},
        config = function ()
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
    },

    {
        'Wansmer/symbol-usage.nvim',
        event = 'LspAttach',
        opts = {},
    }
}
