--!strict
--!native

local Module = {}

function Module.GetPositionAndAnglesFromCamera(camera: Camera, positionOffset: Vector3?, rotationOffset: Vector3?)
	local positionOffset = positionOffset or Vector3.zero
	local rotationOffset = rotationOffset or Vector3.zero

	local cframe = camera.CFrame
	local position = cframe:PointToWorldSpace(positionOffset)
	local rotation = Vector3.new(cframe:ToOrientation()) + rotationOffset
	local degrees = Vector3.new(math.deg(rotation.X), math.deg(rotation.Y), math.deg(rotation.Z))

	return table.freeze({
		Position = position,
		Rotation = rotation,
		Degrees = degrees,
		Look = cframe.LookVector
	})
end

return table.freeze(Module)