local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local parent = plr:WaitForChild("PlayerGui")

local KEYBD = Enum.UserInputType.Keyboard.Value
local scriptDestroyed = false
local allConns = {}

local function track(c)
    table.insert(allConns, c)
    return c
end

local function getTypeValue(inp)
    local ok, v = pcall(function() return inp.UserInputType.Value end)
    return ok and v or -1
end

-- SPLASH
local SPLASH_ACCENT = Color3.fromRGB(100, 70, 255)
local SPLASH_DIM = Color3.fromRGB(65, 45, 160)
local SPLASH_BG = Color3.fromRGB(12, 12, 22)
local SPLASH_TXT = Color3.fromRGB(200, 200, 220)

local sg = Instance.new("ScreenGui")
sg.Name = "MomentumSplash"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 999
sg.Parent = parent

-- dark overlay
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = SPLASH_BG
overlay.BackgroundTransparency = 1
overlay.BorderSizePixel = 0
overlay.Parent = sg

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game:GetService("Lighting")

local TEXT_SIZE = 80
local TOTAL_WIDTH = 600

local wordFrame = Instance.new("Frame")
wordFrame.Size = UDim2.new(0, TOTAL_WIDTH, 0, TEXT_SIZE + 20)
wordFrame.Position = UDim2.new(0.5, -TOTAL_WIDTH / 2, 0.5, -(TEXT_SIZE + 20) / 2)
wordFrame.BackgroundTransparency = 1
wordFrame.Parent = sg

-- "M" — purple accent
local mLabel = Instance.new("TextLabel")
mLabel.Size = UDim2.new(0, 100, 1, 0)
mLabel.Position = UDim2.new(0, 0, 0, 0)
mLabel.BackgroundTransparency = 1
mLabel.Text = "M"
mLabel.Font = Enum.Font.GothamBold
mLabel.TextSize = TEXT_SIZE
mLabel.TextColor3 = SPLASH_ACCENT
mLabel.TextTransparency = 1
mLabel.TextXAlignment = Enum.TextXAlignment.Center
mLabel.TextYAlignment = Enum.TextYAlignment.Center
mLabel.Parent = wordFrame

-- "OMENTUM" — lighter
local oLabel = Instance.new("TextLabel")
oLabel.Size = UDim2.new(0, 500, 1, 0)
oLabel.Position = UDim2.new(0, 100, 0, 60)
oLabel.BackgroundTransparency = 1
oLabel.Text = "OMENTUM"
oLabel.Font = Enum.Font.GothamBold
oLabel.TextSize = TEXT_SIZE
oLabel.TextColor3 = SPLASH_TXT
oLabel.TextTransparency = 1
oLabel.TextXAlignment = Enum.TextXAlignment.Left
oLabel.TextYAlignment = Enum.TextYAlignment.Center
oLabel.Parent = wordFrame

-- accent line under text
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(0, 0, 0, 2)
accentLine.Position = UDim2.new(0.5, 0, 0.5, TEXT_SIZE / 2 + 8)
accentLine.AnchorPoint = Vector2.new(0.5, 0)
accentLine.BackgroundColor3 = SPLASH_ACCENT
accentLine.BorderSizePixel = 0
accentLine.BackgroundTransparency = 1
accentLine.Parent = sg

local lineGradient = Instance.new("UIGradient")
lineGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, SPLASH_BG),
    ColorSequenceKeypoint.new(0.3, SPLASH_DIM),
    ColorSequenceKeypoint.new(0.5, SPLASH_ACCENT),
    ColorSequenceKeypoint.new(0.7, SPLASH_DIM),
    ColorSequenceKeypoint.new(1, SPLASH_BG),
})
lineGradient.Parent = accentLine

-- credit
local creditLab = Instance.new("TextLabel")
creditLab.Size = UDim2.new(1, 0, 0, 18)
creditLab.Position = UDim2.new(0.5, 0, 0.5, TEXT_SIZE / 2 + 18)
creditLab.BackgroundTransparency = 1
creditLab.Text = "Made by QWTOP, poka"
creditLab.Font = Enum.Font.GothamBold
creditLab.TextSize = 14
creditLab.TextColor3 = SPLASH_DIM
creditLab.TextTransparency = 1
creditLab.TextXAlignment = Enum.TextXAlignment.Center
creditLab.TextYAlignment = Enum.TextYAlignment.Center
creditLab.Parent = sg

-- === ANIMATION ===

-- fade in overlay
TS:Create(overlay, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
TS:Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 16}):Play()

-- "M" fades in
TS:Create(mLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

wait(0.8)

-- "OMENTUM" slides up + fades in
TS:Create(oLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0, Position = UDim2.new(0, 100, 0, 0)}):Play()

-- accent line expands
TS:Create(accentLine, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.3), {Size = UDim2.new(0, 300, 0, 2), BackgroundTransparency = 0}):Play()

-- credit fades in
TS:Create(creditLab, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.4), {TextTransparency = 0.3}):Play()

wait(2.2)

