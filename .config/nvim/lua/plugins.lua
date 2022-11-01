local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "source <afile> | PackerCompile",
})

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

	use("nvim-lua/plenary.nvim")

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
		config = [[require('config.telescope')]],
	})

	-- sometimes you really do just need a fs tree view
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = [[require('config.tree')]],
	})

	-- change surrounding delimiters (e.g. changing "" to '')
	use({
		"kylechui/nvim-surround",
		tag = "*",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = [[require('config.surround')]],
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

			-- debugging
			"mfussenegger/nvim-dap",
			"jayp0521/mason-nvim-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"suketa/nvim-dap-ruby",
		},
		config = [[require('config.mason')]],
	})

	-- diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = [[require('config.trouble')]],
	})

	-- git client
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-tree/nvim-web-devicons",
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
		config = [[require ("config.neotest")]],
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = [[require('config.toggleterm')]],
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
