vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- fuzzy find in various contexts, including file browsing
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!.git/*")

			telescope.setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
				},
				extensions = {
					file_browser = {
						cwd_to_path = true,
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
					},
				},
			})
			telescope.load_extension("file_browser")
		end,
	})

	-- sometimes you really do just need a file system tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			-- disable netrw
			vim.g.loaded = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({})
		end,
	})

	-- change surrounding delimiters (e.g. changing "" to '')
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end,
	})

	-- external tooling for LSP servers, autocompletion,
	-- linting, formatting, etc.
	use({
		"williamboman/mason.nvim",
		requires = {
			-- lsp
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",

			-- autocompletion
			{ "ms-jpq/coq_nvim", branch = "coq" },
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },

			-- linting/formatting
			"jose-elias-alvarez/null-ls.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = function()
			vim.g.coq_settings = { auto_start = "shut-up" }
			local coq = require("coq")

			require("mason").setup()
			require("mason-lspconfig").setup(coq.lsp_ensure_capabilities({
				ensure_installed = {
					"bashls",
					"clangd",
					"cssls",
					"dockerls",
					"golangci_lint_ls",
					"graphql",
					"html",
					"jedi_language_server",
					"jsonls",
					"jdtls",
					"tsserver",
					"sumneko_lua",
					"marksman",
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
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								vim.lsp.buf.formatting_sync()
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
					"rubocop",
					"shellcheck",
					"stylua",
					"sqlfluff",
				},
				automatic_installation = true,
			})
			mason_null_ls.setup_handlers({
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
					null_ls.register(null_ls.builtins.formatting.prettierd)
				end,
				rubocop = function()
					null_ls.register(null_ls.builtins.diagnostics.rubocop)
				end,
				shellcheck = function()
					null_ls.register(null_ls.builtins.diagnostics.shellcheck)
				end,
				stylua = function()
					null_ls.register(null_ls.builtins.formatting.stylua)
				end,
				sqlfluff = function()
					null_ls.register(null_ls.builtins.diagnostics.sqlfluff)
				end,
			})
		end,
	})

	-- diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- git client
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("neogit").setup({
				kind = "split",
				integrations = {
					diffview = true,
				},
			})
		end,
	})

	-- git blame
	use({
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_enabled = 0
			require("gitblame")
		end,
	})

	-- git gutter signs (also blame but seems slower than git-blame)
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				yadm = {
					enable = true,
				},
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
	})

	-- Colors
	use({
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "storm",
			})
		end,
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = {
			require("lualine").setup({
				options = {
					theme = "tokyonight",
				},
			}),
		},
	})

	-- syntax highlighting, folding, and other parsery stuff
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"RRethy/nvim-treesitter-endwise",
		},
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"dockerfile",
					"go",
					"graphql",
					"html",
					"java",
					"javascript",
					"json",
					"lua",
					"markdown",
					"regex",
					"ruby",
					"rust",
					"sql",
					"toml",
					"typescript",
					"vim",
					"yaml",
				},
				auto_install = true,
				highlight = {
					enabled = true,
				},
				endwise = {
					enable = true,
				},
			})
		end,
	})

	-- testing
	use({
		"nvim-neotest/neotest",
		tag = "*",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
			"olimorris/neotest-rspec",
			"rouge8/neotest-rust",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-go")({}),
					require("neotest-jest")({}),
					require("neotest-rspec")({
						rspec_cmd = function()
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
							})
						end,
					}),
					require("neotest-rust")({}),
				},
			})

			vim.api.nvim_create_user_command("TestNearest", function(opts)
				neotest.run.run()
			end, {})

			vim.api.nvim_create_user_command("TestFile", function(opts)
				neotest.run.run(vim.fn.expand("%"))
			end, {})

			vim.api.nvim_create_user_command("TestSuite", function(opts)
				neotest.run.run(vim.fn.getcwd())
			end, {})

			vim.api.nvim_create_user_command("TestOutput", function(opts)
				neotest.output.open()
			end, {})

			vim.api.nvim_create_user_command("TestSummary", function(opts)
				neotest.summary.toggle()
			end, {})
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>ts]],
			})
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"ray-x/go.nvim",
		requires = "ray-x/guihua.lua",
		config = function()
			require("go").setup({})
		end,
	})

	use({
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				system_clipboard = {
					sync_with_ring = true,
				},
			})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- vimscript plugins where I couldn't find a lua alternative

	use({ "AndrewRadev/splitjoin.vim" })
	use({ "tpope/vim-rails" })
	use({ "junegunn/vim-easy-align" })
	use({ "tpope/vim-rsi" })
	use({ "tpope/vim-unimpaired" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
