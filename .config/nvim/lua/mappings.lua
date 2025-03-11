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

-- EasyAlign
-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")

-- Chat with LLM about code
vim.keymap.set("n", "<leader>lc", "<cmd>Chat vsplit %<CR>", { noremap = true, desc = "Chat with the current buffer" })
vim.keymap.set("v", "<leader>lc", "<cmd>Chat vsplit<CR>", { noremap = true, desc = "Chat with selected code" })
vim.keymap.set(
	"n",
	"<leader>ld",
	"<cmd>Chat vsplit %:h<CR>",
	{ noremap = true, desc = "Chat with the current directory" }
)

-- Only set <C-a> mappings if not in telescope buffer
local function set_add_keymap()
	local opts = { noremap = true, silent = true }
	-- Check if current buffer is not a telescope prompt
	if vim.bo.filetype ~= "TelescopePrompt" and vim.bo.filetype ~= "oil" then
		vim.keymap.set("n", "<C-a>", ":Add<CR>", vim.tbl_extend("force", opts, { desc = "Add context to LLM" }))
		vim.keymap.set(
			"v",
			"<C-a>",
			":Add<CR>",
			vim.tbl_extend("force", opts, { desc = "Add selected context to LLM" })
		)
	end
end

-- Set up an autocmd to run when entering buffers
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function()
		set_add_keymap()
	end,
})

-- Speech to text
vim.keymap.set("i", "<C-o>", "<cmd>Stt<CR>", { noremap = true, silent = true, desc = "Speech to text" })
