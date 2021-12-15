local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")  -- For impatient.nvim

return require('packer').startup({
function()
    use 'wbthomason/packer.nvim'

    use { 'chaoren/vim-wordmotion', event = 'BufRead' }
    use { 'wellle/targets.vim', event = 'BufRead' }
    use { 'tpope/vim-rsi', event = 'VimEnter' }
    use { 'tpope/vim-surround', event = 'BufRead', requires = 'tpope/vim-repeat' }
    use { 'lewis6991/impatient.nvim', rocks = 'mpack'}
    use { 'tpope/vim-fugitive', cmd = { "Git", "Gdiff", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" } }
    use { 'm-pilia/vim-ccls', ft = { 'c', 'cpp'} }
    use { 'godlygeek/tabular', cmd = 'Tab' }
    use { 'euclio/vim-markdown-composer', run = 'cargo build --release --locked', ft = 'markdown' }
    use { 'mzlogin/vim-markdown-toc', ft = 'markdown'}
    use { "tweekmonster/startuptime.vim", cmd = 'StartupTime' }
    use { 'kmonad/kmonad-vim', ft = 'kbd' }
    use { 'numtostr/FTerm.nvim', module = 'FTerm' }

    use {
        'nvim-treesitter/nvim-treesitter', 
        ft = { "c", "cpp", "rust", "python", "go", "lua" }, 
        run = ':TSUpdate', 
    }

    use { 
        'nvim-telescope/telescope.nvim', 
        cmd = 'Telescope', 
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
        config = function() require('telescope').load_extension('projects') end
    }

    use {
        "nvim-telescope/telescope-frecency.nvim",
        after = 'telescope.nvim',
        requires = { 'tami5/sqlite.lua', after = { 'telescope-frecency.nvim' } },
        config = function() require'telescope'.load_extension('frecency') end
    }

    use { 
        'terrortylor/nvim-comment', 
        event = 'BufRead',
        config = function() require('nvim_comment').setup() end 
    }

    use {
        'famiu/feline.nvim',
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
        event = 'BufRead',
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
        cmd = 'TodoTelescope',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup() end
    }

    use {
        'akinsho/nvim-bufferline.lua',
        after = 'colorscheme',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    show_tab_indicators = true,
                    separator_style = 'slant',
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
        'windwp/nvim-autopairs',
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
            vim.g.material_style = "deep ocean",
            require('material').setup {
                borders = true,
                popup_menu = "colorful",
                italics = {
                    comments = "true"
                },
                text_contrast = {
                    darker = true
                }
            }
            vim.cmd[[colorscheme material]]
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
        end
    }

    use {
        'simrat39/rust-tools.nvim',
        after = 'nvim-lspconfig',
        ft = rust,
        config = function() require('rust-tools').setup() end
    }
end,
config = {
  display = {
    prompt_border = 'rounded',
    open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
    end
  }
}})
