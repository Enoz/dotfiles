return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "f-person/git-blame.nvim" },
	config = function()
		local git_blame = require("gitblame")

		git_blame.setup({
			display_virtual_text = 0,
            gitblame_delay = 1
		})
		vim.keymap.set("n", "<leader>go", "<cmd>:GitBlameOpenFileURL<CR>", { desc = "Git Open File" })
		vim.keymap.set("n", "<leader>gc", "<cmd>:GitBlameCopyFileURL<CR>", { desc = "Git Copy File" })
		vim.keymap.set("v", "<leader>go", "<cmd>'<,'>:GitBlameOpenFileURL<CR>", { desc = "Git Open File" })
		vim.keymap.set("v", "<leader>gc", "<cmd>'<,'>:GitBlameCopyFileURL<CR>", { desc = "Git Copy File" })

		require("lualine").setup({
			sections = {
				lualine_c = {
					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
				},
			},
		})
	end,
}
