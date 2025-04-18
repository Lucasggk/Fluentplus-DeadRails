repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
 
local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua", true))() 

local Window = Fluent:CreateWindow({
    Title = "Meu Script",
    SubTitle = "By Lucas",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = false,
    Theme = "Dark",
    Center = true,
    IsDraggable = true
})


if getgenv().teste then
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

    -- repeat task.wait() until game:IsLoaded()

    local bondLabel
    pcall(function()
        bondLabel = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BondGui"):WaitForChild("BondInfo"):WaitForChild("BondCount")
    end)

    Tab:AddParagraph({
        Title = "Seu Bond:",
        Content = bondLabel and bondLabel.Text or "N/A"
    })
 
    -- eterna linha 116 (sempre ficar na linha 127)
end

            





            
local tabpt = Window:AddTab({ Title = "Teleports", Icon = "car" })

-- repeat task.wait() until game:IsLoaded()



tabpt:AddButton({
    Title = "Tp Tesla",
    Description = " TP para Tesla",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ringtaa/tptotesla.github.io/refs/heads/main/Tptotesla.lua'))()
    end
})

tabpt:AddButton({
    Title = "Tp castelo",
    Description = " TP para castelo",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/castletpfast.github.io/refs/heads/main/FASTCASTLE.lua"))()
    end
})

tabpt:AddButton({
    Title = "Tp fort",
    Description = " TP para fort",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/Tpfort.github.io/refs/heads/main/Tpfort.lua"))()
    end
})


tabpt:AddButton({
    Title = "Tp starling",
    Description = " TP para starling",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ringtaa/sterlingnotifcation.github.io/refs/heads/main/Sterling.lua'))()
    end
})

tabpt:AddButton({
    Title = "Tp Bank",
    Description = " TP para o banco mais próximo",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/Tptobank.github.io/refs/heads/main/Banktp.lua"))()
    end
})


 
 
local trainTab = Window:AddTab({ Title = "Train", Icon = "train" })

trainTab:AddButton({
    Title = "tp to train",
    Description = "Teleporta direto para o trem",
    Callback = function()
        task.spawn(function()
            for i = 1, 4 do
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

                task.wait(0.5)
            end
        end)
    end
})

trainTab:AddParagraph({
      Title = "Em breve",
      Content = "Em breve terá mais funcionalidades por aqui!"
   })


local andtab = Window:AddTab({
    Title = "end game",
    Icon = "list"
})

andtab:AddButton({
    Title = "Tp to end",
    Description = "TP para o final",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/newpacifisct/refs/heads/main/newpacifisct.lua"))()
   wait(7)
   local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local targetPosition = Vector3.new(-426.8, 3.0, -49044.3)
local distance = (rootPart.Position - targetPosition).Magnitude
local time = distance / 13

local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
local goal = {Position = targetPosition}
local tween = TweenService:Create(rootPart, tweenInfo, goal)

tween:Play()
    end
})



andtab:AddButton({
    Title = "my tp to end",
    Description = "Meu tp para o fim, em desenvolvimento mas funciona",
    Callback = function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local runService = game:GetService("RunService")
        local camera = workspace.CurrentCamera

        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local targetPos = Vector3.new(-424.4, 28.1, -49040.7)

        task.spawn(function()
            for i = 1, 90 do
                hrp.CFrame = CFrame.new(targetPos)
                task.wait(0.1)
            end
        end)

        local aimLockLoop

        local function stopAimLock()
            if aimLockLoop then
                aimLockLoop:Disconnect()
                aimLockLoop = nil
            end
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
            end
        end

        local function startAimLock()
            stopAimLock()

            aimLockLoop = runService.RenderStepped:Connect(function()
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

                local closestNPC = nil
                local closestDistance = math.huge

                for _, npc in ipairs(workspace:GetDescendants()) do
                    if npc:IsA("Model") and npc ~= player.Character and not Players:GetPlayerFromCharacter(npc) then
                        local humanoid = npc:FindFirstChildOfClass("Humanoid")
                        local hrp = npc:FindFirstChild("HumanoidRootPart")

                        if humanoid and hrp and humanoid.Health > 0 then
                            local distance = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestNPC = npc
                            end
                        end
                    end
                end

                if closestNPC then
                    camera.CameraSubject = closestNPC:FindFirstChildOfClass("Humanoid")
                else
                    camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                end
            end)
        end

        player.CameraMode = Enum.CameraMode.Classic
        startAimLock()

        local RunService = game:GetService("RunService")
        local noclip = true

        RunService.Stepped:Connect(function()
            if noclip and character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide == true then
                        part.CanCollide = false
                    end
                end
            end
        end)

        local TweenService = game:GetService("TweenService")
        local humanoid = character:WaitForChild("Humanoid")
    end
  task.delay(10.5, function()
	stopAimLock()
end)


  
})









   
andtab:AddParagraph({
      Title = "Em breve",
      Content = "Em breve terá mais funcionalidades por aqui!"
   })



local BondsTab = Window:AddTab({ Title = "aimbot", Icon = "list" })

BondsTab:AddToggle("AimLockToggle", {
    Title = "AimLock NPC",
    Description = "Tranca a câmera no NPC mais próximo",
    Default = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local runService = game:GetService("RunService")
        local camera = workspace.CurrentCamera

        if not _G.AimLockData then
            _G.AimLockData = { Loop = nil }
        end

        local function stopAimLock()
            if _G.AimLockData.Loop then
                _G.AimLockData.Loop:Disconnect()
                _G.AimLockData.Loop = nil
            end
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
            end
        end

        local function startAimLock()
            stopAimLock()
            
            _G.AimLockData.Loop = runService.RenderStepped:Connect(function()
                if not state then return stopAimLock() end
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                
                local closestNPC = nil
                local closestDistance = math.huge
                
                for _, npc in ipairs(workspace:GetDescendants()) do
                    if npc:IsA("Model") and npc ~= player.Character then
                        local humanoid = npc:FindFirstChildOfClass("Humanoid")
                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid and hrp and humanoid.Health > 0 then
                            local distance = (hrp.Position - player.Character.HumanoidRootPart.Position).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestNPC = npc
                            end
                        end
                    end
                end
                
                if closestNPC then
                    camera.CameraSubject = closestNPC:FindFirstChildOfClass("Humanoid")
                else
                    camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                end
            end)
        end

        if state then
            player.CameraMode = Enum.CameraMode.Classic
            startAimLock()
        else
            stopAimLock()
        end
    end
})

BondsTab:AddParagraph({
      Title = "Em breve",
      Content = "Em breve terá mais funcionalidades por aqui!"
   })














local creditos = Window:AddTab({ Title = "Créditos", Icon = "list" })

   creditos:AddParagraph({
      Title = "Créditos de criação do script:",
      Content = "TPs (fim do jogo, Starling) feito por ringtaa"
   })

   creditos:AddParagraph({
      Title = "Créditos de criação do script:",
      Content = "Aimbot,Funções do train, TPs (maioria) feito por Lucas"
   })
