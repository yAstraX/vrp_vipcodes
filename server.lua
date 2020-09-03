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
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("creative/get_code","SELECT * FROM vrp_vipcode WHERE codigos = @codigos")
vRP._prepare("creative/add_code","INSERT IGNORE INTO vrp_vipcode(id,codigos,qtd) VALUES(@id,@codigos,@qtd)")
vRP._prepare("creative/rem_code","DELETE FROM vrp_vipcode WHERE codigos = @codigos AND qtd = @qtd")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG VIPS
-----------------------------------------------------------------------------------------------------------------------------------------

local groupvip1 = "Bronze"
local groupvip2 = "Ouro"
local groupvip3 = "Diamante"

local moneyvip1 = 800000
local moneyvip2 = 1600000
local moneyvip3 = 3600000

-----------------------------------------------------------------------------------------------------------------------------------------
-- LISTA DE CARROS VIPS
-----------------------------------------------------------------------------------------------------------------------------------------

local carsvips = { --lista de veiculos permitidos para pegar no vip
	{'insurgent2'},
	{'contender'},
	{'baller5'},
	{'guardian'}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- Evento
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('addcode')
AddEventHandler('addcode',function()
    local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local id = vRP.prompt(source,"Qual vip ? 1 = bronze, 2 = Gold, 3 = Diamante :","")
		if tonumber(id) == 1 or tonumber(id) == 2 or tonumber(id) == 3 then 
			local name = vRP.prompt(source,"Insira novo codigo vip:","")
			vRP.execute("creative/add_code",{ id = id, codigos = name, qtd = 1 })
			TriggerClientEvent("Notify",source,"sucesso","O codigo <b>"..name.."</b> foi adicionado a lista!",8000)
		else
	  		TriggerClientEvent("Notify",source,"aviso","Vip não encontrado tente usar <b>1</b>, <b>2</b> ou <b>3</b> !",8000)
		end
	end
end)

RegisterNetEvent('checkcode')
AddEventHandler('checkcode',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local name = vRP.prompt(source,"Insira seu codigo vip:","")
		local codigos = vRP.query("creative/get_code",{ codigos = name })
		if parseInt(codigos[1].quantidade) <= 1 then
			TriggerClientEvent("Notify",source,"sucesso","O codigo <b>"..name.."</b> é um codigo válido!",8000)			
			local id = vRP.query("creative/get_code",{ id = tonumber(id), codigos = name})
			
			if id[1].id == 1 then				
				local carro1 = vRP.prompt(source,"Escolha um carro vip:","")
				for _, carTable in ipairs(carsvips) do
					if carro1 == carTable[1] then
						if parseInt(codigos[1].quantidade) <= 1 then
							vRP.execute("creative/rem_code",{ codigos = name, qtd = 1 })
							vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro1, ipva = parseInt(os.time()) }) 
							vRP.addUserGroup(user_id,groupvip1)
							vRP.giveBankMoney(user_id,moneyvip1)
							TriggerClientEvent("Notify",source,"sucesso","Vip <b>"..groupvip1.."</b> recebido!",8000)
								SetTimeout(6000,function()
								TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro1.."</b> foi adicionado a sua garagem!",8000)
									SetTimeout(6000,function()
									TriggerClientEvent("Notify",source,"sucesso","<b>"..moneyvip1.."</b> foi depositado em seu banco!",8000)
								end)
							end)
						else
							TriggerClientEvent("Notify",source,"sucesso","Seja mais experto dá proxima vez e um presentinho para você!",8000)						
						end				
					end
				end				
			elseif id[1].id == 2 then
				local carro1 = vRP.prompt(source,"Escolha um carro vip:","")
				local carro2 = vRP.prompt(source,"Escolha mais um carro vip:","")
				for _, carTable in ipairs(carsvips) do
					if carro1 == carTable[1] then	
						for _, carTable in ipairs(carsvips) do
							if carro2 == carTable[1] then						
								if parseInt(codigos[1].quantidade) <= 1 then
								vRP.execute("creative/rem_code",{ codigos = name, qtd = 1 })
								vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro1, ipva = parseInt(os.time()) }) 
								vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro2, ipva = parseInt(os.time()) })								  
								vRP.addUserGroup(user_id,groupvip2)
								vRP.giveBankMoney(user_id,moneyvip2)
								TriggerClientEvent("Notify",source,"sucesso","Vip <b>"..groupvip2.."</b> recebido!",8000)
									SetTimeout(6000,function()
									TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro1.."</b> foi adicionado a sua garagem!",8000)
										SetTimeout(6000,function()
										TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro2.."</b> foi adicionado a sua garagem!",8000)
											SetTimeout(6000,function()
											TriggerClientEvent("Notify",source,"sucesso","<b>"..moneyvip2.."</b> foi depositado em seu banco!",8000)
										end)
									end)
								end)
							else
								TriggerClientEvent("Notify",source,"sucesso","Seja mais experto dá proxima vez e um presentinho para você!",8000)					
								end	
							end
						end			
					end
				end

			elseif id[1].id == 3 then								
				local carro1 = vRP.prompt(source,"Escolha um carro vip:","")
				local carro2 = vRP.prompt(source,"Escolha mais um carro vip:","")
				local carro3 = vRP.prompt(source,"Escolha mais um carro vip:","")
				for _, carTable in ipairs(carsvips) do
					if carro1 == carTable[1] then	
						for _, carTable in ipairs(carsvips) do
							if carro2 == carTable[1] then		
								for _, carTable in ipairs(carsvips) do
									if carro3 == carTable[1] then					
										if parseInt(codigos[1].quantidade) <= 1 then
										vRP.execute("creative/rem_code",{ codigos = name, qtd = 1 })
										vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro1, ipva = parseInt(os.time()) }) 
										vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro2, ipva = parseInt(os.time()) })
										vRP.execute("creative/add_vehicle",{ user_id = tonumber(vRP.getUserId(source)) , vehicle = carro3, ipva = parseInt(os.time()) }) 
										vRP.addUserGroup(user_id,groupvip3)
										vRP.giveBankMoney(user_id,moneyvip3)
										TriggerClientEvent("Notify",source,"sucesso","Vip <b>"..groupvip3.."</b> recebido!",8000)
											SetTimeout(6000,function()
											TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro1.."</b> foi adicionado a sua garagem!",8000)
												SetTimeout(6000,function()
												TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro2.."</b> foi adicionado a sua garagem!",8000)
													SetTimeout(6000,function()
													TriggerClientEvent("Notify",source,"sucesso","O Carro <b>"..carro3.."</b> foi adicionado a sua garagem!",8000)
														SetTimeout(6000,function()
														TriggerClientEvent("Notify",source,"sucesso","<b>"..moneyvip3.."</b> foi depositado em seu banco!",8000)
													end)
												end)
											end)
										end)
									else
										TriggerClientEvent("Notify",source,"sucesso","Seja mais experto dá proxima vez e um presentinho para você!",8000)					
										end
									end	
								end
							end
						end			
					end
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Não encontramos o id de seu vip!",8000)	
			end
		end
	end
end)