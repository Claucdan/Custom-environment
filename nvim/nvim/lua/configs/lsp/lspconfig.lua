local on_attach = require("configs.lsp.e-lspconfig").on_attach
local on_init = require("configs.lsp.e-lspconfig").on_init
local capabilities = require("configs.lsp.e-lspconfig").capabilities

-- C/C++
vim.lsp.config('clangd', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd-22",
    "--clang-tidy",
  },
  filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
  root_markers = { '.git' },
})
vim.lsp.enable('clangd')

-- Go (gopls) lsp server
vim.lsp.config('gopls', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', '.git' },
  single_file_support = true,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')

-- PhP
vim.lsp.config('phpactor', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  init_options = {
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  }
})
vim.lsp.enable('phpactor')

-- Lua
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  single_file_support = true,
})
vim.lsp.enable('bashls')

-- Meson
vim.lsp.config('meson_ls', {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { 'mesonlsp' },
  filetypes = { 'meson' },
  root_markers = { 'meson.build', '.git' },
  single_file_support = true,
  settings = {}
})
vim.lsp.enable('meson_ls')

-- For all
vim.diagnostic.config({
  virtual_text = false,
})
