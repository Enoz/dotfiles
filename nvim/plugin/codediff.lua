vim.pack.add({
	{ src = "https://github.com/esmuellert/codediff.nvim" },
})

require("codediff").setup({
	explorer = {
		view_mode = "tree",
	},
	keymaps = {
		view = {
			quit = "q",
		},
	},
})

vim.keymap.set("n", "<leader>gv", ":CodeDiff<CR>", { desc = "Open CodeDiff explorer" })
vim.keymap.set("n", "<leader>gf", ":CodeDiff history %<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>gd", function()
	vim.ui.input({ prompt = "Branch to diff against: ", default = "main" }, function(branch)
		if branch and #branch > 0 then
			vim.cmd("CodeDiff " .. branch .. "...HEAD")
		end
	end)
end, { desc = "Diff branch vs HEAD" })
