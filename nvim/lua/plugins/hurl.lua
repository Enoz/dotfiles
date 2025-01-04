-- https://github.com/jellydn/hurl.nvim
return {
	"jellydn/hurl.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Optional, for markdown rendering with render-markdown.nvim
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown" },
			},
			ft = { "markdown" },
		},
	},
	ft = "hurl",
	config = function()
		require("hurl").setup({
			debug = false,
			show_notification = false,
			mode = "split",
			formatters = {
				json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
				html = {
					"prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
					"--parser",
					"html",
				},
				xml = {
					"tidy", -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
					"-xml",
					"-i",
					"-q",
				},
			},
			-- Default mappings for the response popup or split views
			mappings = {
				close = "q", -- Close the response popup or split view
				next_panel = "<C-n>", -- Move to the next response popup window
				prev_panel = "<C-p>", -- Move to the previous response popup window
			},
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "hurl",
			callback = function(event)
				vim.keymap.set(
					"n",
					"<Leader>hr",
					"<cmd>HurlRunner<CR>",
					{ desc = "Run all Hurl requests", buffer = event.buf }
				)

				vim.keymap.set(
					"v",
					"<Leader>hr",
					":HurlRunner<CR>",
					{ desc = "Run all Hurl requests (visual)", buffer = event.buf }
				)

				vim.keymap.set(
					"n",
					"<Leader>hv",
					"<cmd>HurlVerbose<CR>",
					{ desc = "Run all Hurl requests (verbose)", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"<Leader>hR",
					"<cmd>HurlRunnerAt<CR>",
					{ desc = "Run single Hurl request", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"<Leader>hte",
					"<cmd>HurlRunnerToEntry<CR>",
					{ desc = "Run Hurl requests to entry", buffer = event.buf }
				)
				vim.keymap.set(
					"n",
					"<Leader>htE",
					"<cmd>HurlRunnerToEnd<CR>",
					{ desc = "Run Hurl requests from current to End", buffer = event.buf }
				)

				vim.keymap.set(
					"n",
					"<Leader>hev",
					"<cmd>HurlManageVariable<CR>",
					{ desc = "Manage Hurl Global Variables", buffer = event.buf }
				)
				vim.keymap.set("n", "<Leader>hef", function()
					local envfile = vim.fn.input({
						prompt = "Environment File Names: ",
					})
					if envfile ~= "" then
						vim.cmd({ cmd = "HurlSetEnvFile", args = { envfile } })
					end
				end, { desc = "Set Env", buffer = event.buf })
			end,
		})
	end,
}
