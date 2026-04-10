vim.pack.add({
	{ src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
})
vim.cmd("colorscheme oxocarbon")
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff", bg = "NONE" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#ffffff", bg = "NONE" })
