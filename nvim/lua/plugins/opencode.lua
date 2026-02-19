return {
	"sudo-tee/opencode.nvim",
	config = function()
		require("opencode").setup({
			ui = {
				position = "left",
			},
			keymap = {
				editor = {
					["<leader>oc"] = { "toggle" },
					["<leader>op"] = { "configure_provider" },
					["<leader>oP"] = { "configure_variant" },
					["<leader>os"] = { "select_session" },
					["<leader>ov"] = { "add_visual_selection", mode = { "v" } },
					["<leader>oq"] = { "quick_chat", mode = { "n", "x" } },
				},
				input_window = {
					["<S-cr>"] = { "submit_input_prompt", mode = { "n", "i" } }, -- Submit prompt (normal mode and insert mode)
					["<esc>"] = { "close" }, -- Close UI windows
					["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
					["~"] = { "mention_file", mode = "i" }, -- Pick a file and add to context. See File Mentions section
					["@"] = { "mention", mode = "i" }, -- Insert mention (file/agent)
					["/"] = { "slash_commands", mode = "i" }, -- Pick a command to run in the input window
					["#"] = { "context_items", mode = "i" }, -- Manage context items (current file, selection, diagnostics, mentioned files)
					["<C-m>"] = { "switch_mode" }, -- Switch between modes (build/plan)
				},
				output_window = {
					["<esc>"] = { "close" }, -- Close UI windows
					["<C-c>"] = { "cancel" }, -- Cancel opencode request while it is running
					["i"] = { "focus_input", "n" }, -- Focus on input window and enter insert mode at the end of the input from the output window
				},
				session_picker = {
					rename_session = { "<C-r>" }, -- Rename selected session in the session picker
					delete_session = { "<C-d>" }, -- Delete selected session in the session picker
					new_session = { "<C-s>" }, -- Create and switch to a new session in the session picker
				},
				model_picker = {
					toggle_favorite = { "<C-f>", mode = { "i", "n" } },
				},
				mcp_picker = {
					toggle_connection = { "<C-t>", mode = { "i", "n" } }, -- Toggle MCP server connection in the MCP picker
				},
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { "markdown", "opencode_output" },
			},
			ft = { "opencode_output" },
		},
		"saghen/blink.cmp",
		"ibhagwan/fzf-lua",
	},
}
