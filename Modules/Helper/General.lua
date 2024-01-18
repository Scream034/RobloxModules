-- Общий Helper
-- Автор paralax034

local PlayersService = game:GetService("Players")

local Module = {}

--- Получает все элементы по типу
--- @param from Instance: Объект, в котором будет поиск
--- @param typeIs string: Тип нужных объектов
--- @return {}?:  Массив всех найденных объектов
function Module.GetAllElementsOfType(from: Instance, typeIs: string)
    local elements = {}
    for _, element in pairs(from:GetDescendants()) do
        if element:IsA(typeIs) then
            table.insert(elements, element)
        end
	end
	
	return elements
end

--- Копирует все дочерние элементы из одного объекта в другой.
--- @param from Instance: Объект, из которого копируются дочерние элементы.
--- @param to Instance: Объект, в который копируются дочерние элементы.
function Module.CopyChildren(from: Instance, to: Instance): ()
	for _, Child in ipairs(from:GetChildren()) do
		local Clone = Child:Clone()
		Clone.Parent = to
	end
end

return Module
