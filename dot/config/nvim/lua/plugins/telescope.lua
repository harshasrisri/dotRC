return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            -- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
            'nvim-telescope/telescope-frecency.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'ahmedkhalf/project.nvim',
            'AckslD/nvim-neoclip.lua',
        },
        keys = {
            -- Core Telescope maps only. Integrations have their own Telescope maps.
            { '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<CR>' },
            { '<leader>f:', '<cmd>Telescope command_history<CR>' },
            { '<leader>f?', '<cmd>Telescope search_history<CR>' },
            { '<leader>fK', '<cmd>Telescope man_pages<CR>' },
            { '<leader>fb', '<cmd>Telescope buffers<CR>' },
            { '<leader>fc', '<cmd>Telescope commands<CR>' },
            { '<leader>fe', '<cmd>Telescope file_browser<CR>' },
            { '<leader>ff', '<cmd>Telescope find_files<CR>' },
            { '<leader>fh', '<cmd>Telescope frecency<CR>' },
            { '<leader>fj', '<cmd>Telescope jumplist<CR>' },
            { '<leader>fl', '<cmd>Telescope live_grep<CR>' },
            { '<leader>fm', '<cmd>Telescope builtin<CR>' },
            { '<leader>fo', '<cmd>Telescope vim_options<CR>' },
            { '<leader>fr', '<cmd>Telescope resume<CR>' },
            { '<leader>gC', '<cmd>Telescope git_commits<CR>' },
            { '<leader>gb', '<cmd>Telescope git_branches<CR>' },
            { '<leader>gc', '<cmd>Telescope git_bcommits<CR>' },
            { '<leader>gs', '<cmd>Telescope git_status<CR>' },
        },
        config = function ()
            require('telescope').setup()
            vim.api.nvim_create_user_command(
                'TelescopeGrepInPWD',
                function ()
                    local input_string = vim.fn.input("Search For > ")
                    if (input_string == "") then
                        return
                    end
                    require("telescope.builtin").grep_string({
                        prompt_title = "Find in Files: " .. input_string, search = input_string,
                    })
                end,
                {}
            )
            vim.api.nvim_create_user_command(
                'TelescopeGrepOpenBuffers',
                function()
                    require("telescope.builtin").live_grep({
                        prompt_title = "Find string in open buffers",
                        grep_open_files = true
                    })
                end,
                {}
            )
            vim.keymap.set('n', '<leader>fB', '<cmd>TelescopeGrepOpenBuffers<CR>')
            vim.keymap.set('n', '<leader>fg', '<cmd>TelescopeGrepInPWD<CR>')
        end
    },

    {
        'nvim-telescope/telescope-frecency.nvim',
        lazy = true,
        dependencies = { 'tami5/sqlite.lua' },
        config = function() require('telescope').load_extension('frecency') end,
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        build = 'make',
        config = function() require('telescope').load_extension('fzf') end
    },

    {
        'ahmedkhalf/project.nvim',
        event = 'BufReadPost',
        keys = {
            { '<leader>fp', '<cmd>Telescope projects<CR>' },
        },
        config = function()
            require('project_nvim').setup()
            require('telescope').load_extension('projects')
        end
    },

    {
        'AckslD/nvim-neoclip.lua',
        lazy = true,
        keys = {
            { '<leader>fy', '<cmd>Telescope neoclip<CR>' },
        },
        dependencies = { 'tami5/sqlite.lua' },
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
            require('telescope').load_extension('neoclip')
        end
    },
}
