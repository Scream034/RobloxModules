-- Утилита для работы с математикой партов
-- Автор: paralax034

local module = {}

-- Получить позицию по направлению нормали
--- Пример: UtilsBasePart.GetPositionOnNormal(Parent.CFrame, Parent.Size, Enum.NormalId.Left)
function module.GetPositionOnNormal(originCframe: CFrame, originSize: Vector3, normalId: Enum.NormalId, position: Vector3?): Vector3
	position = position or Vector3.zero
	local result = Vector3.zero
	
	if normalId == Enum.NormalId.Right then
		result = originCframe:PointToWorldSpace(Vector3.new(originSize.X, 0, 0) + position)
	elseif normalId == Enum.NormalId.Left then
		result = originCframe:PointToWorldSpace(Vector3.new(-originSize.X, 0, 0) + position)
	elseif normalId == Enum.NormalId.Front then
		result = originCframe:PointToWorldSpace(Vector3.new(0, 0, -originSize.Z) + position)
	elseif normalId == Enum.NormalId.Back then
		result = originCframe:PointToWorldSpace(Vector3.new(0, 0, originSize.Z) + position)
	elseif normalId == Enum.NormalId.Top then
		result = originCframe:PointToWorldSpace(Vector3.new(0, originSize.Y, 0) + position)
	elseif normalId == Enum.NormalId.Bottom then
		result = originCframe:PointToWorldSpace(Vector3.new(0, -originSize.Y, 0) + position)
	end
	
	return result
end

return module
