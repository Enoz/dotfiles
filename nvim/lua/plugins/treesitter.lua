return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		config = function()
			local ts = require("nvim-treesitter")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = ts.get_available(),
				callback = function()
					ts.install({ vim.bo.filetype }):wait(5000)
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
