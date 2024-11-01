return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',
        'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls', -- Lua
                'clangd'  -- C, C++
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = { globals = { 'vim' } }
                            }
                        }
                    })
                end

            }
        })
        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb" },     -- Installs codelldb for C debugging
            automatic_setup = true,
        })
    end
}
