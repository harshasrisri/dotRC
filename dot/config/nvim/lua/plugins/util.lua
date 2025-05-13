return {
    { 'tpope/vim-obsession', lazy = true },
    { 'nvim-lua/plenary.nvim', lazy = true },

    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        keys = {
            -- Actions
            { '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>',    desc = "Git reset buffer" },
            { '<leader>gS', '<cmd>Gitsigns stage_buffer<CR>',    desc = "Git stage buffer" },
            { '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>',    desc = "Git preview hunk" },
            { '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>',      desc = "Git reset hunk" },
            { '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>',      desc = "Git stage hunk" },
            { '<leader>gU', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = "Git undo stage hunk" },
            -- Text object
            { 'ih', '<cmd>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },
            { 'ah', '<cmd>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },
            { ']h', '<cmd>Gitsigns next_hunk<CR>', mode = { 'n', 'o', 'x' } },
            { '[h', '<cmd>Gitsigns prev_hunk<CR>', mode = { 'n', 'o', 'x' } },
        },
        opts = {
            current_line_blame = true,
            current_line_blame_formatter = ' <author>, <author_time:%R>: <summary>'
        },
    },

    {
        'sindrets/diffview.nvim',
        config = true,
        cmd = { "DiffviewOpen" },
        opts = {
            keymaps = {
                view = {
                    { "n", "q", "<cmd>DiffViewClose<CR>", { desc = "Close help menu" } },
                },
                file_panel = {
                    { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close help menu" } },
                },
                file_history_panel = {
                    { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close help menu" } },
                },
            },
        },
        keys = {
            {'<leader>gd', '<cmd>DiffviewOpen<CR>', desc = "Git Diff Index" },
            {'<leader>gl', '<cmd>DiffviewFileHistory<CR>', desc = "File Git History" },
        },
    },

    {
        'akinsho/toggleterm.nvim',
        cmd = 'ToggleTerm',
        keys = {
            {'<leader>tf', '<cmd>ToggleTerm direction=float name=" Scratch "<CR>', desc = "Terminal in float window"},
            {'<leader>th', '<cmd>ToggleTerm direction=horizontal name=" Scratch "<CR>', desc = "Terminal in horizontal split"},
            {'<leader>tv', '<cmd>ToggleTerm direction=vertical name=" Scratch "<CR>', desc = "Terminal in vertical split"},
            {'<leader><Esc>', [[<C-\><C-n>]], mode = 't', desc = "Terminal Normal mode" },
            {'<Esc><Esc>', '<cmd>ToggleTerm<CR>', mode = 't', desc = "Hide terminal" },
            {
                '<leader>tg',
                function()
                    require('toggleterm.terminal').Terminal:new({
                        display_name = 'GitUI',
                        cmd = 'gitui',
                        hidden = true,
                        direction = 'float',
                    }):toggle()
                end,
                desc = "GitUI in float terminal",
            }
        },
        opts = {
            size = function(term)
                if term.direction == 'horizontal' then return vim.o.lines * 0.4
                elseif term.direction == 'vertical' then return vim.o.columns * 0.4
                end
            end,
            float_opts = {
                width = function() return math.floor(vim.o.columns * 0.9) end,
                height = function() return math.floor(vim.o.lines * 0.9) end,
                border = 'curved',
                title_pos = 'center',
            },
        },
    },

    {
        'simondrake/decorated_yank',
        lazy = true,
        requires = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>yb', function() require('decorated_yank').blame_link() end, mode = 'v' },
            { '<leader>yd', function() require('decorated_yank').decorated_yank() end, mode = 'v' },
            { '<leader>yl', function() require('decorated_yank').decorated_yank_with_link() end, mode = 'v' },
        },
        opts = {
            domains = {
                github = {
                    url = "github.com",
                    blob = "/blob/",
                    blame = "/blame/",
                    line_format = "#L%s-L%s",
                },
            }
        },
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            { "<leader>bd",  function() require('snacks').bufdelete.delete() end,             desc = "Delete Buffer" },
            { "<leader>sb",  function() require('snacks').scratch() end,                      desc = "Scratch Buffer" },
            { "<leader>sd",  function() require('snacks').dashboard() end,                    desc = "Snacks Dashboard" },
            { "<leader>fe",  function() require('snacks').explorer() end,                     desc = "File Explorer" },
            -- Git stuff
            { "<leader>gb",  function() require('snacks').gitbrowse() end,                    desc = "Open line(s) in git repo", mode = { 'n', 'x' } },
            { "<leader>gl",  function() require('snacks').picker.git_log() end,               desc = "Git Log" },
            { "<leader>glf", function() require('snacks').picker.git_log_file() end,          desc = "Git Log File" },
            { "<leader>gll", function() require('snacks').picker.git_log_line() end,          desc = "Git Log Line" },
            { "<leader>gui", function() require('snacks').terminal.toggle("gitui") end,       desc = "Git UI in float window"},
            -- LSP pickers
            { "<leader>lD",  function() require('snacks').picker.lsp_declarations() end,      desc = "Goto Declaration" },
            { "<leader>ld",  function() require('snacks').picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "<leader>li",  function() require('snacks').picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "<leader>lx",  function() require('snacks').picker.lsp_references() end,        desc = "References", nowait = true },
            { "<leader>ls",  function() require('snacks').picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>lS",  function() require('snacks').picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            { "<leader>lt",  function() require('snacks').picker.lsp_type_definitions() end,  desc = "Goto Type Definition" },
            -- Fuzzy pickers
            { "<leader>f:",  function() require('snacks').picker.command_history() end,       desc = "Command History" },
            { '<leader>f?',  function() require('snacks').picker.search_history() end,        desc = "Search Search History" },
            { "<leader>fa",  function() require('snacks').picker.autocmds() end,              desc = "Search Autocmds" },
            { "<leader>fb",  function() require('snacks').picker.buffers() end,               desc = "Buffers" },
            { "<leader>fc",  function() require('snacks').picker.commands() end,              desc = "Commands" },
            { "<leader>ff",  function() require('snacks').picker.files() end,                 desc = "Find Files" },
            { "<leader>fh",  function() require('snacks').picker.help() end,                  desc = "Search Help Pages" },
            { "<leader>fi",  function() require('snacks').picker.icons() end,                 desc = "Search Icons" },
            { "<leader>fj",  function() require('snacks').picker.jumps() end,                 desc = "Search Jumps" },
            { "<leader>fk",  function() require('snacks').picker.keymaps() end,               desc = "Search Keymaps" },
            { "<leader>fm",  function() require('snacks').picker.man() end,                   desc = "Search Man Pages" },
            { "<leader>fn",  function() require('snacks').picker.noice() end,                 desc = "Notification History" },
            { "<leader>fp",  function() require('snacks').picker.projects() end,              desc = "Projects" },
            { "<leader>fr",  function() require('snacks').picker.resume() end,                desc = "Resume" },
            { "<leader>fR",  function() require('snacks').picker.recent() end,                desc = "Recent History" },
            { "<leader>fs",  function() require('snacks').picker() end,                       desc = "Snacks Picker" },
            { "<leader>fS",  function() require('snacks').scratch.select() end,               desc = "Scratch Buffer Picker" },
            { "<leader>fu",  function() require('snacks').picker.undo() end,                  desc = "Search Undo History" },
            -- Grep pickers
            { "<leader>/l",  function() require('snacks').picker.lines() end,                 desc = "Grep Buffer Lines" },
            { "<leader>/b",  function() require('snacks').picker.grep_buffers() end,          desc = "Grep Open Buffers" },
            { "<leader>/w",  function() require('snacks').picker.grep_word() end,             desc = "Grep selection or word", mode = { "n", "x" } },
            { "<leader>/L",  function() require('snacks').picker.grep() end,                  desc = "Live Grep PWD" },
            {
                "<leader>//",
                function()
                    require('snacks').input({ win = { row = 0.33 }, prompt = "Search for > " }, function(input)
                        if (input == "") then return end
                        require('snacks').picker.grep({ regex = false, search = input, live = false })
                    end)
                end,
                desc = "Search with ripgrep",
            },
        },
        opts = {
            animate = { duration = 10 },
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            dashboard = {
                sections = {
                    { section = "header" },
                    { title = "Recent Files (PWD) ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
                    { section = "recent_files", cwd = true, limit = 8, padding = 1 },
                    { title = "Recent Files (System)", padding = 1 },
                    { section = "recent_files", limit = 8, padding = 1 },
                    { title = "Projects", padding = 1 },
                    { section = "projects", padding = 1 },
                    { title = "Bookmarks", padding = 1 },
                    { section = "keys", padding = 1 },
                    { section = "startup" },
                },
            },
            explorer = { replace_netrw = true },
            gitbrowse = { what = "permalink" },
            indent = { enabled = true },
            picker = { layout = {
                cycle = true,
                preset = function ()
                    return vim.o.columns >= 120 and 'telescope' or 'vertical'
                end
            }},
            quickfile = { enabled = true },
            scratch = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            toggle = { enabled = true },
            words = { enabled = true },
        },
    },
}
