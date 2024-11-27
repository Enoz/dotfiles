return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        -- "\" will always focus into nvim-tree
        -- BUT, if you are already focused into nvim-tree, when "\" will instead close its
        vim.keymap.set('n', '\\', '<cmd>:NvimTreeFindFile<CR>', { desc = "Open Nvim Tree", silent = true })
        require('nvim-tree').setup({
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set('n', '\\', api.tree.close,
                    { desc = "Close Nvim Tree", buffer = bufnr, noremap = true, silent = true })
            end
        })
    end
}
