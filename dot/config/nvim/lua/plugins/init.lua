local packer_bootstrap = false
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
  packer_bootstrap = true
end

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")  -- For impatient.nvim

return require('packer').startup({
function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'ojroques/nvim-osc52'
    use 'google/vim-jsonnet'
    use 'fedepujol/move.nvim'
    use 'chaoren/vim-wordmotion'
    use 'MunifTanjim/nui.nvim'
    use 'wellle/targets.vim'
    use { 'tpope/vim-rsi', event = { 'InsertEnter', 'CmdlineEnter' } }
    use { 'tpope/vim-fugitive', cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" } }
    use { 'm-pilia/vim-ccls', ft = { 'c', 'cpp'}, after = 'nvim-lspconfig' }
    use { 'godlygeek/tabular', cmd = 'Tab' }
    use { 'euclio/vim-markdown-composer', run = 'cargo build --release --locked', ft = 'markdown' }
    use { 'mzlogin/vim-markdown-toc', ft = 'markdown'}
    use { "dstein64/vim-startuptime", cmd = 'StartupTime' }
    use { 'kmonad/kmonad-vim', ft = 'kbd' }
    use { 'numtostr/FTerm.nvim', module = 'FTerm' }
    use { 'mizlan/iswap.nvim', cmd = { "ISwap", "ISwapWith" } }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'bash', 'c', 'cpp', 'go', 'json', 'lua', 'markdown' ,'regex', 'rust', 'python', 'yaml' },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        scope_incremental = '<CR>',
                        node_incremental = '<TAB>',
                        node_decremental = '<S-TAB>',
                    },
                },
            }
        end
    }

    use {
        "kylechui/nvim-surround",
        requires = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function() require("nvim-surround").setup({}) end
    }

    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        on = 'telescope',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    }

    use {
        'nvim-telescope/telescope-frecency.nvim',
        after = 'telescope.nvim',
        requires = { 'tami5/sqlite.lua', module = 'sqlite' },
        config = function() require('telescope').load_extension('frecency') end
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        after = 'telescope.nvim',
        config = function() require('telescope').load_extension('fzf') end
    }

    use {
        'ahmedkhalf/project.nvim',
        after = 'telescope.nvim',
        config = function()
            require('project_nvim').setup()
            require('telescope').load_extension('projects')
        end
    }

    use {
        'AckslD/nvim-neoclip.lua',
        after = 'telescope.nvim',
        requires = {
            { 'tami5/sqlite.lua', module = 'sqlite' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
            require('telescope').load_extension('neoclip')
        end
    }

    use {
        'terrortylor/nvim-comment',
        config = function() require('nvim_comment').setup() end
    }

    use {
        'feline-nvim/feline.nvim',
        after = 'colorscheme',
        config = function() require('feline').setup() end
    }

    use {
        't9md/vim-choosewin',
        cmd = 'ChooseWin',
        config = function()
            vim.api.nvim_exec([[
                let g:choosewin_overlay_enable = 1
                let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
                let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }
            ]], false)
        end
    }

    use {
        'neovim/nvim-lspconfig',
        ft = { "c", "cpp", "rust", "python", "go", "lua" },
        config = function() require('plugins/lsp') end
    }

    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup() end
    }

    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { "rust_analyzer", "gopls", "jdtls", "pylsp", "sumneko_lua" },
                automatic_installation = true,
            })
        end
    }

    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
            }
            vim.api.nvim_exec([[ hi! link GitSignsCurrentLineBlame Comment ]], false)
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                use_tresitter = true,
                char_list = { '┊' , '┆' , '¦', '|' },
                show_first_indent_level = false,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            }
        end
    }

    use {
        'akinsho/bufferline.nvim',
        after = 'colorscheme',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    show_tab_indicators = true,
                    separator_style = 'slant',
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = false,
                            text_align = 'left',
                        }
                    },
                }
            }
        end
    }

    use {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        config = function() require('symbols-outline').setup() end
    }

    use {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        config = function()
            require('zen-mode').setup {
                plugins = {
                    gitsigns = { enabled = true } -- disables git signs
                },
            }
        end
    }

    use {
        'folke/twilight.nvim',
        cmd = 'TwilightEnable',
        config = function() require('twilight').setup { context = 0 } end
    }

    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup() end
    }

    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup()
        end
    }

    use {
        'karb94/neoscroll.nvim',
        event = 'WinScrolled',
        config = function() require('neoscroll').setup() end
    }

    use {
        'marko-cerovac/material.nvim',
        as = 'colorscheme',
        config = function()
            vim.g.material_style = "oceanic"
            require('material').setup ({
                contrast = { floating_windows = true, terminal = true, cursor_line = true, sidebars = true },
                styles = {
                    comments = { italic = true, },
                    keywords = { bold = true, },
                },
                high_visibility = { darker = true, lighter = true, },
                disable = { eob_lines = true, },
                plugins = { "gitsigns", "indent-blankline", "nvim-tree", "telescope", "which-key", }
            })
            vim.cmd[[colorscheme material]]
        end
    }

    use {
        'simrat39/rust-tools.nvim',
        after = 'nvim-lspconfig',
        ft = { "rust" },
        config = function() require('rust-tools').setup() end
    }

    use {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        requires = { 'nvim-lspconfig' },
        config = function() require('plugins/cmp') end
    }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'onsails/lspkind-nvim', module = 'lspkind' }

    use { 'L3MON4D3/LuaSnip', after = 'nvim-cmp' }
    use { 'rafamadriz/friendly-snippets', after = 'LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp', 'LuaSnip' } }

    use {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        position = { row = "33%", col = "50%", },
                        size = { width = "auto", height = "auto", },
                    },
                },
                routes = {
                    {
                        filter = { event = "msg_show", kind = "search_count", },
                        view = "mini",
                    },
                },
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }

    use {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = function() require('numb').setup() end
    }

    use {
        'gorbit99/codewindow.nvim',
        keys = '<leader>mm',
        config = function()
            local codewindow = require('codewindow')
            codewindow.setup()
            codewindow.apply_default_keybinds()
        end,
    }

    use {
        'Rrethy/vim-illuminate',
        after = 'colorscheme',
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
        end
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
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
    }

    use {
        'hashivim/vim-terraform',
        ft = { 'terraform', 'hcl', 'terraform-vars' },
        config = function()
            vim.cmd([[let g:terraform_fmt_on_save=1]])
            vim.cmd([[let g:terraform_align=1]])
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
  display = {
    prompt_border = 'rounded',
    open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
    end
  }
}})
