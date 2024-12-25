return {
	"ggandor/leap.nvim",
	config = function()
		require("leap").opts.safe_labels = {}
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-from-window)")
	end,
}
