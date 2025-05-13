local QBCore = exports['qb-core']:GetCoreObject()

local playerMissions = {} -- Store mission data for each player
local currentTime = GetGameTimer()
local lastMissionTime = {}
local lastSellTime = {}
local showPlateText = false
local targetPlate = ""

RegisterNetEvent('my-script:startMission', function()
    DebugPrint("Starting mission via ped interaction.")
    StartMission()
end)

RegisterNetEvent('my-script:endMission', function()
    DebugPrint("Ending mission via ped interaction.")
    EndMission()
end)

RegisterNetEvent('my-script:sellVehicle', function()
    DebugPrint("Selling vehicle via ped interaction.")
    SellVehicleToChopshop()
end)

-- Debugging helper function
function DebugPrint(message)
    if Config.Debug then
        print("^3[DEBUG]^7 " .. tostring(message))
    end
end

-- Show text on screen
function ShowPlateText(plate)
    targetPlate = plate
    showPlateText = true
    DebugPrint("Showing plate text: " .. plate)
end

-- Hide the text
function HidePlateText()
    showPlateText = false
    DebugPrint("Hiding plate text.")
end

-- Draw GTA-style mission text on screen
CreateThread(function()
    while true do
        Wait(0)
        if showPlateText then
            DebugPrint("Displaying plate text on screen: " .. targetPlate)
            SetTextColour(255, 255, 255, 255)
            SetTextFont(0)
            SetTextScale(0.5, 0.5)
            SetTextCentre(true)
            SetTextOutline()
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("Find and enter the car with plate: ~r~" .. targetPlate)
            EndTextCommandDisplayText(0.5, 0.95)
        end
    end
end)

