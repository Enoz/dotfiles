return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
    keys = {
        { '\\', ':NvimTreeToggle <CR>', desc = 'NvimTree reveal', silent = true },
    },
    config = function()
        -- disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require('nvim-tree').setup()
    end
}
