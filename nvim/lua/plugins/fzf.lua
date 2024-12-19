return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons", { "junegunn/fzf", build = "./install --bin" } },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({})
		vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "Fzf Files" })
		vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Fzf Live Grep" })
		vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "Fzf Buffers" })
		vim.keymap.set("n", "<leader>fh", require("fzf-lua").help_tags, { desc = "Fzf Help" })
		vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, { desc = "Fzf LSP References" })
		vim.keymap.set("n", "gi", require("fzf-lua").lsp_implementations, { desc = "Fzf LSP Implementations" })
		vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, { desc = "Fzf LSP Definitions" })
		vim.keymap.set("n", "gD", require("fzf-lua").lsp_declarations, { desc = "Fzf LSP Declarations" })
		vim.keymap.set("n", "gt", require("fzf-lua").lsp_typedefs, { desc = "Fzf LSP Type Definitions" })
	end,
}
