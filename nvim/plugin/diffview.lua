vim.pack.add({
	{ src = "https://github.com/esmuellert/codediff.nvim" },
})

require("codediff").setup({
	keymaps = {
		view = {
			quit = "q",
			close_on_open_in_prev_tab = true,
		},
	},
})

vim.keymap.set("n", "<leader>gv", ":CodeDiff<CR>", { desc = "Open CodeDiff explorer" })
vim.keymap.set("n", "<leader>gV", ":tabclose<CR>", { desc = "Close CodeDiff tab" })
vim.keymap.set("n", "<leader>gf", ":CodeDiff history %<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>gd", function()
	vim.ui.input({ prompt = "Branch to diff against: ", default = "origin/main" }, function(branch)
		if branch and #branch > 0 then
			vim.cmd("CodeDiff " .. branch)
		end
	end)
end, { desc = "Diff branch vs HEAD" })
