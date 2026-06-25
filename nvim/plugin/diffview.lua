vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})

require("diffview").setup({})

vim.keymap.set("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Open DiffView" })
vim.keymap.set("n", "<leader>gV", ":DiffviewClose<CR>", { desc = "Close DiffView" })
vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>gd", function()
	vim.ui.input({ prompt = "Branch to diff against: ", default = "origin/main" }, function(branch)
		if branch and #branch > 0 then
			vim.cmd("DiffviewOpen " .. branch .. "...HEAD")
		end
	end)
end, { desc = "Diff branch vs base" })
