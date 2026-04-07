vim.o.autocomplete = true

vim.o.pumborder = "rounded"
vim.o.pummaxwidth = 40
vim.o.completeopt = "menu,menuone,noinsert,popup"

-- Enable native completion for LSP clients with autotrigger
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/completion", bufnr) then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end
	end,
})

-- Navigation Mappings (Insert Mode)
vim.keymap.set("i", "<C-j>", "<C-n>", { desc = "Next completion item" })
vim.keymap.set("i", "<C-k>", "<C-p>", { desc = "Previous completion item" })
