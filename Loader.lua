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

Tab:AddButton({
    Title = "Teleport",
    Callback = function()
        local pos = Vector3.new(100, 10, 200) -- Altere aqui a posição exata que quiser
        game.Players.LocalPlayer.Character:MoveTo(pos)
    end
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local speedValue = 16 -- valor padrão

Tab:AddSlider({
    Title = "Velocidade",
    Description = "Muda a velocidade do personagem",
    Default = speedValue,
    Min = 10,
    Max = 100,
    Rounding = 1,
    Callback = function(value)
        speedValue = value
        local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end
})
