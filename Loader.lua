repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()

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
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char:MoveTo(currentTpPos)
        end
    end
})

Tab:AddButton({
    Title = "Tp Spawn",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            currentTpPos = char.HumanoidRootPart.Position
        end
    end
})

Tab:AddButton({
    Title = "Reset Tp",
    Callback = function()
        currentTpPos = defaultTpPos
    end
})

Tab:AddSlider("Speed", {
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
