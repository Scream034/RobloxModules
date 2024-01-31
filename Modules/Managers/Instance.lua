-- Вспомогательные методы для объектов в Roblox
-- Автор paralax034

local Module = {}

-- Получает все элементы по типу
--
--- Параметры:
---- from = Объект, в котором будет поиск
---- typeIs = Тип нужных объектов
--
--- Возращает:
---- {} = Массив всех найденных объектов, может содержать НИЧЕГО.
function Module.GetAllElementsOfType(from: Instance, typeIs: string)
	local elements = {}
	for _, element in pairs(from:GetDescendants()) do
		if element:IsA(typeIs) then
			table.insert(elements, element)
		end
	end

	return elements
end

-- Копирует все дочерние элементы из одного объекта в другой.
--
--- Параметры:
---- from = Объект, из которого копируются дочерние элементы.
---- param = Объект, в который копируются дочерние элементы.
function Module.CopyChildren(from: Instance, to: Instance): never
	for _, Child in ipairs(from:GetChildren()) do
		local Clone = Child:Clone()
		Clone.Parent = to
	end
end

return Module