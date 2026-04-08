vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup({
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
})
