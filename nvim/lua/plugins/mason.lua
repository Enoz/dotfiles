return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap'
    },
    config = function()
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls', -- Lua
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
                end,


                clangd = function()
                    require('lspconfig').clangd.setup({
                        cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
                    })
                end
            }
        })
    end
}
