return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Disable parsers on big files
		bigfile = {
			enabled = true,
		},
		-- Better text input prompts
		input = {
			enabled = true,
			win = {
				relative = "cursor",
			},
		},
		-- Less intrusive notifications
		notifier = { enabled = true },
		-- Show indentation levels
		indent = {
			enabled = true,
			indent = {
				char = "┊",
			},
			animate = {
				enabled = false,
			},
			scope = {
				enabled = false,
			},
		},
	},
}
