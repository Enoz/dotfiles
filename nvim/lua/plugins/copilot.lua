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
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			local chat = require("CopilotChat")
			chat.setup({
				temperature = 0.1, -- Lower = focused, higher = creative
				window = {
					layout = "vertical",
					width = 0.45,
				},
				auto_insert_mode = false,
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
					vim.opt_local.conceallevel = 0
				end,
			})
			vim.keymap.set({ "n", "v" }, "<leader>gc", chat.toggle, { desc = "CopilotChat Toggle" })
			vim.keymap.set({ "n", "v" }, "<leader>gm", chat.select_model, { desc = "CopilotChat Toggle" })
		end,
	},
}
