return {
    "folke/which-key.nvim",
    name = "which-key",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        require("which-key").setup({
            preset = "classic",
        })
    end,
}
