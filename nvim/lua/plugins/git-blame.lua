return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = false,
	},
	keys = {
		{ "<leader>gy", "<cmd>GitBlameCopyFileURL<CR>", mode = { "n", "v", desc = "Copy Git Link" } },
		{ "<leader>gY", "<cmd>GitBlameOpenFileURL<CR>", mode = { "n", "v", desc = "Open Git Link" } },
	},
}
