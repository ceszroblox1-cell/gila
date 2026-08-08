-- ============================================================
--  GAG2 AutoFarm – Main Loader & UI
--  (c) 2025 – Load all modules from raw GitHub
-- ============================================================

local repoUrl = "https://raw.githubusercontent.com/ceszroblox1-cell/gila/refs/heads/main/lib/"  -- GANTI DENGAN URL REPO ANDA

-- Fungsi untuk memuat modul dengan error handling
local function loadModule(name)
    local url = repoUrl .. name .. ".lua"
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        print("[MAIN] Module " .. name .. " loaded.")
    else
        warn("[MAIN] Gagal load " .. name .. ": " .. tostring(result))
    end
    return result
end

-- Muat semua modul secara urut (Utils harus pertama)
local Utils = loadModule("Utils")
local Farming = loadModule("Farming")
local Economy = loadModule("Economy")
local Pets = loadModule("Pets")
local Steal = loadModule("Steal")
local Loot = loadModule("Loot")

-- Gabungkan semua fungsi ke dalam tabel global (opsional)
_G.GAG2 = {
    Utils = Utils,
    Farming = Farming,
    Economy = Economy,
    Pets = Pets,
    Steal = Steal,
    Loot = Loot,
}

-- Fungsi untuk menampilkan GUI utama (menggunakan UI library dari Utils atau built-in)
local function createMainUI()
    -- Buat ScreenGui dan Frame utama
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GAG2_UI"
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "🌱 GAG2 AutoFarm v2.0"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = mainFrame

    -- Tombol Close
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.1, 0, 0.07, 0)
    closeBtn.Position = UDim2.new(0.9, 0, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Scrolling frame untuk banyak tombol
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(0.95, 0, 0.8, 0)
    scrollFrame.Position = UDim2.new(0.025, 0, 0.12, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.Parent = mainFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scrollFrame

    -- Fungsi bikin toggle
    local function createToggle(parent, label, getter, setter)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 30)
        frame.BackgroundTransparency = 1
        frame.Parent = parent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.7, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Font = Enum.Font.SourceSans
        lbl.TextSize = 14
        lbl.Parent = frame

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.2, 0, 1, 0)
        btn.Position = UDim2.new(0.8, 0, 0, 0)
        btn.BackgroundColor3 = getter() and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
        btn.Text = getter() and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 14
        btn.Parent = frame

        btn.MouseButton1Click:Connect(function()
            local newVal = not getter()
            setter(newVal)
            btn.BackgroundColor3 = newVal and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
            btn.Text = newVal and "ON" or "OFF"
        end)
    end

    -- Fungsi bikin tombol aksi
    local function createButton(parent, label, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        btn.Text = label
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 14
        btn.Parent = parent
        btn.MouseButton1Click:Connect(callback)
    end

    -- --- Tambahkan Toggle & Button ---
    -- Farming
    createToggle(scrollFrame, "Auto Harvest", function() return Farming.getAutoHarvest() end, function(v) Farming.setAutoHarvest(v) end)
    createToggle(scrollFrame, "Auto Plant", function() return Farming.getAutoPlant() end, function(v) Farming.setAutoPlant(v) end)
    createToggle(scrollFrame, "Auto Water", function() return Farming.getAutoWater() end, function(v) Farming.setAutoWater(v) end)
    createToggle(scrollFrame, "Harvest Mutation Only", function() return Farming.getHarvestMutationOnly() end, function(v) Farming.setHarvestMutationOnly(v) end)

    -- Economy
    createToggle(scrollFrame, "Auto Sell", function() return Economy.getAutoSell() end, function(v) Economy.setAutoSell(v) end)
    createToggle(scrollFrame, "Auto Buy Seed", function() return Economy.getAutoBuySeed() end, function(v) Economy.setAutoBuySeed(v) end)
    createToggle(scrollFrame, "Auto Double or Nothing", function() return Economy.getAutoDoubleOrNothing() end, function(v) Economy.setAutoDoubleOrNothing(v) end)

    -- Pets
    createToggle(scrollFrame, "Auto Buy Pet", function() return Pets.getAutoBuyPet() end, function(v) Pets.setAutoBuyPet(v) end)
    createToggle(scrollFrame, "Auto Equip Best", function() return Pets.getAutoEquipBest() end, function(v) Pets.setAutoEquipBest(v) end)
    createToggle(scrollFrame, "Auto Sell Pets", function() return Pets.getAutoSellPets() end, function(v) Pets.setAutoSellPets(v) end)

    -- Steal
    createToggle(scrollFrame, "Auto Steal", function() return Steal.getAutoSteal() end, function(v) Steal.setAutoSteal(v) end)
    createToggle(scrollFrame, "Anti Steal", function() return Steal.getAntiSteal() end, function(v) Steal.setAntiSteal(v) end)

    -- Loot
    createToggle(scrollFrame, "Auto Pickup", function() return Loot.getAutoPickup() end, function(v) Loot.setAutoPickup(v) end)
    createToggle(scrollFrame, "Auto Claim Mail", function() return Loot.getAutoClaimMail() end, function(v) Loot.setAutoClaimMail(v) end)

    -- Utility
    createToggle(scrollFrame, "Anti AFK", function() return Utils.getAntiAFK() end, function(v) Utils.setAntiAFK(v) end)
    createToggle(scrollFrame, "FPS Boost", function() return Utils.getFpsBoost() end, function(v) Utils.setFpsBoost(v) end)

    -- Tombol aksi manual
    createButton(scrollFrame, "🌾 Harvest Now", function() Farming.harvestNow() end)
    createButton(scrollFrame, "🌱 Plant Now", function() Farming.plantNow() end)
    createButton(scrollFrame, "💰 Sell All Now", function() Economy.sellAllNow() end)
    createButton(scrollFrame, "🎲 Gamble Now", function() Economy.gambleNow() end)
    createButton(scrollFrame, "📦 Open All Crates", function() Loot.openAllCrates() end)
    createButton(scrollFrame, "🐾 Check Pets", function() Pets.checkThisServer() end)

    -- Footer
    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, 0, 0, 20)
    footer.Position = UDim2.new(0, 0, 0.95, 0)
    footer.BackgroundTransparency = 1
    footer.Text = "v2.0 | by CESZ"
    footer.TextColor3 = Color3.fromRGB(150, 150, 150)
    footer.TextScaled = true
    footer.Font = Enum.Font.SourceSans
    footer.Parent = mainFrame

    print("[UI] GUI siap!")
