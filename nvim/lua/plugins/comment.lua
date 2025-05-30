return {
    'numToStr/Comment.nvim',
    name = 'Comment',
    opts = {},
    config = function()
        require('Comment').setup({
            toggler = {
                line = '<leader>cl',
                block = '<leader>cb',
            },
        })
    end,
}
