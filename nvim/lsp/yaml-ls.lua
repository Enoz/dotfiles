--- @class vim.lsp.Config
return {
	cmd = {
		"yaml-language-server",
		"--stdio",
	},
	filetypes = {
		"yaml",
	},
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
	root_markers = { ".git" },
}
