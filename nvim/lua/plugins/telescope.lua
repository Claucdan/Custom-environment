return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter'},
  cmd = "Telescope",
  configs =function ()
    return require("configs.telescope")
  end,
}
