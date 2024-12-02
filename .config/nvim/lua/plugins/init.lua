return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},
	-- See https://github.com/gbprod/yanky.nvim/issues/75
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				mappings = { basic = true },
			})
		end,
	},

	"github/copilot.vim",

	"folke/neodev.nvim",

	-- vimscript plugins where I couldn't find a lua alternative

	"AndrewRadev/splitjoin.vim",
	"tpope/vim-rails",
	"junegunn/vim-easy-align",
	"tpope/vim-rsi",
	"tpope/vim-unimpaired",
}
