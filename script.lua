local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("redz hub : Blox Fruits", "BloodTheme")

local Tab = Window:NewTab("Farms / Combat")
local Section = Tab:NewSection("Combat & Bosses")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 1. Auto Attack
local _G_AutoAttack = false
Section:Toggle("Auto Attack", "Auto attack with equipped tool", false, function(state)
    _G_AutoAttack = state
end)

RunService.RenderStepped:Connect(function()
    if _G_AutoAttack then
        pcall(function()
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end)
    end
end)

-- 2. Super Boss Damage & Fast Attack
local _G_SuperBoss = false
Section:Toggle("Super Boss Damage", "High damage and fast cooldown bypass", false, function(state)
    _G_SuperBoss = state
end)

RunService.RenderStepped:Connect(function()
    if _G_SuperBoss then
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" then
                    if rawget(v, "attack") then rawset(v, "attack", function() end) end
                    if rawget(v, "cooldown") then rawset(v, "cooldown", 0) end
                end
            end
            local localChar = LocalPlayer.Character
            if localChar then
                for _, tool in pairs(localChar:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, remote in pairs(tool:GetDescendants()) do
                            if remote:IsA("RemoteEvent") then
                                pcall(function() remote:FireServer() end)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 3. Auto Farm Bosses
local _G_AutoBoss = false
Section:Toggle("Auto Farm Bosses", "Teleport and kill bosses automatically", false, function(state)
    _G_AutoBoss = state
end)

RunService.RenderStepped:Connect(function()
    if _G_AutoBoss then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                    if humanoid and rootPart and humanoid.Health > 0 then
                        if enemy.Name:find("Boss") or (humanoid.MaxHealth > 5000) then
                            if _G_AutoBoss then
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

-- 4. Super WalkSpeed
Section:Toggle("Super WalkSpeed (120)", "High speed movement", false, function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 120 or 16
    end
end)
