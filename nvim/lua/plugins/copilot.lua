return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local codecompanion = require("codecompanion")
			codecompanion.setup({
				ignore_warnings = true,
			})
			vim.keymap.set({ "n", "v" }, "<leader>gc", codecompanion.chat, { desc = "AI Chat" })
		end,
	},
}
