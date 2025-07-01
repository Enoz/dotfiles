vim.lsp.enable({
	"lua-ls",
	"gopls",
	"ts-ls",
	"pylsp",
	"json",
	"css",
	"html",
	"eslint",
	"terraform-ls",
	"yaml-ls",
	"svelte",
})

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Open LSP Hover" })
