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

-- neotest
vim.keymap.set("n", "<leader>r", ":TestNearest<cr>")
vim.keymap.set("n", "<leader>R", ":TestFile<cr>")
vim.keymap.set("n", "<leader>ro", ":TestOutput<cr>")
vim.keymap.set("n", "<leader>rs", ":TestSummary<cr>")
vim.keymap.set("n", "<leader>rp", ":TestOutputPanel<cr>")

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

-- debugging
local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<A-c>", dap.continue, { silent = true, noremap = true })
vim.keymap.set("n", "<A-n>", dap.step_over, { silent = true, noremap = true })
vim.keymap.set("n", "<A-i>", dap.step_into, { silent = true, noremap = true })
vim.keymap.set("n", "<A-o>", dap.step_out, { silent = true, noremap = true })
vim.keymap.set("n", "<A-u>", dap.up, { silent = true, noremap = true })
vim.keymap.set("n", "<A-d>", dap.down, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bc", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bk", dap.clear_breakpoints, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>dd", dapui.toggle, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>br", dap.repl.open, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>bl", dap.run_last, { silent = true, noremap = true })
