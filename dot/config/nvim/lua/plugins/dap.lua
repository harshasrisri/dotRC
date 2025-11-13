local dap_config = function()
    local dap = require('dap')

    -- Custom unicode symbols for debugger signs in gutter
    vim.fn.sign_define('DapBreakpoint', {
        text = '●',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
    })
    vim.fn.sign_define('DapBreakpointCondition', {
        text = '◆',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
    })
    vim.fn.sign_define('DapBreakpointRejected', {
        text = '○',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
    })
    vim.fn.sign_define('DapLogPoint', {
        text = '◉',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = 'DapLogPoint'
    })
    vim.fn.sign_define('DapStopped', {
        text = '▶',
        texthl = 'DapStopped',
        linehl = 'DapStoppedLine',
        numhl = 'DapStopped'
    })

    -- CodeLLDB adapter (installed via Mason)
    dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
            args = { '--port', '${port}' },
        }
    }

    -- C/C++ configuration using codelldb
    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input('Arguments: ')
                return vim.split(args_string, " +")
            end,
        },
        {
            name = 'Launch with Child Process Debugging',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to launcher: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input('Launcher arguments: ')
                return vim.split(args_string, " +")
            end,
            -- Follow child processes (for launcher -> launchee scenario)
            initCommands = {
                'settings set target.process.follow-fork-mode child',
                'settings set target.process.detach-on-fork false',
            },
        },
        {
            name = 'Attach to Process',
            type = 'codelldb',
            request = 'attach',
            pid = function()
                local pid_string = vim.fn.input('Process ID: ')
                return tonumber(pid_string)
            end,
            cwd = '${workspaceFolder}',
        },
    }

    dap.configurations.c = dap.configurations.cpp

    -- Rust configuration using codelldb
    dap.configurations.rust = {
        {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input('Arguments: ')
                return vim.split(args_string, " +")
            end,
        },
    }
end

return {
    {
        'rcarriga/nvim-dap-ui',
        lazy = true,
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
            'theHamsta/nvim-dap-virtual-text',
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
        ft = { 'c', 'cpp', 'rust' },
        config = dap_config,
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        lazy = true,
        opts = {},
    },

    {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            -- Automatically find python3 or use system python
            local python_path = vim.fn.exepath('python3') ~= '' and vim.fn.exepath('python3') or vim.fn.exepath('python')
            require('dap-python').setup(python_path)
        end,
    },

    {
        'leoluz/nvim-dap-go',
        ft = 'go',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('dap-go').setup()
        end,
    },
}
