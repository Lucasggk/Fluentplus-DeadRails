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

local BondsTab = Window:AddTab({ Title = "bonds", Icon = "list" })

local resultadoBox = BondsTab:AddParagraph({
    Title = "Seu Bond:",
    Content = bondLabel.Text or "N/A"
})

local bondTextBox = BondsTab:AddTextBox({
    Title = "Texto do Bond:",
    Default = bondLabel.Text or "N/A",
    Placeholder = "Texto do Bond",
    ClearTextOnFocus = false,
    Callback = function(newText)
        bondLabel.Text = newText
    end
})

task.spawn(function()
    while true do
        task.wait(0.5)
        if bondLabel then
            local currentText = bondLabel.Text or "N/A"
            pcall(function()
                resultadoBox:SetText(currentText)
                bondTextBox:SetText(currentText)
            end)
        end
    end
end)
