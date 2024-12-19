return {
	"ggandor/leap.nvim",
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "<leader>l", "<Plug>(leap)")
	end,
}
