return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text"
        },
        config = function()
            local dap = require("dap")
            require("nvim-dap-virtual-text").setup()

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
            dap.configurations.cpp = dap.configurations.c

            dap.adapters.delve = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
                    args = { "dap", "--listen", "127.0.0.1:${port}" },
                },
            }
            dap.configurations.go = {
                {
                    type = "delve",
                    name = "Debug",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
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
            vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP Continue" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "DAP Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_into, { desc = "Dap Step Into" })
            vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Dap Step Out" })
            vim.keymap.set("n", "<F5>", dap.terminate, { desc = "Dap Terminate" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<F7>", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Toggle Breakpoint (condition)" })
            vim.keymap.set("n", "<F8>", dapui.toggle, { desc = "DAP Toggle UI" })
        end,
    },
}
