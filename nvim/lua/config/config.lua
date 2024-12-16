-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto:3"

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

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
