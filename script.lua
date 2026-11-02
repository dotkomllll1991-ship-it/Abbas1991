local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("redz hub : Blox Fruits", "BloodTheme")

local Tab = Window:NewTab("الفرم والقتال")
local Section = Tab:NewSection("القتال والبوصات")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 1. الهجوم التلقائي
local _G_AutoAttack = false
Section:Toggle("الهجوم التلقائي", "يضرب تلقائياً بالسلاح المفعل", false, function(state)
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

-- 2. دمج خارق للبوصات
local _G_SuperBoss = false
Section:Toggle("دمج خارق للبوصات", "دمج عالي وتخطي وقت الانتظار للهجمات", false, function(state)
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

-- 3. قتل البوصات تلقائياً
local _G_AutoBoss = false
Section:Toggle("قتل البوصات تلقائياً", "الانتقال وقتل البوصات بشكل تلقائي", false, function(state)
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

-- 4. سرعة خارقة
Section:Toggle("سرعة خارقة (120)", "زيادة سرعة حركة الشخصية", false, function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 120 or 16
    end
end)
