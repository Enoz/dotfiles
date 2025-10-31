-- Title
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = [[%{v:progname} %f %h%m%r%w ]]

-- Leaders
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line Numbers
vim.opt.number = true
vim.opt.signcolumn = "auto:2"
vim.opt.relativenumber = true

-- Enables mouse mode for (a)ll vim modes
vim.opt.mouse = "a"

-- Better colors
vim.opt.termguicolors = true

-- Bottom/Top scroll padding
vim.opt.scrolloff = 8

-- Delay without input & CursorHold time for plugins
vim.opt.updatetime = 50

-- case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Timeout Length
vim.opt.timeoutlen = 300

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.clipboard = "unnamedplus"

-- Use win32yank only if it exists in PATH
if vim.fn.executable("win32yank.exe") == 1 then
	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Quickfix keymaps
vim.keymap.set("n", "<C-=>", "<cmd>copen<CR>", { silent = true })
vim.keymap.set("n", "<C-->", "<cmd>cclose<CR>", { silent = true })
vim.keymap.set("n", "]q", "<cmd>:cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "[q", "<cmd>:cprev<CR>", { desc = "Previous Quickfix Item" })
