local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPeds = {}
local spawnedVehicles = {}

local missionActive = false
local currentMissionId = nil
local missionVehicle = nil
local missionBlip = nil
local deliveryBlip = nil
local gtaText = ""
local gtaTextTimer = 0

-- Mission Timer (25 minutes for all missions)
local missionTimer = 0
local missionTimerEnd = 0
local missionFailed = false
local DEFAULT_MISSION_TIME = 1500 -- 25 minutes in seconds
local missionVehicleEntered = false


-- Relationship group for NPCs to prevent friendly fire
local CHOPSHOP_NPC_GROUP = GetHashKey("CHOPSHOP_NPC_GROUP")
if not DoesRelationshipGroupExist(CHOPSHOP_NPC_GROUP) then
    AddRelationshipGroup("CHOPSHOP_NPC_GROUP")
end

-- Spawn mission-giver ped and add target options
CreateThread(function()
    local pedModel = GetHashKey(Config.Ped.model)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(10) end

    local loc = Config.Ped.location
    local bossPed = CreatePed(0, pedModel, loc.x, loc.y, loc.z - 1.0, loc.w, false, false)
    FreezeEntityPosition(bossPed, true)
    SetEntityInvincible(bossPed, true)
    SetBlockingOfNonTemporaryEvents(bossPed, true)
    if Config.Ped.scenario then
        TaskStartScenarioInPlace(bossPed, Config.Ped.scenario, 0, true)
    end

    -- Setup target options
    local options = {
        {
            name = "start_mission",
            icon = "fas fa-car",
            label = "Start Mission",
            canInteract = function(entity, distance, data)
                return not missionActive
            end,
            onSelect = function()
                OpenChopshopMenu()
            end
        },
        {
            name = "end_mission",
            icon = "fas fa-flag-checkered",
            label = "End Mission",
            canInteract = function(entity, distance, data)
                return missionActive
            end,
            onSelect = function()
                EndMissionAtNPC()
            end
        }
    }

    -- Register with your target system (choose ox_target or qb-target)
    if Config.TargetingSystem == "ox_target" then
        exports.ox_target:addLocalEntity(bossPed, options)
    elseif Config.TargetingSystem == "qb-target" then
        exports['qb-target']:AddTargetEntity(bossPed, {
            options = options,
            distance = Config.InteractionDistance
        })
    end
end)

function OpenChopshopMenu()
    local opts = {}
    for id, mission in pairs(Config.Missions) do
        table.insert(opts, {
            header = mission.label or ("Mission " .. id),
            txt = mission.description or "",
            params = {
                event = "skr-chopshop:SelectMission",
                args = { missionId = id }
            }
        })
    end
    exports['qb-menu']:openMenu(opts)
end

RegisterNetEvent("skr-chopshop:SelectMission", function(data)
    local id = data.missionId
    if missionActive then
        QBCore.Functions.Notify("You already have an active mission!", "error")
        return
    end
    currentMissionId = id
    missionActive = true
    missionFailed = false
    missionTimer = DEFAULT_MISSION_TIME
    missionTimerEnd = GetGameTimer() + missionTimer * 1000
    TriggerServerEvent("skr-chopshop:StartMission", id)
end)

