return {
	"ruifm/gitlinker.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	setup = function()
		require("gitlinker").setup({
			callbacks = {
				["github.cloud.capitalone.com"] = require("gitlinker.hosts").get_github_type_url,
			},
			mappings = "<leader>g",
		})
	end,
}
