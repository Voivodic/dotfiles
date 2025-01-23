return {
    "milanglacier/yarepl.nvim",
    config = function()
        local yarepl = require("yarepl")
        yarepl.setup({})
        require("telescope").load_extension("REPLShow")

        vim.keymap.set("n", "<leader>rs", "<Plug>(REPLStart)", { noremap = false })
        vim.keymap.set("n", "<leader>rl", "<Plug>(REPLSendLine)", { noremap = false })
        vim.keymap.set("v", "<leader>rv", "<Plug>(REPLSendVisual)", { noremap = false })
        vim.keymap.set("n", "<leader>rh", "<Plug>(REPLHideOrFocus)", { noremap = false })
    end,
}
