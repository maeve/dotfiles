return {
	-- sometimes you really do just need a fs tree view
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "NvimTreeToggle",
		keys = {
			{ "<leader>ft", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Browse tree" },
		},
		config = {
			hijack_netrw = false, -- we let telescope-file-browser hijack netrw instead
			renderer = {
				add_trailing = true,
			},
			filters = {
				dotfiles = false,
			},
		},
	},
}
