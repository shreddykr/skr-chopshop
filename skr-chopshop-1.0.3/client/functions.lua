-- Function to get a random vehicle model from the config list
function GetRandomVehicleModel()
    local randomIndex = math.random(1, #Config.Mission.VehicleModels)
    return Config.Mission.VehicleModels[randomIndex]
end

-- Function to spawn a vehicle at a specific location
function SpawnRandomVehicle(coords, heading)
    local vehicleModel = GetRandomVehicleModel()  -- Get a random vehicle model
    local modelHash = GetHashKey(vehicleModel)
    
    -- Request and load the vehicle model
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(500)
    end

    -- Ensure heading is passed as the fourth parameter (vector4 w = heading)
    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, heading, true, false)
    
    -- Make the vehicle a mission entity
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 11, 2)  -- Upgrade engine mod
    SetVehicleDoorsLocked(vehicle, 2)  -- Lock vehicle doors

    return vehicle
end

-- Function to select a random spawn location
function SelectRandomLocation()
    return Config.Mission.SpawnLocations[math.random(1, #Config.Mission.SpawnLocations)]
end

-- Function to generate random money reward
function GenerateRandomReward()
    local randomChance = math.random(1, 100)

    -- Make it rare for the player to get more than the minimum
    if randomChance <= 85 then
        return math.random(Config.MinPrice, (Config.MinPrice + Config.MaxPrice) / 2)
    else
        return math.random((Config.MinPrice + Config.MaxPrice) / 2 + 1, Config.MaxPrice)
    end
end
