-- Для работы с объектами
-- Автор: paralax034

local Module = {}

--- Получить полный путь объекта
--- @param instance Instance: Исходный объект
--- @return string?: Конечный путь
function Module.GetInstancePath(instance: Instance): string?
	if not instance:IsDescendantOf(game) then
		return nil
	end

	local path = instance.Name
	local parent = instance.Parent

	while parent and parent ~= game do
		path = parent.Name .. "/" .. path
		parent = parent.Parent
	end

	return path
end

--- Найти объект по пути
--- @param path string: Путь до объекта
--- @return Instance?: Конечный объект
function Module.GetInstanceFromPath(path: string): Instance?
	local parts = path:split("/")
	local result = game

	for _, value in ipairs(parts) do
		if value == "" then
			break
		end

		result = result:FindFirstChild(value)
	end

	return result
end

return Module
