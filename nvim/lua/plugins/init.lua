return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Yank highlight
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
  },
  -- Icons
  {
    'ryanoasis/vim-devicons',
    event = "VeryLazy",
  },
  -- These are for C/C++ Debbuger
  {
    "nvim-neotest/nvim-nio",
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function ()
      require("configs.nvim-dap").setup()
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
  "theHamsta/nvim-dap-virtual-text",
  dependencies = "mfussenegger/nvim-dap",
  config = function()
    require("nvim-dap-virtual-text").setup()
  end,
  },
}
