vim.g.coq_settings = { auto_start = "shut-up" }
local coq = require("coq")

require("coq_3p")({
	{ src = "copilot", short_name = "COP", accept_key = "<S-Space>" },
})

require("mason").setup()
require("mason-lspconfig").setup(coq.lsp_ensure_capabilities({
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
		"tsserver",
		"lua_ls",
		"marksman",
		"rubocop@1.36.0",
		"solargraph",
		"rust_analyzer",
		"sqlls",
		"terraformls",
		"vimls",
		"yamlls",
	},
	automatic_installation = true,
}))

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
		"cpplint",
		"erb_lint",
		"eslint_d",
		"gitlint",
		"golangci_lint",
		"hadolint",
		"jq",
		"markdownlint",
		"prettierd",
		"rubocop@1.36.0",
		"rustfmt",
		"shellcheck",
		"stylua",
		"sqlfluff",
	},
	automatic_installation = true,
	handlers = {
		function(source_name)
			-- all sources with no handler end up here
		end,
		cpplint = function()
			null_ls.register(null_ls.builtins.diagnostics.cpplint)
		end,
		erb_lint = function()
			null_ls.register(null_ls.builtins.diagnostics.erb_lint)
		end,
		eslint_d = function()
			null_ls.register(null_ls.builtins.diagnostics.eslint_d)
		end,
		gitlint = function()
			null_ls.register(null_ls.builtins.diagnostics.gitlint)
		end,
		golangci_lint = function()
			null_ls.register(null_ls.builtins.diagnostics.golangci_lint)
		end,
		hadolint = function()
			null_ls.register(null_ls.builtins.diagnostics.hadolint)
		end,
		jq = function()
			null_ls.register(null_ls.builtins.formatting.jq)
		end,
		markdownlint = function()
			null_ls.register(null_ls.builtins.diagnostics.markdownlint)
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
		rubocop = function()
			null_ls.register(null_ls.builtins.diagnostics.rubocop)
		end,
		rustfmt = function()
			null_ls.register(null_ls.builtins.formatting.rustfmt)
		end,
		shellcheck = function()
			null_ls.register(null_ls.builtins.diagnostics.shellcheck)
		end,
		stylua = function()
			null_ls.register(null_ls.builtins.formatting.stylua)
		end,
		sqlfluff = function()
			null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with({
				extra_args = { "--dialect", "postgres" },
			}))
		end,
	},
})

dap = require("dap")
require("dapui").setup()
require("dap-ruby").setup({})
require("mason-nvim-dap").setup()
