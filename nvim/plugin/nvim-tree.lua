-- disables netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})
require("nvim-tree").setup({
	filters = {
		git_ignored = false,
		dotfiles = false,
	},
	view = {
		float = {
			enable = true,
			open_win_config = {
				border = "double",
			},
		},
		width = {
			min = 50,
			max = -1,
			padding = 5,
		},
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		api.config.mappings.default_on_attach(bufnr)
		for _, val in pairs({ "\\", "<ESC>" }) do
			vim.keymap.set(
				"n",
				val,
				api.tree.close,
				{ desc = "Close Nvim Tree", buffer = bufnr, noremap = true, silent = true }
			)
		end
	end,
})

vim.keymap.set("n", "\\", "<cmd>:NvimTreeFindFile<CR>", { desc = "Open Nvim Tree", silent = true })
