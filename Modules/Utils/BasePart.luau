--!strict
--!native

local Module = {}

function Module.GetBasePartBounds(basePart: BasePart): {Min: Vector3, Max: Vector3}
	local size, position = 
		basePart.Size,
		basePart.Position

	local minX, maxX, minY, maxY, minZ, maxZ = 
		-- X
		position.X - size.X / 2, 
		position.X + size.X / 2,
		-- Y
		position.Y - size.Y / 2, 
		position.Y + size.Y / 2,
		-- Z
		position.Z - size.Z / 2, 
		position.Z + size.Z / 2

	return table.freeze({
		Min = Vector3.new(minX, minY, minZ),
		Max = Vector3.new(maxX, maxY, maxZ)
	})
end

return table.freeze(Module)