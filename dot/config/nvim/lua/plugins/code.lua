return {
    { 'google/vim-jsonnet', ft = 'jsonnet' },
    { 'mzlogin/vim-markdown-toc', ft = 'markdown'},
    { 'kmonad/kmonad-vim', ft = 'kbd' },

    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_theme = 'light'
            vim.g.mkdp_refresh_slow = 1
            if vim.fn.has('macunix') then
                vim.g.mkdp_browser = 'safari'
            end
            vim.g.mkdp_preview_options = {
                maid = {
                    diagramMarginX = 10,
                    actorMargin = 10,
                    boxMargin = 10,
                    boxTextMargin = 10,
                    messageMargin = 10,
                }
            }
        end,
    },

    {
        'mizlan/iswap.nvim',
        cmd = { "ISwapWith", "ISwapNodeWith" },
        keys = {
            { '<leader>sw', '<cmd>ISwapWith<CR>', desc = "Swap current item with another" },
            { '<leader>sn', '<cmd>ISwapNodeWith<CR>', desc = "Swap current treesitter node with another" },
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
        event = 'BufReadPost',
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
        'wansmer/treesj',
        cmd = 'TSJToggle',
        keys = {
            { '<leader>sj', '<cmd>TSJToggle<CR>', desc = "Toggle Split/Join" },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
                max_join_length = 256,
            })
        end,
    },
}
