return {
    "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
    config = function()
        -- 1. Setup autocompletion capabilities
        local capabilities =
            require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- 2. Configure individual servers with capabilities
        -- This overrides/appends your capabilities to nvim-lspconfig's defaults
        local servers = {
            "clangd",
            "pylsp",
            "ruff",
            "zls",       -- Zig Language Server
            "nixd",
            "gopls",
            "nushell",
            "templ",
            "texlab",
        }

        for _, server in ipairs(servers) do
            vim.lsp.config(server, { capabilities = capabilities })
        end

        -- 3. Configure servers that need custom properties
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

        -- 4. Activate/Enable all configurations for autostart
        -- (You can append "ltex" right into the loop array, or pass the full list)
        table.insert(servers, "ltex")
        vim.lsp.enable(servers)

        -- Keymaps
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Definition" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })

        -- Diagnostics
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
