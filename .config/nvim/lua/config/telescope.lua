local telescope = require("telescope")
local telescope_config = require("telescope.config")
local fb_actions = telescope.extensions.file_browser.actions
local trouble = require("trouble.providers.telescope")

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
			mappings = {
				i = {
					["<c-n>"] = fb_actions.create,
					["<c-r>"] = fb_actions.rename,
					["<c-h>"] = fb_actions.toggle_hidden,
					["<c-d>"] = fb_actions.remove,
					["<c-p>"] = fb_actions.move,
					["<c-y>"] = fb_actions.copy,
					["<c-a>"] = fb_actions.select_all,
					["<c-t>"] = trouble.open_with_trouble,
				},
				n = {
					["<c-t>"] = trouble.open_with_trouble,
				},
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			hidden = true,
			follow = true,
			no_ignore = true,
		},
	},
})

telescope.load_extension("file_browser")
