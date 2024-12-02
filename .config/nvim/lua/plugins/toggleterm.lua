return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ [[<C-\>]], mode = { "n", "i", "t" }, desc = "Toggle terminal" },
		},
		opts = {
			size = 20,
			persist_size = false,
			open_mapping = [[<C-\>]],
			insert_mappings = true,
			terminal_mappings = true,
		},
	},
}
