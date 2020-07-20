local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }


ESX = nil

local PlayerData              = {}
local IsHandcuffed            = false   
local isDead = false
local hasAlreadyJoined = false 
local cuffedPlayer = "null" 
local cuffPlayer
local keygiven



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
end)


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('luck_handcuff:unrestrain')
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	cuffedPlayer = false
end)


RegisterNetEvent('luck_handcuff:unrestrain')
AddEventHandler('luck_handcuff:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false
        cuffedPlayer = "null"
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)


RegisterCommand('kcozs', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if cuffPlayer == GetPlayerPed(-1) then
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
	
		if distance <= 2.0 then
			if target_id == cuffedPlayer then
			TriggerServerEvent('luck_handcuff:requestrelease', target_id, playerheading, playerCoords, playerlocation)
			cuffedPlayer = "null"
			if keygiven then
				cuffPlayer = "null"
			end
	
			else
				exports['mythic_notify']:DoHudText('error', 'Kişi kelepçeli değil!')
			end
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Yakında birisi yok!')
	end
else

	exports['mythic_notify']:DoHudText('error', 'Anahtarın yok!')
end

end)

RegisterNetEvent('luck_handcuff:keyy')
AddEventHandler('luck_handcuff:keyy', function(cuff)
cuffPlayer = GetPlayerPed(-1)
cuffedPlayer = cuff
keygiven = true
end)


RegisterCommand('kver', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if cuffPlayer == GetPlayerPed(-1) then
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
	local target, distance = ESX.Game.GetClosestPlayer()
	
	if GetPlayerServerId(closestPlayer) ~=  cuffedPlayer and distance <= 2.0 then 
	
		if distance <= 2.0 then
		local target_id = GetPlayerServerId(target)
		TriggerServerEvent('luck_handcuff:givekey', target_id, cuffedPlayer)
		cuffPlayer = "null"
		cuffedPlayer = "null"
		exports['mythic_notify']:DoHudText('success', 'Anahtarı verdin!')
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Kişi kelepçeli!')	
	end
	else
		exports['mythic_notify']:DoHudText('error', 'Yakında birisi yok!')
	end	
else
	exports['mythic_notify']:DoHudText('error', 'Anahtarın yok!')
end
end)


RegisterNetEvent('luck_handcuff:uselock')
AddEventHandler('luck_handcuff:uselock', function()
	if cuffPlayer ~= GetPlayerPed(-1) then
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		if distance <= 2.0 then
			local skill = skillbar()
			if skill then
			local skill = skillbar()
			if skill then
				local skill = skillbar()
				if skill then
			exports['mythic_notify']:DoHudText('success', 'Kelepçeyi açtın!')
			TriggerServerEvent('luck_handcuff:requestrelease2', target_id, playerheading, playerCoords, playerlocation)
		    else
			exports['mythic_notify']:DoHudText('error', 'Maymuncuğun büküldü!')
			TriggerServerEvent('luck_handcuff:itemdel', "lockpick")
			end
		else
			exports['mythic_notify']:DoHudText('error', 'Maymuncuğun büküldü!')
			TriggerServerEvent('luck_handcuff:itemdel', "lockpick")
			end
		else
			exports['mythic_notify']:DoHudText('error', 'Maymuncuğun büküldü!')
			TriggerServerEvent('luck_handcuff:itemdel', "lockpick")
		    end
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Yakında birisi yok!')
	end
else
	exports['mythic_notify']:DoHudText('error', 'Zaten anahtarın var!')
	end

end)




skillbar = function()
    while true do
        Citizen.Wait(5)
        local basaramadim = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))           
        if basaramadim ~= 100 then
            return false
            else   
             return true
            end
    end
end

RegisterNetEvent('luck_handcuff:use')
AddEventHandler('luck_handcuff:use', function()
	if cuffedPlayer == "null" then
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
	ESX.TriggerServerCallback('luck_handcuff:item', function(qtty)
		if qtty > 0 then 
	   
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		if cuffedPlayer ~= target_id then
		if distance <= 2.0 then
			cuffPlayer = GetPlayerPed(-1)
			cuffedPlayer = target_id
			TriggerServerEvent('luck_handcuff:requestarrest', target_id, playerheading, playerCoords, playerlocation)
		end
	else
		exports['mythic_notify']:DoHudText('error', 'Kişi zaten kelepçeli!')
	end


  
else
	exports['mythic_notify']:DoHudText('error', 'Kelepçen yok!')
end
end, Config.CuffItem)
else
	exports['mythic_notify']:DoHudText('error', 'Yakında birisi yok!')
end
else
	exports['mythic_notify']:DoHudText('error', 'Birden fazla kişiyi kelepçeleyemezsin!')
end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(0, 102, true) -- Disable Jump on foot
			DisableControlAction(0, 143, true) -- Disable Jump on foot
			DisableControlAction(0, 18, true) -- Disable Jump on foot
			DisableControlAction(0, 22, true) -- Disable Jump on foot

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('luck_handcuff:getarrested')
AddEventHandler('luck_handcuff:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	TriggerEvent('luck_handcuff:handcuff')
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	TriggerEvent('esx_status:add', 'stress', 25000)
	exports['mythic_notify']:SendUniqueAlert('id', 'error', 'Stresin arttı')
end)





RegisterNetEvent('luck_handcuff:doarrested')
AddEventHandler('luck_handcuff:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent('luck_handcuff:douncuffing')
AddEventHandler('luck_handcuff:douncuffing', function()
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('luck_handcuff:handcuff')
AddEventHandler('luck_handcuff:handcuff', function()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerServerEvent('rStart', "luck_handcuff started.")
	end
end)

RegisterNetEvent('luck_handcuff:getuncuffed')
AddEventHandler('luck_handcuff:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	IsHandcuffed = false
	TriggerEvent('luck_handcuff:handcuff')
	ClearPedTasks(GetPlayerPed(-1))
	TriggerEvent('esx_status:remove', 'stress', 20000)
	exports['mythic_notify']:SendUniqueAlert('id', 'error', 'Stresin azaldı')
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('luck_handcuff:unrestrain')
		TriggerServerEvent('rStop', "luck_handcuff stoped.")
	end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end




