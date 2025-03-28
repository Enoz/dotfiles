return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		input = {
			enabled = true,
			win = {
				relative = "cursor",
			},
		},
		notifier = { enabled = true },
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
