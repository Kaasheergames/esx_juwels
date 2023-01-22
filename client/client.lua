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

local v2 = vector3(-1374.121, -318.4429, 38.50731)
local ped = PlayerPedId()
local v3 = vector3(1084.851, -2002.407, 31.40142)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(coords, v2.x, v2.y, v2.z, true)
        debounce = true
        if dist < 3 then
            debounce = false
            DrawScriptText(vector3(v2.x, v2.y, v2.z + 1), '~b~E~w~ - Koop juwelen ~b~(€50,000)')
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("esx_juwels:koopjuwelen", ped)
                debounce = true
            end
        end
        if debounce then
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(coords, v3.x, v3.y, v3.z, true)
        debounce = true
        if dist < 3 then
            debounce = false
            DrawScriptText(vector3(v3.x, v3.y, v3.z), '~b~E~w~ - Smelt juwelen')
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent("esx_juwels:smeltjuwelen", ped)
                debounce = true
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
    local NPCped = "a_m_o_soucent_03"

    RequestModel(NPCped)
    while not HasModelLoaded(NPCped) do
        Wait(0)
    end

    local NPC = CreatePed(4, NPCped, v2, 167.558, false, true)
    FreezeEntityPosition(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetEntityInvincible(NPC, true)
end)