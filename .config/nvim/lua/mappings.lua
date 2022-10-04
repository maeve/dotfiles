vim.g.mapleader = ','

-- fuzzy finding
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', 'ff', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', '-', ":Telescope file_browser path=%:p:h<cr>", { noremap = true })

-- git
vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { noremap = true })
vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<cr>', { noremap = true })
