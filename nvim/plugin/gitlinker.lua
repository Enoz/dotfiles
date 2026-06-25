vim.pack.add({
	{ src = "https://github.com/linrongbin16/gitlinker.nvim" },
})

require("gitlinker").setup({})

vim.keymap.set({ "n", "v" }, "<leader>gy", function()
	require("gitlinker").link()
end, { desc = "Copy Git Link" })
vim.keymap.set({ "n", "v" }, "<leader>gY", function()
	require("gitlinker").link({ action = require("gitlinker.actions").system })
end, { desc = "Open Git Link" })