-- Select a random location from Config.Mission.SpawnLocations
function SelectRandomLocation()
    local locations = Config.Mission.SpawnLocations
    if #locations == 0 then
        DebugPrint("Config.Mission.SpawnLocations is empty! Please add some spawn locations.")
        return nil
    end
    local location = locations[math.random(#locations)]
    DebugPrint("Selected random location: " .. json.encode(location))
    return location
end

-- Spawn a random vehicle at the specified location
-- Function to spawn a random vehicle at a given location with a specific heading
function SpawnRandomVehicle(spawnLocation)
    -- Validate Vehicle Models in Config
    local models = Config.Mission.VehicleModels
    if not models or #models == 0 then
        print("[DEBUG] Config.Mission.VehicleModels is empty or not defined!")
        return nil
    end

    -- Extract position and heading from the spawnLocation vector4
    local x, y, z, heading = spawnLocation.x, spawnLocation.y, spawnLocation.z, spawnLocation.w

    -- Select a random vehicle model
    local randomModel = models[math.random(#models)]
    local modelHash = GetHashKey(randomModel)
    print(string.format("[DEBUG] Spawning vehicle model: %s at x: %.2f, y: %.2f, z: %.2f, heading: %.2f", randomModel, x, y, z, heading))

    -- Request and load the model
    print("[DEBUG] Requesting model: " .. randomModel)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
    print("[DEBUG] Model loaded successfully.")

    -- Clear the area to prevent interference
    print("[DEBUG] Clearing area around spawn location.")
    ClearAreaOfVehicles(x, y, z, 10.0, false, false, false, false, false)
    ClearAreaOfObjects(x, y, z, 10.0, 0)
    ClearAreaOfPeds(x, y, z, 10.0, 0)

    -- Spawn the vehicle
    print("[DEBUG] Spawning the vehicle.")
    local vehicle = CreateVehicle(modelHash, x, y, z + 0.7, 0.0, true, false)
    if not vehicle then
        print("[DEBUG] Failed to create the vehicle!")
        return nil
    end
    print("[DEBUG] Vehicle spawned successfully.")

    -- Freeze the vehicle to stabilize it
    print("[DEBUG] Freezing vehicle position for stabilization.")
    FreezeEntityPosition(vehicle, true)

    -- Set position, heading, and ground alignment
    print("[DEBUG] Setting vehicle position and heading.")
    SetEntityCoords(vehicle, x, y, z + 0.7, false, false, false, true)
    SetEntityHeading(vehicle, heading)
    SetVehicleOnGroundProperly(vehicle)

    -- Unfreeze the vehicle
    print("[DEBUG] Unfreezing vehicle position.")
    FreezeEntityPosition(vehicle, false)

    -- Reapply heading after a short delay
    CreateThread(function()
        Wait(100)
        SetEntityHeading(vehicle, heading)
        print("[DEBUG] Heading reapplied after delay: " .. heading)
    end)

    -- Debug: Log final position and heading
    CreateThread(function()
        Wait(500)
        local actualCoords = GetEntityCoords(vehicle)
        local actualHeading = GetEntityHeading(vehicle)
        print(string.format("[DEBUG] Final Position: x: %.2f, y: %.2f, z: %.2f, heading: %.2f",
            actualCoords.x, actualCoords.y, actualCoords.z, actualHeading))
    end)

    -- Set additional properties
    local randomPlate = string.upper(string.char(math.random(65, 90), math.random(65, 90))) .. math.random(1000, 9999)
    print("[DEBUG] Setting vehicle plate: " .. randomPlate)
    SetVehicleNumberPlateText(vehicle, randomPlate)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleDoorsLocked(vehicle, 2)
    SetVehicleEngineOn(vehicle, true, true, false)

    -- Set fuel level if applicable
    local fuelLevel = math.random(30, 100)
    if Config.FuelSystem == 'LegacyFuel' then
        print("[DEBUG] Setting fuel level using LegacyFuel: " .. fuelLevel)
        exports['LegacyFuel']:SetFuel(vehicle, fuelLevel)
    elseif Config.FuelSystem == 'cdn-fuel' then
        print("[DEBUG] Setting fuel level using cdn-fuel: " .. fuelLevel)
        exports['cdn-fuel']:SetFuel(vehicle, fuelLevel)
    elseif Config.FuelSystem == 'lc_fuel' then
        print("[DEBUG] Setting fuel level using lc_fuel: " .. fuelLevel)
        exports['lc_fuel']:SetFuel(vehicle, fuelLevel)
    else
        print("[DEBUG] Invalid Fuel System Configured: " .. tostring(Config.FuelSystem))
    end

    return vehicle
end

-- Monitor player entering the correct vehicle
CreateThread(function()
    while true do
        Wait(1000)
        local playerId = GetPlayerServerId(PlayerId())
        local missionData = playerMissions[playerId]

        if missionData and missionData.isOnMission and missionData.vehicle then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 then
                local currentPlate = GetVehicleNumberPlateText(vehicle)
                currentPlate = string.upper(string.gsub(currentPlate, "%s+", ""))
                local expectedPlate = GetVehicleNumberPlateText(missionData.vehicle)
                expectedPlate = string.upper(string.gsub(expectedPlate, "%s+", ""))
                if currentPlate == expectedPlate then
                    DebugPrint("Player entered the correct vehicle with plate: " .. currentPlate)
                    HidePlateText()
                else
                    DebugPrint("Player entered a vehicle, but the plate does not match: " .. currentPlate)
                end
            end
        end
    end
end)

-- Create Ped and interaction with the target menu
CreateThread(function()
    local model = GetHashKey(Config.Ped.model)
    RequestModel(model)

    DebugPrint("Loading ped model: " .. Config.Ped.model)

    while not HasModelLoaded(model) do
        Wait(0)
    end

    DebugPrint("Ped model loaded successfully.")

    -- Create the ped
    local ped = CreatePed(0, model, Config.Ped.location.x, Config.Ped.location.y, Config.Ped.location.z, Config.Ped.location.w, false, true)
    if not DoesEntityExist(ped) then
        DebugPrint("Failed to create ped! Check Config.Ped.model and Config.Ped.location.")
        return
    end

    DebugPrint("Ped created successfully at location: " .. json.encode(Config.Ped.location))
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {}

    if Config.TargetingSystem == "qb-target" then
        options = {
            {
                label = 'Start Mission',
                icon = 'fas fa-car',
                type = 'client',
                event = 'my-script:startMission'
            },
            {
                label = 'End Mission',
                icon = 'fas fa-flag-checkered',
                type = 'client',
                event = 'my-script:endMission'
            }
        }

        if Config.SellVehicleEnabled then
            table.insert(options, {
                label = 'Sell Vehicle',
                icon = 'fas fa-hand-holding-usd',
                type = 'client',
                event = 'my-script:sellVehicle'
            })
        end

        exports['qb-target']:AddTargetEntity(ped, {
            options = options,
            distance = Config.InteractionDistance
        })
        DebugPrint("qb-target:AddTargetEntity called successfully.")

    elseif Config.TargetingSystem == "ox_target" then
        options = {
            {
                label = 'Start Mission',
                icon = 'fas fa-car',
                onSelect = function()
                    DebugPrint("Starting mission via ped interaction.")
                    StartMission()
                end
            },
            {
                label = 'End Mission',
                icon = 'fas fa-flag-checkered',
                onSelect = function()
                    DebugPrint("Ending mission via ped interaction.")
                    EndMission()
                end
            }
        }

        if Config.SellVehicleEnabled then
            table.insert(options, {
                label = 'Sell Vehicle',
                icon = 'fas fa-hand-holding-usd',
                canInteract = function(entity, distance, data)
                    local playerId = GetPlayerServerId(PlayerId())
                    local missionData = playerMissions[playerId]
                    return not (missionData and missionData.isOnMission)
                end,
                onSelect = function()
                    DebugPrint("Selling vehicle via ped interaction.")
                    SellVehicleToChopshop()
                end
            })
        end

        exports.ox_target:addLocalEntity(ped, options)
        DebugPrint("ox_target:addLocalEntity called successfully.")
    else
        DebugPrint("Invalid Targeting System Configured in Config.TargetingSystem. Must be `ox_target` or `qb-target`.")
    end
end)


-- Start Mission
function StartMission()
    local playerId = GetPlayerServerId(PlayerId())
    local currentTime = GetGameTimer() / 1000

    DebugPrint("Attempting to start mission for player ID: " .. playerId)

    -- Check cooldown
    if lastMissionTime[playerId] and (currentTime - lastMissionTime[playerId]) < Config.Mission.Cooldown then
        local remainingTime = math.ceil(Config.Mission.Cooldown - (currentTime - lastMissionTime[playerId]))
        DebugPrint("Mission cooldown active for player ID: " .. playerId .. ". Remaining time: " .. remainingTime .. " seconds.")
        QBCore.Functions.Notify('You need to wait ' .. remainingTime .. ' seconds before starting another mission.', 'error')
        return
    end

    DebugPrint("No active cooldown for player ID: " .. playerId .. ". Proceeding with mission.")

    if not playerMissions[playerId] then
        playerMissions[playerId] = {}
        DebugPrint("Initialized mission data for player.")
    end

    local missionData = playerMissions[playerId]

    if missionData.isOnMission then
        DebugPrint("Player is already on a mission.")
        return QBCore.Functions.Notify('You are already on a mission.', 'error')
    end

    local randomLocation = SelectRandomLocation()
    if not randomLocation then
        DebugPrint("No valid mission locations available.")
        return QBCore.Functions.Notify('No valid mission locations available.', 'error')
    end

    local vehicle = SpawnRandomVehicle(randomLocation, 0.0)
    if vehicle then
        DebugPrint("Mission vehicle spawned successfully.")
        missionData.isOnMission = true
        missionData.startTime = GetGameTimer()
        missionData.vehicle = vehicle
        missionData.location = randomLocation
        missionData.vehicleDelivered = false
        missionData.blipRadius = CreateMissionRadius(randomLocation)

        local plate = GetVehicleNumberPlateText(vehicle)
        plate = string.upper(string.gsub(plate, "%s+", ""))
        ShowPlateText(plate)

        lastMissionTime[playerId] = currentTime
        DebugPrint("Mission started. Vehicle plate: " .. plate)

        QBCore.Functions.Notify('Mission started! Check your map for the vehicle location.', 'success')
    else
        DebugPrint("Failed to spawn mission vehicle.")
        QBCore.Functions.Notify('Failed to spawn vehicle.', 'error')
    end
end

function CreateMissionRadius(location)
    DebugPrint("Creating mission radius blip at location: " .. json.encode(location))
    local radiusBlip = AddBlipForRadius(location.x, location.y, location.z, 200.0)
    SetBlipAlpha(radiusBlip, 128)
    SetBlipColour(radiusBlip, 1)
    DebugPrint("Mission radius blip created.")
    return radiusBlip
end

function EndMission()
    local playerId = GetPlayerServerId(PlayerId())
    local missionData = playerMissions[playerId]

    if not missionData or not missionData.isOnMission then
        DebugPrint("Player attempted to end a mission but is not currently on one.")
        return QBCore.Functions.Notify('You are not on a mission.', 'error')
    end

    DebugPrint("Ending mission for player ID: " .. playerId)

    if missionData.vehicleDelivered then
        DebugPrint("Mission completed successfully. Rewarding player.")
        TriggerServerEvent('skr-chopshop:addCash')
        QBCore.Functions.Notify('Mission completed! You earned your reward.', 'success')
    else
        DebugPrint("Mission failed. Vehicle was not delivered.")
        QBCore.Functions.Notify('Mission failed. Vehicle was not delivered.', 'error')
    end

    DeleteMissionVehicle(playerId)
    RemoveBlip(missionData.blipRadius)

    playerMissions[playerId] = nil
    HidePlateText()
    DebugPrint("Mission data reset for player ID: " .. playerId)
end

function DeleteMissionVehicle(playerId)
    DebugPrint("Deleting mission vehicle for player ID: " .. playerId)
    local missionData = playerMissions[playerId]
    if missionData and missionData.vehicle then
        SetEntityAsMissionEntity(missionData.vehicle, true, true)
        DeleteVehicle(missionData.vehicle)
        DebugPrint("Mission vehicle successfully deleted.")
    else
        DebugPrint("No mission vehicle found to delete for player ID: " .. playerId)
    end
end

function IsAtDeliveryLocation(location)
    DebugPrint("Checking if player is at the delivery location.")
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - vector3(location.x, location.y, location.z))
    local isAtLocation = distance <= Config.DeliveryRadius
    DebugPrint("Player distance to delivery location: " .. distance .. ". Within radius: " .. tostring(isAtLocation))
    return isAtLocation
end

CreateThread(function()
    while true do
        Wait(1000)
        local playerId = GetPlayerServerId(PlayerId())
        local missionData = playerMissions[playerId]

        if missionData and missionData.isOnMission and missionData.vehicle and not missionData.vehicleDelivered then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            local missionVehicle = missionData.vehicle

            if vehicle == missionVehicle then
                local currentPlate = GetVehicleNumberPlateText(vehicle)
                currentPlate = string.upper(string.gsub(currentPlate, "%s+", ""))
                local expectedPlate = GetVehicleNumberPlateText(missionVehicle)
                expectedPlate = string.upper(string.gsub(expectedPlate, "%s+", ""))

                if currentPlate == expectedPlate and IsAtDeliveryLocation(missionData.location) then
                    missionData.vehicleDelivered = true
                    DebugPrint("Player delivered the correct vehicle at the delivery location.")
                else
                    DebugPrint("Player is in the correct vehicle but not at the delivery location.")
                end
            else
                DebugPrint("Player is not in the correct vehicle.")
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        local playerId = GetPlayerServerId(PlayerId())
        local missionData = playerMissions[playerId]

        if missionData and missionData.isOnMission then
            local elapsedTime = (GetGameTimer() - missionData.startTime) / 1000
            if elapsedTime >= Config.MissionTimeout then
                DebugPrint("Mission timed out for player ID: " .. playerId)
                EndMission()
                QBCore.Functions.Notify('Mission automatically timed out.', 'error')
            end
        end
    end
end)

function SellVehicleToChopshop()
    local playerId = GetPlayerServerId(PlayerId())
    local currentTime = GetGameTimer()

    DebugPrint("Attempting to sell vehicle for player ID: " .. playerId)

    if lastSellTime[playerId] and (currentTime - lastSellTime[playerId]) / 1000 < Config.SellCooldown then
        local remainingTime = math.ceil(Config.SellCooldown - (currentTime - lastSellTime[playerId]) / 1000)
        DebugPrint("Sell cooldown active for player ID: " .. playerId .. ". Remaining time: " .. remainingTime .. " seconds.")
        QBCore.Functions.Notify('You need to wait ' .. remainingTime .. ' seconds before selling another vehicle.', 'error')
        return
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 70)

    if closestVehicle == 0 then
        DebugPrint("No vehicle found nearby to sell.")
        return QBCore.Functions.Notify('No vehicle found nearby.', 'error')
    end

    local distance = #(coords - GetEntityCoords(closestVehicle))
    if distance > 10.0 then
        DebugPrint("Player is too far from the vehicle to sell. Distance: " .. distance)
        return QBCore.Functions.Notify('Get closer to the vehicle.', 'error')
    end

    local plate = GetVehicleNumberPlateText(closestVehicle)
    plate = string.upper(string.gsub(plate, "%s+", ""))
    local vehicleNetId = NetworkGetNetworkIdFromEntity(closestVehicle)

    DebugPrint("Selling vehicle with plate: " .. plate .. " and Net ID: " .. vehicleNetId)
    TriggerServerEvent('skr-chopshop:sellVehicle', plate, vehicleNetId)

    lastSellTime[playerId] = currentTime
    DebugPrint("Vehicle sell event triggered for player ID: " .. playerId)
end

function GenerateRandomReward()
    DebugPrint("Generating random reward.")
    local minReward = Config.RewardRange.min
    local maxReward = Config.RewardRange.max
    local midReward = math.floor((minReward + maxReward) / 2)

    local randomChance = math.random(1, 100)

    if randomChance <= 85 then
        DebugPrint("Generated reward between min and mid range.")
        return math.random(minReward, midReward)
    else
        DebugPrint("Generated reward between mid and max range.")
        return math.random(midReward + 1, maxReward)
    end
end

RegisterNetEvent('skr-chopshop:deleteVehicle', function(vehicleNetId, plate)
    DebugPrint("Deleting vehicle with Net ID: " .. vehicleNetId .. " and plate: " .. plate)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(vehicle) then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
        TriggerEvent('qb-vehiclekeys:removeKey', plate)
        DebugPrint("Vehicle successfully deleted.")
    else
        DebugPrint("Vehicle does not exist and could not be deleted.")
    end
end)

RegisterNetEvent("skr-chopshop:client:AddChopBlip", function(data)
    local coords = data.coords or vector4(476.4, -1315.28, 28.225, 255.99)
    local label = data.label or "Chop Shop Dropoff"

    -- Create the blip
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 1) -- You can change sprite ID
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)

    -- Set waypoint if the player doesn't have one already
    if not IsWaypointActive() then
        SetNewWaypoint(coords.x, coords.y)
    end

    -- Remove blip after 2 minutes
    SetTimeout(120000, function()
        RemoveBlip(blip)
    end)
end)