-- === FADE OUT ===
TS:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0}):Play()
TS:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
TS:Create(mLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
TS:Create(oLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
TS:Create(accentLine, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
TS:Create(creditLab, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()

wait(0.6)
for _, b in ipairs(game:GetService("Lighting"):GetChildren()) do
    if b:IsA("BlurEffect") then b:Destroy() end
end
sg:Destroy()
wait(0.3)

-- MENU
local ACCENT = Color3.fromRGB(100, 70, 255)
local ACCENT_DIM = Color3.fromRGB(65, 45, 160)
local ACCENT_GLOW = Color3.fromRGB(130, 100, 255)
local BG_DARK = Color3.fromRGB(12, 12, 22)
local BG_MID = Color3.fromRGB(18, 18, 32)
local BG_LIGHT = Color3.fromRGB(28, 28, 48)
local BG_HOVER = Color3.fromRGB(38, 38, 60)
local TXT = Color3.fromRGB(200, 200, 220)
local TXT_DIM = Color3.fromRGB(110, 110, 140)
local TXT_BRIGHT = Color3.fromRGB(255, 255, 255)
local DANGER = Color3.fromRGB(180, 50, 60)
local DANGER_HVR = Color3.fromRGB(220, 65, 75)

local function addCorner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end

local function addStroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or ACCENT_DIM
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.6
    s.Parent = parent
    return s
end

local function tweenProp(obj, props, dur)
    TS:Create(obj, TweenInfo.new(dur or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local oldGui = parent:FindFirstChild("Momentum")
if oldGui then oldGui:Destroy() end
local gui = Instance.new("ScreenGui")
gui.Name = "Momentum"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Parent = parent

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 520, 0, 370)
f.Position = UDim2.new(0.5, -260, 0.5, -185)
f.BackgroundColor3 = BG_DARK
f.BorderSizePixel = 0
f.Active = true
f.Parent = gui
addCorner(f, 10)
addStroke(f, ACCENT_DIM, 1, 0.7)

-- open animation
f.Size = UDim2.new(0, 0, 0, 0)
f.Position = UDim2.new(0.5, 0, 0.5, 0)
f.BackgroundTransparency = 1
tweenProp(f, {Size = UDim2.new(0, 520, 0, 370), Position = UDim2.new(0.5, -260, 0.5, -185), BackgroundTransparency = 0}, 0.35)

local h = Instance.new("Frame")
h.Size = UDim2.new(1, 0, 0, 44)
h.BackgroundColor3 = BG_MID
h.BorderSizePixel = 0
h.Parent = f
addCorner(h, 10)

local hCover = Instance.new("Frame")
hCover.Size = UDim2.new(1, 0, 0, 12)
hCover.Position = UDim2.new(0, 0, 1, -12)
hCover.BackgroundColor3 = BG_MID
hCover.BorderSizePixel = 0
hCover.Parent = h

local l = Instance.new("TextLabel")
l.Size = UDim2.new(1, 0, 1, 0)
l.BackgroundTransparency = 1
l.Text = "M O M E N T U M"
l.Font = Enum.Font.GothamBold
l.TextSize = 16
l.TextColor3 = ACCENT
l.TextXAlignment = Enum.TextXAlignment.Center
l.TextYAlignment = Enum.TextYAlignment.Center
l.Parent = h

local ln = Instance.new("Frame")
ln.Size = UDim2.new(1, 0, 0, 2)
ln.Position = UDim2.new(0, 0, 1, 0)
ln.BorderSizePixel = 0
ln.BackgroundColor3 = Color3.new(1, 1, 1)
ln.Parent = h
local lnGrad = Instance.new("UIGradient")
lnGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, BG_MID),
    ColorSequenceKeypoint.new(0.3, ACCENT_DIM),
    ColorSequenceKeypoint.new(0.5, ACCENT_GLOW),
    ColorSequenceKeypoint.new(0.7, ACCENT_DIM),
    ColorSequenceKeypoint.new(1, BG_MID),
})
lnGrad.Parent = ln

local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(0, 72, 0, 26)
destroyBtn.Position = UDim2.new(1, -85, 0, 9)
destroyBtn.BackgroundColor3 = DANGER
destroyBtn.BorderSizePixel = 0
destroyBtn.Text = "UNLOAD"
destroyBtn.Font = Enum.Font.GothamBold
destroyBtn.TextSize = 11
destroyBtn.TextColor3 = TXT_BRIGHT
destroyBtn.Parent = h
addCorner(destroyBtn, 5)

destroyBtn.MouseEnter:Connect(function()
    tweenProp(destroyBtn, {BackgroundColor3 = DANGER_HVR, TextColor3 = Color3.new(1,1,1)}, 0.15)
end)
destroyBtn.MouseLeave:Connect(function()
    tweenProp(destroyBtn, {BackgroundColor3 = DANGER}, 0.15)
end)

local function destroyScript()
    scriptDestroyed = true

    for _, c in ipairs(allConns) do
        pcall(function() c:Disconnect() end)
    end
    allConns = {}

    if conn then pcall(function() conn:Disconnect() end) end

    if gui and gui.Parent then gui:Destroy() end
    if espGui and espGui.Parent then espGui:Destroy() end

    for _, b in ipairs(game:GetService("Lighting"):GetChildren()) do
        if b:IsA("BlurEffect") then b:Destroy() end
    end

    if chamsHighlights then
        for _, ch in pairs(chamsHighlights) do
            if ch and ch.Parent then ch:Destroy() end
        end
        chamsHighlights = {}
    end

    detachFromWall()

    local char = plr.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end

    pcall(function()
        resetShader()
        local lg = game:GetService("Lighting")
        lg.Ambient = Color3.new(0, 0, 0)
        lg.ClockTime = 14
        lg.Brightness = 1
        lg.GlobalShadows = true
        lg.OutdoorAmbient = Color3.new(0.4, 0.4, 0.4)
        lg.ExposureCompensation = 0
    end)

    _G.__momentumDefaults = nil
end

destroyBtn.MouseButton1Click:Connect(destroyScript)

local bd = Instance.new("Frame")
bd.Size = UDim2.new(1, 0, 1, -44)
bd.Position = UDim2.new(0, 0, 0, 44)
bd.BackgroundColor3 = BG_DARK
bd.BorderSizePixel = 0
bd.Parent = f

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 32)
tabBar.Position = UDim2.new(0, 0, 0, 0)
tabBar.BackgroundColor3 = BG_MID
tabBar.BorderSizePixel = 0
tabBar.Parent = bd
addCorner(tabBar, 8)

local tabCover = Instance.new("Frame")
tabCover.Size = UDim2.new(1, 0, 0, 8)
tabCover.Position = UDim2.new(0, 0, 1, -8)
tabCover.BackgroundColor3 = BG_MID
tabCover.BorderSizePixel = 0
tabCover.Parent = tabBar

local mainTab = Instance.new("Frame")
mainTab.Size = UDim2.new(1, -16, 1, -38)
mainTab.Position = UDim2.new(0, 8, 0, 35)
mainTab.BackgroundTransparency = 1
mainTab.BorderSizePixel = 0
mainTab.Parent = bd

local worldTab = Instance.new("Frame")
worldTab.Size = UDim2.new(1, -16, 1, -38)
worldTab.Position = UDim2.new(0, 8, 0, 35)
worldTab.BackgroundTransparency = 1
worldTab.BorderSizePixel = 0
worldTab.Parent = bd
worldTab.Visible = false

local visualTab = Instance.new("Frame")
visualTab.Size = UDim2.new(1, -16, 1, -38)
visualTab.Position = UDim2.new(0, 8, 0, 35)
visualTab.BackgroundTransparency = 1
visualTab.BorderSizePixel = 0
visualTab.Parent = bd
visualTab.Visible = false

local function hideAllTabs()
    mainTab.Visible = false
    worldTab.Visible = false
    visualTab.Visible = false
end

local function setActiveTab(btn)
    mainTabBtn.BackgroundColor3 = BG_LIGHT
    worldTabBtn.BackgroundColor3 = BG_LIGHT
    visualTabBtn.BackgroundColor3 = BG_LIGHT
    mainTabBtn.TextColor3 = TXT_DIM
    worldTabBtn.TextColor3 = TXT_DIM
    visualTabBtn.TextColor3 = TXT_DIM
    tweenProp(btn, {BackgroundColor3 = ACCENT, TextColor3 = TXT_BRIGHT}, 0.2)
end

local tabBtnStyle = {Font = Enum.Font.GothamBold, TextSize = 13, BorderSizePixel = 0}

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Size = UDim2.new(0, 80, 0, 24)
mainTabBtn.Position = UDim2.new(0, 8, 0, 4)
mainTabBtn.BackgroundColor3 = ACCENT
mainTabBtn.Text = "Main"
mainTabBtn.TextColor3 = TXT_BRIGHT
mainTabBtn.Parent = tabBar
for k, v in pairs(tabBtnStyle) do mainTabBtn[k] = v end
addCorner(mainTabBtn, 5)

local worldTabBtn = Instance.new("TextButton")
worldTabBtn.Size = UDim2.new(0, 80, 0, 24)
worldTabBtn.Position = UDim2.new(0, 94, 0, 4)
worldTabBtn.BackgroundColor3 = BG_LIGHT
worldTabBtn.Text = "World"
worldTabBtn.TextColor3 = TXT_DIM
worldTabBtn.Parent = tabBar
for k, v in pairs(tabBtnStyle) do worldTabBtn[k] = v end
addCorner(worldTabBtn, 5)

local visualTabBtn = Instance.new("TextButton")
visualTabBtn.Size = UDim2.new(0, 80, 0, 24)
visualTabBtn.Position = UDim2.new(0, 180, 0, 4)
visualTabBtn.BackgroundColor3 = BG_LIGHT
visualTabBtn.Text = "Visual"
visualTabBtn.TextColor3 = TXT_DIM
visualTabBtn.Parent = tabBar
for k, v in pairs(tabBtnStyle) do visualTabBtn[k] = v end
addCorner(visualTabBtn, 5)

for _, btn in ipairs({mainTabBtn, worldTabBtn, visualTabBtn}) do
    btn.MouseEnter:Connect(function()
        if btn.TextColor3 ~= TXT_BRIGHT then
            tweenProp(btn, {BackgroundColor3 = BG_HOVER}, 0.15)
        end
    end)
    btn.MouseLeave:Connect(function()
        if btn.TextColor3 ~= TXT_BRIGHT then
            tweenProp(btn, {BackgroundColor3 = BG_LIGHT}, 0.15)
        end
    end)
end

mainTabBtn.MouseButton1Click:Connect(function()
    hideAllTabs()
    mainTab.Visible = true
    setActiveTab(mainTabBtn)
end)

worldTabBtn.MouseButton1Click:Connect(function()
    hideAllTabs()
    worldTab.Visible = true
    setActiveTab(worldTabBtn)
end)

visualTabBtn.MouseButton1Click:Connect(function()
    hideAllTabs()
    visualTab.Visible = true
    setActiveTab(visualTabBtn)
end)

-- resize
local gr = Instance.new("Frame")
gr.Size = UDim2.new(0, 14, 0, 14)
gr.Position = UDim2.new(1, -14, 1, -14)
gr.BackgroundColor3 = ACCENT_DIM
gr.BorderSizePixel = 0
gr.Parent = f
addCorner(gr, 3)

gr.MouseEnter:Connect(function()
    tweenProp(gr, {BackgroundColor3 = ACCENT}, 0.15)
end)
gr.MouseLeave:Connect(function()
    tweenProp(gr, {BackgroundColor3 = ACCENT_DIM}, 0.15)
end)

local resizing, rStart, rSize = false
gr.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        rStart = inp.Position
        rSize = f.Size
    end
end)
gr.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end
end)
UIS.InputChanged:Connect(function(inp)
    if resizing and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local d = inp.Position - rStart
        f.Size = UDim2.new(0, math.max(200, rSize.X.Offset + d.X), 0, math.max(100, rSize.Y.Offset + d.Y))
    end
end)

-- WALLHOP
local autoWall = false
local canJump = true
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Excluded

function findWall()
    local char = plr.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    params.FilterDescendantsInstances = {char}
    for i = 0, 7 do
        local dir = (hrp.CFrame * CFrame.Angles(0, math.rad(i * 45), 0)).LookVector
        local ray = workspace:Raycast(hrp.Position, dir * 2, params)
        if ray then return ray end
    end
    local ok, block = pcall(function()
        return workspace:Blockcast(hrp.CFrame * CFrame.new(0, -1, -0.5), Vector3.new(1.5, 1, 0.5), hrp.CFrame.LookVector * 1.5, params)
    end)
    if ok and block then return block end
    return nil
end

function doWallhop(wall)
    if not canJump then return end
    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    if hum:GetState() == Enum.HumanoidStateType.Dead then return end
    canJump = false

    local away = Vector3.new(wall.Normal.X, 0, wall.Normal.Z).Unit
    if away.Magnitude < 0.1 then away = Vector3.new(0, 0, 1) end

    hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + away)
    wait()
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, -1, 0)
    wait(0.15)
    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 1, 0)
    wait(0.05)
    hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position - away)
    wait(0.1)
    canJump = true
end

task.spawn(function()
    while wait() do
        if scriptDestroyed then break end
        if autoWall then
            local w = findWall()
            if w then doWallhop(w) end
        end
    end
end)

-- WALLHOP CHECKBOX
local whCheck = Instance.new("Frame")
whCheck.Size = UDim2.new(0, 16, 0, 16)
whCheck.Position = UDim2.new(0, 15, 0, 15)
whCheck.BackgroundColor3 = BG_LIGHT
whCheck.BorderSizePixel = 0
whCheck.Parent = mainTab
addCorner(whCheck, 3)

local whFill = Instance.new("Frame")
whFill.Size = UDim2.new(1, -4, 1, -4)
whFill.Position = UDim2.new(0, 2, 0, 2)
whFill.BackgroundColor3 = BG_HOVER
whFill.BorderSizePixel = 0
whFill.Parent = whCheck

