vim.g.mapleader = ","

-- fuzzy finding
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "-", ":Telescope file_browser path=%:p:h<cr>", { noremap = true })

-- git
vim.keymap.set("n", "<leader>g", ":Neogit<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b", ":GitBlameToggle<cr>", { noremap = true })

-- neotest
vim.keymap.set("n", "<leader>r", ":TestNearest<cr>")
vim.keymap.set("n", "<leader>R", ":TestFile<cr>")
vim.keymap.set("n", "<leader>ro", ":TestOutput<cr>")
vim.keymap.set("n", "<leader>rs", ":TestSummary<cr>")

-- nvim-tree
vim.keymap.set("n", "<leader>tt", ":NvimTreeFindFileToggle<cr>")

-- killring/yank history
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<leader>n", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<leader>p", "<Plug>(YankyCycleBackward)")
