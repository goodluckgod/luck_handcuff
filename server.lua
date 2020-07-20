ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/734646689276624966/xNnu1BiD-AX8lxqWNeZh87EX-M3ZCX6Z21GMjMsVwoF3lCsKirBjvOnRTlwzxirgAssK"
local DISCORD_NAME = "luck_handcuff"
local STEAM_KEY = ""
local DISCORD_IMAGE = "https://i.hizliresim.com/uhJ4s3.gif"
local cuffplayer
local cuffedplayer
local a = {}
local size = 0


ESX.RegisterUsableItem(Config.CuffItem, function(source)
_source = source
TriggerClientEvent('luck_handcuff:use', _source)
end)

ESX.RegisterUsableItem("lockpick", function(source)
    _source = source
    TriggerClientEvent('luck_handcuff:uselock', _source)
end)
    
RegisterServerEvent('rStart')
AddEventHandler('rStart',function(message)
    DiscordHook("Resource Started", message, 65280)
    Citizen.Wait(1000)
end)

RegisterServerEvent('rStop')
AddEventHandler('rStop',function(message)
    DiscordHook("Resource Stopped", message, 15158332)
    Citizen.Wait(1000)
end)

  

RegisterServerEvent('luck_handcuff:handcuff')
AddEventHandler('luck_handcuff:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('luck_handcuff:handcuff', target)
end)

RegisterServerEvent('luck_handcuff:givekey')
AddEventHandler('luck_handcuff:givekey', function(player, cuffed)
    TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'inform', text = 'Anahtarı aldın!' })
    TriggerClientEvent('luck_handcuff:keyy', player, cuffed )
    local playerName = GetPlayerName(player)
    local playerName2 = GetPlayerName(_source)
    DiscordHook("Player gave Key", "**" .. playerName2 ..  "** gave key to **" .. playerName .. "**", 65280)
end)



ESX.RegisterServerCallback('luck_handcuff:item', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)



RegisterServerEvent('luck_handcuff:requestarrest')
AddEventHandler('luck_handcuff:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local playerName = GetPlayerName(targetid)
    local playerName2 = GetPlayerName(_source)

    DiscordHook("Player Get Cuffed", "**" .. playerName ..  "** get arested by **" .. playerName2 .. "**", 65280)
    TriggerClientEvent('luck_handcuff:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('luck_handcuff:doarrested', _source)
    xPlayer.removeInventoryItem(Config.CuffItem, 1)
 
end)

RegisterServerEvent('luck_handcuff:itemdel')
AddEventHandler('luck_handcuff:itemdel', function(item)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('luck_handcuff:requestrelease')
AddEventHandler('luck_handcuff:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerName = GetPlayerName(targetid)
    local playerName2 = GetPlayerName(_source)
   
    DiscordHook("Player Get Uncuffed", "**" .. playerName ..  "** relased by **" .. playerName2 .. "**", 65280)
    TriggerClientEvent('luck_handcuff:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('luck_handcuff:douncuffing', _source)
    xPlayer.addInventoryItem(Config.CuffItem, 1)
end)

RegisterServerEvent('luck_handcuff:requestrelease2')
AddEventHandler('luck_handcuff:requestrelease2', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    local playerName = GetPlayerName(targetid)
    local playerName2 = GetPlayerName(_source)
    DiscordHook("Player Get Uncuffed with Lockpick", "**" .. playerName ..  "** relased with lockpick by **" .. playerName2 .. "**", 65280)
    TriggerClientEvent('luck_handcuff:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('luck_handcuff:douncuffing', _source)
end)

function DiscordHook(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "luck of god",
              },
          }
      }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end


