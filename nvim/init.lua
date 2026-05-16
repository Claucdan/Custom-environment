-- Default my settings
vim.g.mapleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.wrap = false

-- Add basic configs
require("configs.lazy")
require("mappings")
require("options")
require("custom.init")
