return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup({
			groups = {
				all = {
					Visual = { bg = "#40313b" },
				},
			},
		})
		vim.cmd("colorscheme carbonfox")
	end,
}
