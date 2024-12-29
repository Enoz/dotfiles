local dap = require("dap")

local InputProgram = function()
	return vim.fn.input({
		prompt = "Path to Debuggable Executable: ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	})
end

dap.configurations.c = {
	{
		name = "LLDB: Launch",
		type = "codelldb",
		request = "launch",
		program = InputProgram,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		console = "integratedTerminal",
	},
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

dap.configurations.go = {
	{
		type = "delve",
		name = "Delve: Debug (Input)",
		request = "launch",
		program = InputProgram,
	},
	{
		type = "delve",
		name = "Delve: Debug (File)",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Delve: Debug test (File)",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Delve: Debug test (Input)",
		request = "launch",
		mode = "test",
		program = InputProgram,
	},
}
