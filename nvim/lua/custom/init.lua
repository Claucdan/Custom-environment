-- ========== Telescope ============= --
require("telescope").load_extension("noice")
require("telescope.themes").get_dropdown()


-- ========== Theme ============= --
require("custom.darcula").setup()

-- ========== Make ============= --
require("custom.make")

-- ========== Formating ============= --
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.go" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

