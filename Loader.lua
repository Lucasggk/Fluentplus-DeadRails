
local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()

local Window = Fluent:CreateWindow({
    Title = "Meu Script By Lucas",
    SubTitle = "powered by Fluent",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tab = Window:AddTab({ Title = "testes", Icon = "home" })

-- Botão de Teleport
Tab:AddButton("Teleportar", {
    Title = "Teleport",
    Description = "Clique para teleportar",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Coord. de exemplo, edita aqui se quiser outro lugar
                hrp.CFrame = CFrame.new(Vector3.new(0, 100, 0))
            end
        end
    end
})

-- Toggle de Fly parado
local fly = false
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

Tab:AddToggle("FlyToggle", {
    Title = "Fly Parado no Ar",
    Description = "Ativa ou desativa o Fly parado",
    Default = false,
    Callback = function(state)
        fly = state
        humanoidRootPart.Anchored = fly
    end
})

RunService.RenderStepped:Connect(function()
    if fly then
        humanoidRootPart.Anchored = true
    end
end)
