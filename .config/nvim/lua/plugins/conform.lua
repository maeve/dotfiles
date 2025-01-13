return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		opts = {
			formatters_by_ft = {
				css = { "prettierd" },
				graphql = { "prettierd" },
				handlebars = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				less = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				rust = { "rustfmt" },
				scss = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettierd" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				-- lsp_format = "fallback",
			},
		},
	},
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
