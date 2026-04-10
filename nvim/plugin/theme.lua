vim.pack.add({ { src = "https://github.com/EdenEast/nightfox.nvim" } })

require("nightfox").setup({
	groups = {
		all = {
			Visual = { bg = "#40313b" },
		},
	},
})

vim.cmd("colorscheme carbonfox")
