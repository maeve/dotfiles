local neotest = require("neotest")
neotest.setup({
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
		require("neotest-rust")({}),
	},
	summary = {
		follow = true,
		expand_errors = true,
	},
	output = {
		open_on_run = true,
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

vim.api.nvim_create_user_command("TestOutputPanel", function(opts)
	neotest.output_panel.open()
end, {})

vim.api.nvim_create_user_command("TestSummary", function(opts)
	neotest.summary.toggle()
end, {})
