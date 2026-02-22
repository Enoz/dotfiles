return {
	"nickjvandyke/opencode.nvim",
	config = function()
		vim.g.opencode_opts = {
			provider = {
				enabled = "tmux",
			},
		}

		vim.o.autoread = true

		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<leader>oc", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })

		vim.keymap.set({ "n", "x" }, "<leader>ov", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })
	end,
}
