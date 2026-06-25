vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})

require("diffview").setup({})

vim.keymap.set("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Open DiffView" })
vim.keymap.set("n", "<leader>gV", ":DiffviewClose<CR>", { desc = "Close DiffView" })
vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>", { desc = "File history" })
