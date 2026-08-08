-- ============================================================
--  CONFIG – Template pengaturan (bisa di-load otomatis)
-- ============================================================

return {
    -- Farming
    AutoHarvest = false,
    AutoPlant = false,
    AutoWater = false,
    HarvestMutationOnly = false,
    HarvestMinValue = 0,
    PlantSeeds = {"Carrot", "Maple Corn"},
    WaterInterval = 20,

    -- Economy
    AutoSell = false,
    AutoBuySeed = false,
    AutoDoubleOrNothing = false,
    BuySeeds = {"Carrot"},
    SellWhitelist = {},

    -- Pets
    AutoBuyPet = false,
    AutoEquipBest = false,
    AutoSellPets = false,
    PetSpecies = {},

    -- Steal
    AutoSteal = false,
    AntiSteal = false,
    StealMode = "Any",
    StealMinValue = 100,

    -- Loot
    AutoPickup = false,
    AutoClaimMail = false,
    AutoOpenCrates = false,

    -- Utility
    AntiAFK = false,
    FpsBoost = false,
    FpsCap = 240,
}