local whLab = Instance.new("TextLabel")
whLab.Size = UDim2.new(0, 140, 0, 16)
whLab.Position = UDim2.new(0, 22, 0, 0)
whLab.BackgroundTransparency = 1
whLab.Text = "auto wallhop"
whLab.Font = Enum.Font.GothamBold
whLab.TextSize = 14
whLab.TextColor3 = TXT_DIM
whLab.TextXAlignment = Enum.TextXAlignment.Left
whLab.Parent = whCheck

local whBtn = Instance.new("TextButton")
whBtn.Size = UDim2.new(0, 16, 0, 16)
whBtn.BackgroundTransparency = 1
whBtn.Text = ""
whBtn.Parent = whCheck

local whBindBtn = Instance.new("TextButton")
whBindBtn.Size = UDim2.new(0, 40, 0, 16)
whBindBtn.Position = UDim2.new(0, 170, 0, 15)
whBindBtn.BackgroundColor3 = BG_LIGHT
whBindBtn.BorderSizePixel = 0
whBindBtn.Text = "bind"
whBindBtn.Font = Enum.Font.GothamBold
whBindBtn.TextSize = 12
whBindBtn.TextColor3 = TXT_DIM
whBindBtn.Parent = mainTab
addCorner(whBindBtn, 4)

local wallhopBind = {}
local whBindListener = nil

local function startWhBind()
    if whBindListener then whBindListener:Disconnect() end
    whLab.Text = "press key..."
    whBindListener = UIS.InputBegan:Connect(function(i)
        whBindListener:Disconnect()
        whBindListener = nil
        local ok = pcall(function()
            local itv = getTypeValue(i)
            if itv == KEYBD then
                wallhopBind = {type = "keyboard", key = i.KeyCode}
                whLab.Text = "auto wallhop [" .. i.KeyCode.Name .. "]"
            else
                wallhopBind = {type = "other", inputTypeValue = itv}
                local name = tostring(i.UserInputType):match("%w+$") or tostring(itv)
                whLab.Text = "auto wallhop [" .. name .. "]"
            end
        end)
        if not ok then
            wallhopBind = {}
            whLab.Text = "auto wallhop [bound]"
        end
    end)
end

whBtn.MouseButton1Click:Connect(function()
    autoWall = not autoWall
    whFill.BackgroundColor3 = autoWall and ACCENT or BG_HOVER
end)

whBindBtn.MouseButton1Click:Connect(function()
    startWhBind()
end)

-- drag
local dragging, dStart, dPos = false
h.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dStart = inp.Position
        dPos = f.Position
    end
end)
h.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(inp)
    if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local d = inp.Position - dStart
        f.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y)
    end
end)

-- WALKSPEED
local wsEnabled = false
local wsValue = 16

local wsCheck = Instance.new("Frame")
wsCheck.Size = UDim2.new(0, 16, 0, 16)
wsCheck.Position = UDim2.new(0, 15, 0, 105)
wsCheck.BackgroundColor3 = BG_LIGHT
wsCheck.BorderSizePixel = 0
wsCheck.Parent = mainTab
addCorner(wsCheck, 3)

local wsFill = Instance.new("Frame")
wsFill.Size = UDim2.new(1, -4, 1, -4)
wsFill.Position = UDim2.new(0, 2, 0, 2)
wsFill.BackgroundColor3 = BG_HOVER
wsFill.BorderSizePixel = 0
wsFill.Parent = wsCheck

local wsLab = Instance.new("TextLabel")
wsLab.Size = UDim2.new(0, 140, 0, 16)
wsLab.Position = UDim2.new(0, 22, 0, 0)
wsLab.BackgroundTransparency = 1
wsLab.Text = "walkspeed"
wsLab.Font = Enum.Font.GothamBold
wsLab.TextSize = 14
wsLab.TextColor3 = TXT_DIM
wsLab.TextXAlignment = Enum.TextXAlignment.Left
wsLab.Parent = wsCheck

local wsBtn = Instance.new("TextButton")
wsBtn.Size = UDim2.new(1, 0, 1, 0)
wsBtn.BackgroundTransparency = 1
wsBtn.Text = ""
wsBtn.Parent = wsCheck

local wsInput = Instance.new("TextBox")
wsInput.Size = UDim2.new(0, 40, 0, 16)
wsInput.Position = UDim2.new(0, 170, 0, 105)
wsInput.BackgroundColor3 = BG_LIGHT
wsInput.BorderSizePixel = 0
wsInput.Text = "16"
wsInput.Font = Enum.Font.GothamBold
wsInput.TextSize = 12
wsInput.TextColor3 = TXT_DIM
wsInput.ClearTextOnFocus = false
wsInput.Parent = mainTab
addCorner(wsInput, 4)

local wsBindBtn = Instance.new("TextButton")
wsBindBtn.Size = UDim2.new(0, 40, 0, 16)
wsBindBtn.Position = UDim2.new(0, 215, 0, 105)
wsBindBtn.BackgroundColor3 = BG_LIGHT
wsBindBtn.BorderSizePixel = 0
wsBindBtn.Text = "bind"
wsBindBtn.Font = Enum.Font.GothamBold
wsBindBtn.TextSize = 12
wsBindBtn.TextColor3 = TXT_DIM
wsBindBtn.Parent = mainTab
addCorner(wsBindBtn, 4)

local wsBind = {}
local wsBindListener = nil

local function startWsBind()
    if wsBindListener then wsBindListener:Disconnect() end
    wsLab.Text = "press key..."
    wsBindListener = UIS.InputBegan:Connect(function(i)
        wsBindListener:Disconnect()
        wsBindListener = nil
        local ok = pcall(function()
            local itv = getTypeValue(i)
            if itv == KEYBD then
                wsBind = {type = "keyboard", key = i.KeyCode}
                wsLab.Text = "walkspeed [" .. i.KeyCode.Name .. "]"
            else
                wsBind = {type = "other", inputTypeValue = itv}
                local name = tostring(i.UserInputType):match("%w+$") or tostring(itv)
                wsLab.Text = "walkspeed [" .. name .. "]"
            end
        end)
        if not ok then
            wsBind = {}
            wsLab.Text = "walkspeed [bound]"
        end
    end)
end

wsBtn.MouseButton1Click:Connect(function()
    wsEnabled = not wsEnabled
    wsFill.BackgroundColor3 = wsEnabled and ACCENT or BG_HOVER
end)

wsInput.FocusLost:Connect(function()
    local n = tonumber(wsInput.Text)
    if n then
        n = math.clamp(math.floor(n), 0, 100)
        wsValue = n
        wsInput.Text = tostring(n)
    else
        wsInput.Text = tostring(wsValue)
    end
end)

wsBindBtn.MouseButton1Click:Connect(function()
    startWsBind()
end)

-- BHOP
local RS = game:GetService("RunService")
local bhopEnabled = false
local bhopSlider = 5
local BHOP_BASE_SPEED = 16
local spaceHeld = false

local bhCheck = Instance.new("Frame")
bhCheck.Size = UDim2.new(0, 16, 0, 16)
bhCheck.Position = UDim2.new(0, 15, 0, 135)
bhCheck.BackgroundColor3 = BG_LIGHT
bhCheck.BorderSizePixel = 0
bhCheck.Parent = mainTab
addCorner(bhCheck, 3)

local bhFill = Instance.new("Frame")
bhFill.Size = UDim2.new(1, -4, 1, -4)
bhFill.Position = UDim2.new(0, 2, 0, 2)
bhFill.BackgroundColor3 = BG_HOVER
bhFill.BorderSizePixel = 0
bhFill.Parent = bhCheck

local bhLab = Instance.new("TextLabel")
bhLab.Size = UDim2.new(0, 140, 0, 16)
bhLab.Position = UDim2.new(0, 22, 0, 0)
bhLab.BackgroundTransparency = 1
bhLab.Text = "bhop"
bhLab.Font = Enum.Font.GothamBold
bhLab.TextSize = 14
bhLab.TextColor3 = TXT_DIM
bhLab.TextXAlignment = Enum.TextXAlignment.Left
bhLab.Parent = bhCheck

local bhBtn = Instance.new("TextButton")
bhBtn.Size = UDim2.new(1, 0, 1, 0)
bhBtn.BackgroundTransparency = 1
bhBtn.Text = ""
bhBtn.Parent = bhCheck

local bhTrack = Instance.new("Frame")
bhTrack.Size = UDim2.new(0, 80, 0, 4)
bhTrack.Position = UDim2.new(0, 170, 0, 142)
bhTrack.BackgroundColor3 = BG_LIGHT
bhTrack.BorderSizePixel = 0
bhTrack.Parent = mainTab
addCorner(bhTrack, 2)

local bhTrackFill = Instance.new("Frame")
bhTrackFill.Size = UDim2.new(0.5, 0, 1, 0)
bhTrackFill.BackgroundColor3 = ACCENT
bhTrackFill.BorderSizePixel = 0
bhTrackFill.Parent = bhTrack

local bhHandle = Instance.new("Frame")
bhHandle.Size = UDim2.new(0, 10, 0, 10)
bhHandle.Position = UDim2.new(0.5, -5, 0.5, -5)
bhHandle.BackgroundColor3 = TXT_BRIGHT
bhHandle.BorderSizePixel = 0
bhHandle.Parent = bhTrackFill
addCorner(bhHandle, 5)

