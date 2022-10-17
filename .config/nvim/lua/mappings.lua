vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- open split windows
vim.keymap.set("n", "<leader>x", ":sp<cr>", { noremap = true })
vim.keymap.set("n", "<leader>v", ":vsp<cr>", { noremap = true })

-- window navigation
vim.keymap.set("n", "<leader>h", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<leader>j", "<c-w>j", { noremap = true })
vim.keymap.set("n", "<leader>k", "<c-w>k", { noremap = true })
vim.keymap.set("n", "<leader>l", "<c-w>l", { noremap = true })

vim.keymap.set("t", "<leader>h", "<c-><c-w>h", { noremap = true })
vim.keymap.set("t", "<leader>j", "<c-><c-w>j", { noremap = true })
vim.keymap.set("t", "<leader>k", "<c-><c-w>k", { noremap = true })
vim.keymap.set("t", "<leader>l", "<c-><c-w>l", { noremap = true })

-- Home row navigation in terminal mode
vim.keymap.set("t", "<c-h>", "<c-><c-w>h", { noremap = true })
vim.keymap.set("t", "<c-j>", "<c-><c-w>j", { noremap = true })
vim.keymap.set("t", "<c-k>", "<c-><c-w>k", { noremap = true })
vim.keymap.set("t", "<c-l>", "<c-><c-w>l", { noremap = true })

-- remove trailing spaces
vim.keymap.set("n", "<leader>W", ":%s/s+$//<cr>:let @/=''<cr>", { noremap = true })

-- toggle show listchars (tabs, trailing spaces)
vim.keymap.set("n", "<leader>tl", ":set list!<cr>", { noremap = true })

-- Diff shortcuts
vim.keymap.set("n", "<leader>dg", ":diffget<cr>", { noremap = true })
vim.keymap.set("n", "<leader>dp", ":diffput<cr>", { noremap = true })
vim.keymap.set("n", "<leader>d2", ":diffget //2<cr>", { noremap = true })
vim.keymap.set("n", "<leader>d3", ":diffget //3<cr>", { noremap = true })

-- list nav
vim.keymap.set("n", "<leader>qq", ":cclose<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ql", ":lclose<cr>", { noremap = true })

-- handicaps for learning vim nav

-- no arrow keys
-- vim.keymap.set({ "n", "v" }, "<left>", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<down>", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<up>", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<right>", "<nop>", { noremap = true })

-- no home row navigation
-- vim.keymap.set({ "n", "v" }, "h", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "j", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "k", "<nop>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "l", "<nop>", { noremap = true })

-- fuzzy finding
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, { noremap = true })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true })
vim.keymap.set("n", "<leader>fc", builtin.command_history, { noremap = true })

-- fuzzy file nav via telescope (replaces netrw and vim-vinegar)
local browse_current_file = function()
	require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" })
end
vim.keymap.set("n", "-", browse_current_file, { noremap = true })

-- tree file nav (because sometiems you just need it)
vim.keymap.set("n", "<leader>ft", ":NvimTreeFindFileToggle<cr>", { noremap = true })

-- git
vim.keymap.set("n", "<leader>g", ":Neogit<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b", ":GitBlameToggle<cr>", { noremap = true })

-- neotest
vim.keymap.set("n", "<leader>r", ":TestNearest<cr>")
vim.keymap.set("n", "<leader>R", ":TestFile<cr>")
vim.keymap.set("n", "<leader>ro", ":TestOutput<cr>")
vim.keymap.set("n", "<leader>rs", ":TestSummary<cr>")

-- killring/yank history
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "]n", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "[n", "<Plug>(YankyCycleBackward)")

-- EasyAlign
-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
