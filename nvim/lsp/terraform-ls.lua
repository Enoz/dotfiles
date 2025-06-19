---@type vim.lsp.Config
return {
	cmd = { "terraform-ls", "serve" },
	root_markers = {
		".git",
		".terraform",
	},
	filetypes = { "terraform", "terraform-vars" },
	settings = {},
}
