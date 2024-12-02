return {
  {
    "jay-babu/mason-nvim-dap.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "suketa/nvim-dap-ruby",
    },
    config = function()
      require("dapui").setup()
      require("dap-ruby").setup({})
      require("mason-nvim-dap").setup()
    end,
  },
}
