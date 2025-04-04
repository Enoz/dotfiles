vim.lsp.enable({
	"lua-ls",
	"gopls",
	"ts-ls",
	"pylsp",
	"json",
	"css",
	"html",
})

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
})
