vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})

local actions = require("diffview.actions")

require("diffview").setup({
	keymaps = {
		view = {
			{ "n", "gf", function()
				actions.goto_file_edit()
				vim.cmd.DiffviewClose()
			end, { desc = "Open file and close diffview" } },
		},
		file_panel = {
			{ "n", "gf", function()
				actions.goto_file_edit()
				vim.cmd.DiffviewClose()
			end, { desc = "Open file and close diffview" } },
			{ "n", "K", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
			{ "n", "J", actions.scroll_view(0.25),  { desc = "Scroll the view down" } },
		},
	},
})

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
