ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(10)
	  end
	  
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local v2 =  Config.NPCLocation
local v3 =  Config.SmeltLocation


Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(0)
        local coords = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(coords, v2.x, v2.y, v2.z, true)
        debounce = true
        local localmessage = Config.InkoopTekst
        local distancemessage = Config.InkoopAfstandTekst
        if dist < 3 then
            debounce = false
            if dist <1.5 then
                DrawScriptText(vector3(v2.x, v2.y, v2.z + 1), localmessage)
                if IsControlJustReleased(0, Config.Interactie) then
                   TriggerServerEvent("esx_juwels:koopjuwelen", ped)
                   print("Event getriggerd")
                   debounce = true
                end
            else
               DrawScriptText(vector3(v2.x, v2.y, v2.z + 1), distancemessage)
            end
        end
        if debounce then
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(0)
        local coords = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(coords, v3.x, v3.y, v3.z, true)
        local distancemessage = Config.SmeltTekstAfstand
        local localmessage = Config.SmeltTekst
        debounce = true
        if dist < 3 then
            debounce = false
            if dist < 1.5 then
                DrawScriptText(vector3(v3.x, v3.y, v3.z), localmessage)
                if IsControlJustReleased(0, Config.Interactie) then 
                    TriggerServerEvent("esx_juwels:smeltjuwelen", ped)
                    if Config.Developer then
                        print("Event getriggerd")
                    end
                    debounce = true
                end
            else
                DrawScriptText(vector3(v3.x, v3.y, v3.z), distancemessage)
            end
        end
        if debounce then
            Wait(500)
        end
    end
end)

--functions

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)
end




CreateThread(function(NPCped)
    local NPCped = Config.NPC

    RequestModel(NPCped)
    while not HasModelLoaded(NPCped) do
        Wait(0)
    end

    local NPC = CreatePed(4, NPCped, v2, Config.NPCHeading, false, true)
    FreezeEntityPosition(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetEntityInvincible(NPC, true)
    if Config.ToggleAnimation then
        TaskStartScenarioInPlace(NPC, 'WORLD_HUMAN_SMOKING', 0, true)
    end
    if Config.Developer then
        print("NPC gemaakt")
    end
end)