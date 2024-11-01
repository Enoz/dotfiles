return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
        },
        config = function()
            local dap = require("dap")

            -- Configure C debugger to use Mason's codelldb installation
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Debugging Keybindings
            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_over)
            vim.keymap.set("n", "<F3>", dap.step_into)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.terminate)
            vim.keymap.set("n", "B", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F7>", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end)
            vim.keymap.set("n", "<F8>", dapui.toggle)
        end,
    },
}
