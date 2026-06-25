vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})
require("render-markdown").setup({
	enabled = false,
	win_options = { concealcursor = "nvic" },
})

vim.keymap.set("n", "<leader>r", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })
