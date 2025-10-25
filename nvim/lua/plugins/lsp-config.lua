return {
    "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
    config = function()
        local capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Define and configure the LSP servers
        vim.lsp.config("clangd", {
            capabilities = capabilities,
        })
        vim.lsp.config("pylsp", {
            capabilities = capabilities,
        })
        vim.lsp.config("ruff", {
            capabilities = capabilities,
        })
        vim.lsp.config("zls", {
            capabilities = capabilities,
        })
        vim.lsp.config("nixd", {
            capabilities = capabilities,
        })
        vim.lsp.config("texlab", {
            capabilities = capabilities,
        })
        vim.lsp.config("ltex", {
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
                    dictionary = {
                        ["en-US"] = {
                            "bispectrum",
                            "wavenumber",
                            "cutoff",
                            "renormalizability",
                            "Eq",
                            "Gaussianity",
                            "perturbatively",
                            "trispectrum",
                            "ansatz",
                        },
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
