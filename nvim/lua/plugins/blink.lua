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
		keymap = {
			preset = "none",
			["<C-CR>"] = { "select_and_accept" },

			["<C-j>"] = { "select_next", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },

			["<C-e>"] = { "hide" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-1>"] = {
				function(cmp)
					cmp.accept({ index = 1 })
				end,
			},
			["<C-2>"] = {
				function(cmp)
					cmp.accept({ index = 2 })
				end,
			},
			["<C-3>"] = {
				function(cmp)
					cmp.accept({ index = 3 })
				end,
			},
			["<C-4>"] = {
				function(cmp)
					cmp.accept({ index = 4 })
				end,
			},
			["<C-5>"] = {
				function(cmp)
					cmp.accept({ index = 5 })
				end,
			},
			["<C-6>"] = {
				function(cmp)
					cmp.accept({ index = 6 })
				end,
			},
			["<C-7>"] = {
				function(cmp)
					cmp.accept({ index = 7 })
				end,
			},
			["<C-8>"] = {
				function(cmp)
					cmp.accept({ index = 8 })
				end,
			},
			["<C-9>"] = {
				function(cmp)
					cmp.accept({ index = 9 })
				end,
			},
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
						{ "item_idx", "kind_icon", gap = 1 },
						{ "label", "label_description", gap = 1 },
						{ "kind", gap = 1 },
						{ "source_name" },
					},
					components = {
						item_idx = {
							text = function(ctx)
								return ctx.idx <= 9 and tostring(ctx.idx) or " "
							end,
							highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
						},
					},
				},
			},
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
