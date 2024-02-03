--!strict
--!native

local Module = {}

function Module.GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalId: Enum.NormalId, positionOffset: Vector3?): Vector3
	local positionOffset = positionOffset or Vector3.zero
	local result: Vector3?

	if normalId == Enum.NormalId.Right then
		result = originCframe:PointToWorldSpace(Vector3.new(originSize.X, 0, 0) + positionOffset)
	elseif normalId == Enum.NormalId.Left then
		result = originCframe:PointToWorldSpace(Vector3.new(-originSize.X, 0, 0) + positionOffset)
	elseif normalId == Enum.NormalId.Front then
		result = originCframe:PointToWorldSpace(Vector3.new(0, 0, -originSize.Z) + positionOffset)
	elseif normalId == Enum.NormalId.Back then
		result = originCframe:PointToWorldSpace(Vector3.new(0, 0, originSize.Z) + positionOffset)
	elseif normalId == Enum.NormalId.Top then
		result = originCframe:PointToWorldSpace(Vector3.new(0, originSize.Y, 0) + positionOffset)
	elseif normalId == Enum.NormalId.Bottom then
		result = originCframe:PointToWorldSpace(Vector3.new(0, -originSize.Y, 0) + positionOffset)
	end

	return result or Vector3.zero
end

function Module.GetNormalRelativeToPosition(originCFrame: CFrame, originSize: Vector3, position: Vector3): Enum.NormalId?
	local originCenter = originCFrame.Position
	local positionVector = (position - originCenter).Unit
	
	assert(positionVector.Magnitude ~= 0, "The position is in the center of the object!")

	local xVector, yVector, zVector = 
		originCFrame.RightVector, 
		originCFrame.UpVector, 
		originCFrame.LookVector

	local dotX, dotY, dotZ = 
		positionVector:Dot(xVector),
		positionVector:Dot(yVector),
		positionVector:Dot(zVector)
	
	assert(dotX ~= 0 and dotY ~= 0 and dotZ ~= 0, "The position is outside the object.")

	local absX, absY, absZ = 
		math.abs(dotX), 
		math.abs(dotY), 
		math.abs(dotZ)
	
	local maxDot = math.max(absX, absY, absZ)

	if maxDot == absX then
		return dotX > 0 and Enum.NormalId.Right or Enum.NormalId.Left
	elseif maxDot == absY then
		return dotY > 0 and Enum.NormalId.Top or Enum.NormalId.Bottom
	elseif maxDot == absZ then
		return dotZ > 0 and Enum.NormalId.Front or Enum.NormalId.Back
	end

	return nil
end

return table.freeze(Module)