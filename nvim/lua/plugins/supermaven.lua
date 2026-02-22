return {
    "supermaven-inc/supermaven-nvim",
    name = "supermaven",
    config = function()
        require("supermaven-nvim").setup({  
            keymaps = {
                accept_suggestion = "<M-j>",
                clear_suggestion = "<M-h>",
                accept_word = "<M-l>",
            },
            ignore_filetypes = { }, -- or { "cpp", }
            color = {
                suggestion_color = "#ff00e1",
                cterm = 244,
            },
            log_level = "info", -- set to "off" to disable logging completely
            disable_inline_completion = false, -- disables inline completion for use with cmp
            disable_keymaps = false, -- disables built in keymaps for more manual control
        })
    end,
}
