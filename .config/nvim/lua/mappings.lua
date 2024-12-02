-- open split windows
vim.keymap.set("n", "<leader>x", ":sp<cr>", { noremap = true })
vim.keymap.set("n", "<leader>v", ":vsp<cr>", { noremap = true })

-- window navigation
vim.keymap.set("n", "<leader>h", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<leader>j", "<c-w>j", { noremap = true })
vim.keymap.set("n", "<leader>k", "<c-w>k", { noremap = true })
vim.keymap.set("n", "<leader>l", "<c-w>l", { noremap = true })

-- Make it easier to move out of toggleterm without closing it
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "<c-h>", [[<cmd>wincmd h<cr>]], { noremap = true })
vim.keymap.set("t", "<c-j>", [[<cmd>wincmd j<cr>]], { noremap = true })
vim.keymap.set("t", "<c-k>", [[<cmd>wincmd k<cr>]], { noremap = true })
vim.keymap.set("t", "<c-l>", [[<cmd>wincmd l<cr>]], { noremap = true })

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

-- git
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { noremap = true })

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
