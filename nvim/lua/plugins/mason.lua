return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		{
			"folke/lazydev.nvim", -- vim namespace
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		require("mason").setup({})
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
			},
		})
	end,
}
