local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("skr-chopshop:StartMission", function(missionId)
    TriggerClientEvent("skr-chopshop:SpawnMissionEntities", source, missionId)
end)

RegisterNetEvent("skr-chopshop:addCash", function(missionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local payout = 0
    if missionId and Config.Missions and Config.Missions[missionId] and Config.Missions[missionId].payout then
        payout = Config.Missions[missionId].payout
    end

    if payout > 0 then
        --  Pay to bank instead of cash
        Player.Functions.AddMoney("bank", payout, "chopshop-mission")

        --  Optional item reward
        if Config.Missions[missionId].itemReward then
            local item = Config.Missions[missionId].itemReward
            Player.Functions.AddItem(item.name, item.amount)
        end

        --  Notify player
        TriggerClientEvent("skr-chopshop:missionPaid", src, payout)
    else
        print(("skr-chopshop: No payout set for mission ID %s (player %s - %s)!"):format(
            tostring(missionId), tostring(src), GetPlayerName(src) or "unknown"
        ))
        TriggerClientEvent("skr-chopshop:missionPaid", src, 0)
    end
end)

local resourceName = GetCurrentResourceName()
local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/shreddykr/skr-chopshop/main/version.txt", function(code, res, _)
        if code == 200 then
            local latestVersion = res:match("%S+")
            if currentVersion ~= latestVersion then
                print(("^3[%s]^0 Update available! ^1(%s → %s)^0"):format(resourceName, currentVersion, latestVersion))
                print("^3[" .. resourceName .. "]^0 Download latest: ^5https://github.com/shreddykr/skr-chopshop^0")
            else
                print("^2[" .. resourceName .. "]^0 is up to date. (^2" .. currentVersion .. "^0)")
            end
        else
            print("^1[" .. resourceName .. "]^0 Version check failed. Could not reach GitHub.")
        end
    end, "GET", "", {})
end)
