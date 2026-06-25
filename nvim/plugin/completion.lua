vim.o.autocomplete = false

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range(">=1.0.0 <2.0.0") },
	"https://github.com/rafamadriz/friendly-snippets",
})

local cmp = require("blink.cmp")

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
			["<C-CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "show_and_insert_or_accept_single", "select_next", "fallback" },
			["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
		},
		completion = { list = { selection = { auto_insert = false } }, menu = { auto_show = true } },
	},
	appearance = { nerd_font_variant = "mono" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	completion = {
		list = { selection = { auto_insert = false } },
		menu = {
			border = "rounded",
			draw = {
				columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
			},
		},
	},
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
})
