ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AdminList = {}

local previousJob = {}

TriggerEvent('es:addGroupCommand', 'admin', 'mod', function(source, args, user)
	local found = nil
	local xPlayer = ESX.GetPlayerFromId(source)
	-------------------------------------------------
	local Job = 'staff' -- Staff JOB
    local Grade = 1 -- Staff Job Grade
	-------------------------------------------------
	local Job2 = 'unemployed' -- Job depois de sair do modo admin
    local Grade2 = 0 -- Grade do job depois de sair do modo admin
	-------------------------------------------------
	local Name = xPlayer.getName()
		for i, v in ipairs(AdminList) do
            if v.id == source then
				found = i
				break
			end
        end

        if found == nil then
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, "SERVIDOR", "Ativaste o modo 🛡️ STAFF.", 10000, 'success')
			TriggerEvent('rapozillha_adminmode:updatelist', '~r~Admin', false, source)
            TriggerClientEvent('rapozillha_adminmode:setGodmode', source, true)
			TriggerClientEvent('chat:addMessage', -1, { args = { '^1SERVIDOR:^0 '..Name..' Entrou no modo ^1STAFF^0! 🛡️'} })
            TriggerClientEvent('rapozillha_adminmode:setOutfit', source)
            if ESX.DoesJobExist(Job, Grade) then
			    xPlayer.setJob(Job, Grade)
			end
        else
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, "SERVIDOR", "Desativaste o modo 🛡️ STAFF, não te esqueças de mudar o teu job!!", 10000, 'warning')
            TriggerEvent('rapozillha_adminmode:updatelist', '~r~Admin', true, source)
			TriggerClientEvent('rapozillha_adminmode:setGodmode', source, false)
			TriggerClientEvent('rapozillha_adminmode:civil', source)
			TriggerClientEvent('chat:addMessage', -1, { color = { 255, 0, 0}, args = { '^1SERVIDOR:^0 '..Name..' Saiu do modo ^1STAFF^0! 🚶'} })
			if ESX.DoesJobExist(Job2, Grade2) then
				xPlayer.setJob(Job2, Grade2)
			end
		end
end, function(source, args, user)
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SERVIDOR', 'Não tens permissões para utilizar este comando!' } })
end, {help = 'Ativa o modo admin.'})


ESX.RegisterServerCallback('rapozillha_adminmode:isDuty', function(source, cb)
    local found = nil
    for i, v in ipairs(AdminList) do
        if v.id == source then
            found = i
            break
        end
    end

    if found == nil then
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('rapozillha_adminmode:updatelist')
AddEventHandler('rapozillha_adminmode:updatelist', function(name2, removebool, id)
	if removebool then
		local found = nil
		for i, v in ipairs(AdminList) do
			if v.id == id then
				found = i
				break
			end
		end
		if found ~= nil then
			table.remove(AdminList, found)
		end
	else
		local found = nil
		for i, v in ipairs(AdminList) do
			if v.id == id then
				found = i
				break
			end
		end
		if found ~= nil then
			table.remove(AdminList, found)
		end
		table.insert(AdminList, {name=name2, id=id})
	end
	
    TriggerClientEvent('rapozillha_adminmode:clupdatelist', -1, AdminList)
end) 