local bhValLab = Instance.new("TextLabel")
bhValLab.Size = UDim2.new(0, 20, 0, 16)
bhValLab.Position = UDim2.new(0, 255, 0, 135)
bhValLab.BackgroundTransparency = 1
bhValLab.Text = "5"
bhValLab.Font = Enum.Font.GothamBold
bhValLab.TextSize = 12
bhValLab.TextColor3 = TXT_DIM
bhValLab.TextXAlignment = Enum.TextXAlignment.Left
bhValLab.Parent = mainTab

local bhDragging = false
bhHandle.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then bhDragging = true end
end)
bhHandle.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then bhDragging = false end
end)
UIS.InputChanged:Connect(function(inp)
    if bhDragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local rel = inp.Position.X - bhTrack.AbsolutePosition.X
        local pct = math.clamp(rel / bhTrack.AbsoluteSize.X, 0, 1)
        bhopSlider = math.round(pct * 10)
        bhTrackFill.Size = UDim2.new(pct, 0, 1, 0)
        bhValLab.Text = tostring(bhopSlider)
    end
end)

bhBtn.MouseButton1Click:Connect(function()
    bhopEnabled = not bhopEnabled
    bhFill.BackgroundColor3 = bhopEnabled and ACCENT or BG_HOVER
end)

UIS.InputBegan:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.Space then spaceHeld = true end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.KeyCode == Enum.KeyCode.Space then spaceHeld = false end
end)

task.spawn(function()
    RS.RenderStepped:Connect(function()
        if scriptDestroyed then return end
        local char = plr.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        if bhopEnabled and spaceHeld and hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = 16
            local dir = hum.MoveDirection.Unit
            local boost = bhopSlider * 8
            local vel = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = Vector3.new(dir.X * boost, vel.Y, dir.Z * boost)
        elseif not speedGlitchEnabled then
            hum.WalkSpeed = wsEnabled and wsValue or BHOP_BASE_SPEED
        end
    end)
end)

-- PIXELSERF (fixed bhop, multiplier 3, no slider)
local pxEnabled = false

local pxCheck = Instance.new("Frame")
pxCheck.Size = UDim2.new(0, 16, 0, 16)
pxCheck.Position = UDim2.new(0, 15, 0, 225)
pxCheck.BackgroundColor3 = BG_LIGHT
pxCheck.BorderSizePixel = 0
pxCheck.Parent = mainTab
addCorner(pxCheck, 3)

local pxFill = Instance.new("Frame")
pxFill.Size = UDim2.new(1, -4, 1, -4)
pxFill.Position = UDim2.new(0, 2, 0, 2)
pxFill.BackgroundColor3 = BG_HOVER
pxFill.BorderSizePixel = 0
pxFill.Parent = pxCheck

local pxLab = Instance.new("TextLabel")
pxLab.Size = UDim2.new(0, 140, 0, 16)
pxLab.Position = UDim2.new(0, 22, 0, 0)
pxLab.BackgroundTransparency = 1
pxLab.Text = "pixelserf"
pxLab.Font = Enum.Font.GothamBold
pxLab.TextSize = 14
pxLab.TextColor3 = TXT_DIM
pxLab.TextXAlignment = Enum.TextXAlignment.Left
pxLab.Parent = pxCheck

local pxBtn = Instance.new("TextButton")
pxBtn.Size = UDim2.new(1, 0, 1, 0)
pxBtn.BackgroundTransparency = 1
pxBtn.Text = ""
pxBtn.Parent = pxCheck

pxBtn.MouseButton1Click:Connect(function()
    pxEnabled = not pxEnabled
    pxFill.BackgroundColor3 = pxEnabled and ACCENT or BG_HOVER
end)

task.spawn(function()
    RS.RenderStepped:Connect(function()
        if scriptDestroyed then return end
        local char = plr.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        if pxEnabled and spaceHeld and hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = 16
            local dir = hum.MoveDirection.Unit
            local vel = hrp.AssemblyLinearVelocity
            hrp.AssemblyLinearVelocity = Vector3.new(dir.X * 24, vel.Y, dir.Z * 24)
        end
    end)
end)

-- SPEEDGLITCH
local speedGlitchEnabled = false
local DEFAULT_WALKSPEED = 16
local BASE_GLITCH_SPEED = 200
local conn

local function setupSG(char)
    local hum = char:WaitForChild("Humanoid")
    if conn then conn:Disconnect() end

    conn = RS.RenderStepped:Connect(function()
        if scriptDestroyed then return end
        if bhopEnabled and spaceHeld and hum.MoveDirection.Magnitude > 0 then return end

        if not speedGlitchEnabled then
            hum.WalkSpeed = wsEnabled and wsValue or DEFAULT_WALKSPEED
            return
        end

        local state = hum:GetState()
        local inAir = state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall

        if inAir and hum.MoveDirection.Magnitude > 0 then
            hum.WalkSpeed = BASE_GLITCH_SPEED
        else
            hum.WalkSpeed = wsEnabled and wsValue or DEFAULT_WALKSPEED
        end
    end)
end

plr.CharacterAdded:Connect(setupSG)
if plr.Character then setupSG(plr.Character) end

-- SPEEDGLITCH CHECKBOX
local sgCheck = Instance.new("Frame")
sgCheck.Size = UDim2.new(0, 16, 0, 16)
sgCheck.Position = UDim2.new(0, 15, 0, 45)
sgCheck.BackgroundColor3 = BG_LIGHT
sgCheck.BorderSizePixel = 0
sgCheck.Parent = mainTab
addCorner(sgCheck, 3)

local sgFill = Instance.new("Frame")
sgFill.Size = UDim2.new(1, -4, 1, -4)
sgFill.Position = UDim2.new(0, 2, 0, 2)
sgFill.BackgroundColor3 = BG_HOVER
sgFill.BorderSizePixel = 0
sgFill.Parent = sgCheck

local sgLab = Instance.new("TextLabel")
sgLab.Size = UDim2.new(0, 140, 0, 16)
sgLab.Position = UDim2.new(0, 22, 0, 0)
sgLab.BackgroundTransparency = 1
sgLab.Text = "speedglitch"
sgLab.Font = Enum.Font.GothamBold
sgLab.TextSize = 14
sgLab.TextColor3 = TXT_DIM
sgLab.TextXAlignment = Enum.TextXAlignment.Left
sgLab.Parent = sgCheck

local sgBtn = Instance.new("TextButton")
sgBtn.Size = UDim2.new(1, 0, 1, 0)
sgBtn.BackgroundTransparency = 1
sgBtn.Text = ""
sgBtn.Parent = sgCheck

sgBtn.MouseButton1Click:Connect(function()
    speedGlitchEnabled = not speedGlitchEnabled
    sgFill.BackgroundColor3 = speedGlitchEnabled and ACCENT or BG_HOVER
end)

-- JUMPBUG
local jumpbugEnabled = false
local DEFAULT_JUMP = 50

local function setupJB(char)
    local hum = char:WaitForChild("Humanoid")
    hum.JumpPower = DEFAULT_JUMP
end

plr.CharacterAdded:Connect(setupJB)
if plr.Character then setupJB(plr.Character) end

RS.RenderStepped:Connect(function()
    if scriptDestroyed then return end
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if jumpbugEnabled then
        hum.JumpPower = DEFAULT_JUMP * 1.2
    else
        hum.JumpPower = DEFAULT_JUMP
    end
end)

-- JUMPBUG CHECKBOX
local jbCheck = Instance.new("Frame")
jbCheck.Size = UDim2.new(0, 16, 0, 16)
jbCheck.Position = UDim2.new(0, 15, 0, 75)
jbCheck.BackgroundColor3 = BG_LIGHT
jbCheck.BorderSizePixel = 0
jbCheck.Parent = mainTab
addCorner(jbCheck, 3)

local jbFill = Instance.new("Frame")
jbFill.Size = UDim2.new(1, -4, 1, -4)
jbFill.Position = UDim2.new(0, 2, 0, 2)
jbFill.BackgroundColor3 = BG_HOVER
jbFill.BorderSizePixel = 0
jbFill.Parent = jbCheck

local jbLab = Instance.new("TextLabel")
jbLab.Size = UDim2.new(0, 140, 0, 16)
jbLab.Position = UDim2.new(0, 22, 0, 0)
jbLab.BackgroundTransparency = 1
jbLab.Text = "jumpbug (+20%)"
jbLab.Font = Enum.Font.GothamBold
jbLab.TextSize = 14
jbLab.TextColor3 = TXT_DIM
jbLab.TextXAlignment = Enum.TextXAlignment.Left
jbLab.Parent = jbCheck

local jbBtn = Instance.new("TextButton")
jbBtn.Size = UDim2.new(0, 16, 0, 16)
jbBtn.BackgroundTransparency = 1
jbBtn.Text = ""
jbBtn.Parent = jbCheck

local jbBindBtn = Instance.new("TextButton")
jbBindBtn.Size = UDim2.new(0, 40, 0, 16)
jbBindBtn.Position = UDim2.new(0, 170, 0, 75)
jbBindBtn.BackgroundColor3 = BG_LIGHT
jbBindBtn.BorderSizePixel = 0
jbBindBtn.Text = "bind"
jbBindBtn.Font = Enum.Font.GothamBold
jbBindBtn.TextSize = 12
jbBindBtn.TextColor3 = TXT_DIM
jbBindBtn.Parent = mainTab
addCorner(jbBindBtn, 4)

local jumpbugBind = {}
local jbBindListener = nil

