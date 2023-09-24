-- Общий Helper
-- Автор paralax034

local PlayersService = game:GetService("Players")

local Module = {}

--- Копирует все дочерние элементы из одного объекта в другой.
--- @param From Instance: Объект, из которого копируются дочерние элементы.
--- @param To Instance: Объект, в который копируются дочерние элементы.
function Module.CopyChildren(from: Instance, to: Instance): ()
	for _, Child in ipairs(from:GetChildren()) do
		local Clone = Child:Clone()
		Clone.Parent = to
	end
end

return Module