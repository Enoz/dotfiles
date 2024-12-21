return {
	"saghen/blink.cmp",

	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		enabled = function()
			return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "DressingInput"
		end,
		appearance = {
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind", gap = 1 },
						{ "source_name" },
					},
				},
			},
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
