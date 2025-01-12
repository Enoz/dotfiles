return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
                -- Disable gray during F/T/f/t
				highlight = { backdrop = false },
				char_actions = function(motion)
					return {
						-- jump2d style: same case goes next, opposite case goes prev
						[motion] = "next",
						[motion:match("%l") and motion:upper() or motion:lower()] = "prev",
					}
				end,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
	},
}
