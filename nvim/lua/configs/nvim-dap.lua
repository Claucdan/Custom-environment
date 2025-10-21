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

  -- Настройка подсветки для точек останова (ИСПРАВЛЕННАЯ ВЕРСИЯ)
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379', bg = '#31353f' })

  -- Настройка значков (эта часть правильная)
  vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
  vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
  vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
  vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
end

return M
