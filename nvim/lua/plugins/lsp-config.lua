return {
    "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
    config = function()
        local capabilities =
            require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({ capabilities = capabilities })
        lspconfig.pylsp.setup({ capabilities = capabilities })
        lspconfig.zls.setup({ capabilities = capabilities })
        lspconfig.nixd.setup({ capabilities = capabilities })
        lspconfig.ltex.setup({ 
            capabilities = capabilities,
            cmd = { "ltex-ls-plus" },
            settings = {
                ltex = {
                    enabled = { "latex", "tex", "bib", "markdown", "text" },
                    language = "en-US",
                    diagnosticSeverity = "information",
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = "en",
                    },
                },
            },
        })

        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})

        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                spacing = 4,
            },
            signs = true,
            underline = true,
        })
    end,
}
