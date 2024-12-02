return {
  -- external tooling for LSP servers, autocompletion,
  -- linting, formatting, etc.
  {
    "williamboman/mason.nvim",
    dependencies = {
      -- lsp
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",

      -- linting/formatting
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",

      -- debugging
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "suketa/nvim-dap-ruby",
    },
    config = [[require('config.mason')]],
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      -- "hrsh7th/cmp-emoji",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      -- "f3fora/cmp-spell",
      -- "tamago324/cmp-zsh",

      -- nvim-cmp request a snippets plugin; several are supported,
      -- I chose LuaSnip because why not
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = [[require('config.cmp')]],
  },

  -- git client
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neogit").setup({
        kind = "split",
        integrations = {
          diffview = true,
        },
      })
    end,
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
      require("gitblame")
    end,
  },

  -- git gutter signs (also blame but seems slower than git-blame)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end)
          map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },


  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = [[require('config.treesitter')]],
  },

  {
    "cameron-wags/rainbow_csv.nvim",
    config = function()
      require("rainbow_csv").setup()
    end,
    -- optional lazy-loading below
    module = {
      "rainbow_csv",
      "rainbow_csv.fns",
    },
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },
  -- change surrounding delimiters (e.g. changing "" to '')
  {
    "kylechui/nvim-surround",
    version = "*",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    config = [[require('config.surround')]],
  },

  -- testing
  {
    "nvim-neotest/neotest",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "olimorris/neotest-rspec",
      "rouge8/neotest-rust",
    },
    config = [[require ("config.neotest")]],
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = [[require('config.toggleterm')]],
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = "ray-x/guihua.lua",
    config = function()
      require("go").setup({})
    end,
  },

  -- See https://github.com/gbprod/yanky.nvim/issues/75
  {
	  "gbprod/yanky.nvim",
	  config = function()
		  require("yanky").setup({})
	  end
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
