-- Default my settings
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

-- Add basic configs
require("configs.lazy")
require("mappings")
require("options")

-- Telescope
require("telescope").load_extension("noice")

-- Themes
require("themes.xcodedark").setup()

-- ========== Clipboard ============= --
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.hl_op({ timeout = 1000 })
    local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})
