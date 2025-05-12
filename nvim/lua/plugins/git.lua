return {
    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        config = function()
            require("gitsigns").setup()

            vim.keymap.set("n", "<leader>gv", ":Gitsigns preview_hunk<CR>", {})
        end,
    },
    {
        "tpope/vim-fugitive",
        name = "fugitive",
        config = function()
            vim.keymap.set("n", "<leader>ga", ":Git add", {})
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", {})
            vim.keymap.set("n", "<leader>gs", ":Git status<CR>", {})
            vim.keymap.set("n", "<leader>gp", ":Git push<CR>", {})
        end,
    }
}
