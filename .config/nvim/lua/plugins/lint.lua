return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        eruby = { "erb_lint" },
        go = { "golangcilint" },
        javascript = { "eslint_d" },
        markdown = { "markdownlint" },
        -- sh = { "shellcheck" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-lint",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>l",
        function()
          require("lint").try_lint()
        end,
        desc = "Lint the current file",
      },
    },
    opts = {
      automatic_installation = true,
      quiet_mode = false,
    },
  },
}
