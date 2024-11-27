return
{
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
            autojump = true
        })
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle float<CR>", { desc = "Toggle Aerial Menu" })
    end
}
