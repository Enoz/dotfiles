return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					true,
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
				},
			},
		})
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Find Files" })
		vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Live Grep" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf Buffers" })
		vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Fzf Help" })

		--LSP Binds
		vim.keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "LSP Rename" })
		vim.keymap.set("n", "ga", fzf.lsp_code_actions, { desc = "LSP Code Actions" })
		vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "LSP References" })
		vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "LSP Implementations" })
		vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "LSP Defenitions" })
		vim.keymap.set("n", "gD", fzf.lsp_declarations, { desc = "LSP Declarations" })
		vim.keymap.set("n", "gs", fzf.lsp_document_symbols, { desc = "LSP Symbols" })
		vim.keymap.set("n", "gS", fzf.lsp_live_workspace_symbols, { desc = "LSP Symbols" })
	end,
}
