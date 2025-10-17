return {
    'stevearc/aerial.nvim',
    name = "aerial",
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require('aerial').setup({
            vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>"),
            vim.keymap.set("n", "<leader>fo", "<cmd>Telescope aerial<CR>")
        })
    end
}
