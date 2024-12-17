return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-nvim-dap").setup({
			ensure_installed = {},
			handlers = {
				-- Defualt Handler
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				-- Can add custom handlers here
				-- https://github.com/jay-babu/mason-nvim-dap.nvim?tab=readme-ov-file#advanced-customization
			},
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Lua
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,
			},
		})
	end,
}
