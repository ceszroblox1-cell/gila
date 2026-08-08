-- ============================================================
--  STEAL – AutoSteal, AntiSteal, AutoFling
-- ============================================================

local Steal = {}

-- State
local autoSteal = false
local antiSteal = false
local stealMode = "Any"
local stealMinValue = 100

-- Getter/Setter
function Steal.getAutoSteal() return autoSteal end
function Steal.setAutoSteal(v) autoSteal = v end
function Steal.getAntiSteal() return antiSteal end
function Steal.setAntiSteal(v) antiSteal = v end

-- Steal loop
function Steal.stealLoop()
    if autoSteal then
        -- Cari buah di kebun lain, curi
        print("[Steal] Stealing...")
        wait(1)
    end
end

-- Anti steal (hit back)
function Steal.antiStealLoop()
    if antiSteal then
        -- Deteksi pencuri di kebun sendiri, pukul
        print("[Steal] Anti-steal active.")
        wait(1)
    end
end

return Steal