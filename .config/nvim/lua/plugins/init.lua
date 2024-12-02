return {
	-- external tooling for LSP servers, autocompletion,
	-- linting, formatting, etc.
	{
		"williamboman/mason.nvim",
		dependencies = {
			-- lsp
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",

			-- linting/formatting
			"jose-elias-alvarez/null-ls.nvim",
			"jay-babu/mason-null-ls.nvim",

			-- debugging
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap",
			"jay-babu/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"suketa/nvim-dap-ruby",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
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
			})

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
		end,
	},

	-- git blame
	{
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_enabled = 0
			require("gitblame")
		end,
	},

	-- git gutter signs (also blame but seems slower than git-blame)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},

	{
		"cameron-wags/rainbow_csv.nvim",
		config = function()
			require("rainbow_csv").setup()
		end,
		-- optional lazy-loading below
		module = {
			"rainbow_csv",
			"rainbow_csv.fns",
		},
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = 20,
			persist_size = false,
			open_mapping = [[<C-\>]],
			insert_mappings = true,
			terminal_mappings = true,
		},
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- See https://github.com/gbprod/yanky.nvim/issues/75
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				mappings = { basic = true },
			})
		end,
	},

	"github/copilot.vim",

	"folke/neodev.nvim",

	-- vimscript plugins where I couldn't find a lua alternative

	"AndrewRadev/splitjoin.vim",
	"tpope/vim-rails",
	"junegunn/vim-easy-align",
	"tpope/vim-rsi",
	"tpope/vim-unimpaired",
}
