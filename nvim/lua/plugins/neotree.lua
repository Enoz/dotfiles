return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '\\', ':Neotree position=current<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
        filesystem = {
            use_libuv_file_watcher = true,
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
            },
        },
    },
}
