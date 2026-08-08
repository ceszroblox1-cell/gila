-- ============================================================
--  PETS – AutoBuy, Equip, Sell, Find
-- ============================================================

local Pets = {}

-- State
local autoBuyPet = false
local autoEquipBest = false
local autoSellPets = false
local petSpecies = {}

-- Getter/Setter
function Pets.getAutoBuyPet() return autoBuyPet end
function Pets.setAutoBuyPet(v) autoBuyPet = v end
function Pets.getAutoEquipBest() return autoEquipBest end
function Pets.setAutoEquipBest(v) autoEquipBest = v end
function Pets.getAutoSellPets() return autoSellPets end
function Pets.setAutoSellPets(v) autoSellPets = v end

-- Buy pet (tame)
function Pets.buyPetNow()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local tameEvent = remote:FindFirstChild("TamePet")
        if tameEvent then
            pcall(function()
                tameEvent:FireServer()
                print("[Pets] Tame executed.")
            end)
        end
    end
end

function Pets.buyPetLoop()
    if autoBuyPet then
        Pets.buyPetNow()
        wait(3)
    end
end

-- Equip best
function Pets.equipBestNow()
    -- Logic untuk cari pet tertinggi di inventory dan equip
    print("[Pets] Equip best triggered.")
end

function Pets.equipBestLoop()
    if autoEquipBest then
        Pets.equipBestNow()
        wait(10)
    end
end

-- Sell junk pets
function Pets.sellPetsNow()
    -- Logic jual pet dengan nilai di bawah threshold
    print("[Pets] Sell junk pets triggered.")
end

function Pets.sellPetsLoop()
    if autoSellPets then
        Pets.sellPetsNow()
        wait(10)
    end
end

-- Check server for wanted pets
function Pets.checkThisServer()
    print("[Pets] Scanning server for wanted pets...")
end

return Pets