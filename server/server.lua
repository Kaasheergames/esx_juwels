ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

RegisterServerEvent("esx_juwels:koopjuwelen")
AddEventHandler("esx_juwels:koopjuwelen", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getAccount("black_money").money
    local amount = 50000
    local itemamount = xPlayer.getInventoryItem("juwels")

    if inventory >= amount then
        if itemamount.count <=450 then
            xPlayer.removeAccountMoney("black_money", amount)
            xPlayer.addInventoryItem("juwels", 50)
            TriggerClientEvent('esx:showNotification', source, '~g~Je hebt 50 juwelen gekocht.')
        else
            TriggerClientEvent('esx:showNotification', source, '~r~Je hebt teveel juwelen bij je.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Je hebt niet genoeg geld bij je.')
    end
end)

RegisterServerEvent("esx_juwels:smeltjuwelen")
AddEventHandler("esx_juwels:smeltjuwelen", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getInventoryItem("juwels")
    local itemamount = xPlayer.getInventoryItem("golbar")
    local amount = 50

    if itemamount.count >= 10 then
        TriggerClientEvent('esx:showNotification', source, '~r~Je hebt teveel goudstafen bij je.')
    else
        if inventory.count >= 50 then
            xPlayer.removeInventoryItem("juwels", amount)
            xPlayer.addInventoryItem('goldbar', 1)
            TriggerClientEvent('esx:showNotifcation', source, '~g~Je hebt juwelen omgesmolten naar een goudstaaf.')
        else
            TriggerClientEvent('esx:showNotification', source, '~r~Je hebt te weinig juwelen bij je.')
        end
    end
end)