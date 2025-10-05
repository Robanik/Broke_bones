-- ═══════════════════════════════════════════════════════
-- 💀 ROBANIK BONE BREAKER - ULTIMATE EDITION
-- BY ROBANIK | For "Break Your Bones" Game
-- Maximum Damage System | Premium Quality
-- ═══════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

print("🚀 Загрузка Bone Breaker...")

-- ═══════════════════════════════════════════════════════
-- 🛡️ ЗАЩИТА
-- ═══════════════════════════════════════════════════════

pcall(function()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then return end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end)

-- ═══════════════════════════════════════════════════════
-- 🎨 GUI СОЗДАНИЕ
-- ═══════════════════════════════════════════════════════

local gui = Instance.new("ScreenGui")
gui.Name = "RobanikBoneBreakerGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui") or player.PlayerGui

-- Главный фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 480)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(220, 38, 38)
mainStroke.Thickness = 3
mainStroke.Transparency = 0.3

-- Заголовок
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
header.BorderSizePixel = 0
header.Position = UDim2.new(0, 0, 0, 0)

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)

local headerGrad = Instance.new("UIGradient", header)
headerGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 38, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 27, 27))
}

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 60, 0, 0)
title.BackgroundTransparency = 1
title.Text = "💀 BONE BREAKER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local icon = Instance.new("TextLabel", header)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 5, 0, 5)
icon.BackgroundTransparency = 1
icon.Text = "💥"
icon.TextSize = 32

local brand = Instance.new("TextLabel", header)
brand.Size = UDim2.new(0, 80, 0, 18)
brand.Position = UDim2.new(1, -85, 0, 6)
brand.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
brand.BackgroundTransparency = 0
brand.Text = "ROBANIK"
brand.TextColor3 = Color3.fromRGB(0, 0, 0)
brand.TextSize = 10
brand.Font = Enum.Font.GothamBold
brand.BorderSizePixel = 0

Instance.new("UICorner", brand).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Статистика
local statsFrame = Instance.new("Frame", mainFrame)
statsFrame.Size = UDim2.new(1, -30, 0, 70)
statsFrame.Position = UDim2.new(0, 15, 0, 75)
statsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statsFrame.BorderSizePixel = 0

Instance.new("UICorner", statsFrame).CornerRadius = UDim.new(0, 12)

local statValues = {}

for i = 1, 3 do
    local statBox = Instance.new("Frame", statsFrame)
    statBox.Size = UDim2.new(0.33, -8, 1, -10)
    statBox.Position = UDim2.new((i-1) * 0.33, 5 + (i-1) * 4, 0, 5)
    statBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statBox.BorderSizePixel = 0
    Instance.new("UICorner", statBox).CornerRadius = UDim.new(0, 8)
    
    local icons = {"🦴", "⚡", "💥"}
    local names = {"Сломано", "Урон/сек", "Макс. урон"}
    local colors = {
        Color3.fromRGB(239, 68, 68),
        Color3.fromRGB(234, 179, 8),
        Color3.fromRGB(168, 85, 247)
    }
    
    local iconLabel = Instance.new("TextLabel", statBox)
    iconLabel.Size = UDim2.new(0, 30, 0, 30)
    iconLabel.Position = UDim2.new(0, 5, 0, 3)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icons[i]
    iconLabel.TextSize = 18
    
    local nameLabel = Instance.new("TextLabel", statBox)
    nameLabel.Size = UDim2.new(1, -40, 0, 16)
    nameLabel.Position = UDim2.new(0, 38, 0, 3)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = names[i]
    nameLabel.TextColor3 = Color3.fromRGB(156, 163, 175)
    nameLabel.TextSize = 9
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel", statBox)
    valueLabel.Size = UDim2.new(1, -40, 0, 22)
    valueLabel.Position = UDim2.new(0, 38, 0, 20)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "0"
    valueLabel.TextColor3 = colors[i]
    valueLabel.TextSize = 16
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    statValues[i] = valueLabel
end

-- Режимы
local modesFrame = Instance.new("Frame", mainFrame)
modesFrame.Size = UDim2.new(1, -30, 0, 100)
modesFrame.Position = UDim2.new(0, 15, 0, 160)
modesFrame.BackgroundTransparency = 1

