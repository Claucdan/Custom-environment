require("nvchad.configs.lspconfig").defaults()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- clangd lsp server
vim.lsp.config('clangd', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--experimental-modules-support",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--limit-references=5",
    "--malloc-trim",
    "--pch-storage=disk",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  init_options = {
    fallbackFlags = {'-std=c++20'},
  }
})

vim.diagnostic.config({
  virtual_text = false,
})

vim.lsp.enable('clangd')
