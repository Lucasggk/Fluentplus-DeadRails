repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
 
local Fluent = loadstring(Game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua", true))()

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

repeat task.wait() until game:IsLoaded()

-- Configuração inicial
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- Configuração da UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../bondslib.lua"))() -- Substitua pelo link real
local Window = Library:CreateWindow("Seu Hack Menu")
local BondsTab = Window:AddTab({ Title = "aimbot", Icon = "list" })

-- Variáveis do NPC Lock
local npcLock = false
local lastTarget = nil
local toggleLoop

-- Funções auxiliares
local function adicionarDestaque()
    if player.Character then
        local highlight = player.Character:FindFirstChild("PlayerHighlightESP")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "PlayerHighlightESP"
            highlight.FillColor = Color3.new(1, 0, 0) -- Vermelho
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
        end
    end
end

local function removerDestaque()
    if player.Character and player.Character:FindFirstChild("PlayerHighlightESP") then
        player.Character.PlayerHighlightESP:Destroy()
    end
end

local function encontrarNPCMaisProximo()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local npcMaisProximo = nil
    local menorDistancia = math.huge
    local posicaoJogador = player.Character.HumanoidRootPart.Position

    for _, objeto in ipairs(workspace:GetDescendants()) do
        if objeto:IsA("Model") then
            local humanoid = objeto:FindFirstChildOfClass("Humanoid")
            local hrp = objeto:FindFirstChild("HumanoidRootPart") or objeto.PrimaryPart
            
            if humanoid and hrp and humanoid.Health > 0 then
                -- Verificar se não é um jogador
                local ehJogador = false
                for _, jogador in ipairs(Players:GetPlayers()) do
                    if jogador.Character == objeto then
                        ehJogador = true
                        break
                    end
                end
                
                if not ehJogador then
                    local distancia = (hrp.Position - posicaoJogador).Magnitude
                    if distancia < menorDistancia then
                        menorDistancia = distancia
                        npcMaisProximo = objeto
                    end
                end
            end
        end
    end

    return npcMaisProximo
end

-- Adicionar o toggle ao BondsTab
BondsTab:AddToggle({
    Title = "NPC Lock",
    Default = false,
    Callback = function(estado)
        npcLock = estado
        
        -- Limpar conexão existente
        if toggleLoop then
            toggleLoop:Disconnect()
        end
        
        if npcLock then
            toggleLoop = runService.RenderStepped:Connect(function()
                local npc = encontrarNPCMaisProximo()
                
                if npc and npc:FindFirstChildOfClass("Humanoid") then
                    local humanoidNPC = npc:FindFirstChildOfClass("Humanoid")
                    if humanoidNPC.Health > 0 then
                        camera.CameraSubject = humanoidNPC
                        lastTarget = npc
                        adicionarDestaque()
                    else
                        lastTarget = nil
                        removerDestaque()
                        camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    end
                else
                    camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    lastTarget = nil
                    removerDestaque()
                end
            end)
        else
            -- Resetar quando desligado
            camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            removerDestaque()
        end
    end
})

-- Configuração adicional (opcional)
BondsTab:AddButton({
    Title = "Resetar Câmera",
    Callback = function()
        if player.Character then
            camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
        end
    end
})

print("Menu Aimbot carregado com sucesso!")


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

tabpt:AddToggle("starlingtoggle", {
    Title = "Tp starling",
    Description = " TP para starling",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ringtaa/sterlingnotifcation.github.io/refs/heads/main/Sterling.lua'))()
            end
    end
})

tabpt:AddToggle("banktoggle", {
    Title = "Tp Bank",
    Description = " TP para o banco mais próximo",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/Tptobank.github.io/refs/heads/main/Banktp.lua"))()
            end
    end
})

tabpt:AddToggle("endtoggle", {
    Title = "Tp to end",
    Description = " TP para o final",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/newpacifisct/refs/heads/main/newpacifisct.lua"))()
            end
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
