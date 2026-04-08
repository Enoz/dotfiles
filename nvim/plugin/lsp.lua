vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

-- Lua
vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

local servers = {
	"lua_ls",
	"gopls",
	"ts_ls",
	"pylsp",
	"jsonls",
	"cssls",
	"html",
	"eslint",
	"terraformls",
	"yamlls",
	"svelte",
	"clangd",
	"omnisharp",
	"lemminx",
}

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
