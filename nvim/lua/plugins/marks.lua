return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = function()
		require("marks").setup()
		vim.keymap.set("n", "dm*", "<CMD>delmarks A-Za-z<CR>")
	end,
}
