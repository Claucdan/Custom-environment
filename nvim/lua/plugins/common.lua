return {
  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  -- Marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"},
    opts = function ()
      require("configs.gitsigns")
    end
  },
  -- Theme
  {
    "xiantang/darcula-dark.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
  },
  -- Nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {'NvimTreeToggle', 'NvimTreeFocus'},
    opts = function ()
      require("configs.nvimtree")
    end,
  },
  -- Pairs
  {
    'nvim-mini/mini.pairs',
    event = {"BufReadPre", "BufNewFile"},
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
    config = function ()
      require("configs.nvimtree")
    end,
  },
  -- Yank Highlight
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
