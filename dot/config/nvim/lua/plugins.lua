local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup({
function()
    use 'wbthomason/packer.nvim'
    vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
    use {'lewis6991/impatient.nvim', rocks = 'mpack'}
    use { 'terrortylor/nvim-comment', cmd = 'CommentToggle', config = function() require('nvim_comment').setup() end }
    use { 'tpope/vim-fugitive', cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" } }
    use 'tpope/vim-repeat'
    use 'tpope/vim-rsi'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim'
    use 'chaoren/vim-wordmotion'
    use { 'm-pilia/vim-ccls', ft = 'cpp' }
    use { 'godlygeek/tabular', cmd = 'Tab' }
    use { 'euclio/vim-markdown-composer', run = 'cargo build --release --locked', ft = 'markdown' }
    use { 'mzlogin/vim-markdown-toc', ft = 'markdown'}
    use { "tweekmonster/startuptime.vim", cmd = 'StartupTime' }

    use {
        'famiu/feline.nvim',
        config = function()
            require('feline').setup()
        end
    }

    use {
        't9md/vim-choosewin',
        cmd = 'ChooseWin',
        config = function()
            vim.api.nvim_exec([[
                nmap - :ChooseWin<CR>
                let g:choosewin_overlay_enable = 1
                let g:choosewin_color_overlay = { 'gui': ['DodgerBlue3', 'DodgerBlue3'], 'cterm': [25, 25] }
                let g:choosewin_color_overlay_current = { 'gui': ['firebrick1', 'firebrick1'], 'cterm': [124, 124] }
            ]], false)
        end
    }

    use {
        'neovim/nvim-lspconfig',
        config = function() require('config/lsp') end
    }

    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
        config = function() require('config/telescope') end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        event = 'BufRead'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        event = 'BufRead',
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
            }
        end
    }

    use { 
        'folke/todo-comments.nvim', 
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup() end
    }

    use {
        'hrsh7th/nvim-compe',
        event = 'InsertEnter',
        config = function() require('config/compe') end
    }

    use {
        'onsails/lspkind-nvim',
        config = function() require('lspkind').init() end
    }

    use {
        'ray-x/lsp_signature.nvim',
        after = 'nvim-lspconfig',
        config = function() require('lsp_signature').setup() end
    }

    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    show_tab_indicators = true,
                    separator_style = 'slant',
                }
            }
            local utils = require('utils')
            utils.map('n', '<C-n>', ':BufferLineCycleNext<CR>')
            utils.map('n', '<C-p>', ':BufferLineCyclePrev<CR>')
        end
    }

    use {
        'simrat39/symbols-outline.nvim',
        config = function() require('symbols-outline').setup() end
    }

    use {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        config = function()
            require('zen-mode').setup {
                window = {
                    backdrop = 1,
                    width = 0.8,
                    height = 0.9,
                    options = {
                        number = false,         -- disable number column
                        relativenumber = false, -- disable relative numbers
                        foldcolumn = "0",       -- disable fold column
                        list = false,           -- disable whitespace characters
                    },
                },
                plugins = {
                    gitsigns = { enabled = true }, -- disables git signs
                    tmux = { enabled = false }     -- disables tmux statusline
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
        event = 'BufWinEnter',
        config = function() require('which-key').setup() end
    }

    use {
        'romgrk/nvim-treesitter-context',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('treesitter-context').setup() end
    }

    use {
        'windwp/nvim-autopairs',
        after = 'nvim-compe',
        config = function()
            require('nvim-autopairs').setup()
            require("nvim-autopairs.completion.compe").setup({
                map_cr = true, --  map <CR> on insert mode
                map_complete = true, -- it will auto insert `(` after select function or method item
                auto_select = false,  -- auto select first item
            })
        end
    }

    use {
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup() end
    }

    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-compe',
        requires = 'rafamadriz/friendly-snippets',
        config = function() require('config/luasnip') end
    }

    use {
        'EdenEast/nightfox.nvim',
        config = function()
            nightfox = require('nightfox')
            nightfox.setup {
                styles = {
                    comments = "italic",
                    strings = "italic",
                    keywords = "bold"
                }
            }
            nightfox.load()
        end
    }

    use {
        'sunjon/shade.nvim',
        event = BufSplit,
        config = function()
            require'shade'.setup({
                overlay_opacity = 50,
                opacity_step = 1,
                keys = {
                    brightness_up    = '<C-Up>',
                    brightness_down  = '<C-Down>',
                    toggle           = '<leader>sh',
                }
            })
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
        end
    }
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
