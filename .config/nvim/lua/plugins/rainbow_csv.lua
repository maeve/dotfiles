return {
	{
		"cameron-wags/rainbow_csv.nvim",
		opts = {},
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
}
