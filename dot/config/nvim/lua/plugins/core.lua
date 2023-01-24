return {
    -- 'lewis6991/impatient.nvim',
    'ojroques/nvim-osc52',
    'google/vim-jsonnet',
    'chaoren/vim-wordmotion',
    'wellle/targets.vim',
    { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } },
    { 'tpope/vim-fugitive', cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" } },
    { 'godlygeek/tabular', cmd = 'Tab' },
    { 'euclio/vim-markdown-composer', run = 'cargo build --release --locked', ft = 'markdown' },
    { 'mzlogin/vim-markdown-toc', ft = 'markdown'},
    { 'kmonad/kmonad-vim', ft = 'kbd' },
    { 'mizlan/iswap.nvim', cmd = { "ISwap", "ISwapWith" } },

    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'bash', 'c', 'cpp', 'go', 'hcl', 'json', 'lua', 'markdown' , 'python', 'rust', 'yaml' },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>',
                    },
                },
            }
        end
    },

    {
        "kylechui/nvim-surround",
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = true,
    },

    {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end,
    },

    {
        't9md/vim-choosewin',
        cmd = 'ChooseWin',
        config = function()
            vim.api.nvim_exec([[
                let g:choosewin_overlay_enable = 1
                let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
                let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }
            ]], false)
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
            }
            vim.api.nvim_exec([[ hi! link GitSignsCurrentLineBlame Comment ]], false)
        end
    },

    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        config = true,
    },

    {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        config = function()
            require('zen-mode').setup {
                plugins = {
                    gitsigns = { enabled = true } -- disables git signs
                },
            }
        end
    },

    {
        'folke/twilight.nvim',
        cmd = 'TwilightEnable',
        config = function() require('twilight').setup { context = 0 } end
    },

    {
        'folke/which-key.nvim',
        config = true,
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        'gorbit99/codewindow.nvim',
        keys = '<leader>mm',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    },

    {
        'Rrethy/vim-illuminate',
        after = 'colorscheme',
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Cursor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Cursor" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Cursor" })
        end
    },

    {
        'hashivim/vim-terraform',
        ft = { 'terraform', 'hcl', 'terraform-vars' },
        config = function()
            vim.cmd([[let g:terraform_fmt_on_save=1]])
            vim.cmd([[let g:terraform_align=1]])
        end
    },

    {
        "narutoxy/silicon.lua",
        module = 'silicon',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("silicon").setup({
                font = "MesloLGS NF",
                output = string.format("~/Downloads/nvim_silicon_%s%s%s_%s%s%s.png",
                    os.date("%Y"),os.date("%m"),os.date("%d"),
                    os.date("%H"),os.date("%M"),os.date("%S")),
                })
        end
    },

    {
        'ggandor/leap.nvim',
        keys = { 's', 'S', 'gs' },
        config = function () require('leap').add_default_mappings() end
    },

    {
        'ggandor/leap-spooky.nvim',
        after = 'leap.nvim',
        config = function () require('leap-spooky').setup({}) end
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
        config = function()
            require('nvim-tree').setup({
                view = {
                    width = 36,
                },
                renderer = {
                    highlight_git = true,
                    highlight_opened_files = "all",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        git_placement = 'signcolumn',
                    }
                },
                actions = {
                    open_file = {
                        window_picker = {
                            enable = false,
                        }
                    }
                }
            })
        end
    },

    {
        'numtostr/FTerm.nvim',
        module = 'FTerm',
        config = function()
            require('FTerm').setup({
                border = 'solid',
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            })
        end
    },
}
