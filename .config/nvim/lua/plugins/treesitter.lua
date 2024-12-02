return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      endwise = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "graphql",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "regex",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "yaml",
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  }
}
