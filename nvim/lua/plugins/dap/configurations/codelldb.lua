local dap = require("dap")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.exepath("codelldb"),
		args = { "--port", "${port}" },
	},
}
