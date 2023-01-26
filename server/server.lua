ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

--Config
local goldbar = GoldbarItem
local jewel = Config.JuwelenItem
--

RegisterServerEvent("esx_juwels:koopjuwelen")
AddEventHandler("esx_juwels:koopjuwelen", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getAccount("black_money").money
    local amount = Config.GeldPerJuwelen
    local itemamount = xPlayer.getInventoryItem(jewel)

    if inventory >= amount then
        if itemamount.count <=450 then
            xPlayer.removeAccountMoney("black_money", amount)
            xPlayer.addInventoryItem(jewel, 50)
            TriggerClientEvent('esx:showNotification', source, Config.JuwelenGekocht)
        else
            TriggerClientEvent('esx:showNotification', source, Config.TeveelJuwelen)
        end
    else
        TriggerClientEvent('esx:showNotification', source, Config.GeenGeld)
    end
end)

RegisterServerEvent("esx_juwels:smeltjuwelen")
AddEventHandler("esx_juwels:smeltjuwelen", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getInventoryItem(jewel)
    local itemamount = xPlayer.getInventoryItem(goldbar)
    local amount = 50

    if itemamount.count >= 10 then
        TriggerClientEvent('esx:showNotification', source, Config.TeveelGoud)
    else
        if inventory.count >= 50 then
            xPlayer.removeInventoryItem(jewel, amount)
            xPlayer.addInventoryItem(goldbar, 1)
            TriggerClientEvent('esx:showNotifcation', source, Config.GoudGesmolten)
        else
            TriggerClientEvent('esx:showNotification', source, Config.GeenGoud)
        end
    end
end)