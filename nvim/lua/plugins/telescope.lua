return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local builtin = require("telescope.builtin")
		require("telescope").setup()
		require("telescope").load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP telescope actions",
			callback = function(event)
				vim.keymap.set(
					"n",
					"gr",
					builtin.lsp_references,
					{ desc = "Telescope LSP References", buffer = event.buf }
				)

				vim.keymap.set(
					"n",
					"gi",
					builtin.lsp_implementations,
					{ desc = "Telescope LSP Implementations", buffer = event.buf }
				)
			end,
		})
	end,
}
