local function SafeLoad()
    repeat task.wait() until game:IsLoaded()
    repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")

    local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()
    local Window = Fluent:CreateWindow({
        Title = "Meu Script By Lucas",
        SubTitle = "powered by Fluent",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 400),
        Acrylic = true,
        Theme = "Dark",
        Center = true,
        IsDraggable = true
    })

    local Tab = Window:AddTab({ Title = "testes", Icon = "home" })

    Tab:AddButton({
        Title = "Teleport",
        Description = "Clique para teleportar pra frente",
        Callback = function()
            local player = game.Players.LocalPlayer
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 10
            end
        end
    })

    local fly = false

    Tab:AddToggle("ToggleFly", {
        Title = "Fly (visual)",
        Default = false,
        Callback = function(state)
            fly = state
            local player = game.Players.LocalPlayer
            local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
            if hrp then
                hrp.Anchored = fly
            end
        end
    })

    game:GetService("RunService").RenderStepped:Connect(function()
        if fly then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Anchored = true
            end
        end
    end)
end

SafeLoad()
