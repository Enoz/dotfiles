return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
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