local modesTitle = Instance.new("TextLabel", modesFrame)
modesTitle.Size = UDim2.new(1, 0, 0, 20)
modesTitle.BackgroundTransparency = 1
modesTitle.Text = "🎯 РЕЖИМЫ УДАРА"
modesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
modesTitle.TextSize = 13
modesTitle.Font = Enum.Font.GothamBold
modesTitle.TextXAlignment = Enum.TextXAlignment.Left

local modes = {
    {name = "БЫСТРЫЙ", desc = "Много ударов", icon = "⚡", color = Color3.fromRGB(59, 130, 246)},
    {name = "МОЩНЫЙ", desc = "Макс. урон", icon = "💪", color = Color3.fromRGB(220, 38, 38)},
    {name = "КОМБО", desc = "Серия ударов", icon = "🔥", color = Color3.fromRGB(234, 179, 8)}
}

local modeButtons = {}

for i, mode in ipairs(modes) do
    local btn = Instance.new("TextButton", modesFrame)
    btn.Name = mode.name
    btn.Size = UDim2.new(0.33, -7, 0, 65)
    btn.Position = UDim2.new((i-1) * 0.33, (i-1) * 3.5, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.BorderSizePixel = 0
    btn.Text = ""
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = mode.color
    stroke.Thickness = 2
    stroke.Transparency = 0.7
    
    local btnIcon = Instance.new("TextLabel", btn)
    btnIcon.Size = UDim2.new(1, 0, 0, 25)
    btnIcon.Position = UDim2.new(0, 0, 0, 5)
    btnIcon.BackgroundTransparency = 1
    btnIcon.Text = mode.icon
    btnIcon.TextSize = 20
    
    local btnName = Instance.new("TextLabel", btn)
    btnName.Size = UDim2.new(1, -10, 0, 16)
    btnName.Position = UDim2.new(0, 5, 0, 30)
    btnName.BackgroundTransparency = 1
    btnName.Text = mode.name
    btnName.TextColor3 = mode.color
    btnName.TextSize = 11
    btnName.Font = Enum.Font.GothamBold
    
    local btnDesc = Instance.new("TextLabel", btn)
    btnDesc.Size = UDim2.new(1, -10, 0, 12)
    btnDesc.Position = UDim2.new(0, 5, 0, 48)
    btnDesc.BackgroundTransparency = 1
    btnDesc.Text = mode.desc
    btnDesc.TextColor3 = Color3.fromRGB(156, 163, 175)
    btnDesc.TextSize = 8
    btnDesc.Font = Enum.Font.Gotham
    
    table.insert(modeButtons, {btn = btn, stroke = stroke, color = mode.color, name = mode.name})
end

-- Настройки силы
local settingsFrame = Instance.new("Frame", mainFrame)
settingsFrame.Size = UDim2.new(1, -30, 0, 75)
settingsFrame.Position = UDim2.new(0, 15, 0, 275)
settingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
settingsFrame.BorderSizePixel = 0

Instance.new("UICorner", settingsFrame).CornerRadius = UDim.new(0, 12)

local powerLabel = Instance.new("TextLabel", settingsFrame)
powerLabel.Size = UDim2.new(1, -20, 0, 22)
powerLabel.Position = UDim2.new(0, 10, 0, 8)
powerLabel.BackgroundTransparency = 1
powerLabel.Text = "⚙️ Сила удара: 100%"
powerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
powerLabel.TextSize = 13
powerLabel.Font = Enum.Font.GothamBold
powerLabel.TextXAlignment = Enum.TextXAlignment.Left

local sliderBg = Instance.new("Frame", settingsFrame)
sliderBg.Size = UDim2.new(1, -20, 0, 8)
sliderBg.Position = UDim2.new(0, 10, 0, 38)
sliderBg.BackgroundColor3 = Color3.fromRGB(55, 65, 81)
sliderBg.BorderSizePixel = 0

Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame", sliderBg)
sliderFill.Size = UDim2.new(1, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
sliderFill.BorderSizePixel = 0

Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local speedLabel = Instance.new("TextLabel", settingsFrame)
speedLabel.Size = UDim2.new(1, -20, 0, 18)
speedLabel.Position = UDim2.new(0, 10, 0, 52)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⏱️ Интервал: 0.3 сек"
speedLabel.TextColor3 = Color3.fromRGB(156, 163, 175)
speedLabel.TextSize = 11
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопки управления
local startBtn = Instance.new("TextButton", mainFrame)
startBtn.Size = UDim2.new(0.48, -15, 0, 45)
startBtn.Position = UDim2.new(0, 15, 0, 365)
startBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
startBtn.BorderSizePixel = 0
startBtn.Text = "▶️ СТАРТ"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.TextSize = 16
startBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 10)

local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(0.48, -15, 0, 45)
stopBtn.Position = UDim2.new(0.52, 0, 0, 365)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
stopBtn.BorderSizePixel = 0
stopBtn.Text = "⏹️ СТОП"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 16
stopBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 10)

