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
