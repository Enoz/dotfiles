return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Find Files" })
		vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Live Grep" })
		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf Buffers" })
		vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "Fzf Help" })
		vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "Fzf LSP References" })
		vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "Fzf LSP Implementations" })
		vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Fzf LSP Defenitions" })
	end,
}