local autoBtn = Instance.new("TextButton", mainFrame)
autoBtn.Size = UDim2.new(1, -30, 0, 26)
autoBtn.Position = UDim2.new(0, 15, 0, 420)
autoBtn.BackgroundColor3 = Color3.fromRGB(107, 114, 128)
autoBtn.BorderSizePixel = 0
autoBtn.Text = "🔄 АВТО: ВЫКЛ"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.TextSize = 12
autoBtn.Font = Enum.Font.GothamBold

Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 8)

-- Мини кнопка
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -30)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "💀"
toggleBtn.TextSize = 28
toggleBtn.Active = true
toggleBtn.Draggable = true

Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

-- ═══════════════════════════════════════════════════════
-- 💥 СИСТЕМА ЛОМАНИЯ КОСТЕЙ
-- ═══════════════════════════════════════════════════════

local breaker = {
    active = false,
    mode = "БЫСТРЫЙ",
    power = 1,
    totalBones = 0,
    maxDamage = 0,
    dps = 0
}

local modeSettings = {
    ["БЫСТРЫЙ"] = {vel = 150, int = 0.3, cnt = 1},
    ["МОЩНЫЙ"] = {vel = 350, int = 1, cnt = 1},
    ["КОМБО"] = {vel = 200, int = 0.15, cnt = 5}
}

local function getRoot()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function createEffect(pos)
    local p = Instance.new("Part")
    p.Size = Vector3.new(0.5, 0.5, 0.5)
    p.Position = pos
    p.Anchored = true
    p.CanCollide = false
    p.Material = Enum.Material.Neon
    p.Color = Color3.fromRGB(220, 38, 38)
    p.Transparency = 0.3
    p.Parent = workspace
    
    spawn(function()
        wait(0.5)
        p:Destroy()
    end)
    
    TweenService:Create(p, TweenInfo.new(0.5), {Size = Vector3.new(3, 3, 3), Transparency = 1}):Play()
end

local function performHit()
    local root = getRoot()
    if not root then return end
    
    local settings = modeSettings[breaker.mode]
    local velocity = settings.vel * breaker.power
    
    local ray = Ray.new(root.Position, root.CFrame.LookVector * 20)
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character})
    
    if hit then
        createEffect(pos)
        
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(100000, 100000, 100000)
        bv.Velocity = root.CFrame.LookVector * velocity
        bv.Parent = root
        
        game:GetService("Debris"):AddItem(bv, 0.1)
        
        breaker.totalBones = breaker.totalBones + 1
        if velocity > breaker.maxDamage then
            breaker.maxDamage = math.floor(velocity)
        end
        
        print("💥 Удар! Скорость:", velocity)
    end
end

local lastHit = tick()
local dmgCount = 0
local lastDmgCheck = tick()
local connection = nil

local function autoLoop()
    if not breaker.active then return end
    if not getRoot() then return end
    
    local now = tick()
    local settings = modeSettings[breaker.mode]
    
    if now - lastHit >= settings.int then
        for i = 1, settings.cnt do
            performHit()
            if settings.cnt > 1 then wait(0.05) end
        end
        lastHit = now
        dmgCount = dmgCount + 1
    end
    
    if now - lastDmgCheck >= 1 then
        breaker.dps = dmgCount
        dmgCount = 0
        lastDmgCheck = now
    end
end

-- Обновление UI
spawn(function()
    while wait(0.1) do
        statValues[1].Text = tostring(breaker.totalBones)
        statValues[2].Text = tostring(breaker.dps)
        statValues[3].Text = tostring(breaker.maxDamage)
    end
end)

-- ═══════════════════════════════════════════════════════
-- 🎮 СОБЫТИЯ
-- ═══════════════════════════════════════════════════════

print("⚙️ Настройка событий...")

