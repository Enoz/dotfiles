return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup({
			groups = {
				all = {
					Visual = { bg = "#373737" },
				},
			},
		})
		vim.cmd("colorscheme carbonfox")
	end,
}
