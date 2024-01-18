-- Модуль для работы с живыми существами
-- Автор: paralax034

local PlayersService = game:GetService("Players")

local Module = {}

--- Получает Humanoid, связанного с указанным партом, на основе имени партa.
--- @param part BasePart: Парт, для которого ищем игрока.
--- @param enableExactSearchMethod boolean?: (Опционально) искать ли соответсвия в строке или полностью по ней.
--- @param name string?: (Опционально) Имя партa, чтобы проверить соответствие.
--- @return Humanoid?: Humanoid, связанный с указанным партом, или nil, если Humanoid не найден.
function Module.GetHumanoidByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Humanoid?
	if name then
		if enableExactSearchMethod then
			if part.Name ~= name then return end
		else
			if part.Name:find(name) == nil then return end
		end
	end

	local Character = part.Parent
	if not (Character and Character:IsA("Model")) then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not (Humanoid and Humanoid.Health > 0) then return end

	return Humanoid
end

--- Получает игрока, связанного с указанным партом, на основе имени партa.
--- @param part BasePart: Парт, для которого ищем игрока.
--- @param enableExactSearchMethod boolean?: (Опционально) искать ли соответсвия в строке или полностью по ней.
--- @param name string?: (Опционально) Имя партa, чтобы проверить соответствие.
--- @return Player?: Игрок, связанный с указанным партом, или nil, если игрок не найден.
function Module.GetPlayerByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Player?
	if name then
		if enableExactSearchMethod then
			if part.Name ~= name then return end
		else
			if part.Name:find(name) == nil then return end
		end
	end

	local Character = part.Parent
	if not (Character and Character:IsA("Model")) then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not (Humanoid and Humanoid.Health > 0) then return end

	return PlayersService:GetPlayerFromCharacter(Character)
end

return Module
