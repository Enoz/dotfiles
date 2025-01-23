return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			keymap = {
				fzf = {
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
		vim.keymap.set("n", "<leader>fr", fzf.lsp_references, { desc = "Fzf LSP References" })
		vim.keymap.set("n", "<leader>fi", fzf.lsp_implementations, { desc = "Fzf LSP Implementations" })
		vim.keymap.set("n", "<leader>fd", fzf.lsp_definitions, { desc = "Fzf LSP Defenitions" })
		vim.keymap.set("n", "<leader>fD", fzf.lsp_declarations, { desc = "Fzf LSP Declarations" })
		vim.keymap.set("n", "<leader>fa", fzf.lsp_code_actions, { desc = "Fzf LSP Code Actions" })
	end,
}
