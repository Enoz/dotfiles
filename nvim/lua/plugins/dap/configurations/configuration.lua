local dap = require("dap")

local InputProgram = function()
	return vim.fn.input({
		prompt = "Path to Debuggable Executable: ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	})
end

dap.configurations.go = {
	{
		type = "delve",
		name = "Delve: Debug (Input)",
		request = "launch",
		program = InputProgram,
	},
}
