return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},

		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")
			local mason_null_ls = require("mason-null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.terraform_fmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
			mason_null_ls.setup({
				ensure_installed = {
					"prettierd",
				},
				automatic_installation = true,
				handlers = {
					function(source_name)
						-- all sources with no handler end up here
					end,
					prettierd = function()
						null_ls.register(null_ls.builtins.formatting.prettierd.with({
							filetypes = {
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"vue",
								"css",
								"scss",
								"less",
								"html",
								"json",
								"jsonc",
								-- "yaml",
								"markdown",
								"markdown.mdx",
								"graphql",
								"handlebars",
							},
						}))
					end,
				},
			})
		end,
	},
}