local function startJbBind()
    if jbBindListener then jbBindListener:Disconnect() end
    jbLab.Text = "press key..."
    jbBindListener = UIS.InputBegan:Connect(function(i)
        jbBindListener:Disconnect()
        jbBindListener = nil
        local ok = pcall(function()
            local itv = getTypeValue(i)
            if itv == KEYBD then
                jumpbugBind = {type = "keyboard", key = i.KeyCode}
                jbLab.Text = "jumpbug (+20%) [" .. i.KeyCode.Name .. "]"
            else
                jumpbugBind = {type = "other", inputTypeValue = itv}
                local name = tostring(i.UserInputType):match("%w+$") or tostring(itv)
                jbLab.Text = "jumpbug (+20%) [" .. name .. "]"
            end
        end)
        if not ok then
            jumpbugBind = {}
            jbLab.Text = "jumpbug (+20%) [bound]"
        end
    end)
end

jbBtn.MouseButton1Click:Connect(function()
    jumpbugEnabled = not jumpbugEnabled
    jbFill.BackgroundColor3 = jumpbugEnabled and ACCENT or BG_HOVER
end)

jbBindBtn.MouseButton1Click:Connect(function()
    startJbBind()
end)

-- SPIN
local spinEnabled = false
local spinSpeed = 80

RS.RenderStepped:Connect(function()
    if scriptDestroyed then return end
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if spinEnabled then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
    end
end)

local spinCheck = Instance.new("Frame")
spinCheck.Size = UDim2.new(0, 16, 0, 16)
spinCheck.Position = UDim2.new(0, 15, 0, 165)
spinCheck.BackgroundColor3 = BG_LIGHT
spinCheck.BorderSizePixel = 0
spinCheck.Parent = mainTab
addCorner(spinCheck, 3)

local spinFill = Instance.new("Frame")
spinFill.Size = UDim2.new(1, -4, 1, -4)
spinFill.Position = UDim2.new(0, 2, 0, 2)
spinFill.BackgroundColor3 = BG_HOVER
spinFill.BorderSizePixel = 0
spinFill.Parent = spinCheck

local spinLab = Instance.new("TextLabel")
spinLab.Size = UDim2.new(0, 140, 0, 16)
spinLab.Position = UDim2.new(0, 22, 0, 0)
spinLab.BackgroundTransparency = 1
spinLab.Text = "spin"
spinLab.Font = Enum.Font.GothamBold
spinLab.TextSize = 14
spinLab.TextColor3 = TXT_DIM
spinLab.TextXAlignment = Enum.TextXAlignment.Left
spinLab.Parent = spinCheck

local spinBtn = Instance.new("TextButton")
spinBtn.Size = UDim2.new(1, 0, 1, 0)
spinBtn.BackgroundTransparency = 1
spinBtn.Text = ""
spinBtn.Parent = spinCheck

spinBtn.MouseButton1Click:Connect(function()
    spinEnabled = not spinEnabled
    spinFill.BackgroundColor3 = spinEnabled and ACCENT or BG_HOVER
end)

local spinBindBtn = Instance.new("TextButton")
spinBindBtn.Size = UDim2.new(0, 40, 0, 16)
spinBindBtn.Position = UDim2.new(0, 170, 0, 165)
spinBindBtn.BackgroundColor3 = BG_LIGHT
spinBindBtn.BorderSizePixel = 0
spinBindBtn.Text = "bind"
spinBindBtn.Font = Enum.Font.GothamBold
spinBindBtn.TextSize = 12
spinBindBtn.TextColor3 = TXT_DIM
spinBindBtn.Parent = mainTab
addCorner(spinBindBtn, 4)

local spinBind = {}
local spinBindListener = nil

local function startSpinBind()
    if spinBindListener then spinBindListener:Disconnect() end
    spinLab.Text = "press key..."
    spinBindListener = UIS.InputBegan:Connect(function(i)
        spinBindListener:Disconnect()
        spinBindListener = nil
        local ok = pcall(function()
            local itv = getTypeValue(i)
            if itv == KEYBD then
                spinBind = {type = "keyboard", key = i.KeyCode}
                spinLab.Text = "spin [" .. i.KeyCode.Name .. "]"
            else
                spinBind = {type = "other", inputTypeValue = itv}
                local name = tostring(i.UserInputType):match("%w+$") or tostring(itv)
                spinLab.Text = "spin [" .. name .. "]"
            end
        end)
        if not ok then
            spinBind = {}
            spinLab.Text = "spin [bound]"
        end
    end)
end

spinBindBtn.MouseButton1Click:Connect(function()
    startSpinBind()
end)

-- WALLBAG
local wallbagEnabled = false
local wallbagActive = false
local wallbagConn = nil
local wallbagChar = nil
local wallbagNormal = nil
local wallbagWallPos = nil

local function clearWallbagMovers()
    if wallbagChar then
        for _, name in ipairs({"WallbagPos", "WallbagGyro", "WallbagVel"}) do
            local m = wallbagChar:FindFirstChild(name)
            if m then m:Destroy() end
        end
    end
end

local function detachFromWall()
    wallbagActive = false
    clearWallbagMovers()
    if wallbagConn then wallbagConn:Disconnect() wallbagConn = nil end
    if wallbagChar then
        local hum = wallbagChar:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    wallbagChar = nil
    wallbagNormal = nil
    wallbagWallPos = nil
end

local function findWallForBag()
    local char = plr.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local p = RaycastParams.new()
    p.FilterType = Enum.RaycastFilterType.Excluded
    p.FilterDescendantsInstances = {char}
    local checks = {
        hrp.CFrame.LookVector * 3,
        hrp.CFrame.RightVector * 3,
        -hrp.CFrame.RightVector * 3,
        -hrp.CFrame.LookVector * 3,
    }
    for _, dir in ipairs(checks) do
        local ray = workspace:Raycast(hrp.Position, dir, p)
        if ray then return ray end
    end
    return nil
end

local function attachToWall(wall)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    detachFromWall()

    wallbagChar = char
    wallbagNormal = wall.Normal
    wallbagWallPos = wall.Position + wall.Normal * 1.5
    local lookAway = -wallbagNormal

    local bg = Instance.new("BodyGyro")
    bg.Name = "WallbagGyro"
    bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    bg.P = 50000
    bg.D = 500
    bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookAway)
    bg.Parent = hrp

    local bp = Instance.new("BodyPosition")
    bp.Name = "WallbagPos"
    bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bp.P = 50000
    bp.D = 1000
    bp.Position = wallbagWallPos + Vector3.new(0, -1, 0)
    bp.Parent = hrp

    local bv = Instance.new("BodyVelocity")
    bv.Name = "WallbagVel"
    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.P = 10000
    bv.Parent = hrp

    hum.PlatformStand = true
    wallbagActive = true

    wallbagConn = RS.RenderStepped:Connect(function()
        if not wallbagActive then
            if wallbagConn then wallbagConn:Disconnect() wallbagConn = nil end
            return
        end
        pcall(function()
            local bg2 = char:FindFirstChild("WallbagGyro")
            local bp2 = char:FindFirstChild("WallbagPos")
            local bv2 = char:FindFirstChild("WallbagVel")
            if bg2 then bg2.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookAway) end
            if bp2 then bp2.Position = wallbagWallPos + Vector3.new(0, -1, 0) end
            if bv2 then bv2.Velocity = Vector3.new(0, 0, 0) end
        end)
    end)
end

local function toggleWallbag()
    if wallbagActive then
        detachFromWall()
    else
        local wall = findWallForBag()
        if wall then attachToWall(wall) end
    end
end

-- WALLBAG CHECKBOX
local wbCheck = Instance.new("Frame")
wbCheck.Size = UDim2.new(0, 16, 0, 16)
wbCheck.Position = UDim2.new(0, 15, 0, 195)
wbCheck.BackgroundColor3 = BG_LIGHT
wbCheck.BorderSizePixel = 0
wbCheck.Parent = mainTab
addCorner(wbCheck, 3)

local wbFill = Instance.new("Frame")
wbFill.Size = UDim2.new(1, -4, 1, -4)
wbFill.Position = UDim2.new(0, 2, 0, 2)
wbFill.BackgroundColor3 = BG_HOVER
wbFill.BorderSizePixel = 0
wbFill.Parent = wbCheck

local wbLab = Instance.new("TextLabel")
wbLab.Size = UDim2.new(0, 140, 0, 16)
wbLab.Position = UDim2.new(0, 22, 0, 0)
wbLab.BackgroundTransparency = 1
wbLab.Text = "wallbag"
wbLab.Font = Enum.Font.GothamBold
wbLab.TextSize = 14
wbLab.TextColor3 = TXT_DIM
wbLab.TextXAlignment = Enum.TextXAlignment.Left
wbLab.Parent = wbCheck

local wbBtn = Instance.new("TextButton")
wbBtn.Size = UDim2.new(1, 0, 1, 0)
wbBtn.BackgroundTransparency = 1
wbBtn.Text = ""
wbBtn.Parent = wbCheck

wbBtn.MouseButton1Click:Connect(function()
    wallbagEnabled = not wallbagEnabled
    wbFill.BackgroundColor3 = wallbagEnabled and ACCENT or BG_HOVER
end)

