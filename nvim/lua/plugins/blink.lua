return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		enabled = function()
			return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "DressingInput"
		end,
		-- keymap = {
		-- 	preset = "enter",
		-- 	["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		-- 	["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		-- },
		appearance = {
			nerd_font_variant = "normal",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				NvimTree = {},
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
		},
		draw = {
			treesitter = { "lsp" },
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
