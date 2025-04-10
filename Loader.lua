local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua", true))()


local Window = Fluent:CreateWindow({
    Title = "Meu Script",
    SubTitle = "By Lucas",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Dark"
})

local Tab = Window:AddTab({ Title = "testes", Icon = "home" })

Tab:AddButton({
    Title = "Teleportar",
    Callback = function()
        local pos = Vector3.new(100, 10, 200) -- Altere para a coordenada que quiser
        game.Players.LocalPlayer.Character:MoveTo(pos)
    end
})
