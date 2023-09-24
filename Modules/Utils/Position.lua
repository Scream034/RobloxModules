-- Утилита для работы с математикой координат
-- Автор: paralax034

local Module = {}

--- Получение позици на нормале
--- @param originCFrame CFrame: Исходный CFrame
--- @param originSize Vector3: Исходный размер
--- @param normalId Enum.NormalId: Айди нормали
--- @param offset Vector3?: Смещение
--- @return Vector3: Конечную позицию
function Module.GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalId: Enum.NormalId, positionOffset: Vector3?): Vector3
	positionOffset = positionOffset or Vector3.zero
	local result = Vector3.zero

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

	return result
end

--- Получение позици на нормале
--- @param originCFrame CFrame: Исходный CFrame
--- @param originSize Vector3: Исходный размер
--- @param position Vector3: Позиция объекта
--- @return Enum.NormalId?: Нормаль относительно указанной позиции
function Module.GetNormalRelativeToPosition(originCFrame: CFrame, originSize: Vector3, position: Vector3): Enum.NormalId?
	local originCenter = originCFrame.Position
	local positionVector = (position - originCenter).Unit

	if positionVector.Magnitude == 0 then
		warn("The position is in the center of the object!")
		return nil
	end

	local xVector = originCFrame.RightVector
	local yVector = originCFrame.UpVector
	local zVector = originCFrame.LookVector

	local dotX = positionVector:Dot(xVector)
	local dotY = positionVector:Dot(yVector)
	local dotZ = positionVector:Dot(zVector)

	if dotX == 0 and dotY == 0 and dotZ == 0 then
		warn("The position is outside the object!")
		return nil
	end

	local absX = math.abs(dotX)
	local absY = math.abs(dotY)
	local absZ = math.abs(dotZ)

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

--- Получение позиции и углов из камеры
--- @param camera Camera: Камера игрока
--- @param positionOffset Vector3?: Смещение позиции
--- @param rotationOffset Vector3?: Смещение углов
--- @return table: Объект с позицией, углами и направлением камеры
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

return Module