repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Meu Script",
    SubTitle = "By Lucas",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Dark",
    Center = true,
    IsDraggable = true
})

local Tab = Window:AddTab({ Title = "testes", Icon = "home" })

local defaultTpPos = Vector3.new(100, 10, 200)
local currentTpPos = defaultTpPos

Tab:AddButton({
    Title = "Teleportar",
    Description = "Tp normal",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char:MoveTo(currentTpPos)
        end
    end
})

Tab:AddButton({
    Title = "Tp Spawn",
    Description = "Define o local atual como novo TP",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            currentTpPos = char.HumanoidRootPart.Position
        end
    end
})

Tab:AddButton({
    Title = "Reset Tp",
    Description = "Volta o TP para o padrão",
    Callback = function()
        currentTpPos = defaultTpPos
    end
})

Tab:AddSlider("Slider", {
    Title = "Velocidade",
    Default = 16,
    Min = 10,
    Max = 150,
    Rounding = 1,
    Callback = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
    end
})

local flying = false
local RS = game:GetService("RunService")
local speed = 3
local bv, bg, char, hrp, humanoid

Tab:AddToggle("FlyToggle", {
    Title = "Fly (Analógico Mobile)",
    Default = false,
    Callback = function(state)
        flying = state
        char = game.Players.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        hrp = char:FindFirstChild("HumanoidRootPart")
        humanoid = char:FindFirstChildWhichIsA("Humanoid")

        if flying then  
            bv = Instance.new("BodyVelocity")  
            bv.Velocity = Vector3.zero  
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)  
            bv.Parent = hrp  

            bg = Instance.new("BodyGyro")  
            bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)  
            bg.CFrame = hrp.CFrame  
            bg.Parent = hrp  

            humanoid.PlatformStand = true  

            RS:BindToRenderStep("Fly", Enum.RenderPriority.Input.Value, function()  
                local cam = workspace.CurrentCamera  
                local moveDir = humanoid.MoveDirection  

                if moveDir.Magnitude > 0 then  
                    bv.Velocity = cam.CFrame:VectorToWorldSpace(moveDir.Unit * speed)  
                else  
                    bv.Velocity = Vector3.zero  
                end  

                bg.CFrame = cam.CFrame  
            end)  
        else  
            RS:UnbindFromRenderStep("Fly")  
            if bv then bv:Destroy() end  
            if bg then bg:Destroy() end  
            if humanoid then humanoid.PlatformStand = false end  
        end  
    end
})

repeat task.wait() until game:IsLoaded()

local bondLabel = game.Players.LocalPlayer:WaitForChild("PlayerGui")
:WaitForChild("BondGui")
:WaitForChild("BondInfo")
:WaitForChild("BondCount")

Tab:AddParagraph({
    Title = "Seu Bond:",
    Content = bondLabel and bondLabel.Text or "N/A"
})

-- eterna linha 116

local BondsTab = Window:AddTab({ Title = "aimbot", Icon = "list" })

local player = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

local function getClosestNPCTarget()
    local closest, dist = nil, math.huge
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            local screenPos, onScreen = cam:WorldToViewportPoint(npc.HumanoidRootPart.Position)
            if onScreen then
                local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude
                if magnitude < dist then
                    closest = npc.HumanoidRootPart
                    dist = magnitude
                end
            end
        end
    end
    return closest
end

local aimlockEnabled = false
local aimlockConnection

local function startAimlock()
    aimlockConnection = RS.RenderStepped:Connect(function()
        local target = getClosestNPCTarget()
        if target then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local direction = (target.Position - cam.CFrame.Position).Unit
                cam.CFrame = CFrame.lookAt(cam.CFrame.Position, cam.CFrame.Position + direction)
            end
        end
    end)
end

local function stopAimlock()
    if aimlockConnection then
        aimlockConnection:Disconnect()
        aimlockConnection = nil
    end
end

BondsTab:AddToggle("AimlockToggle", {
    Title = "Aimlock (NPC)",
    Default = false,
    Callback = function(state)
        aimlockEnabled = state
        if aimlockEnabled then
            startAimlock()
        else
            stopAimlock()
        end
    end
})

repeat task.wait() until game:IsLoaded()

local tabpt = Window:AddTab({ Title = "Teleports", Icon = "car" })

repeat task.wait() until game:IsLoaded()

tabpt:AddToggle("TeslaToggle", {
    Title = "Tp Tesla",
    Description = " TP para Tesla",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ringtaa/tptotesla.github.io/refs/heads/main/Tptotesla.lua'))()
        end
    end
})

tabpt:AddToggle("CastleToggle", {
    Title = "Tp castelo",
    Description = " TP para castelo",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/castletpfast.github.io/refs/heads/main/FASTCASTLE.lua"))()
        end
    end
})

tabpt:AddToggle("fortToggle", {
    Title = "Tp fort",
    Description = " TP para fort",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/Tpfort.github.io/refs/heads/main/Tpfort.lua"))()
            end
    end
})

local trainTab = Window:AddTab({ Title = "Train", Icon = "train" })

trainTab:AddButton({
    Title = "Viajar de Primeira Classe",
    Description = "Teleporta direto para o trem",
    Callback = function()
        local train = workspace:FindFirstChild("Train") or workspace:WaitForChild("Train")

        local function getVehicleSeat()
            for _, v in pairs(train:GetDescendants()) do
                if v:IsA("VehicleSeat") then
                    return v
                end
            end
            return nil
        end

        local seat = getVehicleSeat()
        if seat then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char:MoveTo(seat.Position + Vector3.new(0, 5, 0))
            end
        end
    end
})