RegisterNetEvent("skr-chopshop:SpawnMissionEntities")
AddEventHandler("skr-chopshop:SpawnMissionEntities", function(missionId)
    DeleteMissionEntities()
    local mission = Config.Missions[missionId]
    if not mission then return end

    -- Spawn vehicle
    if mission.vehicle then
        local v = mission.vehicle
        local modelHash = GetHashKey(v.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end

        missionVehicle = CreateVehicle(modelHash, v.coords.x, v.coords.y, v.coords.z, v.coords.w, true, true)
        SetVehicleOnGroundProperly(missionVehicle)
        SetVehicleNumberPlateText(missionVehicle, v.plate or "CHOPSHOP")
        SetEntityAsMissionEntity(missionVehicle, true, true)
        SetVehicleHasBeenOwnedByPlayer(missionVehicle, true)
        NetworkRegisterEntityAsNetworked(missionVehicle)
        table.insert(spawnedVehicles, missionVehicle)

        if missionBlip then RemoveBlip(missionBlip) end
        missionBlip = AddBlipForEntity(missionVehicle)
        SetBlipSprite(missionBlip, 225)
        SetBlipColour(missionBlip, 5)
        SetBlipScale(missionBlip, 0.9)
        SetBlipRoute(missionBlip, true)
        SetBlipRouteColour(missionBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(mission.label or "Chopshop Car")
        EndTextCommandSetBlipName(missionBlip)
    end

    -- Delivery blip
    if mission.delivery then
        if deliveryBlip then RemoveBlip(deliveryBlip) end
        deliveryBlip = AddBlipForCoord(mission.delivery.x, mission.delivery.y, mission.delivery.z)
        SetBlipSprite(deliveryBlip, 1)
        SetBlipColour(deliveryBlip, 2)
        SetBlipScale(deliveryBlip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Chopshop Dropoff")
        EndTextCommandSetBlipName(deliveryBlip)
    end

    ShowGtaStyleText("Find and steal the car with the marked location!")

    -- Spawn NPCs
    if mission.npcs then
        for _, npc in ipairs(mission.npcs) do
            local modelHash = GetHashKey(npc.model or "s_m_m_security_01")
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do Wait(10) end

            local ped = CreatePed(4, modelHash, npc.coords.x, npc.coords.y, npc.coords.z, npc.heading or 0.0, true, true)
            if DoesEntityExist(ped) then
                SetEntityAsMissionEntity(ped, true, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetPedDropsWeaponsWhenDead(ped, false)
                NetworkRegisterEntityAsNetworked(ped)
                SetPedRelationshipGroupHash(ped, CHOPSHOP_NPC_GROUP)
                SetRelationshipBetweenGroups(0, CHOPSHOP_NPC_GROUP, CHOPSHOP_NPC_GROUP)
                SetRelationshipBetweenGroups(5, CHOPSHOP_NPC_GROUP, GetHashKey("PLAYER"))
                SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), CHOPSHOP_NPC_GROUP)

                if npc.weapon then
                    GiveWeaponToPed(ped, GetHashKey(npc.weapon), 250, false, true)
                    SetCurrentPedWeapon(ped, GetHashKey(npc.weapon), true)
                end

                -- Combat behavior settings
                SetPedAccuracy(ped, npc.accuracy or 65)
                SetPedAlertness(ped, 3)
                SetPedSeeingRange(ped, npc.detectRange or 60.0)
                SetPedHearingRange(ped, 150.0)
                SetPedCombatAttributes(ped, 46, true) -- No fleeing
                SetPedFleeAttributes(ped, 0, 0)
                SetPedCombatAbility(ped, 2)  -- High skill
                SetPedCombatRange(ped, 1)    -- Medium range
                SetPedCombatMovement(ped, 1) -- Use cover
                SetPedCanRagdollFromPlayerImpact(ped, true)
                SetPedCanBeTargetted(ped, true)

                TaskStandStill(ped, -1) -- Until aggro

                table.insert(spawnedPeds, {
                    ped = ped,
                    detectRange = 35.0,
                    aggroed = false
                })
            end
        end
    end

    -- Aggro logic thread
    CreateThread(function()
        local playerPed = PlayerPedId()

        while true do
            Wait(200)

            local playerCoords = GetEntityCoords(playerPed)
            local triggerAggro = false

            for _, data in ipairs(spawnedPeds) do
                local ped = data.ped
                if DoesEntityExist(ped) then
                    if not IsPedDeadOrDying(ped) then
                        local npcCoords = GetEntityCoords(ped)
                        local dist = #(npcCoords - playerCoords)

                        -- Proximity check
                        if dist <= 35.0 and not data.aggroed then
                            data.aggroed = true
                            triggerAggro = true
                        end

                        -- Damage check
                        if HasEntityBeenDamagedByEntity(ped, playerPed, true) and not data.aggroed then
                            data.aggroed = true
                            triggerAggro = true
                        end
                    else
                        triggerAggro = true -- One died, global aggro
                    end
                end
            end

            -- Trigger combat
            if triggerAggro then
                for _, data in ipairs(spawnedPeds) do
                    local ped = data.ped
                    if DoesEntityExist(ped) and not IsPedDeadOrDying(ped) then
                        ClearPedTasksImmediately(ped)

                        SetPedCombatMovement(ped, 1) -- Take cover
                        SetPedCombatRange(ped, 1)    -- Medium range
                        SetPedCombatAbility(ped, 2)  -- High skill

                        SetPedCombatAttributes(ped, 0, true)   -- Use cover
                        SetPedCombatAttributes(ped, 1, true)   -- Aggressive
                        SetPedCombatAttributes(ped, 2, true)   -- Always fight
                        SetPedCombatAttributes(ped, 5, true)   -- Defensive
                        SetPedCombatAttributes(ped, 46, true)  -- Never flee

                        TaskCombatPed(ped, playerPed, 0, 16)
                        data.aggroed = true
                    end
                end
                break
            end
        end
    end)
end)


-- GTA style text (bottom of screen)
function ShowGtaStyleText(text, duration)
    gtaText = text
    gtaTextTimer = GetGameTimer() + (duration or 7000)
end

CreateThread(function()
    while true do
        Wait(0)
        if gtaText ~= "" and (gtaTextTimer == 0 or GetGameTimer() < gtaTextTimer) then
            SetTextColour(255, 255, 255, 255)
            SetTextFont(7)
            SetTextScale(0.7, 0.7)
            SetTextCentre(true)
            SetTextDropShadow()
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextOutline()
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName(gtaText)
            EndTextCommandDisplayText(0.5, 0.93)
        end
    end
end)

-- Mission timer (bottom right, big)
CreateThread(function()
    while true do
        Wait(0)
        if missionActive and missionTimer and missionTimer > 0 and not missionFailed then
            local timeLeft = math.max(0, math.floor((missionTimerEnd - GetGameTimer()) / 1000))
            SetTextFont(7)
            SetTextScale(1.2, 1.2)
            SetTextColour(255, 255, 50, 255)
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(string.format("%02d:%02d", math.floor(timeLeft / 60), timeLeft % 60))
            DrawText(0.90, 0.92)
        end
    end
end)

-- Mission timer fail
CreateThread(function()
    while true do
        Wait(500)
        if missionActive and missionTimer and missionTimer > 0 and not missionFailed then
            if GetGameTimer() > missionTimerEnd then
                missionFailed = true
                TriggerMissionFail()
            end
        end
    end
end)

function TriggerMissionFail()
    PlayMissionFailEffect()
    EndMission(false)
    QBCore.Functions.Notify("You failed the mission! Time's up!", "error")
end

function PlayMissionFailEffect()
    DoScreenFadeOut(300)
    Wait(300)
    StartScreenEffect("DeathFailOut", 2000, false)
    AnimpostfxPlay("DeathFailMPIn", 2000, false)
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
    Wait(1000)
    DoScreenFadeIn(500)
    StopScreenEffect("DeathFailOut")
    AnimpostfxStop("DeathFailMPIn")
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.0)
end

-- Always show route to car and to delivery, and keep blip following car
CreateThread(function()
    while true do
        Wait(1000)
        if missionActive and missionVehicle and DoesEntityExist(missionVehicle) then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)

            -- If player enters the mission vehicle, apply wanted level (only once, after delay) requires sd_police
            if veh == missionVehicle and not missionVehicleEntered then
                missionVehicleEntered = true
                CreateThread(function()
                    Wait(4000)
                    if currentMission and currentMission.wantedLevel then
                        exports['sd-aipolice']:ApplyWantedLevel(currentMission.wantedLevel)
                    else
                        exports['sd-aipolice']:ApplyWantedLevel(1) -- fallback
                    end
                end)
            end

            -- Delivery blip
            if deliveryCoords and (not deliveryBlip or not DoesBlipExist(deliveryBlip)) then
                deliveryBlip = AddBlipForCoord(deliveryCoords)
                SetBlipSprite(deliveryBlip, 1)
                SetBlipColour(deliveryBlip, 5)
                SetBlipScale(deliveryBlip, 0.8)
                SetBlipRoute(deliveryBlip, false)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Dropoff Location")
                EndTextCommandSetBlipName(deliveryBlip)
            end

            -- Show route to car if not in car, else to delivery
            if veh == missionVehicle then
                if missionBlip and DoesBlipExist(missionBlip) then SetBlipRoute(missionBlip, false) end
                if deliveryBlip and DoesBlipExist(deliveryBlip) then SetBlipRoute(deliveryBlip, true) end
                ShowGtaStyleText("Deliver the car to the dropoff location!")
            else
                if missionBlip and DoesBlipExist(missionBlip) then SetBlipRoute(missionBlip, true) end
                if deliveryBlip and DoesBlipExist(deliveryBlip) then SetBlipRoute(deliveryBlip, false) end
                ShowGtaStyleText("Find and steal the car with the marked location!")
            end
        else
            if missionBlip and DoesBlipExist(missionBlip) then SetBlipRoute(missionBlip, false) end
            if deliveryBlip and DoesBlipExist(deliveryBlip) then SetBlipRoute(deliveryBlip, false) end
        end
    end
end)



