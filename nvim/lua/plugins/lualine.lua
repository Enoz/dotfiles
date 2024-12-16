return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "f-person/git-blame.nvim" },
	config = function()
		-- Remove virtual text from gitblame, only want it in lualine
		local git_blame = require("gitblame")
		git_blame.setup({
			display_virtual_text = 0,
		})
		require("lualine").setup({
			sections = {
				lualine_c = {
					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
				},
			},
		})
	end,
}
