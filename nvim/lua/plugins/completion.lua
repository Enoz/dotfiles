return {
	{
		"zbirenbaum/copilot.lua",
		enabled = vim.env.DISABLE_COPILOT ~= "1",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				dependencies = { "nvim-treesitter/nvim-treesitter" },
				ft = { "codecompanion" },
				opts = {},
			},
		},
		config = function()
			local codecompanion = require("codecompanion")
			codecompanion.setup({
				adapters = {
					acp = {
						gemini_cli = function()
							return require("codecompanion.adapters").extend("gemini_cli", {
								commands = {
									default = {
										"gemini",
										"--experimental-acp",
									},
								},
							})
						end,
						claude_code = function()
							return require("codecompanion.adapters").extend("claude_coode", {
								env = {
									CLAUDE_CODE_OAUTH_TOKEN = vim.env.CLAUDE_CODE_TOKEN,
								},
							})
						end,
					},
				},
				strategies = {
					chat = {
						adapter = vim.env.DISABLE_COPILOT == "1" and "gemini_cli" or "copilot",
					},
					inline = {
						adapter = vim.env.DISABLE_COPILOT == "1" and "gemini_cli" or "copilot",
					},
				},
				ignore_warnings = true,
				display = {
					action_palette = {
						provider = "fzf_lua",
					},
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>gc", codecompanion.chat, { desc = "AI Chat" })
		end,
	},
	{

		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"fang2hou/blink-copilot",
				opts = {
					debounce = 0,
				},
			},
		},
		version = "1.*",
		opts = {
			appearance = {
				nerd_font_variant = "mono",
			},
			keymap = {
				preset = "none",

				["<C-n>"] = {},
				["<C-p>"] = {},

				["<C-CR>"] = { "select_and_accept" },

				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },

				["<C-s>"] = { "show" },
				["<C-g>"] = {
					function(cmp)
						cmp.show({ providers = { "copilot" } })
					end,
				},
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
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "inherit",
				},
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},

			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
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
	},
}
