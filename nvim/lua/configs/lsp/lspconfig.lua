local on_attach = require("configs.lsp.e-lspconfig").on_attach
local on_init = require("configs.lsp.e-lspconfig").on_init
local capabilities = require("configs.lsp.e-lspconfig").capabilities

-- clangd lsp server
vim.lsp.config('clangd', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--background-index-priority=normal",
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
vim.lsp.enable('clangd')

-- Lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  single_file_support = true,
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath('config'),
        },
      },
    },
  }
})
vim.lsp.enable('lua_ls')

-- Bash
vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  single_file_support = true,
})
vim.lsp.enable('bashls')

-- For all
vim.diagnostic.config({
  virtual_text = false,
})
