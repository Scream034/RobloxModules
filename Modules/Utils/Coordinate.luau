-- Утилита для работы с математикой координат
-- Автор: paralax034

local Module = {}

-- Получение позици на нормале
--
--- Параметры:
---- originCFrame = Исходный CFrame
---- originSize = Исходный размер
---- normalId = Айди нормали
---- offset = (Опционально) Смещение
--
--- Возращает:
---- Vector3 = Конечную позицию
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

-- Получение позици на нормале
--
--- Параметры:
---- originCFrame = Исходный CFrame
---- originSize = Исходный размер
---- position = Позиция объекта
--
--- Возращает:
---- Enum.NormalId = Нормаль относительно указанной позиции
---- nil = Если нормаль не нашлась, относительно указанной позиции
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

return table.freeze(Module)