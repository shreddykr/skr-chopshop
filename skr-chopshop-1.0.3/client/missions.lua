local QBCore = exports['qb-core']:GetCoreObject()

local activeMissions = {}

-- Event to handle mission start
RegisterNetEvent('skr-chopshop:startMission', function(randomLocation)
    local playerId = source

    if activeMissions[playerId] then
        TriggerClientEvent('QBCore:Notify', playerId, 'You are already on a mission.', 'error')
        return
    end

    activeMissions[playerId] = {
        location = randomLocation,
        startTime = os.time(),
        isOnMission = true
    }

    -- Start mission on client
    TriggerClientEvent('skr-chopshop:startMissionClient', playerId, randomLocation)
end)

-- Event to handle mission completion
RegisterNetEvent('skr-chopshop:completeMission', function()
    local playerId = source

    if activeMissions[playerId] and activeMissions[playerId].isOnMission then
        local reward = GenerateRandomReward()
        local Player = QBCore.Functions.GetPlayer(playerId)

        if Player then
            -- Give money (cash)
            Player.Functions.AddMoney('cash', reward, "chopshop-mission")
            TriggerClientEvent('QBCore:Notify', playerId, 'Mission completed! You earned $' .. reward, 'success')
        end

        activeMissions[playerId] = nil
    end
end)

-- Event to delete the mission vehicle
RegisterNetEvent('skr-chopshop:deleteVehicle', function(vehicleNetId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if vehicle and DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
    end
end)

-- Mission timeout checker (20 min)
CreateThread(function()
    while true do
        Wait(5000)
        for playerId, mission in pairs(activeMissions) do
            if mission.isOnMission then
                local elapsedTime = os.time() - mission.startTime
                if elapsedTime >= 1200 then
                    TriggerClientEvent('skr-chopshop:deleteVehicle', tonumber(playerId), mission.vehicleNetId or 0)
                    TriggerClientEvent('QBCore:Notify', tonumber(playerId), 'Mission automatically cancelled due to timeout.', 'error')
                    activeMissions[playerId] = nil
                end
            end
        end
    end
end)

-- Utility: Random payout
function GenerateRandomReward()
    return math.random(500, 1500)
end
