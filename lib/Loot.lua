-- ============================================================
--  LOOT – Grab, Pickup, Claim Mail, Open Crates
-- ============================================================

local Loot = {}

-- State
local autoPickup = false
local autoClaimMail = false
local autoOpenCrates = false

-- Getter/Setter
function Loot.getAutoPickup() return autoPickup end
function Loot.setAutoPickup(v) autoPickup = v end
function Loot.getAutoClaimMail() return autoClaimMail end
function Loot.setAutoClaimMail(v) autoClaimMail = v end

-- Pickup loop
function Loot.pickupLoop()
    if autoPickup then
        -- Ambil semua item di tanah
        print("[Loot] Picking up...")
        wait(2)
    end
end

-- Claim mail
function Loot.claimMailLoop()
    if autoClaimMail then
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
        if remote then
            local mailEvent = remote:FindFirstChild("ClaimMail")
            if mailEvent then
                pcall(function()
                    mailEvent:FireServer()
                    print("[Loot] Mail claimed.")
                end)
            end
        end
        wait(30)
    end
end

-- Open crates
function Loot.openAllCrates()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local openEvent = remote:FindFirstChild("OpenCrate")
        if openEvent then
            pcall(function()
                openEvent:FireServer()
                print("[Loot] Opened crate.")
            end)
        end
    end
end

return Loot