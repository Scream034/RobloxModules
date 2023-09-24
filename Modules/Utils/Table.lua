-- Утилита для таблиц и массивов
-- Автор: paralax034

local Module = {}

--- Удалить все элементы из таблицы до номера
--- @param table {}: Исходная таблица
--- @param endIndex number: Номер
--- @return {}: Таблицу с удалёнными элементами
function Module.RemoveElementsUntilIndex(table: {}, endIndex: number): {}
	local tbl = table.clone(table)

	local i = 1
	while i <= endIndex do
		table.remove(tbl, 1)
		i = i + 1
	end

	return tbl
end

--- Обновить ключи, которые указаны
--- @param table {}: Исходная таблица
--- @param keyMappings {}: Ключи, которые нужно обновить
--- @return {}: Таблицу с обновлёнными элементами
function Module.UpdateExistingKeys(table: {}, keyMappings: {})
	for oldKey, newKey in pairs(keyMappings) do
		if table[oldKey] ~= nil then
			table[newKey] = table[oldKey]
			table[oldKey] = nil
		end
	end
end

return Module
