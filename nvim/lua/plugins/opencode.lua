return {
	"nickjvandyke/opencode.nvim",
	config = function()
		local opencode = require("opencode")

		vim.g.opencode_opts = {
			provider = {
				enabled = "tmux",
			},
		}

		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			opencode.ask("@this: ", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			opencode.select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<leader>oc", function()
			opencode.toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set("n", "<S-C-u>", function()
			opencode.command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			opencode.command("session.half.page.down")
		end, { desc = "Scroll opencode down" })

		vim.keymap.set({ "n", "x" }, "<leader>ov", function()
			return opencode.operator("@this ")
		end, { desc = "Add range to opencode", expr = true })
	end,
}
