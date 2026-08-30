vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_init = function(client)
    if client:supports_method('textDocument/semanticTokens') then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = vim.keymap.set
    local function opts(desc)
      return { buffer = args.buf, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  end,
})

-- C/C++
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--clang-tidy",
  },
  filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
  root_markers = { '.git' },
})

-- Go
vim.lsp.config('gopls', {
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

-- PHP
vim.lsp.config('phpactor', {
  init_options = {
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
    ["language_server_mago.enabled"] = false,
  }
})

-- Lua
vim.lsp.config('lua_ls', {
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

vim.diagnostic.config({
  virtual_text = false,
})
