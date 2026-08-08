-- ============================================================
--  ECONOMY – AutoSell, AutoBuy, DoubleOrNothing, dll
-- ============================================================

local Economy = {}

-- State
local autoSell = false
local autoBuySeed = false
local autoDoubleOrNothing = false
local buySeeds = {"Carrot"}
local sellWhitelist = {}

-- Getter/Setter
function Economy.getAutoSell() return autoSell end
function Economy.setAutoSell(v) autoSell = v end
function Economy.getAutoBuySeed() return autoBuySeed end
function Economy.setAutoBuySeed(v) autoBuySeed = v end
function Economy.getAutoDoubleOrNothing() return autoDoubleOrNothing end
function Economy.setAutoDoubleOrNothing(v) autoDoubleOrNothing = v end

-- Jual semua
function Economy.sellAllNow()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local sellEvent = remote:FindFirstChild("SellFruit")
        if sellEvent then
            pcall(function()
                sellEvent:FireServer()
                print("[Economy] Sell All executed.")
            end)
        end
    end
end

function Economy.sellLoop()
    if autoSell then
        Economy.sellAllNow()
        wait(15)  -- interval
    end
end

-- Beli seed
function Economy.buySeedNow()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local buyEvent = remote:FindFirstChild("BuySeed")
        if buyEvent then
            for _, seed in ipairs(buySeeds) do
                pcall(function()
                    buyEvent:FireServer(seed)
                    print("[Economy] Bought " .. seed)
                    wait(0.3)
                end)
            end
        end
    end
end

function Economy.buySeedLoop()
    if autoBuySeed then
        Economy.buySeedNow()
        wait(5)
    end
end

-- Double or Nothing
function Economy.gambleNow()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    if remote then
        local gambleEvent = remote:FindFirstChild("DoubleOrNothing")
        if gambleEvent then
            pcall(function()
                gambleEvent:FireServer()
                print("[Economy] Gamble executed.")
            end)
        end
    end
end

function Economy.doubleOrNothingLoop()
    if autoDoubleOrNothing then
        Economy.gambleNow()
        wait(30)
    end
end

return Economy