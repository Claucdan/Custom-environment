-- Default my settings
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

-- Add basic configs
require("configs.lazy")
require("base_configs")
require("mappings")
require("options")

-- Telescope
require("telescope").load_extension("noice")

-- Themes
require("themes.xcodedark").setup()

-- ========== Clipboard ============= --
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
    local contents = vim.deepcopy(vim.v.event.regcontents)
    -- Preserve linewise yanks/deletes when sending plain text through OSC 52.
    if vim.v.event.regtype == "V" then
      table.insert(contents, "")
    end
    local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
    copy_to_unnamedplus(contents)
    local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
    copy_to_unnamed(contents)
  end,
})
