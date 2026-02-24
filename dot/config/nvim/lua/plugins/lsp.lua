-- populate completion engine with language specific LSP capabilities
local _capabilities
local function get_capabilities()
    if _capabilities then return _capabilities end
    local caps = vim.lsp.protocol.make_client_capabilities()

    local ok, blink = pcall(require, "blink.cmp")
    if ok and blink and blink.get_lsp_capabilities then
        caps = vim.tbl_deep_extend("force", caps, blink.get_lsp_capabilities({}, false))
    end

    _capabilities = caps
    return _capabilities
end

return {
    { 'mrcjkb/rustaceanvim', ft = 'rust', version = '^6' },
    { 'mason-org/mason.nvim', cmd = 'Mason', build = ':MasonUpdate', opts = {} },

    {
        'ranjithshegde/ccls.nvim',
        ft = { 'c', 'cpp'},
        dependencies = { 'nvim-lspconfig' },
        opts = function ()
            return {
                codelens = {
                    enable = true,
                    events = { 'BufWritePost', 'InsertLeave' },
                },
                lsp = {
                    lspconfig = {
                        capabilities = get_capabilities(),
                        flags = { debounce_text_changes = 150 },
                        init_options = {
                            index = { threads = 16 },
                            highlight = { lsRanges = true },
                        },
                    }
                }
            }
        end
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
                lsp_cfg = { capabilities = get_capabilities() },
            })
        end
    },

    {
        'aznhe21/actions-preview.nvim',
        lazy = true,
        keys = {
            { '<leader>la', function() require('actions-preview').code_actions() end, desc = "Code Actions Menu" },
        },
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

            local installed_packages = require("mason-registry").get_installed_packages()
            local installed_lsp_names = vim.iter(installed_packages):fold({}, function(acc, pack)
                if (pack.spec.neovim and pack.spec.neovim.lspconfig) then
                    local lsp_name = pack.spec.neovim.lspconfig
                    if (lsp_name == 'rust_analyzer' or lsp_name == 'gopls') then return acc end
                    table.insert(acc, lsp_name)
                    vim.lsp.config[lsp_name].capabilities = get_capabilities()
                end
                return acc
            end)

            vim.lsp.enable(installed_lsp_names)

            -- Lua LSP (for Neovim config editing)
            vim.lsp.config.lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            }

            -- Python LSP (type checking)
            vim.lsp.config.pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        }
                    }
                }
            }

            -- Bash LSP
            vim.lsp.config.bashls = {
                filetypes = { "sh", "bash", "zsh" },
            }
        end,
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
            ensure_installed = {
                -- Language Servers
                'bash-language-server',
                'gopls',
                'lua-language-server',
                'marksman',
                'pyright',
                'ruff',
                -- Debuggers
                'codelldb',
                'delve',
                -- Linters/Formatters
                'markdownlint',
            },
            auto_update = false,
            run_on_start = true,
        }
    },
}
