vim.o.autocomplete = false

vim.pack.add({
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/rafamadriz/friendly-snippets",
})

local cmp = require("blink.cmp")
cmp.build():pwait()

cmp.setup({
	keymap = {
		preset = "none",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-S-K>"] = { "scroll_documentation_up", "fallback" },
		["<C-S-J>"] = { "scroll_documentation_down", "fallback" },
	},
	cmdline = {
		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-CR>"] = { "accept_and_enter", "fallback" },
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
			["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
		},
		completion = { menu = { auto_show = true } },
	},
	appearance = { nerd_font_variant = "mono" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	completion = {
		menu = {
			border = "rounded",
			draw = {
				columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
			},
		},
	},
	signature = { enabled = true },
})
