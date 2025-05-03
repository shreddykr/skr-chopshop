--Thanks for downloading
--Check Github for Updates


░██████╗██╗░░██╗██████╗░░░░░░░░█████╗░██╗░░██╗░█████╗░██████╗░░██████╗██╗░░██╗░█████╗░██████╗░
██╔════╝██║░██╔╝██╔══██╗░░░░░░██╔══██╗██║░░██║██╔══██╗██╔══██╗██╔════╝██║░░██║██╔══██╗██╔══██╗
╚█████╗░█████═╝░██████╔╝█████╗██║░░╚═╝███████║██║░░██║██████╔╝╚█████╗░███████║██║░░██║██████╔╝
░╚═══██╗██╔═██╗░██╔══██╗╚════╝██║░░██╗██╔══██║██║░░██║██╔═══╝░░╚═══██╗██╔══██║██║░░██║██╔═══╝░
██████╔╝██║░╚██╗██║░░██║░░░░░░╚█████╔╝██║░░██║╚█████╔╝██║░░░░░██████╔╝██║░░██║╚█████╔╝██║░░░░░
╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░░░░░░░╚════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░


Config = {}

Config.Debug = false

-------------------------------------------------------------------------------------------------------------------------

Config.TargetingSystem = "ox_target" -- Options: "ox_target", "qb_target"

Config.FuelSystem = 'lc_fuel' -- Select the fuel system to use: 'LegacyFuel', 'cdn-fuel', or 'lc_fuel'

-------------------------------------------------------------------------------------------------------------------------

Config.RewardRange = {min = 500, max = 1500}

Config.DeliveryRadius = 10.0

Config.InteractionDistance = 2.5

-------------------------------------------------------------------------------------------------------------------------

Config.MissionTimeout = 1800 -- Timeout for mission completion in seconds (default: 1800 seconds = 30 minutes)

Config.SellCooldown = 300 -- Cooldown in sec1800onds before player can sell another stolen car (e.g., 300 seconds = 5 minutes)

Config.SellVehicleEnabled = true -- Only allows missions?

-------------------------------------------------------------------------------------------------------------------------

Config.Ped = { --Multiple PEDS not supported
    model = "g_m_m_armgoon_01", --PED Model
    location = vector4(476.4, -1315.28, 28.225, 255.99), -- Hayes Auto by MRPD
    scenario = "WORLD_HUMAN_SMOKING" -- Ped animation
}

-------------------------------------------------------------------------------------------------------------------------

Config.DeliveryLocations = { -- Add More Here
    -- Hayes Auto by MRPD
    vector4(476.4, -1315.28, 28.225, 255.99),
}

-------------------------------------------------------------------------------------------------------------------------

-- Chopshop mission system
Config.Mission = {
    Radius = 100.0, -- How large the search area is for finding the vehicle
    Cooldown = 300, -- Time between missions (in seconds)

    Blip = {
        Sprite = 161,
        Color = 1,
        Alpha = 100
    },

    VehicleModels = {
        -- X80Prototype
        "prototipo",
    },

    SpawnLocations = { -- Add More Here
        -- Mission Row PD
        vector4(408.05, -998.15, 29.27, 52.46),

    }    
}
