return {
    'MeanderingProgrammer/render-markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
        })
    end,
}
