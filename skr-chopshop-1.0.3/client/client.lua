local QBCore = exports['qb-core']:GetCoreObject()

local missionData = {}

-- Variables for plate text display
local showPlateText = false
local targetPlate = ""

-- Show text on screen
function ShowPlateText(plate)
    targetPlate = plate
    showPlateText = true
end

-- Hide the text
function HidePlateText()
    showPlateText = false
end

-- Draw GTA-style mission text on screen
CreateThread(function()
    while true do
        Wait(0)
        if showPlateText then
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

-- Monitor player entering the correct vehicle
CreateThread(function()
    while true do
        Wait(1000)
        if showPlateText and missionData.isOnMission and missionData.vehicle then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 then
                local currentPlate = GetVehicleNumberPlateText(vehicle)
                currentPlate = string.upper(string.gsub(currentPlate, "%s+", ""))
                local expectedPlate = GetVehicleNumberPlateText(missionData.vehicle)
                expectedPlate = string.upper(string.gsub(expectedPlate, "%s+", ""))
                if currentPlate == expectedPlate then
                    HidePlateText()
                end
            end
        end
    end
end)

-- Create Ped and interaction with the target menu
CreateThread(function()
    local model = GetHashKey(Config.Ped.model)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
    end

    local ped = CreatePed(0, model, Config.Ped.location.x, Config.Ped.location.y, Config.Ped.location.z, Config.Ped.location.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local options = {
        {
            label = 'Start Mission',
            icon = 'fas fa-car',
            onSelect = function()
                StartMission()
            end
        },
        {
            label = 'End Mission',
            icon = 'fas fa-flag-checkered',
            onSelect = function()
                EndMission()
            end
        }
    }

    if Config.SellVehicleEnabled then
        table.insert(options, {
            label = 'Sell Vehicle',
            icon = 'fas fa-hand-holding-usd',
            onSelect = function()
                SellVehicleToChopshop()
            end
        })
    end

    if Config.TargetingSystem == "ox_target" then
        exports.ox_target:addLocalEntity(ped, options)
    elseif Config.TargetingSystem == "qb_target" then
        exports.qb-target:AddTargetEntity(ped, {
            options = options,
            distance = 2.5 -- Adjust interaction distance as needed
        })
    else
        print("Invalid Targeting System Configured")
    end
end)

-- Start Mission
function StartMission()
    if missionData.isOnMission then
        return QBCore.Functions.Notify('You are already on a mission.', 'error')
    end

    local randomLocation = SelectRandomLocation()
    TriggerEvent('skr-chopshop:startMission', randomLocation)

    local vehicle = SpawnRandomVehicle(randomLocation, 0.0)
    if vehicle then
        missionData.isOnMission = true
        missionData.startTime = GetGameTimer()
        missionData.vehicle = vehicle
        missionData.location = randomLocation
        missionData.blipRadius = CreateMissionRadius(randomLocation)

        -- Show plate
        local plate = GetVehicleNumberPlateText(vehicle)
        plate = string.upper(string.gsub(plate, "%s+", ""))
        ShowPlateText(plate)

        QBCore.Functions.Notify('Mission started! Check your map for the vehicle location.', 'success')
    else
        QBCore.Functions.Notify('Failed to spawn vehicle.', 'error')
    end
end

function CreateMissionRadius(location)
    local radiusBlip = AddBlipForRadius(location.x, location.y, location.z, 200.0)
    SetBlipAlpha(radiusBlip, 128)
    SetBlipColour(radiusBlip, 1)
    return radiusBlip
end

function EndMission()
    if not missionData.isOnMission then
        return QBCore.Functions.Notify('You are not on a mission.', 'error')
    end

    DeleteMissionVehicle()
    TriggerServerEvent('skr-chopshop:addCash')
    RemoveBlip(missionData.blipRadius)

    missionData.isOnMission = false
    missionData.vehicle = nil
    missionData.blipRadius = nil

    HidePlateText()
    QBCore.Functions.Notify('Mission ended.', 'success')
end

function DeleteMissionVehicle()
    if missionData.vehicle then
        SetEntityAsMissionEntity(missionData.vehicle, true, true)
        DeleteVehicle(missionData.vehicle)
        QBCore.Functions.Notify('Mission Vehicle Chopped.', 'success')
    end
end

CreateThread(function()
    while true do
        Wait(5000)
        if missionData.isOnMission then
            local elapsedTime = (GetGameTimer() - missionData.startTime) / 1000
            if elapsedTime >= 1200 then
                EndMission()
                QBCore.Functions.Notify('Mission automatically timeout.', 'error')
            end
        end
    end
end)

function SellVehicleToChopshop()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 70)

    if closestVehicle == 0 then
        return QBCore.Functions.Notify('No vehicle found nearby.', 'error')
    end

    local distance = #(coords - GetEntityCoords(closestVehicle))
    if distance > 10.0 then
        return QBCore.Functions.Notify('Get closer to the vehicle.', 'error')
    end

    local plate = GetVehicleNumberPlateText(closestVehicle)
    plate = string.upper(string.gsub(plate, "%s+", ""))

    local vehicleNetId = NetworkGetNetworkIdFromEntity(closestVehicle)
    TriggerServerEvent('skr-chopshop:sellVehicle', plate, vehicleNetId)
end
