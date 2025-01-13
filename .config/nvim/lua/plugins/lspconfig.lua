return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		lazy = true,
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"graphql",
				"html",
				"jedi_language_server",
				"jsonls",
				"jdtls",
				"lua_ls",
				"marksman",
				"rubocop",
				"rust_analyzer",
				"solargraph",
				"sqlls",
				"terraformls",
				"ts_ls",
				"vimls",
				"yamlls",
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.bashls.setup({
				filetypes = { "sh", "zsh" },
			})
			lspconfig.clangd.setup({})
			lspconfig.cssls.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.graphql.setup({})
			lspconfig.html.setup({})
			lspconfig.jedi_language_server.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.jdtls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.marksman.setup({})
			lspconfig.rubocop.setup({
				-- See: https://docs.rubocop.org/rubocop/usage/lsp.html
				cmd = { "bundle", "exec", "rubocop", "--lsp" },
				root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
			})
			lspconfig.rust_analyzer.setup({})
			lspconfig.solargraph.setup({
				-- See: https://medium.com/@cristianvg/neovim-lsp-your-rbenv-gemset-and-solargraph-8896cb3df453
				cmd = { os.getenv("HOME") .. "/.asdf/shims/solargraph", "stdio" },
				root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
				settings = {
					solargraph = {
						autoformat = false,
						completion = true,
						diagnostics = true,
						folding = true,
						references = true,
						rename = true,
						symbols = true,
					},
				},
			})
			lspconfig.sqlls.setup({})
			lspconfig.terraformls.setup({})
			lspconfig.ts_ls.setup({})
			lspconfig.vimls.setup({})
			lspconfig.yamlls.setup({})
		end,
	},
}
