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
        vim.keymap.set('n', '<leader>rf', api.edit, {})
        
        -- Tale the telescope and information about the remote connection
        local builtin = require("telescope.builtin")
        local connections = require("remote-sshfs.connections")

        -- Define the find files for remote or local files
        vim.keymap.set("n", "<leader>ff", function()
            if connections.is_connected then
                api.find_files()
            else
                builtin.find_files()
            end
        end, {})

        -- Define the live grep for remote or local files
        vim.keymap.set("n", "<leader>fg", function()
            if connections.is_connected then
                api.live_grep()
            else
                builtin.live_grep()
            end
        end, {})

    end,
}
