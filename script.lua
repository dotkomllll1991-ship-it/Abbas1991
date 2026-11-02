if getgenv().AbbasRedzLoaded then return end
getgenv().AbbasRedzLoaded = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

if LocalPlayer.PlayerGui:FindFirstChild("RedzStyleHub") then
    LocalPlayer.PlayerGui.RedzStyleHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedzStyleHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 8)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Sidebar.ScrollBarThickness = 2

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.Parent = Sidebar
SidebarCorner.CornerRadius = UDim.new(0, 8)

local ContentPanel = Instance.new("ScrollingFrame")
ContentPanel.Parent = MainFrame
ContentPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
ContentPanel.Position = UDim2.new(0, 155, 0, 0)
ContentPanel.Size = UDim2.new(1, -155, 1, 0)
ContentPanel.CanvasSize = UDim2.new(0, 0, 1.8, 0)
ContentPanel.ScrollBarThickness = 3

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = ContentPanel
ContentCorner.CornerRadius = UDim.new(0, 8)

local LogoText = Instance.new("TextLabel")
LogoText.Parent = Sidebar
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 0, 45)
LogoText.Text = "redz hub : Blox Fruits"
LogoText.TextColor3 = Color3.fromRGB(255, 60, 60)
LogoText.TextSize = 13
LogoText.Font = Enum.Font.GothamBold

local function createTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Text = "  " .. name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize, btn.Font = 12, Enum.Font.GothamSemibold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 6)
    return btn
end

createTabButton("Discord", 50)
createTabButton("Farms / Combat", 88)
createTabButton("Sea (البحر)", 126)
createTabButton("Quest / Items", 164)
createTabButton("Fruits / Raid", 202)
createTabButton("Stats", 240)

local function createToggle(name, yPos, callback)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = ContentPanel
    toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    toggleBtn.Position = UDim2.new(0.04, 0, 0, yPos)
    toggleBtn.Size = UDim2.new(0.92, 0, 0, 38)
    toggleBtn.Text = "  " .. name .. " [ OFF ]"
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    toggleBtn.TextSize = 12
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local corner = Instance.new("UICorner")
    corner.Parent = toggleBtn
    corner.CornerRadius = UDim.new(0, 6)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.Text = "  " .. name .. " [ ON ]"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        else
            toggleBtn.Text = "  " .. name .. " [ OFF ]"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        end
        callback(state)
    end)
end

local autoAttackEnabled = false
createToggle("Auto Attack", 15, function(state)
    autoAttackEnabled = state
end)

RunService.RenderStepped:Connect(function()
    if autoAttackEnabled then
        pcall(function()
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end)
    end
end)

local autoBossEnabled = false
createToggle("Auto Farm Bosses", 60, function(state)
    autoBossEnabled = state
end)

RunService.RenderStepped:Connect(function()
    if autoBossEnabled then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                    if humanoid and rootPart and humanoid.Health > 0 then
                        if enemy.Name:find("Boss") or (humanoid.MaxHealth > 5000) then
                            if autoBossEnabled then
                                hrp.CFrame = rootPart.CFrame * CFrame.new(0, 3, 4)
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local superBossAttack = false
createToggle("Super Boss Damage (God Hit)", 105, function(state)
    superBossAttack = state
end)

RunService.RenderStepped:Connect(function()
    if superBossAttack then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" then
                    if rawget(v, "attack") then
                        rawset(v, "attack", function() end)
                    end
                    if rawget(v, "cooldown") then
                        rawset(v, "cooldown", 0)
                    end
                end
            end
            local localChar = LocalPlayer.Character
            if localChar then
                for _, tool in pairs(localChar:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, remote in pairs(tool:GetDescendants()) do
                            if remote:IsA("RemoteEvent") then
                                pcall(function()
                                    remote:FireServer()
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local autoSeaEvent = false
createToggle("Auto Sea Events / Sea Beasts", 150, function(state)
    autoSeaEvent = state
end)

RunService.RenderStepped:Connect(function()
    if autoSeaEvent then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, seaObj in pairs(workspace.Enemies:GetChildren()) do
                    local hum = seaObj:FindFirstChild("Humanoid")
                    local rp = seaObj:FindFirstChild("HumanoidRootPart")
                    if hum and rp and hum.Health > 0 then
                        if seaObj.Name:find("SeaBeast") or seaObj.Name:find("TerrorShark") or seaObj.Name:find("Ship") then
                            if autoSeaEvent then
                                hrp.CFrame = rp.CFrame * CFrame.new(0, 10, 10)
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end)

createToggle("Super WalkSpeed (120)", 195, function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 120 or 16
    end
end)
