-- Класс работы с датастором игроков
-- Автор: paralax034

local module = {}
local DataStoreService = game:GetService("DataStoreService")

-- Получить датастор у игрока
function module.GetDataStoreValues(datastoreName: string, scopeName: string, userId: string)
	local dataStore = DataStoreService:GetDataStore(datastoreName, scopeName)
	local success, values = pcall(function()
		return dataStore:GetAsync("uid_" .. userId)
	end)
	if success then
		return values
	else
		error("Error: Failed to GetDataStoreValues for " .. "uid_" .. userId)
	end
end

-- Создать значения датастора (значений) у игрока
function module.SetDataStoreValues(datastoreName: string, scopeName: string, userId: string, values: {})
	local dataStore = DataStoreService:GetDataStore(datastoreName, scopeName)
	local success, errorMessage = pcall(function()
		dataStore:SetAsync("uid_" .. userId, values)
	end)
	if not success then
		error("Error: Failed to SetDataStoreValues for " .. userId .. "\nMessage: " .. errorMessage)
	end
end

-- Изменить значения датастора (значений) у игрока
function module.ChangeDataStoreValues(datastoreName: string, scopeName: string, userId: string, values: {})
	local dataStore = DataStoreService:GetDataStore(datastoreName, scopeName)
	local success, errorMessage = pcall(function()
		dataStore:UpdateAsync("uid_" .. userId, function(oldData)
			return values
		end)
	end)
	if not success then
		error("Error: Failed to ChangeDataStoreValues for " .. "uid_" .. userId .. " value: " .. name .. "\nMessage: " .. errorMessage)
	end
end

-- Удалить значения датастора (значений) у игрока
function module.RemoveDataStoreValues(datastoreName: string, scopeName: string, userId: string)
	local dataStore = DataStoreService:GetDataStore(datastoreName, scopeName)
	local success, errorMessage = pcall(function()
		dataStore:RemoveAsync("uid_" .. userId)
	end)
	if not success then
		error("Error: Failed to RemoveDataStoreValues for " .. "uid_" .. userId .. "\nMessage: " .. errorMessage)
	end
end

return module