local wbBindBtn = Instance.new("TextButton")
wbBindBtn.Size = UDim2.new(0, 40, 0, 16)
wbBindBtn.Position = UDim2.new(0, 170, 0, 195)
wbBindBtn.BackgroundColor3 = BG_LIGHT
wbBindBtn.BorderSizePixel = 0
wbBindBtn.Text = "bind"
wbBindBtn.Font = Enum.Font.GothamBold
wbBindBtn.TextSize = 12
wbBindBtn.TextColor3 = TXT_DIM
wbBindBtn.Parent = mainTab
addCorner(wbBindBtn, 4)

local wallbagBind = {}
local wbBindListener = nil

local function startWbBind()
    if wbBindListener then wbBindListener:Disconnect() end
    wbLab.Text = "press key..."
    wbBindListener = UIS.InputBegan:Connect(function(i)
        wbBindListener:Disconnect()
        wbBindListener = nil
        local ok = pcall(function()
            local itv = getTypeValue(i)
            if itv == KEYBD then
                wallbagBind = {type = "keyboard", key = i.KeyCode}
                wbLab.Text = "wallbag [" .. i.KeyCode.Name .. "]"
            else
                wallbagBind = {type = "other", inputTypeValue = itv}
                local name = tostring(i.UserInputType):match("%w+$") or tostring(itv)
                wbLab.Text = "wallbag [" .. name .. "]"
            end
        end)
        if not ok then
            wallbagBind = {}
            wbLab.Text = "wallbag [bound]"
        end
    end)
end

wbBindBtn.MouseButton1Click:Connect(function()
    startWbBind()
end)

track(UIS.InputBegan:Connect(function(i)
    if scriptDestroyed then return end
    if not wallbagEnabled then return end
    local ok = pcall(function()
        if wallbagBind.type == "keyboard" and i.KeyCode == wallbagBind.key then
            toggleWallbag()
        elseif wallbagBind.type == "other" and i.UserInputType.Value == wallbagBind.inputTypeValue then
            toggleWallbag()
        end
    end)
end))

-- ESP
local espEnabled = false
local boxEspEnabled = false

local espGui = Instance.new("ScreenGui")
espGui.Name = "MomentumESP"
espGui.ResetOnSpawn = false
espGui.IgnoreGuiInset = true
espGui.DisplayOrder = 101
espGui.Parent = parent

local espFolder = Instance.new("Folder")
espFolder.Name = "MomentumESP"
espFolder.Parent = espGui

local espColor = ACCENT

local function createBoxEsp(player)
    local box = Instance.new("Frame")
    box.Name = "ESP_" .. player.Name
    box.BorderSizePixel = 0
    box.BackgroundTransparency = 0.5
    box.BackgroundColor3 = espColor
    box.Parent = espFolder

    local outline = Instance.new("UIStroke")
    outline.Color = espColor
    outline.Thickness = 1.5
    outline.Parent = box

    local nameTag = Instance.new("TextLabel")
    nameTag.Size = UDim2.new(1, 0, 0, 14)
    nameTag.Position = UDim2.new(0, 0, 1, 2)
    nameTag.BackgroundTransparency = 1
    nameTag.Text = player.Name
    nameTag.Font = Enum.Font.GothamBold
    nameTag.TextSize = 12
    nameTag.TextColor3 = espColor
    nameTag.TextStrokeTransparency = 0.5
    nameTag.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameTag.Parent = box

    return box, outline, nameTag
end

local function updateEsp()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local cam = workspace.CurrentCamera
                local pos, onScreen = cam:WorldToScreenPoint(hrp.Position)
                if onScreen then
                    local scaleFactor = 1 / (pos.Z * 0.04)
                    local width = 30 * scaleFactor
                    local height = 40 * scaleFactor

                    local box, outline, nameTag
                    local existing = espFolder:FindFirstChild("ESP_" .. p.Name)
                    if existing then
                        box = existing
                        outline = existing:FindFirstChildOfClass("UIStroke")
                        nameTag = existing:FindFirstChildOfClass("TextLabel")
                    else
                        box, outline, nameTag = createBoxEsp(p)
                    end

                    if boxEspEnabled then
                        box.Visible = true
                        box.Size = UDim2.new(0, width, 0, height)
                        box.Position = UDim2.new(0, pos.X - width / 2, 0, pos.Y - height / 2)
                        outline.Color = espColor
                        nameTag.TextColor3 = espColor
                    else
                        box.Visible = false
                    end
                else
                    local existing = espFolder:FindFirstChild("ESP_" .. p.Name)
                    if existing then existing.Visible = false end
                end
            else
                local existing = espFolder:FindFirstChild("ESP_" .. p.Name)
                if existing then existing:Destroy() end
            end
        else
            local existing = espFolder:FindFirstChild("ESP_" .. p.Name)
            if existing then existing:Destroy() end
        end
    end
end

RS.RenderStepped:Connect(function()
    if scriptDestroyed then return end
    if espEnabled then
        updateEsp()
    else
        for _, v in pairs(espFolder:GetChildren()) do
            v:Destroy()
        end
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(p)
    local existing = espFolder:FindFirstChild("ESP_" .. p.Name)
    if existing then existing:Destroy() end
end)

-- ESP CHECKBOX
local espCheck = Instance.new("Frame")
espCheck.Size = UDim2.new(0, 16, 0, 16)
espCheck.Position = UDim2.new(0, 15, 0, 15)
espCheck.BackgroundColor3 = BG_LIGHT
espCheck.BorderSizePixel = 0
espCheck.Parent = visualTab
addCorner(espCheck, 3)

local espFill = Instance.new("Frame")
espFill.Size = UDim2.new(1, -4, 1, -4)
espFill.Position = UDim2.new(0, 2, 0, 2)
espFill.BackgroundColor3 = BG_HOVER
espFill.BorderSizePixel = 0
espFill.Parent = espCheck

local espLab = Instance.new("TextLabel")
espLab.Size = UDim2.new(0, 140, 0, 16)
espLab.Position = UDim2.new(0, 22, 0, 0)
espLab.BackgroundTransparency = 1
espLab.Text = "enabled esp"
espLab.Font = Enum.Font.GothamBold
espLab.TextSize = 14
espLab.TextColor3 = TXT_DIM
espLab.TextXAlignment = Enum.TextXAlignment.Left
espLab.Parent = espCheck

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(1, 0, 1, 0)
espBtn.BackgroundTransparency = 1
espBtn.Text = ""
espBtn.Parent = espCheck

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espFill.BackgroundColor3 = espEnabled and ACCENT or BG_HOVER
end)

-- BOX ESP CHECKBOX
local boxCheck = Instance.new("Frame")
boxCheck.Size = UDim2.new(0, 16, 0, 16)
boxCheck.Position = UDim2.new(0, 15, 0, 45)
boxCheck.BackgroundColor3 = BG_LIGHT
boxCheck.BorderSizePixel = 0
boxCheck.Parent = visualTab
addCorner(boxCheck, 3)

local boxFill = Instance.new("Frame")
boxFill.Size = UDim2.new(1, -4, 1, -4)
boxFill.Position = UDim2.new(0, 2, 0, 2)
boxFill.BackgroundColor3 = BG_HOVER
boxFill.BorderSizePixel = 0
boxFill.Parent = boxCheck

local boxLab = Instance.new("TextLabel")
boxLab.Size = UDim2.new(0, 140, 0, 16)
boxLab.Position = UDim2.new(0, 22, 0, 0)
boxLab.BackgroundTransparency = 1
boxLab.Text = "box esp"
boxLab.Font = Enum.Font.GothamBold
boxLab.TextSize = 14
boxLab.TextColor3 = TXT_DIM
boxLab.TextXAlignment = Enum.TextXAlignment.Left
boxLab.Parent = boxCheck

local boxBtn = Instance.new("TextButton")
boxBtn.Size = UDim2.new(1, 0, 1, 0)
boxBtn.BackgroundTransparency = 1
boxBtn.Text = ""
boxBtn.Parent = boxCheck

boxBtn.MouseButton1Click:Connect(function()
    boxEspEnabled = not boxEspEnabled
    boxFill.BackgroundColor3 = boxEspEnabled and ACCENT or BG_HOVER
end)

-- CHAMS
local chamsEnabled = false
local chamsHighlights = {}

local function applyChams()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
            local char = p.Character
            local existing = char:FindFirstChild("MomentumChams")
            if chamsEnabled then
                if not existing then
                    local h = Instance.new("Highlight")
                    h.Name = "MomentumChams"
                    h.FillColor = ACCENT
                    h.OutlineColor = TXT_BRIGHT
                    h.FillTransparency = 0.5
                    h.OutlineTransparency = 0
                    h.Adornee = char
                    h.Parent = char
                    table.insert(chamsHighlights, h)
                end
            else
                if existing then existing:Destroy() end
            end
        end
    end
end

local function removeChams()
    for _, h in pairs(chamsHighlights) do
        if h and h.Parent then h:Destroy() end
    end
    chamsHighlights = {}
end

RS.RenderStepped:Connect(function()
    if scriptDestroyed then return end
    if chamsEnabled then
        applyChams()
    else
        removeChams()
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(p)
    if p.Character then
        local h = p.Character:FindFirstChild("MomentumChams")
        if h then h:Destroy() end
    end
end)

-- CHAMS CHECKBOX
local chCheck = Instance.new("Frame")
chCheck.Size = UDim2.new(0, 16, 0, 16)
chCheck.Position = UDim2.new(0, 15, 0, 75)
chCheck.BackgroundColor3 = BG_LIGHT
chCheck.BorderSizePixel = 0
chCheck.Parent = visualTab
addCorner(chCheck, 3)

