-- eagerly disable netrw (will be replaced by plugins)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("config.lazy")
require("mappings")

-- Abandoned buffers are hidden instead of unloaded
vim.o.hidden = true

-- some language servers have issues with backup files
vim.o.backup = false
vim.o.writebackup = false

-- more space for displaying messages from commands
vim.o.cmdheight = 2

-- tell vim to look for file-specific settings in a special comment
-- at the beginning or end of each file
vim.o.modelines = 1

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- autosave before make
vim.o.autowrite = true
-- do not autosave before quit
vim.o.autowriteall = true

-- line numbers
vim.o.number = true
vim.o.numberwidth = 3

-- include additional context when scrolling
vim.o.scrolloff = 1

-- wrapping
vim.o.wrap = true
vim.o.textwidth = 79
vim.opt.formatoptions:append("qrn1")

-- quiet please
vim.o.visualbell = true

-- dark mode
vim.o.background = "dark"

-- show tab chars and trailing spaces
vim.opt.list = true
vim.opt.listchars.tab = "▷⋅"
vim.opt.listchars.trail = "·"
vim.opt.listchars.eol = "↴"

-- tabs/indents should be 2 spaces
vim.o.tabstop = 2 -- render tab chars as two spaces
vim.o.softtabstop = 2 -- number of spaces that pressing tab counts for
vim.o.expandtab = true -- only insert spaces, never tab chars
vim.o.shiftwidth = 2 -- indents (e.g. with '>') are two spaces

-- ms after typing stops before writing swap file
vim.o.updatetime = 250

-- split window behavior
vim.opt.splitbelow = true -- open horizontal split below current window
vim.opt.splitright = true -- open vertical split to right of current window
vim.opt.diffopt:append("vertical") -- default diff to vertical split

-- allow mouse interaction in all modes
vim.o.mouse = "a"

-- shared clipboard
vim.o.clipboard = "unnamedplus"

-- go-specific configuration
local golangstyle = vim.api.nvim_create_augroup("golangstyle", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = false
	end,
	group = golangstyle,
})

-- markdown specific configuration
local mdstyle = vim.api.nvim_create_augroup("mdstyle", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.bo.expandtab = true

		vim.wo.spell = true
		vim.bo.spelllang = "en_us"
	end,
	group = mdstyle,
})
