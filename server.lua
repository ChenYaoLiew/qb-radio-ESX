local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("radio", function(source)
    TriggerClientEvent("qb-radio:use", source)
end)

ESX.RegisterServerCallback('qb-radio:server:GetItem', function(source, cb, item)
    local src = source
    local Player = ESX.GetPlayerFromId(source)
    if Player ~= nil then
        local RadioItem = Player.getInventoryItem(item).count
        if RadioItem > 0 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

for channel, config in pairs(Config.RestrictedChannels) do
    exports['pma-voice']:addChannelCheck(channel, function(source)
        local Player = ESX.GetPlayerFromId(source)
        return config[Player.PlayerData.job.name]
    end)
end
