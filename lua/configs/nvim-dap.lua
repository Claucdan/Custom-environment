local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Настройка адаптера codelldb для C/C++
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
      args = { '--port', '${port}' },
    }
  }

  -- Конфигурации для C/C++
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
    },
  }

  -- Используем те же конфигурации для C
  dap.configurations.c = dap.configurations.cpp

  -- Настройка dap-ui :cite[1]:cite[4]
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.33 },
          { id = "breakpoints", size = 0.17 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 0.33,
        position = "right",
      },
      {
        elements = {
          { id = "repl", size = 0.45 },
          { id = "console", size = 0.55 },
        },
        size = 0.27,
        position = "bottom",
      },
    },
  })

  -- Автоматическое открытие/закрытие UI :cite[1]:cite[9]
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end

  -- Настройка значков для точек останова :cite[1]:cite[10]
  vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "LspDiagnosticsSignError" })
  vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "LspDiagnosticsSignInformation" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "LspDiagnosticsSignHint" })
end

return M
