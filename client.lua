local QBCore = exports['qb-core']:GetCoreObject()

exports('qb-npwd:phoneCheck', function()
    return QBCore.Functions.HasItem('phone')
end)