vim.g.gitblame_enabled = 0

return {
	{
		"f-person/git-blame.nvim",
		keys = {
			{ "<leader>gb", "<cmd>GitBlameToggle<cr>", "Toggle git blame" },
		},
		opts = {},
	},
}