-- Check if the mission vehicle is near the NPC (for mission completion)
function IsMissionVehicleNearNPC()
    if not missionVehicle or not DoesEntityExist(missionVehicle) then return false end
    local carCoords = GetEntityCoords(missionVehicle)
    local npcCoords = vector3(Config.Ped.location.x, Config.Ped.location.y, Config.Ped.location.z)
    return #(carCoords - npcCoords) < 7.0
end

function EndMissionAtNPC()
    if IsMissionVehicleNearNPC() then
        EndMission(true)
    else
        EndMission(false)
    end
end

function EndMission(giveReward)
    if missionBlip then RemoveBlip(missionBlip) missionBlip = nil end
    if deliveryBlip then RemoveBlip(deliveryBlip) deliveryBlip = nil end
    DeleteMissionEntities()
    missionActive = false
    gtaText = ""
    gtaTextTimer = 0
    missionTimer = 0
    missionTimerEnd = 0
    missionFailed = false
    if giveReward then
        PlayMissionCompleteEffect()
        -- Don't notify about payout here! Wait for server to send skr-chopshop:missionPaid
        TriggerServerEvent("skr-chopshop:addCash", currentMissionId)
    else
        QBCore.Functions.Notify("Mission abandoned.", "error")
    end
    currentMissionId = nil
