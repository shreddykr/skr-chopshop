local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('skr-chopshop:sellVehicle')
AddEventHandler('skr-chopshop:sellVehicle', function(plate, vehicleNetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    plate = string.upper(string.gsub(plate, "%s+", ""))

    exports.oxmysql:execute('SELECT 1 FROM player_vehicles WHERE plate = ? LIMIT 1', {plate}, function(result)
        if result and result[1] then
            TriggerClientEvent('QBCore:Notify', src, 'You cannot sell your personal vehicle here.', 'error')
        else
            -- Give reward
            local reward = math.random(3000, 10000)
            Player.Functions.AddMoney('cash', reward)
            TriggerClientEvent('QBCore:Notify', src, 'Vehicle sold for $' .. reward, 'success')

            -- Remove vehicle and keys on client
            TriggerClientEvent('skr-chopshop:deleteVehicle', src, vehicleNetId, plate)
        end
    end)
end)

RegisterServerEvent('skr-chopshop:addCash')
AddEventHandler('skr-chopshop:addCash', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        local reward = math.random(3000, 10000)  -- Random reward between $3,000 and $10,000
        Player.Functions.AddMoney('cash', reward)  -- Add money to player's cash balance
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle sold for $' .. reward, 'success')  -- Notify the player
    else
        print('Error: Player not found for source ' .. src)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == 'skr-chopshop' then
        print([[
╭━━━━┳╮╱╱╱╱╱╱╱╭╮╱╱╱╱╱╱╭━╮╱╱╱╱╱╭━━━╮╱╱╱╱╱╱╱╱╱╱╭╮╱╱╱╱╱╱╱╱╭╮
┃╭╮╭╮┃┃╱╱╱╱╱╱╱┃┃╱╱╱╱╱╱┃╭╯╱╱╱╱╱╰╮╭╮┃╱╱╱╱╱╱╱╱╱╱┃┃╱╱╱╱╱╱╱╱┃┃
╰╯┃┃╰┫╰━┳━━┳━╮┃┃╭┳━━╮╭╯╰┳━━┳━╮╱┃┃┃┣━━┳╮╭╮╭┳━╮┃┃╭━━┳━━┳━╯┣┳━╮╭━━╮
╱╱┃┃╱┃╭╮┃╭╮┃╭╮┫╰╯┫━━┫╰╮╭┫╭╮┃╭╯╱┃┃┃┃╭╮┃╰╯╰╯┃╭╮┫┃┃╭╮┃╭╮┃╭╮┣┫╭╮┫╭╮┃
╱╱┃┃╱┃┃┃┃╭╮┃┃┃┃╭╮╋━━┃╱┃┃┃╰╯┃┃╱╭╯╰╯┃╰╯┣╮╭╮╭┫┃┃┃╰┫╰╯┃╭╮┃╰╯┃┃┃┃┃╰╯┃
╱╱╰╯╱╰╯╰┻╯╰┻╯╰┻╯╰┻━━╯╱╰╯╰━━┻╯╱╰━━━┻━━╯╰╯╰╯╰╯╰┻━┻━━┻╯╰┻━━┻┻╯╰┻━╮┃
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯
╭━━━┳╮╭━┳━━━╮╱╭━━━┳╮╱╭┳━━━┳━━━┳━━━┳╮╱╭┳━━━┳━━━╮
┃╭━╮┃┃┃╭┫╭━╮┃╱┃╭━╮┃┃╱┃┃╭━╮┃╭━╮┃╭━╮┃┃╱┃┃╭━╮┃╭━╮┃
┃╰━━┫╰╯╯┃╰━╯┃╱┃┃╱╰┫╰━╯┃┃╱┃┃╰━╯┃╰━━┫╰━╯┃┃╱┃┃╰━╯┃
╰━━╮┃╭╮┃┃╭╮╭┻━┫┃╱╭┫╭━╮┃┃╱┃┃╭━━┻━━╮┃╭━╮┃┃╱┃┃╭━━╯
┃╰━╯┃┃┃╰┫┃┃╰┳━┫╰━╯┃┃╱┃┃╰━╯┃┃╱╱┃╰━╯┃┃╱┃┃╰━╯┃┃
╰━━━┻╯╰━┻╯╰━╯╱╰━━━┻╯╱╰┻━━━┻╯╱╱╰━━━┻╯╱╰┻━━━┻╯
]])
    end
end)