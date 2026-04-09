--- Config

-- Leader keys
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

-- case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- UI2
require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = { echomsg = "msg" },
	},
})

--- Keybinds

-- Yank line numbers
vim.keymap.set("v", "go", function()
	local path = vim.fn.expand("%:p")
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end
	local content
	if start_line == end_line then
		content = path .. ":L" .. start_line
	else
		content = path .. ":L" .. start_line .. "-L" .. end_line
	end
	vim.fn.setreg("+", content)
	vim.notify("Copied: " .. content)
end, { desc = "Copy path with line range" })

-- Quickfix
vim.keymap.set("n", "<C-=>", "<cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<C-->", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- Plugin management
vim.keymap.set("n", "<leader>ps", function()
	vim.pack.status()
end, { desc = "Show plugin status" })
vim.keymap.set("n", "<leader>pu", function()
	vim.pack.update(nil, { force = true })
end, { desc = "Update plugins" })
vim.keymap.set("n", "<leader>pr", function()
	vim.pack.update(nil, { force = true, target = "lockfile" })
end, { desc = "Restore plugins to lockfile" })
