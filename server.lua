AddEventHandler('QBCore:Server:PlayerLoaded', function(qbPlayer)
  debugPrint('QBPlayer:')
  printTable(qbPlayer)
  local playerIdent = qbPlayer.PlayerData.citizenid
  local phoneNumber = tostring(qbPlayer.PlayerData.charinfo.phone)
  local charInfo = qbPlayer.PlayerData.charinfo
  local playerSrc = qbPlayer.PlayerData.source

  exports.oxmysql:executeSync('UPDATE players SET phone_number = ? WHERE citizenid = ?', { phoneNumber, playerIdent })

  TriggerEvent('npwd:newPlayer', {
    source = playerSrc,
    phoneNumber = charInfo.phone,
    identifier = playerIdent,
    firstname = charInfo.firstname,
    lastname = charInfo.lastname
  })
  debugPrint(('Loaded new player. S: %s, Iden: %s, Num: %s'):format(playerSrc, playerIdent, phoneNumber))
end)

local currentResName = GetCurrentResourceName()
AddEventHandler('onResourceStart', function(resName)
  if resName ~= currentResName then return end

  debugPrint('Launched with debug mode on')
  local players = QBCore.Functions.GetQBPlayers()

  for _,v in pairs(players) do
    TriggerEvent('npwd:newPlayer', {
      source = v.PlayerData.source,
      identifier = v.PlayerData.citizenid,
      phoneNumber = v.PlayerData.charinfo.phone,
      firstname = v.PlayerData.charinfo.firstname,
      lastname = v.PlayerData.charinfo.firstname,
    })
  end
end)