return {
  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  -- Screenkey
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "main", to use the latest commit
  },
  -- Marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require("configs.gitsigns")
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true
  },
  -- Formating
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require "configs.conform"
    end,
  },
  -- Sessions
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    opts = {
      autostart = true,
      autosave = true,
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      use_git_branch = true,
      autoload = false,
    },
  },
  -- Navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>jj", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
      { "<leader>jt", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "<leader>jr", mode = "o",               function() require("flash").remote() end,     desc = "Flash remote" },
      { "<c-s>",      mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash search" },
    },
  },
}
