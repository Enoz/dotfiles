return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		config = function()
			local ts = require("nvim-treesitter")
			ts.install({
				"asm",
				"bash",
				"c",
				"c_sharp",
				"cmake",
				"comment",
				"cpp",
				"css",
				"csv",
				"desktop",
				"diff",
				"disassembly",
				"dockerfile",
				"editorconfig",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"goctl",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"gpg",
				"graphql",
				"html",
				"http",
				"hurl",
				"ini",
				"java",
				"javadoc",
				"javascript",
				"jq",
				"jsdoc",
				"json",
				"json5",
				"jsonc",
				"latex",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"nginx",
				"nix",
				"objc",
				"objdump",
				"php",
				"printf",
				"puppet",
				"python",
				"regex",
				"requirements",
				"robots",
				"rust",
				"scss",
				"sql",
				"ssh_config",
				"strace",
				"terraform",
				"toml",
				"tsx",
				"typescript",
				"udev",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = ts.get_installed(),
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				lookahead = true,
			})

			local select_binds = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}

			local move_next_start_binds = {
				["]a"] = "@parameter.inner",
			}

			local move_previous_start_binds = {
				["[a"] = "@parameter.inner",
			}

			for bind, object in pairs(select_binds) do
				vim.keymap.set({ "x", "o" }, bind, function()
					require("nvim-treesitter-textobjects.select").select_textobject(object, "textobjects")
				end)
			end

			for bind, object in pairs(move_next_start_binds) do
				vim.keymap.set({ "n", "x", "o" }, bind, function()
					require("nvim-treesitter-textobjects.move").goto_next_start(object, "textobjects")
				end)
			end

			for bind, object in pairs(move_previous_start_binds) do
				vim.keymap.set({ "n", "x", "o" }, bind, function()
					require("nvim-treesitter-textobjects.move").goto_previous_start(object, "textobjects")
				end)
			end
		end,
	},
}
