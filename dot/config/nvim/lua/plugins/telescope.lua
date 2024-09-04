return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            -- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
            'nvim-telescope/telescope-frecency.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'debugloop/telescope-undo.nvim',
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
            { '<leader>fp', '<cmd>Telescope projects<CR>' },
            { '<leader>fr', '<cmd>Telescope resume<CR>' },
            { '<leader>fu', '<cmd>Telescope undo<CR>' },
            { '<leader>fy', '<cmd>Telescope neoclip<CR>' },
            { '<leader>gC', '<cmd>Telescope git_commits<CR>' },
            { '<leader>gb', '<cmd>Telescope git_branches<CR>' },
            { '<leader>gc', '<cmd>Telescope git_bcommits<CR>' },
            { '<leader>gs', '<cmd>Telescope git_status<CR>' },
            { '<leader>fg', '<cmd>Telescope<CR><Esc><cmd>TelescopeGrepInPWD<CR>'}
        },
        opts = {},
        config = function ()
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

            -- Plugins that can function w/o loading telescope integration until this point
            require('telescope').load_extension('projects')
            require('telescope').load_extension('neoclip')
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
        'debugloop/telescope-undo.nvim',
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function() require("telescope").load_extension("undo") end,
    },
}
