vim.pack.add({
	{ src = "https://github.com/esmuellert/codediff.nvim" },
})

require("codediff").setup({
	explorer = {
		view_mode = "tree",
	},
})

vim.keymap.set("n", "<leader>gv", ":CodeDiff<CR>", { desc = "Open CodeDiff explorer" })
vim.keymap.set("n", "<leader>gf", ":CodeDiff history %<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>gd", function()
	require("fzf-lua").git_branches({
		remotes = "all",
		actions = {
			["enter"] = function(selected)
				local branch = selected[1]:match("^[%*+]*%s*([^%s]+)")
				if branch then
					vim.cmd("CodeDiff " .. branch .. "...HEAD")
				end
			end,
		},
	})
end, { desc = "Diff branch vs HEAD" })
