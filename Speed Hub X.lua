-- LocalScript in StarterGui ▶ ScreenGui
local Players = game:GetService("Players")
local player  = Players.LocalPlayer
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/refs/heads/main/Spawner.lua"))()

-- create ScreenGui
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "DarkSpawnerUI"

-- main window
local window = Instance.new("Frame", screenGui)
window.Size             = UDim2.new(0, 450, 0, 350)
window.Position         = UDim2.new(0.5, -225, 0.5, -175)
window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
window.BorderSizePixel  = 0
Instance.new("UICorner", window).CornerRadius = UDim.new(0,16)

-- title bar
local titleBar = Instance.new("Frame", window)
titleBar.Size               = UDim2.new(1, 0, 0, 48)
titleBar.BackgroundColor3   = Color3.fromRGB(25, 25, 25)
titleBar.BorderSizePixel    = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", titleBar)
title.Size               = UDim2.new(1, -96, 1, 0)
title.Position           = UDim2.new(0, 16, 0, 0)
title.Text               = "Dark Spawner"
title.Font               = Enum.Font.GothamBold
title.TextSize           = 20
title.TextColor3         = Color3.fromRGB(225,225,225)
title.BackgroundTransparency = 1

-- close button
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size               = UDim2.new(0, 32, 0, 32)
closeBtn.Position           = UDim2.new(1, -48, 0, 8)
closeBtn.Text               = "✕"
closeBtn.Font               = Enum.Font.GothamBold
closeBtn.TextSize           = 20
closeBtn.TextColor3         = Color3.fromRGB(200,200,200)
closeBtn.BackgroundTransparency = 1
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = Color3.fromRGB(255,100,100) end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = Color3.fromRGB(200,200,200) end)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- tab bar
local tabBar = Instance.new("Frame", window)
tabBar.Size              = UDim2.new(1, -32, 0, 40)
tabBar.Position          = UDim2.new(0,16,0,56)
tabBar.BackgroundTransparency = 1

local tabs = {"Pet","Seed","Egg","Spin"}
local tabButtons, contentFrames = {}, {}

for i,name in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabBar)
    btn.Name             = name.."Tab"
    btn.Size             = UDim2.new(0,100,1,0)
    btn.Position         = UDim2.new(0, 110*(i-1), 0, 0)
    btn.Text             = name
    btn.Font             = Enum.Font.GothamSemibold
    btn.TextSize         = 14
    btn.TextColor3       = Color3.fromRGB(180,180,180)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel  = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    tabButtons[name] = btn

    local frame = Instance.new("Frame", window)
    frame.Name             = name.."Content"
    frame.Size             = UDim2.new(1, -32, 1, -128)
    frame.Position         = UDim2.new(0,16,0,112)
    frame.BackgroundTransparency = 1
    frame.Visible          = false
    contentFrames[name]    = frame
end

-- select tab helper
local function selectTab(active)
    for name,btn in pairs(tabButtons) do
        local isActive = (name == active)
        btn.BackgroundColor3 = isActive and Color3.fromRGB(60,60,60) or Color3.fromRGB(40,40,40)
        btn.TextColor3       = isActive and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180)
        contentFrames[name].Visible = isActive
    end
end
selectTab("Pet")
for name,btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() selectTab(name) end)
end

-- input factory
local function makeInput(parent, y, labelText, placeholder)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Text            = labelText
    lbl.Font            = Enum.Font.Gotham
    lbl.TextSize        = 14
    lbl.TextColor3      = Color3.fromRGB(200,200,200)
    lbl.BackgroundTransparency = 1
    lbl.Position        = UDim2.new(0,0,0,y)

    local box = Instance.new("TextBox", parent)
    box.PlaceholderText = placeholder or ""
    box.Font            = Enum.Font.Gotham
    box.TextSize        = 14
    box.TextColor3      = Color3.fromRGB(225,225,225)
    box.BackgroundColor3 = Color3.fromRGB(50,50,50)
    box.BorderSizePixel  = 0
    box.Size            = UDim2.new(1, 0, 0, 30)
    box.Position        = UDim2.new(0, 0, 0, y + 24)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    return box
end

-- Pet tab
do
    local f = contentFrames["Pet"]
    local nameBox = makeInput(f, 0,  "Pet Name",    "Raccoon")
    local kgBox   = makeInput(f, 80, "Weight (KG)", "1")
    local ageBox  = makeInput(f, 160,"Age",         "2")

    local btn = Instance.new("TextButton", f)
    btn.Text             = "Spawn Pet"
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 16
    btn.TextColor3       = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    btn.BorderSizePixel  = 0
    btn.Size             = UDim2.new(0,140,0,36)
    btn.Position         = UDim2.new(1,-156,1,-52)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(0,200,255) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(0,170,255) end)

    btn.MouseButton1Click:Connect(function()
        Spawner.SpawnPet(nameBox.Text, tonumber(kgBox.Text) or 1, tonumber(ageBox.Text) or 1)
    end)
end

-- Seed tab
do
    local f = contentFrames["Seed"]
    local box = makeInput(f, 0, "Seed Name", "Candy Blossom")

    local btn = Instance.new("TextButton", f)
    btn.Text             = "Spawn Seed"
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 16
    btn.TextColor3       = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    btn.BorderSizePixel  = 0
    btn.Size             = UDim2.new(0,140,0,36)
    btn.Position         = UDim2.new(1,-156,1,-52)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(0,255,160) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(0,255,127) end)

    btn.MouseButton1Click:Connect(function()
        Spawner.SpawnSeed(box.Text)
    end)
end

-- Egg tab
do
    local f = contentFrames["Egg"]
    local box = makeInput(f, 0, "Egg Name", "Night Egg")

    local btn = Instance.new("TextButton", f)
    btn.Text             = "Spawn Egg"
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 16
    btn.TextColor3       = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(255, 153, 51)
    btn.BorderSizePixel  = 0
    btn.Size             = UDim2.new(0,140,0,36)
    btn.Position         = UDim2.new(1,-156,1,-52)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(255,180,80) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(255,153,51) end)

    btn.MouseButton1Click:Connect(function()
        Spawner.SpawnEgg(box.Text)
    end)
end

-- Spin tab
do
    local f = contentFrames["Spin"]
    local box = makeInput(f, 0, "Item to Spin", "Sunflower")

    local btn = Instance.new("TextButton", f)
    btn.Text             = "Spin"
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 16
    btn.TextColor3       = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(181, 85, 215)
    btn.BorderSizePixel  = 0
    btn.Size             = UDim2.new(0,140,0,36)
    btn.Position         = UDim2.new(1,-156,1,-52)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(210,100,240) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(181,85,215) end)

    btn.MouseButton1Click:Connect(function()
        Spawner.Spin(box.Text)
    end)
end
