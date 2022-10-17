local telescope = require("telescope")
local telescope_config = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

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
			grouped = true,
			hidden = true,
			hijack_netrw = true,
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
})

telescope.load_extension("file_browser")
