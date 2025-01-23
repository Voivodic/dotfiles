return {
    'akinsho/bufferline.nvim',
    name = "bufferline",
    version = "*",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        vim.opt.termguicolors = true
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                mode = "buffers",
                style_preset = bufferline.style_preset.minimal,
                number = "buffer_id",
                diagnostics = "nvim_lsp",
                buffer_close_icon = ' ',
                modified_icon = '● ',
                close_icon = ' ',
                left_trunc_marker = ' ',
                right_trunc_marker = ' ',
            }
        })
    end
}
