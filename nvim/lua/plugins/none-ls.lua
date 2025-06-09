return {
    "nvimtools/none-ls.nvim",
    name = "none-ls",
    -- dependencies = {
    --     "nvimtools/none-ls-extras.nvim",
    -- },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Formatting tools
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "-style=file" },
                }), -- C

                -- Linters
                null_ls.builtins.diagnostics.cppcheck, -- C/C++
                null_ls.builtins.diagnostics.rstcheck, -- rst
                -- null_ls.builtins.diagnostics.codespell, -- spelling
            },
        })

        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
    end,
}
