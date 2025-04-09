return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("plugins.dap.configurations.delve")
			require("plugins.dap.configurations.configuration")

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
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Dap Step Over" })
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
