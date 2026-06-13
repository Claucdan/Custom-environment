require('conform').setup({
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    go  = { "gofmr" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  notify_on_error = true,
})
