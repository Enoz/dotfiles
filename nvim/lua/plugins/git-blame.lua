return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = false,
	},
	keys = {
		{ "<leader>gy", "<cmd>GitBlameCopyFileURL<CR>", mode = { "n", desc = "Copy Git Link" } },
		{ "<leader>gY", "<cmd>GitBlameOpenFileURL<CR>", mode = { "n", desc = "Open Git Link" } },
		{ "<leader>gy", ":GitBlameCopyFileURL<CR>", mode = { "v", desc = "Copy Git Link" } },
		{ "<leader>gY", ":GitBlameOpenFileURL<CR>", mode = { "v", desc = "Open Git Link" } },
	},
}
