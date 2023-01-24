return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    },

    {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = {
            { 'tami5/sqlite.lua' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function() require('telescope').load_extension('frecency') end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function() require('telescope').load_extension('fzf') end
    },

    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup()
            require('telescope').load_extension('projects')
        end
    },

    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            { 'tami5/sqlite.lua' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
            require('telescope').load_extension('neoclip')
        end
    },
}
