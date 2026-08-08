-- ============================================================
--  FARMING – AutoHarvest, AutoPlant, AutoWater (FIXED)
-- ============================================================

local Farming = {}

-- State
local autoHarvest = false
local autoPlant = false
local autoWater = false
local harvestMutationOnly = false
local plantSeeds = {"Carrot", "Maple Corn"}  -- ganti sesuai keinginan
local waterInterval = 20

-- Getter/Setter
function Farming.getAutoHarvest() return autoHarvest end
function Farming.setAutoHarvest(v) autoHarvest = v end
function Farming.getAutoPlant() return autoPlant end
function Farming.setAutoPlant(v) autoPlant = v end
function Farming.getAutoWater() return autoWater end
function Farming.setAutoWater(v) autoWater = v end
function Farming.getHarvestMutationOnly() return harvestMutationOnly end
function Farming.setHarvestMutationOnly(v) harvestMutationOnly = v end

-- Fungsi untuk mencari remote event dengan nama yang mungkin berbeda
local function findRemote(eventName)
    local remoteFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
        or game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        or game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if remoteFolder then
        local event = remoteFolder:FindFirstChild(eventName)
        if event then
            return event
        end
        -- Coba cari event di seluruh ReplicatedStorage jika tidak ditemukan di folder
        for _, child in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if child.Name == eventName and child:IsA("RemoteEvent") then
                return child
            end
        end
    end
    return nil
end

-- Fungsi panen
function Farming.harvestNow()
    local harvestEvent = findRemote("Harvest") or findRemote("HarvestPlant") or findRemote("CollectFruit")
    if harvestEvent then
        pcall(function()
            harvestEvent:FireServer()
            print("[Farming] Harvest Now executed.")
        end)
    else
        warn("[Farming] Harvest event tidak ditemukan! Cek nama remote.")
    end
end

function Farming.harvestLoop()
    if autoHarvest then
        Farming.harvestNow()
        wait(0.5)
    end
end

-- Fungsi tanam
function Farming.plantNow()
    local plantEvent = findRemote("PlantSeed") or findRemote("Plant") or findRemote("PlantSeedling")
    if plantEvent then
        for _, seed in ipairs(plantSeeds) do
            pcall(function()
                plantEvent:FireServer(seed)
                print("[Farming] Plant " .. seed)
                wait(0.3)
            end)
        end
    else
        warn("[Farming] Plant event tidak ditemukan!")
    end
end

function Farming.plantLoop()
    if autoPlant then
        Farming.plantNow()
        wait(1)
    end
end

-- Fungsi siram
function Farming.waterNow()
    local waterEvent = findRemote("WaterPlant") or findRemote("Water") or findRemote("WaterSeed")
    if waterEvent then
        pcall(function()
            waterEvent:FireServer()
            print("[Farming] Water Now executed.")
        end)
    else
        warn("[Farming] Water event tidak ditemukan!")
    end
end

function Farming.waterLoop()
    if autoWater then
        Farming.waterNow()
        wait(waterInterval)
    end
end

return Farming
