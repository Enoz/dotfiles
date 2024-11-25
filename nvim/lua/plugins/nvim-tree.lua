return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
    keys = {
        { '\\', ':NvimTreeFocus <CR>', desc = 'NvimTree reveal', silent = true },
    },
    config = function()
        -- disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require('nvim-tree').setup({
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', '\\', api.tree.close, { buffer = bufnr, noremap = true, silent = true })
            end
        })
    end
}
