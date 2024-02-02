-- Всё для лёгкой работы с камерой.
-- Автор: paralax034

local Module = {}

-- Получение позиции и углов из камеры.
--
--- Параметры:
---- camera = Камера игрока.
---- positionOffset = Смещение позиции.
---- rotationOffset = Смещение углов.
--
--- Возращает:
---- table = Объект с позицией, углами и направлением камеры.
function Module.GetPositionAndAnglesFromCamera(camera: Camera, positionOffset: Vector3?, rotationOffset: Vector3?)
	assert(typeof(camera) == "Instance" and camera:IsA("Camera"), "Camera must be an instance of the Camera object.")

	positionOffset = positionOffset or Vector3.new(0, 0, 0)
	rotationOffset = rotationOffset or Vector3.new(0, 0, 0)

	local cframe = camera.CFrame
	local position = cframe:PointToWorldSpace(positionOffset)
	local rotation = Vector3.new(cframe:ToOrientation()) + rotationOffset
	local degrees = Vector3.new(math.deg(rotation.X), math.deg(rotation.Y), math.deg(rotation.Z))

	return {
		Position = position,
		Rotation = rotation,
		Degrees = degrees,
		Look = cframe.LookVector
	}
end

return table.freeze(Module)
