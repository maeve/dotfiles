require("nvim-tree").setup({
	hijack_netrw = false, -- we let telescope-file-browser hijack netrw instead
	renderer = {
		add_trailing = true,
	},
	filters = {
		dotfiles = false,
	},
})
