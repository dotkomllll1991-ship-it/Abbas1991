if getgenv().AbbasLoaded then
    return
end
getgenv().AbbasLoaded = true

pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return nil
        end
        return old(self, ...)
    end)
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

if LocalPlayer.PlayerGui:FindFirstChild("AbbasRedzHub") then
    LocalPlayer.PlayerGui.AbbasRedzHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ContentHolder = Instance.new("ScrollingFrame")

ScreenGui.Name = "AbbasRedzHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
MainFrame.Size = UDim2.new(0, 420, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 12)

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.Size = UDim2.new(1, 0, 0, 45)

local TopCorner = Instance.new("UICorner")
TopCorner.Parent = TopBar
TopCorner.CornerRadius = UDim.new(0, 12)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Size = UDim2.new(0.9, 0, 1, 0)
Title.Text = "🔥 Abbas Hub | Redz Style 🔥"
Title.TextColor3 = Color3.fromRGB(255, 100, 0)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

ContentHolder.Name = "ContentHolder"
ContentHolder.Parent = MainFrame
ContentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentHolder.Position = UDim2.new(0.03, 0, 0.15, 0)
ContentHolder.Size = UDim2.new(0.94, 0, 0.81, 0)
ContentHolder.CanvasSize = UDim2.new(0, 0, 1.8, 0)

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = ContentHolder
ContentCorner.CornerRadius = UDim.new(0, 8)

local FarmButton = Instance.new("TextButton")
FarmButton.Parent = ContentHolder
FarmButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FarmButton.Position = UDim2.new(0.05, 0, 0.04, 0)
FarmButton.Size = UDim2.new(0.9, 0, 0, 45)
FarmButton.Text = "Auto Farm Level: [ OFF ]"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 14
FarmButton.Font = Enum.Font.GothamBold

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.Parent = FarmButton
BtnCorner1.CornerRadius = UDim.new(0, 6)

local autoFarming = false
FarmButton.MouseButton1Click:Connect(function()
    autoFarming = not autoFarming
    if autoFarming then
        FarmButton.Text = "Auto Farm Level: [ ON ]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    else
        FarmButton.Text = "Auto Farm Level: [ OFF ]"
        FarmButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)

RunService.RenderStepped:Connect(function()
    if autoFarming then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if autoFarming then
                            hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 3, 3)
                            break
                        end
                    end
                end
            end
        end)
    end
end)

local FastAttackBtn = Instance.new("TextButton")
FastAttackBtn.Parent = ContentHolder
FastAttackBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
FastAttackBtn.Position = UDim2.new(0.05, 0, 0.17, 0)
FastAttackBtn.Size = UDim2.new(0.9, 0, 0, 45)
FastAttackBtn.Text = "Fast Attack (God Mode Hit)"
FastAttackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FastAttackBtn.TextSize = 14
FastAttackBtn.Font = Enum.Font.GothamBold

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.Parent = FastAttackBtn
BtnCorner2.CornerRadius = UDim.new(0, 6)

FastAttackBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "attack") then
                rawset(v, "attack", function() end)
            end
        end
    end)
    FastAttackBtn.Text = "Fast Attack: [ Activated ]"
    FastAttackBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
end)

local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = ContentHolder
SpeedButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedButton.Position = UDim2.new(0.05, 0, 0.30, 0)
SpeedButton.Size = UDim2.new(0.9, 0, 0, 45)
SpeedButton.Text = "Super Speed (120)"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextSize = 14
SpeedButton.Font = Enum.Font.GothamBold

local BtnCorner3 = Instance.new("UICorner")
BtnCorner3.Parent = SpeedButton
BtnCorner3.CornerRadius = UDim.new(0, 6)

SpeedButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 120
    end
end)
