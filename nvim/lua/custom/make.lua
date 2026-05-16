_G.last_make_command = nil
_G.make_terminal_buf = nil
_G.build_targets = {}

local config_file = vim.fn.stdpath('config') .. '/build_targets.json'

-- Загрузка таргетов из файла
local function load_targets()
    local ok, data = pcall(vim.fn.readfile, config_file)
    if ok and data[1] then
        _G.build_targets = vim.fn.json_decode(data[1])
    else
        _G.build_targets = {}
    end
end

-- Сохранение таргетов в файл
local function save_targets()
    local data = vim.fn.json_encode(_G.build_targets)
    vim.fn.writefile({data}, config_file)
end

-- Загружаем таргеты при старте
load_targets()

local function run_make_command(command)
    if _G.make_terminal_buf and vim.api.nvim_buf_is_valid(_G.make_terminal_buf) then
        vim.cmd('buffer ' .. _G.make_terminal_buf)
    else
        vim.cmd('terminal')
        _G.make_terminal_buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd('startinsert')
    vim.defer_fn(function()
        if vim.b.terminal_job_id then
            vim.fn.chansend(vim.b.terminal_job_id, "clear\n")
            vim.fn.chansend(vim.b.terminal_job_id, command .. "\n")
        end
    end, 300)
end

-- Основная команда сборки (оставьте вашу текущую)
vim.api.nvim_create_user_command('Build', function()
    vim.ui.input({
        prompt = 'Флаги сборки: ',
        default = '',
    }, function(flags)
        if flags == nil then return end
        vim.ui.input({
            prompt = 'Имя проекта: ',
            default = '',
        }, function(project_name)
            if project_name == nil then return end
            local make_cmd = "meson compile" .. flags .. " " .. project_name
            _G.last_make_command = make_cmd
            run_make_command(make_cmd)
            vim.notify("🔨 Сборка запущена: " .. make_cmd)
        end)
    end)
end, {
    desc = "Сборка проекта в терминале"
})

vim.api.nvim_create_user_command('TargetNew', function()
    vim.ui.input({
        prompt = 'Название таргета: ',
        default = '',
    }, function(target_name)
        if target_name == nil or target_name == '' then return end
        vim.ui.input({
            prompt = 'Команда сборки для "' .. target_name .. '": ',
            default = '',
        }, function(build_command)
            if build_command == nil or build_command == '' then return end
            _G.build_targets[target_name] = build_command
            save_targets()
            vim.notify("✅ Таргет '" .. target_name .. "' сохранен")
        end)
    end)
end, {
    desc = "Создать новый таргет сборки"
})

-- ПЕРЕПИСАННАЯ команда для выбора таргета с использованием vim.ui.select
vim.api.nvim_create_user_command('Target', function()
    local target_count = 0
    for _ in pairs(_G.build_targets) do
        target_count = target_count + 1
    end
    if target_count == 0 then
        vim.notify("❌ Нет сохраненных таргетов. Используйте :TargetNew", vim.log.levels.ERROR)
        return
    end
    -- Подготавливаем список для vim.ui.select
    local targets_list = {}
    for name, cmd in pairs(_G.build_targets) do
        table.insert(targets_list, {
            name = name,
            cmd = cmd,
            -- Форматируем для красивого отображения
            display = string.format("🔨 %s\n   📝 %s", name, cmd)
        })
    end
    -- Сортируем по имени
    table.sort(targets_list, function(a, b) return a.name < b.name end)
    vim.ui.select(targets_list, {
        prompt = '📋 Выберите таргет сборки:',
        format_item = function(item)
            return item.display
        end,
    }, function(selected)
        if not selected then
            vim.notify("❌ Выбор отменен", vim.log.levels.WARN)
            return
        end
        _G.last_make_command = selected.cmd
        run_make_command(selected.cmd)
        vim.notify("🔨 Запускаю: " .. selected.cmd)
    end)
end, {
    desc = "Выбрать таргет сборки"
})

-- Команда для просмотра всех таргетов
vim.api.nvim_create_user_command('TargetList', function()
    local target_count = 0
    for _ in pairs(_G.build_targets) do
        target_count = target_count + 1
    end
    if target_count == 0 then
        print("📝 Список таргетов пуст")
        return
    end
    print("📋 Сохраненные таргеты сборки:")
    local targets_list = {}
    for name, cmd in pairs(_G.build_targets) do
        table.insert(targets_list, { name = name, cmd = cmd })
    end
    table.sort(targets_list, function(a, b) return a.name < b.name end)
    for i, target in ipairs(targets_list) do
        print(string.format("  %d. %s → %s", i, target.name, target.cmd))
    end
end, {
    desc = "Показать список всех таргетов"
})

-- Команда для удаления таргета (уже использует vim.ui.select - оставляем как есть)
vim.api.nvim_create_user_command('TargetDelete', function()
    local target_count = 0
    for _ in pairs(_G.build_targets) do
        target_count = target_count + 1
    end
    if target_count == 0 then
        vim.notify("❌ Нет сохраненных таргетов", vim.log.levels.ERROR)
        return
    end
    local targets_list = {}
    for name, cmd in pairs(_G.build_targets) do
        table.insert(targets_list, name)
    end
    table.sort(targets_list)
    vim.ui.select(targets_list, {
        prompt = 'Выберите таргет для удаления:',
    }, function(selected)
        if not selected then return end
        _G.build_targets[selected] = nil
        save_targets()
        vim.notify("🗑️  Таргет '" .. selected .. "' удален")
    end)
end, {
    desc = "Удалить таргет сборки"
})

-- Повтор последней сборки (оставьте вашу текущую)
vim.api.nvim_create_user_command('LastBuild', function()
    if _G.last_make_command then
        run_make_command(_G.last_make_command)
        vim.notify("🔁 Повторяю: " .. _G.last_make_command)
    else
        vim.notify("❌ Нет истории сборок", vim.log.levels.ERROR)
    end
end, {
    desc = "Повторить последнюю сборку в терминале"
})