local chFill = Instance.new("Frame")
chFill.Size = UDim2.new(1, -4, 1, -4)
chFill.Position = UDim2.new(0, 2, 0, 2)
chFill.BackgroundColor3 = BG_HOVER
chFill.BorderSizePixel = 0
chFill.Parent = chCheck

local chLab = Instance.new("TextLabel")
chLab.Size = UDim2.new(0, 140, 0, 16)
chLab.Position = UDim2.new(0, 22, 0, 0)
chLab.BackgroundTransparency = 1
chLab.Text = "chams"
chLab.Font = Enum.Font.GothamBold
chLab.TextSize = 14
chLab.TextColor3 = TXT_DIM
chLab.TextXAlignment = Enum.TextXAlignment.Left
chLab.Parent = chCheck

local chBtn = Instance.new("TextButton")
chBtn.Size = UDim2.new(1, 0, 1, 0)
chBtn.BackgroundTransparency = 1
chBtn.Text = ""
chBtn.Parent = chCheck

chBtn.MouseButton1Click:Connect(function()
    chamsEnabled = not chamsEnabled
    chFill.BackgroundColor3 = chamsEnabled and ACCENT or BG_HOVER
end)

-- WORLD TAB - SHADERS
local SHADER_URLS = {
    "https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/shr/",
    "https://cdn.jsdelivr.net/gh/randomstring0/pshade-ultimate@main/shr/",
}
local SKY_URL = "https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/sky/"

local shaderEnabled = false
local shaderEffects = {}
local shaderDefaults = _G.__momentumDefaults and _G.__momentumDefaults._ver == 2 and _G.__momentumDefaults or {}

local function ensureEffect(className, key)
    local effect = game:GetService("Lighting"):FindFirstChildOfClass(className)
    if not effect then
        effect = Instance.new(className)
        effect.Parent = game:GetService("Lighting")
    end
    shaderEffects[key] = effect
    return effect
end

local function getOrCreateEffects()
    ensureEffect("ColorCorrectionEffect", "cor")
    ensureEffect("BloomEffect", "bloom")
    ensureEffect("BlurEffect", "blur")
    shaderEffects["blur"].Size = 0
    ensureEffect("DepthOfFieldEffect", "dof")
    ensureEffect("SunRaysEffect", "sray")

    if not game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere") then
        local a = Instance.new("Atmosphere")
        a.Parent = game:GetService("Lighting")
    end
    shaderEffects["atmo"] = game:GetService("Lighting"):FindFirstChildOfClass("Atmosphere")

    if not game:GetService("Lighting"):FindFirstChildOfClass("Sky") then
        local s = Instance.new("Sky")
        s.Parent = game:GetService("Lighting")
    end
    shaderEffects["sky"] = game:GetService("Lighting"):FindFirstChildOfClass("Sky")

    local terr = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
    if terr then
        shaderEffects["cloud"] = terr:FindFirstChildOfClass("Clouds")
    end
end

local function applyShader(t)
    if not shaderEffects["cor"] then getOrCreateEffects() end
    local lg = game:GetService("Lighting")
    local cor = shaderEffects["cor"]
    local bloom = shaderEffects["bloom"]
    local blur = shaderEffects["blur"]
    local dof = shaderEffects["dof"]
    local sray = shaderEffects["sray"]
    local atmo = shaderEffects["atmo"]
    local sky = shaderEffects["sky"]
    local cloud = shaderEffects["cloud"]

    if cor then
        cor.Brightness = t.fhnchvhfjsd or 0
        cor.Contrast = t.ugtbbjhygt or 0
        cor.Saturation = t.tfbghuugbnjhg or 0
        cor.TintColor = t.fvrtccvghghj or Color3.new(1, 1, 1)
        cor.Enabled = true
    end
    if bloom then
        bloom.Intensity = t.jnfdhbnfcvh or 0.2
        bloom.Size = t.fvtyghj or 5
        bloom.Threshold = t.ygbhnj or 0.8
        bloom.Enabled = true
    end
    if blur then
        blur.Size = shaderEnabled and (t.njnfg or 0) or 0
    end
    if dof then
        dof.FarIntensity = t.jdfkd or 0
        dof.FocusDistance = t.fvgsdfg or 0
        dof.InFocusRadius = t.sdkvkflv or 0
        dof.NearIntensity = t.hbjhd or 0
        dof.Enabled = true
    end
    if sray then
        sray.Enabled = true
    end
    if atmo then
        atmo.Density = t.shdbsnjfc or 0
        atmo.Offset = t.skdjfkdm or 0
        atmo.Color = t.sjdjncdjf or TXT_DIM
        atmo.Decay = t.efjdjfk or Color3.new(0, 0, 0)
        atmo.Glare = t.sejfd or 0
        atmo.Haze = t.jddfjsd or 0
    end
    if sky then
        sky.SkyboxBk = shaderEffects["skyBk"] or ""
        sky.SkyboxDn = shaderEffects["skyDn"] or ""
        sky.SkyboxFt = shaderEffects["skyFt"] or ""
        sky.SkyboxLf = shaderEffects["skyLf"] or ""
        sky.SkyboxRt = shaderEffects["skyRt"] or ""
        sky.SkyboxUp = shaderEffects["skyUp"] or ""
    end
    if cloud then
        cloud.Cover = t.gyhgtg or 0
        cloud.Density = t.ygbhggv or 0
        cloud.Color = t.jghbjhgyfd or Color3.new(1, 1, 1)
    end
    lg.Ambient = t.yfbghj or Color3.new(0, 0, 0)
    lg.ClockTime = t.tgvbyd or 12
    lg.GeographicLatitude = t.ghuybhuyhj or 0
    lg.Brightness = t.khnbfth or 1
    lg.ColorShift_Bottom = t.hgyghkg or Color3.new(0, 0, 0)
    lg.ColorShift_Top = t.yfbhjku or Color3.new(1, 1, 1)
    lg.EnvironmentDiffuseScale = t.ygyyfgvhbjytrt or 0
    lg.EnvironmentSpecularScale = t.sdfcddc or 0
    lg.GlobalShadows = t.hgnujuu7thgr or true
    lg.OutdoorAmbient = t.hyhnngtf or Color3.new(0, 0, 0)
    lg.ExposureCompensation = t.hdfr7thgr or 0
end

local function resetShader()
    shaderEnabled = false
    local lg = game:GetService("Lighting")
    if shaderEffects["cor"] then shaderEffects["cor"].Enabled = false end
    if shaderEffects["bloom"] then shaderEffects["bloom"].Enabled = false end
    if shaderEffects["blur"] then shaderEffects["blur"].Size = 0 end
    if shaderEffects["dof"] then shaderEffects["dof"].Enabled = false end
    if shaderEffects["sray"] then shaderEffects["sray"].Enabled = false end
    lg.Ambient = shaderDefaults.ambient or Color3.new(0, 0, 0)
    lg.ClockTime = shaderDefaults.clockTime or 14
    lg.GeographicLatitude = shaderDefaults.lat or 0
    lg.Brightness = shaderDefaults.brightness or 1
    lg.ColorShift_Bottom = shaderDefaults.colorBtm or Color3.new(0, 0, 0)
    lg.ColorShift_Top = shaderDefaults.colorTop or Color3.new(1, 1, 1)
    lg.EnvironmentDiffuseScale = shaderDefaults.envDiff or 0
    lg.EnvironmentSpecularScale = shaderDefaults.envSpec or 0
    lg.GlobalShadows = shaderDefaults.shadows or true
    lg.OutdoorAmbient = shaderDefaults.outdoor or Color3.new(0, 0, 0)
    lg.ExposureCompensation = shaderDefaults.exposure or 0
end

local function resetEffects()
    if shaderEffects["cor"] then
        shaderEffects["cor"].Brightness = 0
        shaderEffects["cor"].Contrast = 0
        shaderEffects["cor"].Saturation = 0
        shaderEffects["cor"].TintColor = Color3.new(1, 1, 1)
    end
    if shaderEffects["bloom"] then
        shaderEffects["bloom"].Intensity = 0
        shaderEffects["bloom"].Size = 0
        shaderEffects["bloom"].Threshold = 0
    end
    if shaderEffects["blur"] then shaderEffects["blur"].Size = 0 end
    if shaderEffects["dof"] then
        shaderEffects["dof"].FarIntensity = 0
        shaderEffects["dof"].FocusDistance = 0
        shaderEffects["dof"].InFocusRadius = 0
        shaderEffects["dof"].NearIntensity = 0
    end
end

getOrCreateEffects()

-- If no valid cached defaults, save current (clean) state
if not (_G.__momentumDefaults and _G.__momentumDefaults._ver == 2) then
    resetEffects()
    -- Force clean Lighting (previous run may have left it corrupted)
    local lg = game:GetService("Lighting")
    lg.ClockTime = 14
    lg.Brightness = 1
    lg.Ambient = Color3.new(0, 0, 0)
    lg.ColorShift_Bottom = Color3.new(0, 0, 0)
    lg.ColorShift_Top = Color3.new(1, 1, 1)
    lg.GlobalShadows = true
    lg.OutdoorAmbient = Color3.new(0.4, 0.4, 0.4)
    lg.ExposureCompensation = 0
    lg.EnvironmentDiffuseScale = 0
    lg.EnvironmentSpecularScale = 0
    lg.GeographicLatitude = 0
    shaderDefaults = {
        ambient = lg.Ambient,
        clockTime = lg.ClockTime,
        lat = lg.GeographicLatitude,
        brightness = lg.Brightness,
        colorBtm = lg.ColorShift_Bottom,
        colorTop = lg.ColorShift_Top,
        envDiff = lg.EnvironmentDiffuseScale,
        envSpec = lg.EnvironmentSpecularScale,
        shadows = lg.GlobalShadows,
        outdoor = lg.OutdoorAmbient,
        exposure = lg.ExposureCompensation,
    }
    _G.__momentumDefaults = shaderDefaults
    _G.__momentumDefaults._ver = 2
