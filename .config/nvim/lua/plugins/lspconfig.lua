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
				"ts_ls",
				"lua_ls",
				"marksman",
				"rubocop",
				"solargraph",
				"rust_analyzer",
				"sqlls",
				"terraformls",
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
	},
}
