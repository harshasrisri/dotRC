return {
    { 'google/vim-jsonnet', ft = 'jsonnet' },
    { 'euclio/vim-markdown-composer', build = 'cargo build --release --locked', ft = 'markdown' },
    { 'mzlogin/vim-markdown-toc', ft = 'markdown'},
    { 'kmonad/kmonad-vim', ft = 'kbd' },

    {
        'mizlan/iswap.nvim',
        cmd = "ISwapWith",
        keys = {
            { '<leader>s', '<cmd>ISwapWith<CR>' },

        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = true,
        keys = { "<CR>", desc = "Initiate treesitter incremental selecion" },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'bash', 'c', 'cpp', 'go', 'help', 'hcl', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'rust', 'vim', 'yaml' },
                hightlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>',
                    },
                },
            })
        end
    },

    {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end,
    },

    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        init = function ()
            vim.g.symbols_outline = {
                relative_width = false,
                width = 40,
                auto_preview = false,
                auto_close = true,
            }
        end,
        config = true,
    },

    {
        'hashivim/vim-terraform',
        ft = { 'terraform', 'hcl', 'terraform-vars' },
        config = function()
            vim.g.terraform_fmt_on_save = 1
            vim.g.terraform_align = 1
        end
    },
}