else
    -- Re-run: reset leftover values but keep effects enabled
    resetEffects()
    local lg = game:GetService("Lighting")
    lg.Ambient = shaderDefaults.ambient or Color3.new(0, 0, 0)
    lg.ClockTime = shaderDefaults.clockTime or 14
    lg.GeographicLatitude = shaderDefaults.lat or 0
    lg.Brightness = shaderDefaults.brightness or 1
    lg.ColorShift_Bottom = shaderDefaults.colorBtm or Color3.new(0, 0, 0)
    lg.ColorShift_Top = shaderDefaults.colorTop or Color3.new(1, 1, 1)
    lg.EnvironmentDiffuseScale = shaderDefaults.envDiff or 0
    lg.EnvironmentSpecularScale = shaderDefaults.envSpec or 0
    lg.GlobalShadows = shaderDefaults.shadows or true
    lg.OutdoorAmbient = shaderDefaults.outdoor or Color3.new(0, 0, 0)
    lg.ExposureCompensation = shaderDefaults.exposure or 0
end

-- World tab scroll frame
local worldScroll = Instance.new("ScrollingFrame")
worldScroll.Size = UDim2.new(1, 0, 1, 0)
worldScroll.Position = UDim2.new(0, 0, 0, 0)
worldScroll.BackgroundColor3 = BG_DARK
worldScroll.BorderSizePixel = 0
worldScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
worldScroll.ScrollBarThickness = 4
worldScroll.Parent = worldTab
addCorner(worldScroll, 6)

local function shaderCheckbox(name, y)
    local check = Instance.new("Frame")
    check.Size = UDim2.new(0, 16, 0, 16)
    check.Position = UDim2.new(0, 15, 0, y)
    check.BackgroundColor3 = BG_LIGHT
    check.BorderSizePixel = 0
    check.Parent = worldScroll

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(1, -4, 1, -4)
    fill.Position = UDim2.new(0, 2, 0, 2)
    fill.BackgroundColor3 = BG_HOVER
    fill.BorderSizePixel = 0
    fill.Parent = check

    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(0, 140, 0, 16)
    lab.Position = UDim2.new(0, 22, 0, 0)
    lab.BackgroundTransparency = 1
    lab.Text = name
    lab.Font = Enum.Font.GothamBold
    lab.TextSize = 14
    lab.TextColor3 = TXT_DIM
    lab.TextXAlignment = Enum.TextXAlignment.Left
    lab.Parent = check

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = check

    return {fill = fill, btn = btn}
end

local function shaderPresetButton(name, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 22)
    btn.Position = UDim2.new(0, 45, 0, y)
    btn.BackgroundColor3 = BG_LIGHT
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = TXT_DIM
    btn.Parent = worldScroll
    addCorner(btn, 4)

    btn.MouseButton1Click:Connect(function()
        shaderEnabled = true
        shaderFill.BackgroundColor3 = ACCENT
        callback()
    end)
    btn.MouseEnter:Connect(function()
        tweenProp(btn, {BackgroundColor3 = BG_HOVER, TextColor3 = TXT_BRIGHT}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        tweenProp(btn, {BackgroundColor3 = BG_LIGHT, TextColor3 = TXT_DIM}, 0.15)
    end)
    return btn
end

local function shaderLabel(name, y)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(0, 160, 0, 20)
    lab.Position = UDim2.new(0, 15, 0, y)
    lab.BackgroundTransparency = 1
    lab.Text = name
    lab.Font = Enum.Font.GothamBold
    lab.TextSize = 13
    lab.TextColor3 = TXT
    lab.TextXAlignment = Enum.TextXAlignment.Left
    lab.Parent = worldScroll
end

local function fetchShader(name)
    local data
    for _, base in ipairs(SHADER_URLS) do
        local ok, d = pcall(game.HttpGet, game, base .. name .. ".json")
        if ok and type(d) == "string" and #d > 10 then
            data = d
            break
        end
    end
    if not data then
        warn("[Momentum] all HTTP sources failed for " .. name)
        return nil
    end
    local fn, err = loadstring(data)
    if not fn then
        warn("[Momentum] loadstring failed for " .. name .. ": " .. tostring(err))
        return nil
    end
    local ok, res = pcall(fn)
    if not ok then
        warn("[Momentum] execute failed for " .. name .. ": " .. tostring(res))
        return nil
    end
    if type(res) ~= "table" then
        warn("[Momentum] shader " .. name .. " did not return a table")
        return nil
    end
    return res
end

-- Shader master toggle
local shaderToggle = shaderCheckbox("shaders", 5)
shaderFill = shaderToggle.fill
shaderToggle.btn.MouseButton1Click:Connect(function()
    shaderEnabled = not shaderEnabled
    shaderFill.BackgroundColor3 = shaderEnabled and ACCENT or BG_HOVER
    if not shaderEnabled then resetShader() end
end)

-- Shader presets
local sy = 30
shaderLabel("-- TIME OF DAY --", sy) sy = sy + 22

local shaderNames = {
    "Morning", "Midday", "Afternoon", "Evening", "Night", "Midnight",
}

for _, label in ipairs(shaderNames) do
    local key = label:lower()
    shaderPresetButton(label, sy, function()
        local t = fetchShader(key)
        if t then applyShader(t) end
    end)
    sy = sy + 24
end

sy = sy + 5
shaderLabel("-- WEATHER --", sy) sy = sy + 22

local weatherNames = {
    "Rain", "Snow", "Fog", "Sunny", "Cloudy", "Storm",
}

for _, label in ipairs(weatherNames) do
    local key = label:lower()
    shaderPresetButton(label, sy, function()
        local t = fetchShader(key)
        if t then applyShader(t) end
    end)
    sy = sy + 24
end

sy = sy + 5
shaderLabel("-- SEASONS --", sy) sy = sy + 22

local seasonNames = {
    "Autumn", "Spring", "Summer", "Winter",
}

for _, label in ipairs(seasonNames) do
    local key = label:lower()
    shaderPresetButton(label, sy, function()
        local t = fetchShader(key)
        if t then applyShader(t) end
    end)
    sy = sy + 24
end

sy = sy + 5
shaderLabel("-- COLORS --", sy) sy = sy + 22

local colorNames = {
    "Black", "Green", "Red", "Yellow", "Pink", "Gray", "White", "Purple",
}

for _, label in ipairs(colorNames) do
    local key = label:lower()
    shaderPresetButton(label, sy, function()
        local t = fetchShader(key)
        if t then applyShader(t) end
    end)
    sy = sy + 24
end

worldScroll.CanvasSize = UDim2.new(0, 0, 0, sy + 10)

UIS.InputBegan:Connect(function(inp, gp)
    if not gp then
        if inp.KeyCode == Enum.KeyCode.RightControl or inp.KeyCode == Enum.KeyCode.Insert then
            gui.Enabled = not gui.Enabled
        end
        if inp.KeyCode == Enum.KeyCode.R then
            speedGlitchEnabled = not speedGlitchEnabled
            sgFill.BackgroundColor3 = speedGlitchEnabled and ACCENT or BG_HOVER
        end
    end

    if wallhopBind and wallhopBind.type then
        local match = false
        if wallhopBind.type == "keyboard" and not gp and inp.KeyCode == wallhopBind.key then
            match = true
        elseif wallhopBind.type == "other" then
            local v = getTypeValue(inp)
            if v == wallhopBind.inputTypeValue then match = true end
        end
        if match then
            autoWall = not autoWall
            whFill.BackgroundColor3 = autoWall and ACCENT or BG_HOVER
        end
    end

    if jumpbugBind and jumpbugBind.type then
        local match = false
        if jumpbugBind.type == "keyboard" and not gp and inp.KeyCode == jumpbugBind.key then
            match = true
        elseif jumpbugBind.type == "other" then
            local v = getTypeValue(inp)
            if v == jumpbugBind.inputTypeValue then match = true end
        end
        if match then
            jumpbugEnabled = not jumpbugEnabled
            jbFill.BackgroundColor3 = jumpbugEnabled and ACCENT or BG_HOVER
        end
    end

    if wsBind and wsBind.type then
        local match = false
        if wsBind.type == "keyboard" and not gp and inp.KeyCode == wsBind.key then
            match = true
        elseif wsBind.type == "other" then
            local v = getTypeValue(inp)
            if v == wsBind.inputTypeValue then match = true end
        end
        if match then
            wsEnabled = not wsEnabled
            wsFill.BackgroundColor3 = wsEnabled and ACCENT or BG_HOVER
        end
    end

    if spinBind and spinBind.type then
        local match = false
        if spinBind.type == "keyboard" and not gp and inp.KeyCode == spinBind.key then
            match = true
        elseif spinBind.type == "other" then
            local v = getTypeValue(inp)
            if v == spinBind.inputTypeValue then match = true end
        end
        if match then
            spinEnabled = not spinEnabled
            spinFill.BackgroundColor3 = spinEnabled and ACCENT or BG_HOVER
        end
    end
end)
