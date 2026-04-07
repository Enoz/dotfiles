vim.pack.add({
	"https://github.com/f-person/git-blame.nvim",
})

require("gitblame").setup({
	enabled = false,
})

vim.keymap.set("n", "<leader>gy", "<cmd>GitBlameCopyFileURL<CR>", { desc = "Copy Git Link" })
vim.keymap.set("n", "<leader>gY", "<cmd>GitBlameOpenFileURL<CR>", { desc = "Open Git Link" })
vim.keymap.set("v", "<leader>gy", ":GitBlameCopyFileURL<CR>", { desc = "Copy Git Link" })
vim.keymap.set("v", "<leader>gY", ":GitBlameOpenFileURL<CR>", { desc = "Open Git Link" })
vim.keymap.set({ "n", "v" }, "<leader>gt", "<cmd>GitBlameToggle<CR>", { desc = "Toggle Blame" })
