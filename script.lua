local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer.PlayerGui:FindFirstChild("AbbasBloxHub") then
    LocalPlayer.PlayerGui.AbbasBloxHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ContentHolder = Instance.new("ScrollingFrame")

ScreenGui.Name = "AbbasBloxHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner")
TopCorner.Parent = TopBar
TopCorner.CornerRadius = UDim.new(0, 10)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.04, 0, 0, 0)
Title.Size = UDim2.new(0.9, 0, 1, 0)
Title.Text = "Abbas Hub | Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

ContentHolder.Name = "ContentHolder"
ContentHolder.Parent = MainFrame
ContentHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentHolder.Position = UDim2.new(0.03, 0, 0.15, 0)
ContentHolder.Size = UDim2.new(0.94, 0, 0.81, 0)
ContentHolder.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local ContentCorner = Instance.new("UICorner")
ContentCorner.Parent = ContentHolder
ContentCorner.CornerRadius = UDim.new(0, 8)

local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = ContentHolder
SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
SpeedButton.Position = UDim2.new(0.05, 0, 0.05, 0)
SpeedButton.Size = UDim2.new(0.9, 0, 0, 45)
SpeedButton.Text = "Boost Speed (WalkSpeed 80)"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextSize = 15
SpeedButton.Font = Enum.Font.SourceSansBold

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.Parent = SpeedButton
BtnCorner1.CornerRadius = UDim.new(0, 6)

SpeedButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 80
    end
end)

local TeleportButton = Instance.new("TextButton")
TeleportButton.Parent = ContentHolder
TeleportButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TeleportButton.Position = UDim2.new(0.05, 0, 0.22, 0)
TeleportButton.Size = UDim2.new(0.9, 0, 0, 45)
TeleportButton.Text = "Teleport Up"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 15
TeleportButton.Font = Enum.Font.SourceSansBold

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.Parent = TeleportButton
BtnCorner2.CornerRadius = UDim.new(0, 6)

TeleportButton.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    end
end)

local FarmButton = Instance.new("TextButton")
FarmButton.Parent = ContentHolder
FarmButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
FarmButton.Position = UDim2.new(0.05, 0, 0.39, 0)
FarmButton.Size = UDim2.new(0.9, 0, 0, 45)
FarmButton.Text = "Toggle Auto Farm (OFF)"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 15
FarmButton.Font = Enum.Font.SourceSansBold

local BtnCorner3 = Instance.new("UICorner")
BtnCorner3.Parent = FarmButton
BtnCorner3.CornerRadius = UDim.new(0, 6)

local farming = false
FarmButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        FarmButton.Text = "Toggle Auto Farm (ON)"
        FarmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        FarmButton.Text = "Toggle Auto Farm (OFF)"
        FarmButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)
