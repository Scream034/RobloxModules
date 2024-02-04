--!strict
--!native

local Module = {}

local function GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalVector: Vector3, positionOffset: Vector3): Vector3
	return originCframe:PointToWorldSpace(normalVector * originSize / 2 + positionOffset)
end

function Module.GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalId: Enum.NormalId, positionOffset: Vector3?): Vector3
	local positionOffset = positionOffset or Vector3.zero
	local normalVector = Vector3.FromNormalId(normalId)
	return GetPositionOnNormal(originCframe, originSize, normalVector, positionOffset)
end

function Module.GetNormalRelativeToPosition(originCFrame: CFrame, originSize: Vector3, position: Vector3): Enum.NormalId?
	local localPosition = originCFrame:Inverse() * position
	local relativePosition = localPosition / originSize

	local maxAxis = math.max(math.abs(relativePosition.X), math.abs(relativePosition.Y), math.abs(relativePosition.Z))

	if maxAxis == math.abs(relativePosition.X) then
		return relativePosition.X > 0 and Enum.NormalId.Right or Enum.NormalId.Left
	elseif maxAxis == math.abs(relativePosition.Y) then
		return relativePosition.Y > 0 and Enum.NormalId.Top or Enum.NormalId.Bottom
	elseif maxAxis == math.abs(relativePosition.Z) then
		return relativePosition.Z > 0 and Enum.NormalId.Front or Enum.NormalId.Back
	end

	return nil
end

return table.freeze(Module)