end

-- Jalankan UI
spawn(createMainUI)

-- Mulai semua loop otomatis (jika diaktifkan)
spawn(function()
    while wait(1) do
        -- Farming loop
        if Farming.getAutoHarvest() then Farming.harvestLoop() end
        if Farming.getAutoPlant() then Farming.plantLoop() end
        if Farming.getAutoWater() then Farming.waterLoop() end
        -- Economy loop
        if Economy.getAutoSell() then Economy.sellLoop() end
        if Economy.getAutoBuySeed() then Economy.buySeedLoop() end
        if Economy.getAutoDoubleOrNothing() then Economy.doubleOrNothingLoop() end
        -- Pets loop
        if Pets.getAutoBuyPet() then Pets.buyPetLoop() end
        if Pets.getAutoEquipBest() then Pets.equipBestLoop() end
        if Pets.getAutoSellPets() then Pets.sellPetsLoop() end
        -- Steal loop
        if Steal.getAutoSteal() then Steal.stealLoop() end
        if Steal.getAntiSteal() then Steal.antiStealLoop() end
        -- Loot loop
        if Loot.getAutoPickup() then Loot.pickupLoop() end
        if Loot.getAutoClaimMail() then Loot.claimMailLoop() end
        -- Utils
        if Utils.getAntiAFK() then Utils.antiAFKLoop() end
        if Utils.getFpsBoost() then Utils.fpsBoostLoop() end
    end
end)

print("[MAIN] Skrip GAG2 siap digunakan!")
