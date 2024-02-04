--!strict
--!native

local Module = {}

function Module.GetPositionAndAnglesFromCamera(camera: Camera, positionOffset: Vector3?, rotationOffset: Vector3?)
	local positionOffset = positionOffset or Vector3.zero
	local rotationOffset = rotationOffset or Vector3.zero

	local cframe = camera.CFrame
	local position = cframe:PointToWorldSpace(positionOffset)
	local rotation = Vector3.new(cframe:ToOrientation()) + rotationOffset

	return table.freeze({
		Position = position,
		Rotation = rotation,
		Look = cframe.LookVector
	})
end

function Module.GetDegrees(rotation: Vector3)
	return Vector3.new(math.deg(rotation.X), math.deg(rotation.Y), math.deg(rotation.Z))
end

return table.freeze(Module)
