return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"f-person/git-blame.nvim",
			event = "VeryLazy",
			opts = {
				display_virtual_text = false,
				gitblame_delay = 1,
			},
		},
	},
	config = function()
		local git_blame = require("gitblame")

		vim.keymap.set("n", "<leader>lo", "<cmd>:GitBlameOpenFileURL<CR>", { desc = "Git Open File" })
		vim.keymap.set("n", "<leader>lc", "<cmd>:GitBlameCopyFileURL<CR>", { desc = "Git Copy File" })
		vim.keymap.set("v", "<leader>lo", "<cmd>'<,'>:GitBlameOpenFileURL<CR>", { desc = "Git Open File" })
		vim.keymap.set("v", "<leader>lc", "<cmd>'<,'>:GitBlameCopyFileURL<CR>", { desc = "Git Copy File" })

		require("lualine").setup({
			sections = {
				lualine_c = { "filename" },
				lualine_x = {
					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
				},
			},
		})
	end,
}
