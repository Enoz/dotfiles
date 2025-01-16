return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettierd" },
				html = { "prettierd" },
				htmlangular = { "prettierd" },
				javascript = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				lua = { "stylua" },
				scss = { "prettierd" },
				typescript = { "prettierd" },
				vue = { "prettierd" },
				markdown = { "prettierd" },
				go = { "goimports", "gofumpt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "x" }, "<leader>cf", function()
			require("conform").format()
		end, { desc = "Conform Format" })
	end,
}
