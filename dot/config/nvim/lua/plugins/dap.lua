-- local dap_config = function ()
--     local dap = require('dap')
-- end

return {
    {
        'rcarriga/nvim-dap-ui',
        enabled = false,
        lazy = true,
        dependencies = {
            'nvim-dap',
            'nvim-dap-virtual-text',
        },
        keys = {
            { '<leader>dd', '<cmd>lua require("dapui").toggle()<CR>', desc = "Debug: Toggle Debugger UI" },
            { '<leader>dh', '<cmd>lua require("dapui").eval()<CR>', desc = "Debug: Hover in floating window", mode = { 'n', 'v' } },
            { '<leader>dw', '<cmd>lua require("dapui").elements.watches.add()<CR>', desc = "Debug: Add to watch list" },
        },
        config = function ()
            require('dapui').setup({
                controls = {
                    element = "console",
                    icons = {
                        pause = "Pause ",
                        play = "Continue ",
                        run_last = "Run Last ",
                        step_back = "Step Back ",
                        step_into = "Step Into ",
                        step_out = "Step Out ",
                        step_over = "Step Over ",
                        terminate = "Terminate ",
                    },
                },
                layouts = {
                    {
                        size = 0.2,
                        position = "bottom",
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                    },
                    {
                        size = 0.2,
                        position = "left",
                        elements = {
                            { id = "breakpoints", size = 0.3 },
                            { id = "stacks", size = 0.7 },
                        },
                    },
                    {
                        size = 0.25,
                        position = "right",
                        elements = {
                            { id = "scopes", size = 0.5 },
                            { id = "watches", size = 0.5 },
                        },
                    },
                },
            })
        end
    },

    {
        'mfussenegger/nvim-dap',
        enabled = false,
        lazy  = true,
        dependencies = {
            'nvim-treesitter',
        },
        keys = {
            { '<leader>dc', '<cmd>lua require("dap").continue()<CR>', desc = "Debug: Start/Continue" },
            { '<leader>do', '<cmd>lua require("dap").step_over()<CR>', desc = "Debug: Step over line" },
            { '<leader>di', '<cmd>lua require("dap").step_into()<CR>', desc = "Debug: Step into line" },
            { '<leader>dO', '<cmd>lua require("dap").step_out()<CR>', desc = "Debug: Step out of function" },
            { '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', desc = "Debug: Toggle breakpoint" },
            { '<leader>dB', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', desc = "Debug: Conditional breakpoint" },
            { '<leader>dl', '<cmd>lua require("dap").run_last()<CR>', desc = "Debug: Run last" },
            { '<leader>dt', '<cmd>lua require("dap").run_to_cursor()<CR>', desc = "Debug: Run till cursor" },
        },
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        enabled = false,
        lazy = true,
        opts = {},
    }
}
