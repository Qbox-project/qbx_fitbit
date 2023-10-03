exports.qbx_core:CreateUseableItem("fitbit", function(source)
    TriggerClientEvent('qb-fitbit:use', source)
end)

RegisterNetEvent('qb-fitbit:server:setValue', function(type, value)
    local src = source
    local player = exports.qbx_core:GetPlayer(src)
    if not player then return end
    if not exports.ox_inventory:Search(source, 'count', 'fitbit') >= 1 then return end

    local currentMeta = player.PlayerData.metadata.fitbit
    local fitbitData = {
        thirst = type == "thirst" and value or currentMeta.thirst,
        food = type == "food" and value or currentMeta.food
    }
    player.Functions.SetMetaData('fitbit', fitbitData)
end)
