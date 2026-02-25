return {
	"nickjvandyke/opencode.nvim",
	config = function()
		vim.g.opencode_opts = {
            -- Explicitely start opencode myself
			server = {
				start = function() end,
				stop = function() end,
				toggle = function() end,
			},
		}
	end,
	keys = {
		{
			"<leader>oa",
			function()
				require("opencode").ask("@this: ", { submit = true })
			end,
			desc = "Ask opencode…",
			mode = { "n", "x" },
		},
		{
			"<leader>os",
			function()
				require("opencode").select()
			end,
			desc = "Execute opencode action…",
			mode = { "n", "x" },
		},
		{
			"<S-C-u>",
			function()
				require("opencode").command("session.half.page.up")
			end,
			desc = "Scroll opencode up",
			mode = "n",
		},
		{
			"<S-C-d>",
			function()
				require("opencode").command("session.half.page.down")
			end,
			desc = "Scroll opencode down",
			mode = "n",
		},
		{
			"go",
			function()
				return require("opencode").operator("@this ")
			end,
			desc = "Add range to opencode",
			expr = true,
			mode = "v",
		},
	},
}
