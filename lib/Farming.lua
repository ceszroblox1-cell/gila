-- ============================================================
--  FARMING – AutoHarvest, AutoPlant, AutoWater, dll
-- ============================================================

local Farming = {}

-- State
local autoHarvest = false
local autoPlant = false
local autoWater = false
local harvestMutationOnly = false
local harvestMinValue = 0
local plantSeeds = {"Carrot"}  -- contoh
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

-- Fungsi panen
function Farming.harvestNow()
    -- Cari remote dan kirim perintah panen
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local harvestEvent = remote:FindFirstChild("Harvest")
        if harvestEvent then
            pcall(function()
                harvestEvent:FireServer()
                print("[Farming] Harvest Now executed.")
            end)
        end
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
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local plantEvent = remote:FindFirstChild("PlantSeed")
        if plantEvent then
            for _, seed in ipairs(plantSeeds) do
                pcall(function()
                    plantEvent:FireServer(seed)
                    print("[Farming] Plant " .. seed)
                    wait(0.2)
                end)
            end
        end
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
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local waterEvent = remote:FindFirstChild("WaterPlant")
        if waterEvent then
            pcall(function()
                waterEvent:FireServer()
                print("[Farming] Water Now executed.")
            end)
        end
    end
end

function Farming.waterLoop()
    if autoWater then
        Farming.waterNow()
        wait(waterInterval)
    end
end

return Farming