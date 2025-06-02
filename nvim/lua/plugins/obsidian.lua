return {
    "epwalsh/obsidian.nvim",
    name = "obsidian",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("obsidian").setup({
            ui = {
                enable = false,
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            notes_subdir = "notes",
            new_notes_location = "notes_subdir",
            workspaces = {
                {
                    name = "default",
                    path = "~/GitRepos/obsidian",
                },
            },
            -- templates = {
            --     folder = "~/GitRepos/obsidian/templates",
            --     date_format = "%d-%m-%Y",
            --     time_format = "%H:%M",
            -- },
        })

        vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate note<CR>")
    end,
}
