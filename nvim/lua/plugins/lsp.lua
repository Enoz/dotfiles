return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.diagnostic.config({ virtual_text = false })
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = function(desc)
						return { buffer = event.buf, desc = desc }
					end
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP Show Info"))
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts("LSP Rename"))
                    vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, opts("LSP Code Action"))
				end,
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
}
