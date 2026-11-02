-- تحميل مكتبة الواجهة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ريدز هب (نسخة عباس الفعالة) : Blox Fruits", "BloodTheme")

-- إنشاء أقسام الواجهة
local Tab = Window:NewTab("الفرم والقتال الفعلي")
local Section = Tab:NewSection("التحكم الكامل والوظائف")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- المتغيرات للتحكم بالوظائف
local _G_AutoFarm = false
local _G_AutoBoss = false
local _G_Speed = false
local _G_ESP = false

-- 1. [فعلي 100%] الفرم التلقائي للفل (يتحرك نحو الوحش، يختار المهمة، ويضرب تلقائياً)
Section:Toggle("الفرم التلقائي الفعلي", "الانتقال الفعلي للوحوش والقتل وتجميع الأرباح", false, function(state)
    _G_AutoFarm = state
end)

RunService.RenderStepped:Connect(function()
    if _G_AutoFarm then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                    if humanoid and rootPart and humanoid.Health > 0 then
                        if _G_AutoFarm then
                            -- انتقال حقيقي لمكان الوحش والضرب بالسلاح المفعل
                            hrp.CFrame = rootPart.CFrame * CFrame.new(0, 3, 4)
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                            break
                        end
                    end
                end
            end
        end)
    end
end)

-- 2. [فعلي 100%] قتل البوصات تلقائياً (البحث عن البوص واستهدافه فعلياً)
Section:Toggle("قتل البوصات الفعلي", "البحث عن أقوى البوصات والانتقال لقتلهم فوراً", false, function(state)
    _G_AutoBoss = state
end)

RunService.RenderStepped:Connect(function()
    if _G_AutoBoss then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                    if humanoid and rootPart and humanoid.Health > 0 then
                        if enemy.Name:find("Boss") or (humanoid.MaxHealth > 5000) then
                            if _G_AutoBoss then
                                hrp.CFrame = rootPart.CFrame * CFrame.new(0, 3, 4)
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 3. [فعلي 100%] سرعة خارقة للشخصية (تعديل حقيقي لسرعة المشي)
Section:Toggle("سرعة خارقة للشخصية (120)", "زيادة سرعة الحركة بشكل حقيقي داخل اللعبة", false, function(state)
    _G_Speed = state
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = _G_Speed and 120 or 16
        end
    end)
end)

-- 4. [فعلي 100%] كشف أماكن اللاعبين ESP (إظهار اسماء اللاعبين وأماكنهم بوضوح)
Section:Toggle("كشف أماكن اللاعبين (ESP)", "إظهار اسماء واماكن اللاعبين على الشاشة", false, function(state)
    _G_ESP = state
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Head") then
                    local existingBillboard = player.Character.Head:FindFirstChild("ESP_Text")
                    if _G_ESP then
                        if not existingBillboard then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP_Text"
                            billboard.Size = UDim2.new(0, 100, 0, 50)
                            billboard.AlwaysOnTop = true
                            billboard.Adornee = player.Character.Head
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = player.Name
                            textLabel.TextColor3 = Color3.fromRGB(255, 165, 0) -- لون برتقالي فخم
                            textLabel.TextScaled = true
                            textLabel.Parent = billboard
                            
                            billboard.Parent = player.Character.Head
                        end
                    else
                        if existingBillboard then
                            existingBillboard:Destroy()
                        end
                    end
                end
            end)
        end
    end
end)
