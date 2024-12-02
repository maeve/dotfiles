return {
	{
		"williamboman/mason.nvim",
		opts = {}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
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
}
