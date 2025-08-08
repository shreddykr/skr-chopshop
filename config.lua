-- skr-chopshop Handcrafted Missions Config

Config = {}

Config.Debug = false

Config.TargetingSystem = "ox_target" -- Options: "ox_target", "qb_target"
Config.FuelSystem = 'lc_fuel' -- 'legacyFuel', 'cdn-fuel', or 'lc_fuel'

Config.DeliveryRadius = 10.0
Config.InteractionDistance = 2.5

Config.MissionTimeout = 1800 -- Seconds (30 minutes default)
Config.SellVehicleEnabled = true

Config.Ped = {
    model = "g_m_m_armgoon_01",
    location = vector4(476.78, -1314.48, 29.2, 254.91),
    scenario = "WORLD_HUMAN_SMOKING"
}

Config.DeliveryLocations = {
    vector4(476.4, -1315.28, 28.225, 255.99),
}
-- Handcrafted Missions Only!
Config.Missions = {
    [1] = {
        label = "Drug Dealers Fresh Batch",
        blip = { sprite = 225, color = 5 },
        payout = 23578,
        vehicle = {
            model = 'toros',
            coords = vector4(363.63, -790.93, 29.29, 179.34),
            plate = 'PLUG',
            network = true
        },
        npcs = {
            {
                model = 's_m_y_dealer_01',
                coords = vector3(363.92, -788.28, 29.28),
                heading = 74.91,
                weapon = 'WEAPON_APPISTOL',
                aggressive = true,
                accuracy = 68,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 'g_m_m_armlieut_01',
                coords = vector3(361.94, -786.81, 29.28),
                heading = 227.3,
                weapon = 'WEAPON_COMBATPISTOL',
                aggressive = true,
                accuracy = 44,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 'g_m_m_armgoon_01',
                coords = vector3(361.75, -789.26, 29.29),
                heading = 296.39,
                weapon = 'WEAPON_COMBATPISTOL',
                aggressive = true,
                accuracy = 55,
                patrol = false,
                detectRange = 40.0
            },
        }
    },
    [2] = {
        label = "Steal Car with Ballas Weapons",
        blip = { sprite = 225, color = 1 },
        payout = 65874,
        vehicle = {
            model = 'baller8',
            coords = vector4(-1070.5, -1669.81, 4.44, 38.76),
            plate = 'BALLA',
            network = true
        },
        npcs = {
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1082.76, -1673.75, 4.7),
                heading = 354.27,
                weapon = 'WEAPON_PISTOL50',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1084.72, -1674.15, 4.7),
                heading = 326.53,
                weapon = 'WEAPON_COMBATPISTOL',
                aggressive = true,
                accuracy = 50,
                patrol = false,
                --[[patrolRoute = {
                    vector3(1198.0, -1400.0, 35.0),
                    vector3(1202.0, -1404.0, 35.0)
                },]]--
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1072.94, -1658.24, 7.23),
                heading = 128.56,
                weapon = 'WEAPON_PISTOL50',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1070.99, -1652.68, 4.46),
                heading = 135.86,
                weapon = 'WEAPON_PISTOL50',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1072.0, -1651.64, 4.5),
                heading = 153.35,
                weapon = 'WEAPON_MACHINEPISTOL',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1093.94, -1647.13, 4.4),
                heading = 110.91,
                weapon = 'WEAPON_PISTOL50',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
            {
                model = 'g_m_y_ballaeast_01',
                coords = vector3(-1096.31, -1648.08, 4.4),
                heading = 287.3,
                weapon = 'WEAPON_PISTOL50',
                aggressive = true,
                accuracy = 65,
                patrol = false,
                detectRange = 12.0
            },
        }
    },
    [3] = {
        label = "Rival Chop Shop Takeout",
        blip = { sprite = 225, color = 5 },
        payout = 109885,
        vehicle = {
            model = 'speedo',
            coords = vector4(978.32, -1823.92, 31.41, 344.52),
            plate = 'THESHOP',
            network = true
        },
        npcs = {
            {
                model = 's_m_y_xmech_02',
                coords = vector3(975.95, -1828.65, 31.17),
                heading = 247.37,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_strvend_01',
                coords = vector3(977.96, -1829.33, 31.21),
                heading = 76.32,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
        }
    },
    [4] = {
        label = "FIB Union Depository",
        blip = { sprite = 225, color = 5 },
        payout = 139885,
        vehicle = {
            model = 'xls2',
            coords = vector4(-148.23, -588.39, 31.88, 23.09),
            plate = 'FIB',
            network = true
        },
        npcs = {
            {
                model = 's_m_y_blackops_01',
                coords = vector3(-145.52, -591.78, 32.42),
                heading = 162.06,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_blackops_01',
                coords = vector3(-151.22, -586.31, 32.42),
                heading = 140.72,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_blackops_01',
                coords = vector3(-146.87, -587.29, 32.42),
                heading = 346.85,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_blackops_01',
                coords = vector3(-144.2, -586.42, 32.42),
                heading = 55.94,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_m_highsec_01',
                coords = vector3(-145.81, -584.6, 32.42),
                heading = 205.38,
                weapon = 'WEAPON_SNSPISTOL',
                aggressive = true,
                accuracy = 60,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_m_fiboffice_01',
                coords = vector3(-147.22, -585.02, 32.42),
                heading = 193.59,
                weapon = 'WEAPON_SNSPISTOL',
                aggressive = true,
                accuracy = 35,
                patrol = false,
                detectRange = 40.0
            },
        }
    },
    [5] = {
        label = "Casino Hit",
        blip = { sprite = 225, color = 5 },
        payout = 189000,
        vehicle = {
            model = 'stockade',
            coords = vector4(971.51, 1.84, 80.49, 157.17),
            plate = 'EX6829',
            network = true
        },
        npcs = {
            {
                model = 's_m_y_xmech_02',
                coords = vector3(974.04, -1.04, 81.04),
                heading = 84.76,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_strvend_01',
                coords = vector3(972.47, -0.77, 81.04),
                heading = 259.28,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_strvend_01',
                coords = vector3(973.02, 5.68, 81.04),
                heading = 161.25,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
            {
                model = 's_m_y_strvend_01',
                coords = vector3(971.16, 7.71, 81.04),
                heading = 230.65,
                weapon = 'WEAPON_CARBINERIFLE',
                aggressive = true,
                accuracy = 75,
                patrol = false,
                detectRange = 40.0
            },
        }
    },
    -- Add more missions here!
}