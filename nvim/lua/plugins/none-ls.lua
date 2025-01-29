return {
	"nvimtools/none-ls.nvim",
	name = "none-ls",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.isort, -- python's imports
				null_ls.builtins.formatting.black, -- python
				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "-style=file" },
				}), -- C

				null_ls.builtins.diagnostics.pylint, -- python
				null_ls.builtins.diagnostics.cpplint, -- C
			},
		})

		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
