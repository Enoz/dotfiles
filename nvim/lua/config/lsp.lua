vim.lsp.enable({
	"lua-ls",
	"gopls",
	"ts-ls",
	"pylsp",
	"json",
	"css",
	"html",
	"eslint",
})

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
