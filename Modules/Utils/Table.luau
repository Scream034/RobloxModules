--!strict
--!native

local Module = {}

function Module.GetKeyByIndex(_table: {[string]: any}, index: number): {}?
	local position = 1
	for key, value in pairs(_table) do
		if position == index then
			return {key, value}
		end
		position += 1
	end
	
	return nil
end

function Module.GetKeyIndexByName(_table: {}, name: string): number?
	local position = 1
	for key in pairs(_table) do
		if key == name then
			return position
		end
		position += 1
	end
	
	return nil
end

function Module.GetKeyIndexByValue<a>(_table: {}, value: a): number?
	local position = 1
	for _, _value in pairs(_table) do
		if _value == value then
			return position
		end
		position += 1
	end

	return nil
end

function Module.ReplaceKeys(_table: {}, keyMappings: {})
	local cloneTable = table.freeze(table.clone(_table))
	
	for oldKey, newKey in pairs(keyMappings) do
		if cloneTable[oldKey] ~= nil then
			_table[newKey] = cloneTable[oldKey]
		end
	end
end

function Module.UpdateExistingKeys(_table: {}, fromTable: {})
	for newKey, value in pairs(fromTable) do
		local pair = Module.GetKeyByIndex(_table, Module.GetKeyIndexByName(_table, newKey) :: number)
		if not pair then continue end
		
		_table[pair[1]] = value
	end
end

return table.freeze(Module)