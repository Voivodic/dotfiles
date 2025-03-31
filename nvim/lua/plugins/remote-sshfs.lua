return {
    "nosduco/remote-sshfs.nvim",
    name = "remote-sshfs",
    dependencies = {
        "nvim-telescope/telescope.nvim" 
    },
    config = function()
        require("remote-sshfs").setup({})

        -- Set some keymaps for remote connection
        local api = require('remote-sshfs.api')
        vim.keymap.set("n", "<leader>rc", api.connect, {})
        vim.keymap.set('n', '<leader>rd', api.disconnect, {})
        vim.keymap.set('n', '<leader>re', api.edit, {})
        vim.keymap.set("n", "<leader>rf", api.find_files, {})
        vim.keymap.set("n", "<leader>rg", api.live_grep, {})
    end,
}
