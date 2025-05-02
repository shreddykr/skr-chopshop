local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    local model = `s_m_y_dealer_01` -- NPC model for the chopshop dealer
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = CreatePed(0, model, Config.ChopshopLocation.xyz, Config.ChopshopLocation.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- Register interaction with the NPC using ox_target
    exports.ox_target:addLocalEntity(ped, {
        {
            label = 'Sell Vehicle',
            icon = 'fas fa-car',
            onSelect = function()
                print("Chopshop interaction triggered!") -- Debugging line
                SellVehicleToChopshop()
            end
        }
    })
end)

function SellVehicleToChopshop()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    -- Find the closest vehicle
    local closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 70)
    
    if closestVehicle == 0 then
        return QBCore.Functions.Notify('No vehicle found nearby.', 'error')
    end

    -- Check distance to vehicle
    local distance = #(coords - GetEntityCoords(closestVehicle))
    if distance > 10.0 then
        return QBCore.Functions.Notify('Get closer to the vehicle.', 'error')
    end

    -- Normalize and send plate to server
    local plate = GetVehicleNumberPlateText(closestVehicle)
    plate = string.upper(string.gsub(plate, "%s+", ""))

    -- Send plate and vehicle net ID to server
    local vehicleNetId = NetworkGetNetworkIdFromEntity(closestVehicle)
    TriggerServerEvent('skr-chopshop:sellVehicle', plate, vehicleNetId)
end


function GenerateRandomReward()
    local randomChance = math.random(1, 100)

    -- Make it rare for the player to get more than $6,000
    if randomChance <= 85 then
        return math.random(3000, 6000)  -- 85% chance to get between $3,000 and $6,000
    else
        return math.random(6001, 10000) -- 15% chance to get between $6,001 and $10,000
    end
end

RegisterNetEvent('skr-chopshop:deleteVehicle', function(vehicleNetId, plate)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(vehicle) then
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
        TriggerEvent('qb-vehiclekeys:removeKey', plate)
    end
end)

