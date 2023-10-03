local isLoggedIn = LocalPlayer.state.isLoggedIn
local hasFitbit = false
local cooldown = false
-- Functions
local function fitbitCheck(PlayerItems)
    for _, item in pairs(PlayerItems) do
        if item.name == "fitbit" then
            return true
        end
    end
end

local function openWatch()
    SendNUIMessage({
        action = "openWatch",
        watchData = {}
    })
    SetNuiFocus(true, true)
end

local function closeWatch()
    SetNuiFocus(false, false)
end

local function activateCooldown()
    cooldown = true
    Wait(2*60*1000)
    cooldown = false
end
-- Events

AddStateBagChangeHandler('isLoggedIn', nil, function(_, _, value)
    isLoggedIn = value
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not isLoggedIn then return end
    hasFitbit = fitbitCheck(QBX.PlayerData.items)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    hasFitbit = fitbitCheck(QBX.PlayerData.items)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    hasFitbit = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function()
    hasFitbit = fitbitCheck(QBX.PlayerData.items)
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    if not hasFitbit or cooldown then return end
    if QBX.PlayerData.metadata.fitbit.food then
        if newHunger < QBX.PlayerData.metadata.fitbit.food then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "warning", Lang:t('warning.hunger_warning', {hunger = math.round(newHunger, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end

    if QBX.PlayerData.metadata.fitbit.thirst then
        if newThirst < QBX.PlayerData.metadata.fitbit.thirst then
            TriggerEvent("chatMessage", Lang:t('info.fitbit'), "warning", Lang:t('warning.thirst_warning', {thirst = math.round(newThirst, 2)}))
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end
    activateCooldown()
end)

RegisterNetEvent('qb-fitbit:use', function()
    openWatch()
end)

-- NUI Callbacks

RegisterNUICallback('close', function(_, cb)
    closeWatch()
    cb('ok')
end)

RegisterNUICallback('setFoodWarning', function(data, cb)
    local foodValue = tonumber(data.value)
    TriggerServerEvent('qb-fitbit:server:setValue', 'food', foodValue)
    exports.qbx_core:Notify(Lang:t('success.hunger_set', {hungervalue = foodValue}), 'success')
    cb('ok')
end)

RegisterNUICallback('setThirstWarning', function(data, cb)
    local thirstValue = tonumber(data.value)
    TriggerServerEvent('qb-fitbit:server:setValue', 'thirst', thirstValue)
    exports.qbx_core:Notify(Lang:t('success.thirst_set', {thirstvalue = thirstValue}), 'success')
    cb('ok')
end)