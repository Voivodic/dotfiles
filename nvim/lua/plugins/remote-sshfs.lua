return {
    "nosduco/remote-sshfs.nvim",
    name = "remote-sshfs",
    dependencies = {
        "nvim-telescope/telescope.nvim" 
    },
    config = function()
        require("remote-sshfs").setup({})
        vim.keymap.set("n", "<leader>rc", ":RemoteSSHFSConnect ")
        vim.keymap.set('n', '<leader>rd', ":RemoteSSHFSDisconnect<CR>")
        
        require("telescope").load_extension "remote-sshfs"
    end,
}
