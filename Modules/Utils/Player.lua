-- Модуль для работы с игроком
-- Автор: paralax034

local PlayersService = game:GetService("Players")

local Module = {}

--- Получает игрока, связанного с указанным партом, на основе имени партa.
--- @param part BasePart: Парт, для которого ищем игрока.
--- @param methodFindName boolean?: (Опционально) искать ли соответсвия в строке или полностью по ней.
--- @param name string?: (Опционально) Имя партa, чтобы проверить соответствие.
--- @return Player?: Игрок, связанный с указанным партом, или nil, если игрок не найден.
function Module.GetPlayerByPart(part: BasePart, methodFindName: boolean?, name: string?): Player?
	if name then
		if methodFindName then
			if part.Name:find(name) then return end
		else
			if part.Name ~= name then return end
		end
	end

	local Character = part.Parent
	if not Character or not Character:IsA("Model") then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	if Humanoid.Health <= 0 then return end

	return PlayersService:GetPlayerFromCharacter(Character)
end

return Module
