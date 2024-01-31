-- Для простой работы с путями у объектов роблокс.
-- Автор: paralax034

local Module = {}

-- Получить полный путь объекта от Workspace только по слешу '/'.
--
--- Параметры:
---- instance = Исходный объект.
--
--- Возращает:
---- string = Конечный путь.
---- nil = Если объекта нет в вашей игре.
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

-- Найти объект по пути только по слешу '/'.
--
--- Параметры:
---- path = Путь до объекта.
--
--- Возращает:
---- Instance = Конечный объект.
---- nil = Если объекта нет в вашей игре.
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