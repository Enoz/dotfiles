return {
	"dense-analysis/ale",
	config = function()
		vim.g.ale_linters = {
			go = { "golangci-lint" },
		}
	end,
}
