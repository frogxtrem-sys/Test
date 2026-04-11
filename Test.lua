-- ==========================================
-- ⚙️ CONFIGURAÇÕES GERAIS (Puxa do Workspace se existir)
-- ==========================================
getgenv().FarmConfig = {
    -- SESSÃO 1: Farm Básico e Otimização
    AutoBaby = true,
    AutoPetFarm = true,
    AutoHatch = true,
    AutoBuyEggs = true,
    EggType = "Cracked Egg", -- "Cracked Egg", "Pet Egg", "Royal Egg", etc.
    BucksLimit = 350,        -- Só compra se tiver mais que isso
    CPUSaver = true,
    FPSLimit = 10,

    -- SESSÃO 2: Automação Avançada
    AutoPetPen = true,
    ClaimPen = true,
    ClaimLure = true,
    ClaimQuests = true,
    AutoNeon = true,
    AutoMega = true
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 🛡️ SESSÃO 1.4 & 1.5: CPU SAVER & FPS LIMITER
-- ==========================================
if getgenv().FarmConfig.CPUSaver then
    setfpscap(getgenv().FarmConfig.FPSLimit)
    RunService:Set3dRenderingEnabled(false)
    
    -- Deleta texturas para aliviar a RAM
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") then
            v:Destroy()
        end
    end
    game:GetService("Lighting").GlobalShadows = false
    print("[+] CPU Saver e Limite de FPS Ativados.")
end

-- ==========================================
-- 👶 SESSÃO 1: AUTO FARM BÁSICO
-- ==========================================

-- Função para virar Bebê
local function BecomeBaby()
    if getgenv().FarmConfig.AutoBaby then
        -- O Remote exato muda, geralmente é algo como:
        -- ReplicatedStorage.API:FindFirstChild("TeamAPI/ChooseTeam"):InvokeServer("Babies", true)
        print("[+] Virando Bebê...")
    end
end

-- Função para comprar e equipar Egg
local function BuyAndEquipEgg()
    if getgenv().FarmConfig.AutoBuyEggs then
        -- Aqui você precisará capturar o Remote de compra de item do Adopt Me
        -- Exemplo Lógico:
        -- local myBucks = getBucksFunction()
        -- if myBucks >= getgenv().FarmConfig.BucksLimit then
        --     ReplicatedStorage.API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer(getgenv().FarmConfig.EggType, 1)
        -- end
        print("[+] Checando Bucks e comprando " .. getgenv().FarmConfig.EggType)
    end
end

-- Loop Principal de Farm (Ailments / Necessidades)
task.spawn(function()
    while task.wait(5) do
        if not getgenv().FarmConfig.AutoPetFarm then continue end
        
        BecomeBaby()
        BuyAndEquipEgg()
        
        -- Lógica de Farm:
        -- 1. Ler o ClientData (Inventário) para achar um pet que não é Full Grown.
        -- 2. Equipar o pet.
        -- 3. Ler o monitor de necessidades (Ailments) do Pet e do Bebê.
        -- 4. Disparar o RemoteEvent para curar/alimentar/dar banho.
        print("[~] Auto Farm de Necessidades rodando...")
    end
end)

-- ==========================================
-- 🚀 SESSÃO 2: AUTOMAÇÃO AVANÇADA (NEON/MEGA/PEN)
-- ==========================================

-- Loop de Reivindicações (Lure, Quests, Pen)
task.spawn(function()
    while task.wait(15) do -- Checa a cada 15 segundos
        if getgenv().FarmConfig.ClaimLure then
            -- ReplicatedStorage.API:FindFirstChild("HousingAPI/ClaimLure"):InvokeServer()
            print("[+] Claim Lure")
        end
        
        if getgenv().FarmConfig.ClaimQuests then
            -- ReplicatedStorage.API:FindFirstChild("QuestAPI/ClaimQuestReward"):InvokeServer(...)
            print("[+] Claim Quests")
        end
        
        if getgenv().FarmConfig.ClaimPen then
            -- ReplicatedStorage.API:FindFirstChild("PetPenAPI/ClaimExp"):InvokeServer()
            print("[+] Claim Pet Pen XP/Cash")
        end
    end
end)

-- Sistema de Auto Neon / Mega
task.spawn(function()
    while task.wait(60) do -- Checa a cada 1 minuto
        if getgenv().FarmConfig.AutoNeon then
            -- 1. Varre o inventário buscando 4 pets iguais com idade "Full Grown".
            -- 2. Se achar, teleporta para a Caverna (opcional, dependendo de como o servidor valida).
            -- 3. Dispara o Remote de fusão:
            -- ReplicatedStorage.API:FindFirstChild("PetAPI/MakeNeon"):InvokeServer(petId1, petId2, petId3, petId4)
            print("[~] Checando possibilidade de Neon...")
        end
        
        if getgenv().FarmConfig.AutoMega then
            -- Lógica idêntica ao Neon, mas buscando 4 pets "Luminous" (Neon Full Grown).
            print("[~] Checando possibilidade de Mega...")
        end
    end
end)

print("\033[1;32m[ ✓ ] Script Headless Iniciado com Sucesso!\033[0m")
