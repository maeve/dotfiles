-- Autocompletion
return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			-- "hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			-- "hrsh7th/cmp-emoji",
			"petertriho/cmp-git",
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			-- "f3fora/cmp-spell",
			-- "tamago324/cmp-zsh",

			-- nvim-cmp request a snippets plugin; several are supported,
			-- I chose LuaSnip because why not
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")

			return {
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
				}),
			}
		end,

		config = function()
			local cmp = require("cmp")

			-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})
			require("cmp_git").setup()
			--

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.bashls.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})

			lspconfig.graphql.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.jedi_language_server.setup({
				capabilities = capabilities,
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.rubocop.setup({
				capabilities = capabilities,
			})

			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			lspconfig.sqlls.setup({
				capabilities = capabilities,
			})

			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})

			lspconfig.vimls.setup({
				capabilities = capabilities,
			})

			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
		end,
	},
}
