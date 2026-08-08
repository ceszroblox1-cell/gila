-- ============================================================
--  UTILS – AntiAFK, FPS Boost, Webhook, Config Save/Load
-- ============================================================

local Utils = {}

-- State
local antiAFK = false
local fpsBoost = false
local fpsCap = 240

-- Getter/Setter
function Utils.getAntiAFK() return antiAFK end
function Utils.setAntiAFK(v) antiAFK = v end
function Utils.getFpsBoost() return fpsBoost end
function Utils.setFpsBoost(v) fpsBoost = v end
function Utils.getFpsCap() return fpsCap end
function Utils.setFpsCap(v) fpsCap = v end

-- Anti AFK
function Utils.antiAFKLoop()
    if antiAFK then
        -- Simulasi gerakan kamera atau tombol
        local vim = game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true, Enum.KeyCode.W, false, game)
        wait(0.1)
        vim:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end
end

-- FPS Boost
function Utils.fpsBoostLoop()
    if fpsBoost then
        -- Contoh: matikan efek, partikel, dll
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("ParticleEmitter") then v.Enabled = false end
                if v:IsA("Decal") and v.Name ~= "important" then v:Destroy() end
            end
            settings().Rendering.QualityLevel = 1
        end)
        -- Set FPS cap (jika executor support)
        if setfpscap then setfpscap(fpsCap) end
    end
end

-- Webhook (placeholder)
function Utils.sendWebhook(message)
    -- Implementasi dengan HttpService
    -- ...
end

-- Config Save/Load (placeholder)
function Utils.saveConfig()
    -- Simpan ke file (jika executor support)
end

function Utils.loadConfig()
    -- Muat dari file
end

return Utils