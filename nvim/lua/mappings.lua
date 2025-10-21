require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Debbuger mappings
map('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle breakpoint' })
map('n', '<leader>dr', '<cmd>DapContinue<CR>', { desc = 'Start/continue debug' })
map('n', '<leader>ds', '<cmd>DapStepOver<CR>', { desc = 'Step over' })
map('n', '<leader>di', '<cmd>DapStepInto<CR>', { desc = 'Step into' })
map('n', '<leader>do', '<cmd>DapStepOut<CR>', { desc = 'Step out' })
map('n', '<leader>dq', '<cmd>DapTerminate<CR>', { desc = 'Stop debug' })
map('n', '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', { desc = 'Toggle DAP UI' })

-- LSP
map('n', '<leader>lo', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Open diagnostic' })
map('n', '[l', '<cmd>DapContinue<CR>', { noremap = true, silent = true, desc = 'Go to prev diagnostic' })
map('n', ']l', '<cmd>DapStepOver<CR>', { noremap = true, silent = true, desc = 'Go to next diagnostic' })
map('n', '<leader>lt', '<cmd>DapStepInto<CR>', { noremap = true, silent = true, desc = 'Open toggle' })

-- Tabs
map('n', '<leader>tn', '<cmd>:tabnew<CR>', { noremap = true, silent = true, desc = 'Open new tab' })
map('n', '<leader>tc', '<cmd>:tabclose<CR>', { noremap = true, silent = true, desc = 'Close this tab' })
map('n', '<leader>tl', '<cmd>:tabnext<CR>', { noremap = true, silent = true, desc = 'Go to next tab' })
map('n', '<leader>th', '<cmd>:tabprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })
