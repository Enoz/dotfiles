---@type vim.lsp.Config
return {
	cmd = {
		"omnisharp",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},
	filetypes = {
		"cs",
		"vb",
	},
	root_markers = {
		"*.sln",
		"*.csproj",
	},
	init_options = {
		RoslynExtensionsOptions = {
			enableAnalyzersSupport = true,
			enableDecompilationSupport = true,
			organizeImportsOnFormat = true,
			renameRefactoring = true,
		},
	},
}
