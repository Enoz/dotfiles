vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local ts = require("nvim-treesitter")

ts.install({
	"asm",
	"bash",
	"c",
	"c_sharp",
	"commonlisp",
	"caddy",
	"capnp",
	"cpp",
	"css",
	"csv",
	"desktop",
	"diff",
	"disassembly",
	"dockerfile",
	"dot",
	"editorconfig",
	"fish",
	"gdscript",
	"gdshader",
	"go",
	"gomod",
	"gosum",
	"gpg",
	"graphql",
	"html",
	"http",
	"hurl",
	"java",
	"javadoc",
	"json",
	"json5",
	"latex",
	"llvm",
	"lua",
	"luadoc",
	"make",
	"markdown",
	"markdown_inline",
	"mermaid",
	"nginx",
	"nix",
	"objc",
	"passwd",
	"pem",
	"php",
	"proto",
	"python",
	"regex",
	"requirements",
	"rust",
	"scss",
	"sproto",
	"sql",
	"ssh_config",
	"terraform",
	"tmux",
	"toml",
	"tsv",
	"tsx",
	"typescript",
	"udev",
	"vimdoc",
	"vue",
	"xml",
	"xresources",
	"yaml",
})

local available = {}
for _, language in ipairs(ts.get_available()) do
	available[language] = true
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local language = vim.treesitter.language.get_lang(args.match)
		if not language or not available[language] then
			return
		end

		ts.install({ language }):await(function(err, installed)
			if err or not installed then
				return
			end

			vim.schedule(function()
				if not vim.api.nvim_buf_is_valid(args.buf) then
					return
				end

				local current_language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if current_language == language then
					vim.treesitter.start(args.buf, language)
				end
			end)
		end)
	end,
})