-- Выбор режима
for i, data in ipairs(modeButtons) do
    data.btn.MouseButton1Click:Connect(function()
        print("🎯 Выбран режим:", data.name)
        breaker.mode = data.name
        
        for _, d in ipairs(modeButtons) do
            d.stroke.Transparency = 0.7
            d.stroke.Thickness = 2
        end
        
        data.stroke.Transparency = 0
        data.stroke.Thickness = 3
        
        local s = modeSettings[breaker.mode]
        speedLabel.Text = "⏱️ Интервал: " .. s.int .. " сек"
    end)
end

-- Слайдер
local dragging = false

sliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        print("🖱️ Слайдер активирован")
    end
end)

sliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging then
        local mouse = game:GetService("UserInputService"):GetMouseLocation()
        local relativeX = mouse.X - sliderBg.AbsolutePosition.X
        local percentage = math.clamp(relativeX / sliderBg.AbsoluteSize.X, 0, 1)
        
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        breaker.power = 0.1 + (percentage * 1.9)
        powerLabel.Text = string.format("⚙️ Сила удара: %d%%", math.floor(breaker.power * 100))
        
        local hue = 0.33 - (percentage * 0.33)
        sliderFill.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 0.9)
    end
end)

-- Старт
startBtn.MouseButton1Click:Connect(function()
    print("▶️ СТАРТ нажат")
    if not breaker.active then
        breaker.active = true
        connection = RunService.Heartbeat:Connect(autoLoop)
        print("✅ Система активирована!")
    end
end)

-- Стоп
stopBtn.MouseButton1Click:Connect(function()
    print("⏹️ СТОП нажат")
    if breaker.active then
        breaker.active = false
        if connection then
            connection:Disconnect()
            connection = nil
        end
        print("❌ Система остановлена")
    end
end)

-- Авто
autoBtn.MouseButton1Click:Connect(function()
    print("🔄 Авто-режим переключен")
    if not breaker.active then
        startBtn.MouseButton1Click:Fire()
        autoBtn.Text = "🔄 АВТО: ВКЛ"
        autoBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
    else
        stopBtn.MouseButton1Click:Fire()
        autoBtn.Text = "🔄 АВТО: ВЫКЛ"
        autoBtn.BackgroundColor3 = Color3.fromRGB(107, 114, 128)
    end
end)

-- Закрытие
closeBtn.MouseButton1Click:Connect(function()
    print("❌ Закрытие GUI")
    mainFrame.Visible = false
end)

-- Открытие
toggleBtn.MouseButton1Click:Connect(function()
    print("🔄 Переключение видимости")
    mainFrame.Visible = not mainFrame.Visible
end)

-- Анимации
spawn(function()
    while wait(0.03) do
        if headerGrad and headerGrad.Parent then
            headerGrad.Rotation = (headerGrad.Rotation + 2) % 360
        end
    end
end)

-- Инициализация
print("🎯 Активация первого режима...")
modeButtons[1].btn.MouseButton1Click:Fire()

print("═══════════════════════════════════")
print("💀 ROBANIK BONE BREAKER")
print("✅ УСПЕШНО ЗАГРУЖЕНО!")
print("═══════════════════════════════════")
print("🎮 Инструкции:")
print("1. Выберите режим (Быстрый/Мощный/Комбо)")
print("2. Настройте силу слайдером")
print("3. Нажмите СТАРТ")
print("4. Бейтесь об стены!")
print("═══════════════════════════════════")

wait(1)

-- Уведомление
local notif = Instance.new("Frame", gui)
notif.Size = UDim2.new(0, 300, 0, 80)
notif.Position = UDim2.new(0.5, -150, 0, -100)
notif.BackgroundColor3 = Color3.fromRGB(17, 24, 39)
notif.BorderSizePixel = 0

Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)

local notifText = Instance.new("TextLabel", notif)
notifText.Size = UDim2.new(1, -20, 1, -20)
notifText.Position = UDim2.new(0, 10, 0, 10)
notifText.BackgroundTransparency = 1
notifText.Text = "✅ BONE BREAKER\nЗагружено успешно!\n💥 Ломай кости!"
notifText.TextColor3 = Color3.fromRGB(34, 197, 94)
notifText.TextSize = 14
notifText.Font = Enum.Font.GothamBold
notifText.TextWrapped = true

TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()

wait(3)

TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -150, 0, -100)}):Play()

wait(0.5)
notif:Destroy()
