local M = {}

local uv = vim.loop
local data_dir = vim.fn.stdpath("data") .. "/time_tracker"
local stats_file = data_dir .. "/stats.json"
local heartbeat_file = data_dir .. "/heartbeat_" .. vim.fn.getpid()

local timer = nil
local last_tick = os.time()

--------------------------------------------------
-- Utils
--------------------------------------------------

local function ensure_dir()
  vim.fn.mkdir(data_dir, "p")
end

local function read_stats()
  local f = io.open(stats_file, "r")
  if not f then return {} end
  local content = f:read("*a")
  f:close()
  return vim.json.decode(content) or {}
end

local function write_stats(data)
  local f = io.open(stats_file, "w")
  if not f then return end
  f:write(vim.json.encode(data))
  f:close()
end

local function format_time(seconds)
  local h = math.floor(seconds / 3600)
  local m = math.floor((seconds % 3600) / 60)
  return string.format("%dh %dm", h, m)
end

local function current_filetype()
  return vim.bo.filetype ~= "" and vim.bo.filetype or "unknown"
end

--------------------------------------------------
-- Time tracking
--------------------------------------------------

local function update_heartbeat()
  local f = io.open(heartbeat_file, "w")
  if f then
    f:write(os.time())
    f:close()
  end
end

local function add_time(seconds)
  local stats = read_stats()
  local date = os.date("%Y-%m-%d")
  local ft = current_filetype()

  stats[date] = stats[date] or { total = 0, languages = {} }
  stats[date].total = stats[date].total + seconds
  stats[date].languages[ft] =
      (stats[date].languages[ft] or 0) + seconds

  write_stats(stats)
end

local function start_timer()
  timer = uv.new_timer()
  timer:start(0, 5000, vim.schedule_wrap(function()
    local now = os.time()
    local diff = now - last_tick
    last_tick = now

    update_heartbeat()
    add_time(diff)
  end))
end

local function cleanup()
  os.remove(heartbeat_file)
end

--------------------------------------------------
-- :TimeToday
--------------------------------------------------

local function show_today()
  local stats = read_stats()
  local today = os.date("%Y-%m-%d")
  local data = stats[today]

  if not data then
    vim.notify("No activity today 🚀", vim.log.levels.INFO)
    return
  end

  local lines = {}
  table.insert(lines, "📅 " .. today)
  table.insert(lines, "")
  table.insert(lines, "Total: " .. format_time(data.total))
  table.insert(lines, "")
  table.insert(lines, "Languages:")

  for lang, time in pairs(data.languages) do
    table.insert(lines, string.format("  %s: %s", lang, format_time(time)))
  end

  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
    title = "Nvim Time Tracker",
  })
end

--------------------------------------------------
-- Heatmap
--------------------------------------------------

local function setup_highlights()
  vim.api.nvim_set_hl(0, "TimeHeat0", { fg = "#2d333b" })
  vim.api.nvim_set_hl(0, "TimeHeat1", { fg = "#0e4429" })
  vim.api.nvim_set_hl(0, "TimeHeat2", { fg = "#006d32" })
  vim.api.nvim_set_hl(0, "TimeHeat3", { fg = "#26a641" })
  vim.api.nvim_set_hl(0, "TimeHeat4", { fg = "#39d353" })
end

local function get_level(seconds)
  if seconds == 0 then return 0 end
  if seconds < 1800 then return 1 end
  if seconds < 7200 then return 2 end
  if seconds < 14400 then return 3 end
  return 4
end

local function build_matrix()
  local stats = read_stats()
  local matrix = {}

  for w = 1, 53 do
    matrix[w] = {}
    for d = 1, 7 do
      matrix[w][d] = 0
    end
  end

  local today = os.time()

  for i = 0, 364 do
    local ts = today - i * 86400
    local date = os.date("%Y-%m-%d", ts)
    local weekday = tonumber(os.date("%w", ts))
    weekday = weekday == 0 and 7 or weekday

    local week = math.floor((364 - i) / 7) + 1
    if week <= 53 then
      matrix[week][weekday] =
          stats[date] and stats[date].total or 0
    end
  end

  return matrix
end

local function show_year()
  setup_highlights()
  local matrix = build_matrix()

  local buf = vim.api.nvim_create_buf(false, true)

  local lines = {}
  table.insert(lines, "  📈 Nvim Activity — Last 365 Days")
  table.insert(lines, "")

  for day = 1, 7 do
    local line = ""
    for week = 1, 53 do
      line = line .. "██"
    end
    table.insert(lines, line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  for day = 1, 7 do
    for week = 1, 53 do
      local seconds = matrix[week][day]
      local level = get_level(seconds)

      vim.api.nvim_buf_add_highlight(
        buf,
        -1,
        "TimeHeat" .. level,
        day + 1,
        (week - 1) * 2,
        (week - 1) * 2 + 2
      )
    end
  end

  local width = 53 * 2 + 4
  local height = 10

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })
end

--------------------------------------------------
-- Setup
--------------------------------------------------

function M.setup()
  ensure_dir()
  start_timer()

  vim.api.nvim_create_user_command("TimeToday", show_today, {})
  vim.api.nvim_create_user_command("TimeYear", show_year, {})

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = cleanup,
  })
end

return M
