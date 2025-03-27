return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				htmlangular = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				scss = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				markdown = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "x" }, "<leader>c", function()
			require("conform").format()
		end, { desc = "Conform Format" })
	end,
}
