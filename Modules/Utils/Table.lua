-- Утилита для таблиц и массивов
-- Автор: paralax034

local module = {}

-- Удаляет все эл-ты до какого-то индекса
function module.RemoveElementsUntilIndex(t: {}, endIndex: number): {}
	local tbl = table.clone(t)
	
	local i = 1
	while i <= endIndex do
		table.remove(tbl, 1)
		i = i + 1
	end
	
	return tbl
end

return module
