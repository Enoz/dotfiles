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
				model = "gpt-4.1", -- AI model to use
				temperature = 0.1, -- Lower = focused, higher = creative
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float'
					width = 0.4, -- 40% of screen width
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
		end,
	},
}
