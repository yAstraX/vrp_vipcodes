  ----------------------------------
---    |  DESENVOLVIDA POR    |   ----  
---    |     ASTRAX           |   ----
  ----------------------------------
  
  -------------------------------------------------------
--- https://github.com/yAstraX/Fivem-Scripts/tree/master ---
  -------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('ativar', function(source,args,rawCommand)
	TriggerServerEvent("checkcode",source)
end)

RegisterCommand('addcode', function(source,args,rawCommand)
  TriggerServerEvent("addcode",source)
end)