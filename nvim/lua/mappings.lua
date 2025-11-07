local map = vim.keymap.set

-- ========== Basics =========== --
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ========== Debug =========== --
map('n', '<leader>db', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle breakpoint' })
map('n', '<leader>dr', '<cmd>DapContinue<CR>', { desc = 'Start/continue debug' })
map('n', '<leader>ds', '<cmd>DapStepOver<CR>', { desc = 'Step over' })
map('n', '<leader>di', '<cmd>DapStepInto<CR>', { desc = 'Step into' })
map('n', '<leader>do', '<cmd>DapStepOut<CR>', { desc = 'Step out' })
map('n', '<leader>dq', '<cmd>DapTerminate<CR>', { desc = 'Stop debug' })
map('n', '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', { desc = 'Toggle DAP UI' })

-- ========== LSP =========== --
map('n', '<leader>lo', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Open diagnostic' })
map('n', '[l', '<cmd>DapContinue<CR>', { noremap = true, silent = true, desc = 'Go to prev diagnostic' })
map('n', ']l', '<cmd>DapStepOver<CR>', { noremap = true, silent = true, desc = 'Go to next diagnostic' })
map('n', '<leader>lt', '<cmd>DapStepInto<CR>', { noremap = true, silent = true, desc = 'Open toggle' })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- ========== Tabs ========== --
map('n', '<leader>tn', '<cmd>:tabnew<CR>', { noremap = true, silent = true, desc = 'Open new tab' })
map('n', '<leader>tc', '<cmd>:tabclose<CR>', { noremap = true, silent = true, desc = 'Close this tab' })
map('n', '<leader>tl', '<cmd>:tabnext<CR>', { noremap = true, silent = true, desc = 'Go to next tab' })
map('n', '<leader>th', '<cmd>:tabprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })

-- ========== Sessions ============= --
map("n", "<leader>ss", "<cmd>:SessionSave<CR>", {noremap = true, silent = true})
map("n", "<leader>sl", "<cmd>:SessionLoad<CR>", {noremap = true, silent = true})
map("n", "<leader>st", "<cmd>:Telescope persisted<CR>", {noremap = true, silent = true})

-- ========== Window moves ============= --
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- ========== Line moves ============= --
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- ========== Comments ============= --
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- ========== Nvim-tree ============= --
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- ========== Telescope ============= --
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })

-- ========== Which-key ============= --
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

-- ========== Buffers ============= --
map("n", "<leader>x", "<cmd>bp | sp | bn | bd<CR>", {desc = "Close buffer"})
map("n", "<leader>e", "<cmd>enew<CR>", {desc = "Create buffer"})
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", {desc = "Go to next buffer"})
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", {desc = "Go to prev buffer"})
