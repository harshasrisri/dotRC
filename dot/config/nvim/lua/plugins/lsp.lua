local nvim_lsp = require('lspconfig')

-- list of langservers to configure
local servers = { "ccls", "rust_analyzer", "gopls", "jdtls", "pylsp", "sumneko_lua" }

-- populate completion engine with language specific LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer local keybindings when the language server attaches
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

nvim_lsp.ccls.setup {
  init_options = {
    index = {
      threads = 16;
    };
  }
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
