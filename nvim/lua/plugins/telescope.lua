return  {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "Telescope",
  configs = function()
    return require "configs.telescope"
  end,
}
