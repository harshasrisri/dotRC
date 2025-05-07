local leet_arg = "leetcode.nvim"

return {
    { 'echasnovski/mini.comment', event = 'BufReadPost', opts = {} },

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
        lazy = vim.fn.argc(-1) == 0, -- load early when opening file on CLI
        keys = { "<CR>", desc = "Initiate treesitter incremental selecion" },
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects'},
        opts = {
            ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'go', 'hcl', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'printf', 'rust', 'toml', 'vim', 'vimdoc', 'yaml' },
            hightlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 1024 * 1024 -- 1 MB
                    local filename = vim.api.nvim_buf_get_name(buf)
                    local ok, stats = pcall(vim.uv.fs_stat, filename)
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                },
            },
        },
        config = function (_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    },

    {
        'hedyhli/outline.nvim',
        cmd = 'Outline',
        keys = {
            { '<leader>lo', '<cmd>Outline<CR>', desc = "Toggle symbols outline" },
        },
        opts = {
            outline_window = { relative_width = false, width = 40 },
            outline_items = { show_symbol_details = false }
        },
    },

    {
        'wansmer/treesj',
        cmd = 'TSJToggle',
        keys = { { '<leader>sj', '<cmd>TSJToggle<CR>', desc = "Toggle Split/Join" } },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = { use_default_keymaps = false },
    },

    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        branch = "dev",
        lazy = leet_arg ~= vim.fn.argv()[1],
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            lang = "rust",
            arg = leet_arg,
        },
    }
}
