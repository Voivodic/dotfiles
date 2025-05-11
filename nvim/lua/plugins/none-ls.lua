return {
    "nvimtools/none-ls.nvim",
    name = "none-ls",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Formatting tools
                null_ls.builtins.formatting.isort, -- python's imports
                null_ls.builtins.formatting.black, -- python
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "-style=file" },
                }), -- C

                -- Linters
                null_ls.builtins.diagnostics.pylint, -- python
                null_ls.builtins.diagnostics.cppcheck, -- C
                null_ls.builtins.diagnostics.vale, -- latex
            },
        })

        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
    end,
}
