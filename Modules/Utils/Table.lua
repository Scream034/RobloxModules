-- Утилита для таблиц и массивов.
-- Автор: paralax034

local Module = {}

-- Удалить все элементы из таблицы до номера.
--
--- Параметры:
---- table = Исходная таблица.
---- endIndex = Номер до которого будут удалены.
--
--- Возращает:
--- {} = Таблицу с удалёнными элементами.
function Module.RemoveElementsUntilIndex(table: {}, endIndex: number): {}
	local tbl = table.clone(table)

	local i = 1
	while i <= endIndex do
		table.remove(tbl, 1)
		i = i + 1
	end

	return tbl
end

--- Обновить уже существующие ключи на новые.
--
--- Параметры:
---- table = Исходная таблица.
---- keyMappings = Ключи, которые нужно обновить.
--
--- Возращает:
--- {} = Таблицу с обновлёнными элементами.
function Module.UpdateExistingKeys(table: {}, keyMappings: {})
	for oldKey, newKey in pairs(keyMappings) do
		if table[oldKey] ~= nil then
			table[newKey] = table[oldKey]
			table[oldKey] = nil
		end
	end
end

return Module
