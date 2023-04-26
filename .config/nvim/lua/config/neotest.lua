local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-go")({}),
		require("neotest-jest")({}),
		require("neotest-rspec")({
			rspec_cmd = "dcrspec"
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

vim.api.nvim_create_user_command("TestSummary", function(opts)
	neotest.summary.toggle()
end, {})
