return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			keymap = {
				builtin = {
					true,
                    ["<C-S-j>"] = "preview-down",
                    ["<C-S-k>"] = "preview-up",
                    ["<C-S-d>"] = "preview-page-down",
                    ["<C-S-u>"] = "preview-page-up"
				},
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
		vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "Fzf LSP References" })
		vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "Fzf LSP Implementations" })
		vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Fzf LSP Defenitions" })
		vim.keymap.set("n", "gD", fzf.lsp_declarations, { desc = "Fzf LSP Declarations" })
		vim.keymap.set("n", "ga", fzf.lsp_code_actions, { desc = "Fzf LSP Code Actions" })
	end,
}
