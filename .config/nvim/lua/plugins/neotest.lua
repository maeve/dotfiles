return {
	{
		"nvim-neotest/neotest",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			-- "nvim-neotest/neotest-go",
			-- "haydenmeade/neotest-jest",
			"olimorris/neotest-rspec",
			-- "rouge8/neotest-rust",
		},
		keys = {
			{
				"<leader>r",
				function()
					require("neotest").run.run()
				end,
				desc = "Test nearest",
			},
			{
				"<leader>R",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Test file",
			},
			{
				"<leader>ro",
				function()
					require("neotest").output.open()
				end,
				desc = "Test output",
			},
			{
				"<leader>rs",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Test summary",
			},
			{
				"<leader>rp",
				function()
					require("neotest").output_panel.open()
				end,
				desc = "Test output panel",
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					-- require("neotest-go")({}),
					-- require("neotest-jest")({}),
					require("neotest-rspec")({
						rspec_cmd = function()
							return vim.tbl_flatten({
								"docker",
								"compose",
								"exec",
								"web",
								"rspec",
							})
						end,

						transform_spec_path = function(path)
							local prefix = require("neotest-rspec").root(path)
							return string.sub(path, string.len(prefix) + 2, -1)
						end,

						results_path = "tmp/rspec.output",
					}),
					-- require("neotest-rust")({}),
				},
				discovery = {
					-- Improve performance in large projects by only AST-parsing the
					-- currently opened buffer
					enabled = false,
					-- Number of workers to parse files concurrently. Set 0 to use
					-- all available CPU cores, or 1 if experiencing neovim lag
					concurrent = 1,
				},
				summary = {
					follow = true,
					expand_errors = true,
				},
				output = {
					open_on_run = true,
				},
			})
		end,
	},
}
