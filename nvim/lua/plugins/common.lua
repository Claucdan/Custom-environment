return {
  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    'nvim-mini/mini.nvim',
    version = '*'
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
    event = {"BufReadPre", "BufNewFile"},
    opts = function()
      require("configs.gitsigns")
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true
  },
  -- Nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },
  -- Pairs
  {
    "nvim-mini/mini.pairs",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },

  },
  -- Formating
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require "configs.conform"
    end,
  },
  -- Yank highlight
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
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
}
