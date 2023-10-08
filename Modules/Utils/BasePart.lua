-- Необходимые функции для работы с BasePart
-- Автор: paralax034

local Module = {}

--- Получение координат позиций границ парта
--- @param basePart BasePart: 3D-объект
--- @return table: Координаты границ парта (Min Vector3, Max Vector3)
function Module.GetBasePartBounds(basePart: BasePart)
	local size = basePart.Size
	local position = basePart.Position
	
	local minX = position.X - size.X / 2
	local maxX = position.X + size.X / 2
	local minY = position.Y - size.Y / 2
	local maxY = position.Y + size.Y / 2
	local minZ = position.Z - size.Z / 2
	local maxZ = position.Z + size.Z / 2
	
	return {
		Min = Vector3.new(minX, minY, minZ),
		Max = Vector3.new(maxX, maxY, maxZ)
	}
end

return Module
