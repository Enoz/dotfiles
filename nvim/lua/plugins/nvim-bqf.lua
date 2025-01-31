return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	config = function()
		vim.keymap.set("n", "]q", "<cmd>:cnext<CR>", { desc = "Next Quickfix Item" })
		vim.keymap.set("n", "[q", "<cmd>:cprev<CR>", { desc = "Previous Quickfix Item" })
	end,
}
