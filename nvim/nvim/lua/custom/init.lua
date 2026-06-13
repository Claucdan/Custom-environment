-- ========== Telescope ============= --
require("telescope").load_extension("noice")
require("telescope.themes").get_dropdown()


-- ========== Theme ============= --
require("custom.darcula").setup()

-- ========== Make ============= --
require("custom.make")

-- ========== Formating ============= --
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.go" },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

-- ========== Clipboard ============= --
vim.o.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- vim.highlight.on_yank()
    local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})
