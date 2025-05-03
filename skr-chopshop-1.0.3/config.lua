Config = {}

Config.Debug = false -- Toggle debug mode only if you know what to do after

Config.TargetingSystem = "ox_target" -- Options: "ox_target", "qb_target"

Config.SellVehicleEnabled = true -- Turn on and off selling random stolen vehicles -- only allows missions

Config.Ped = {
    model = "g_m_m_armgoon_01", -- Ped model for the chopshop NPC
    location = vector4(476.4, -1315.28, 28.225, 255.99), -- Hayes Auto by MRPD
    scenario = "WORLD_HUMAN_SMOKING" -- Ped animation scenario
}

-- Chopshop mission system
Config.Mission = {
    Radius = 100.0, -- How large the search area is for finding the vehicle
    Cooldown = 900, -- Time between missions (in seconds)

    Blip = {
        Sprite = 161,
        Color = 1,
        Alpha = 100
    },

    VehicleModels = {
        "prototipo",   -- Progen T20
        "osiris",      -- Pegassi Osiris
        "sheava",      -- Truffade Nero
        "entity2",     -- Entity XXR
        "reaper",      -- Pegassi Reaper
        "tezeract",    -- Ocelot Tezeract
        "nero",        -- Truffade Nero
        "italigtb",    -- Itali GTB
        "vacca",       -- Pegassi Vacca
        "torero",      -- Pegassi Torero
        "t20",         -- Progen T20
        "lynx",        -- Ocelot Lynx
        "jester",      -- Dinka Jester
        "autarch",     -- Pegassi Autarch
        "jester2",     -- Dinka Jester (2nd Version)
        
        -- Southern San Andreas Super Autos
        "sultan",      -- Sultan RS
        "comet2",      -- Comet (2nd version)
        "dominator",   -- Dominator
        "buffalo4",    -- Buffalo STX
        "kuruma",      -- Kuruma (Normal and Armored)
        "tailgater2",  -- Tailgater S
        "drafter",     -- Drafter
        "penumbra2",   -- Penumbra FF
        "elegy",       -- Elegy Retro Custom
        "schlagen",    -- Schlagen GT
        "vectre",      -- Vectre
        "previon",     -- Previon
        "zr350",       -- ZR350
        "euros",       -- Euros
        "remus",       -- Remus
        "growler",     -- Growler
        "rt3000",      -- RT3000
        "sultanrs",    -- Sultan RS
        "calico",      -- Calico GTF
        "jester4",     -- Jester (4th version)
        "futo2",       -- Futo GTX
        "banshee2",    -- Banshee 900R
    },

    --Locations are being updated in 1.0.4
    SpawnLocations = {
        -- Vinewood Hills - Upscale parking
        vector4(1045.87, 2587.56, 37.76, 180.00), -- Heading south
        
        -- Los Santos International Airport (LSIA) - Airport parking
        vector4(-1044.61, -2757.45, 20.43, 90.00), -- Heading east
        
        -- Maze Bank Arena - Arena parking lot
        vector4(-234.85, -1014.85, 29.29, 270.00), -- Heading west
        
        -- Downtown Los Santos - Parking near office buildings
        vector4(225.52, -808.63, 30.73, 270.00), -- Heading west
        
        -- Mirror Park - Residential parking
        vector4(1143.63, -1641.16, 36.49, 0.00), -- Heading north
        
        -- Davis - Street parking
        vector4(278.94, -1963.91, 22.22, 180.00), -- Heading south
        
        -- Sandy Shores - Trailer park parking
        vector4(1953.28, 3795.21, 31.81, 90.00), -- Heading east
        
        -- Paleto Bay - Gas station parking
        vector4(-452.33, 5992.09, 31.71, 270.00), -- Heading west
        
        -- Del Perro Beach - Near the pier
        vector4(-1632.91, -945.65, 9.85, 180.00), -- Heading south
        
        -- Los Santos Customs - Workshop parking
        vector4(-348.71, -136.83, 39.01, 0.00), -- Heading north
        
        -- Legion Square - Downtown parking
        vector4(345.83, -185.14, 54.22, 90.00), -- Heading east
        
        -- The Vinewood Bowl - Parking for events
        vector4(2352.68, 2682.46, 47.70, 180.00), -- Heading south
        
        -- Del Perro Pier - Beachfront parking
        vector4(-1629.93, -1082.43, 13.15, 270.00), -- Heading west
        
        -- Rockford Hills - Residential area
        vector4(1244.43, -2770.33, 2.88, 180.00), -- Heading south
        
        -- La Mesa - Industrial area parking
        vector4(825.43, -1052.09, 28.94, 270.00), -- Heading west
        
        -- Pillbox Hill - Office parking lot
        vector4(311.19, -599.55, 43.29, 180.00), -- Heading south
        
        -- Strawberry - Urban street parking
        vector4(250.12, -1152.44, 29.29, 90.00), -- Heading east
        
        -- Cypress Flats - Industrial street parking
        vector4(1154.99, -1033.36, 39.16, 270.00), -- Heading west
        
        -- Blaine County - Trailer parking
        vector4(1395.97, 3706.89, 32.83, 0.00), -- Heading north
        
        -- Mirror Park - Residential parking
        vector4(1246.67, -1711.91, 54.77, 0.00), -- Heading north
        
        -- Little Seoul - Near shops
        vector4(-473.15, -305.52, 34.91, 270.00), -- Heading west
        
        -- Grand Senora Desert - Gas station
        vector4(1711.43, 4691.77, 42.09, 180.00), -- Heading south
        
        -- Vespucci Beach - Parking near surf shop
        vector4(-1324.19, -1055.39, 6.99, 270.00), -- Heading west
        
        -- Great Ocean Highway - Rest stop
        vector4(1643.72, 4863.13, 41.94, 90.00), -- Heading east
        
        -- Pacific Bluffs - Cliffside parking
        vector4(-415.89, 1226.99, 325.42, 90.00), -- Heading east
        
        -- LSA Freeway - Underpass parking
        vector4(259.95, -1304.98, 29.24, 0.00), -- Heading north
        
        -- Vinewood - Movie set parking
        vector4(1459.13, 1761.45, 74.91, 180.00), -- Heading south
        
        -- Eclipse Towers - High-rise apartment parking
        vector4(814.58, -811.07, 57.32, 180.00), -- Heading south
        
        -- Little Haiti - Caribbean neighborhood parking
        vector4(-897.23, -559.58, 29.77, 270.00), -- Heading west
        
        -- Pacific Standard Bank - Bank parking
        vector4(243.45, 224.75, 106.28, 0.00), -- Heading north
        
        -- Tinsel Towers - Parking lot
        vector4(321.85, 181.56, 102.57, 90.00), -- Heading east
        
        -- Vespucci Beach - Parking near parking lot
        vector4(-1357.55, -1054.44, 5.52, 270.00), -- Heading west
        
        -- Legion Square - Urban park parking
        vector4(280.41, -163.11, 54.28, 0.00), -- Heading north
        
        -- Terminal - City bus terminal parking
        vector4(-1325.46, -1667.14, 51.65, 180.00), -- Heading south
        
        -- Mirror Park - Park parking
        vector4(1086.99, -1323.02, 32.32, 0.00), -- Heading north
        
        -- East Vinewood - Street parking
        vector4(506.74, -1321.77, 29.44, 270.00), -- Heading west
        
        -- Mount Chiliad - Scenic view parking
        vector4(452.59, 5604.74, 766.79, 180.00), -- Heading south
        
        -- Downtown Los Santos - Parking garage
        vector4(243.19, -657.34, 28.27, 180.00), -- Heading south
        
        -- La Puerta - Industrial district parking
        vector4(358.65, -1742.89, 28.28, 90.00), -- Heading east
        
        -- Blaine County - Roadside parking
        vector4(1917.98, 3686.27, 32.45, 0.00), -- Heading north
        
        -- Los Santos International Airport (LSIA) - Parking garage
        vector4(-1337.43, -2724.87, 13.94, 90.00), -- Heading east
        
        -- Mount Gordo - Mountain view parking
        vector4(-1328.11, 4260.14, 28.13, 0.00), -- Heading north
        
        -- Mirror Park - Parking garage
        vector4(1050.79, -1452.33, 29.79, 180.00), -- Heading south
        
        -- Vinewood Hills - Parking lot
        vector4(1087.91, 2413.99, 55.81, 180.00), -- Heading south
        
        -- Davis - Urban parking
        vector4(275.64, -1709.57, 29.83, 90.00), -- Heading east
        
        -- Sandy Shores - Desert parking
        vector4(1689.45, 4829.79, 42.07, 270.00), -- Heading west
        
        -- Alta Street - City parking lot
        vector4(131.35, -1076.71, 29.22, 180.00), -- Heading south
        
        -- The Beach - Parking spot near water
        vector4(-1557.71, -954.73, 11.15, 270.00), -- Heading west
        
        -- El Burro Heights - Industrial parking
        vector4(1217.89, -2791.73, 41.88, 270.00), -- Heading west
        
        -- Los Santos Custom - Workshop lot
        vector4(-347.34, -136.58, 39.01, 180.00), -- Heading south
        
        -- Vinewood Boulevard - Movie star parking
        vector4(1141.03, -348.64, 69.07, 270.00), -- Heading west
        
        -- Rancho - Urban street parking
        vector4(338.87, -1504.64, 29.29, 90.00), -- Heading east
        
        -- Downtown - Industrial parking lot
        vector4(95.48, -1220.04, 29.29, 180.00), -- Heading south
        
        -- Hawick Avenue - Parking near shops
        vector4(363.89, -875.77, 28.31, 90.00), -- Heading east
        
        -- Vespucci - Beach parking
        vector4(-1379.13, -1060.49, 5.68, 270.00), -- Heading west
        
        -- Richman - Residential street parking
        vector4(1230.92, -2080.22, 39.99, 180.00), -- Heading south
        
        -- Rockford Hills - Neighborhood parking
        vector4(1733.93, 3784.01, 34.55, 0.00), -- Heading north
        
        -- Sandy Shores - Gas station parking
        vector4(1953.36, 3795.35, 31.81, 90.00), -- Heading east
        
        -- Great Ocean Highway - Beachside parking
        vector4(2203.71, 4770.68, 41.11, 0.00), -- Heading north
        
        -- Paleto Bay - Roadside parking
        vector4(-462.94, 5992.09, 31.71, 270.00), -- Heading west
        
        -- Ganton - Park parking
        vector4(-1159.34, -1505.77, 4.37, 180.00), -- Heading south
        
        -- Downtown Vinewood - City parking
        vector4(1197.17, 2654.09, 37.99, 0.00), -- Heading north
        
        -- Mission Row - Police parking
        vector4(431.84, -975.02, 30.69, 90.00), -- Heading east
        
        -- Los Santos - Beachfront parking
        vector4(-1464.72, -970.04, 10.29, 270.00), -- Heading west
        
        -- Vinewood Hills - Car parking
        vector4(1594.99, 3794.57, 31.92, 0.00), -- Heading north
        
        -- Alta Street - City parking lot
        vector4(207.63, -1071.67, 29.29, 180.00), -- Heading south
        
        -- Rockford Hills - Fancy hotel parking
        vector4(1280.59, -2204.31, 48.65, 270.00), -- Heading west
    }    
}
