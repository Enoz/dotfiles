local dap = require("dap")

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.exepath("dlv"),
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}
