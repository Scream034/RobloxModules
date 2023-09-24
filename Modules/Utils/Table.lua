-- Утилита для таблиц и массивов
-- Автор: paralax034

local Module = {}

-- Удаляет все эл-ты до какого-то индекса
function Module.RemoveElementsUntilIndex(t: {}, endIndex: number): {}
	local tbl = table.clone(t)
	
	local i = 1
	while i <= endIndex do
		table.remove(tbl, 1)
		i = i + 1
	end
	
	return tbl
end

-- Обновить ключи, которые указаны
function Module.UpdateExistingKeys(table: {}, keyMappings: {})
	for oldKey, newKey in pairs(keyMappings) do
		if table[oldKey] ~= nil then
			table[newKey] = table[oldKey]
			table[oldKey] = nil
		end
	end
end

return Module
