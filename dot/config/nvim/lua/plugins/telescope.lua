return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-telescope/telescope-frecency.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'ahmedkhalf/project.nvim',
            'AckslD/nvim-neoclip.lua',
        }
    },

    {
        'nvim-telescope/telescope-frecency.nvim',
        lazy = true,
        dependencies = { 'tami5/sqlite.lua' },
        config = function() require('telescope').load_extension('frecency') end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        build = 'make',
        config = function() require('telescope').load_extension('fzf') end
    },

    {
        'ahmedkhalf/project.nvim',
        lazy = true,
        config = function()
            require('project_nvim').setup()
            require('telescope').load_extension('projects')
        end
    },

    {
        'AckslD/nvim-neoclip.lua',
        lazy = true,
        dependencies = { 'tami5/sqlite.lua' },
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
            require('telescope').load_extension('neoclip')
        end
    },
}
