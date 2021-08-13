local utils = require('utils')

--------------------------- LSP ---------------------------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    utils.map('n', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    utils.map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
    utils.map('n', '<leader>ln', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    utils.map('n', '<leader>lp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    utils.map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
    utils.map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    utils.map('n', '<leader>lD', '<cmd>Telescope lsp_document_diagnostics<cr>')
    utils.map('n', '<leader>lS', '<cmd>Telescope lsp_workspace_symbols<cr>')
    utils.map('n', '<leader>la', '<cmd>Telescope lsp_code_actions<cr>')
    utils.map('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>')
    utils.map('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>')
    utils.map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
    utils.map('n', '<leader>lw', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
    utils.map('n', '<leader>lx', '<cmd>Telescope lsp_references<cr>')
    utils.map('v', '<leader>la', '<cmd>Telescope lsp_range_code_actions<cr>')

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "ccls", "rust_analyzer", "gopls", "jdtls", "pyright" }
local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end
