return {
    "lervag/vimtex",
    name = "vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
        vim.g.vimtex_view_method = "zathura"
        maplocallader = "\\"
    end,
}