end

function DeleteMissionEntities()
    for _, pedData in ipairs(spawnedPeds) do
        if pedData.ped and DoesEntityExist(pedData.ped) then
            DeleteEntity(pedData.ped)
        end
    end
    spawnedPeds = {}
    for _, veh in ipairs(spawnedVehicles) do
        if veh and DoesEntityExist(veh) then
            DeleteEntity(veh)
        end
    end
    spawnedVehicles = {}
    missionVehicle = nil
end

-- Cinematic mission completion effect (thud, color, zoom)
function PlayMissionCompleteEffect()
    DoScreenFadeOut(300)
    Wait(300)
    StartScreenEffect("HeistCelebPass", 2000, false)
    AnimpostfxPlay("MP_Celeb_Win", 2000, false)
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local ply = PlayerPedId()
    local coords = GetEntityCoords(ply)
    SetCamCoord(cam, coords.x, coords.y, coords.z + 1.0)
    PointCamAtEntity(cam, ply, 0, 0, 0, true)
    SetCamFov(cam, 40.0)
    RenderScriptCams(true, false, 0, true, true)
    Wait(400)
    SetCamFov(cam, 60.0)
    Wait(600)
    RenderScriptCams(false, false, 0, false, false)
    DestroyCam(cam, false)
    DoScreenFadeIn(500)
    StopScreenEffect("HeistCelebPass")
    AnimpostfxStop("MP_Celeb_Win")
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.0)
end

-- Fail mission if player dies
-- Fail mission if player dies, delay 5s before fail trigger
CreateThread(function()
    while true do
        Wait(1000)
        if missionActive and not missionFailed then
            local player = PlayerPedId()
            if IsEntityDead(player) then
                missionFailed = true
                CreateThread(function()
                    Wait(5000)
                    if missionActive then
                        EndMission(false)
                    end
                end)
            end
        end
    end
end)



-- Listen for payout confirmation from server and show correct notification
RegisterNetEvent("skr-chopshop:missionPaid", function(payout)
    if payout and payout > 0 then
        QBCore.Functions.Notify("Mission completed! You earned $" .. payout, "success")
    else
        QBCore.Functions.Notify("You completed the mission but no payout was set. Contact staff.", "error")
    end
end)