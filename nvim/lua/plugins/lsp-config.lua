return {
	{
		"williamboman/mason.nvim",
		name = "mason",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pylsp",
					"bashls",
                    "zls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		name = "nvim-lspconfig",
		config = function()
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.pylsp.setup({ capabilities = capabilities })
            lspconfig.zls.setup({ capabilities = capabilities })

			-- vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
		end,
	},
}
