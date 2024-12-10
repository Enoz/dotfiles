return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
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

		vim.api.nvim_create_autocmd("BufNew", {
			desc = "Conform Actions",
			callback = function(event)
				local opts = function(desc)
					return { buffer = event.buf, desc = desc }
				end

				vim.keymap.set({ "n", "x" }, "gf", function()
					require("conform").format({ bufnr = event.buf })
				end, opts("Conform Format Code"))
			end,
		})
	end,
}
