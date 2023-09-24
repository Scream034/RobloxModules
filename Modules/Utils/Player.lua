-- Модуль для работы с игроком
-- Автор: paralax034

local PlayersService = game:GetService("Players")

local Module = {}

--- Получает игрока, связанного с указанным партом, на основе имени партa.
--- @param part BasePart: Парт, для которого ищем игрока.
--- @param name string: (Опционально) Имя партa, чтобы проверить соответствие.
--- @return Player?: Игрок, связанный с указанным партом, или nil, если игрок не найден.
function Module.GetPlayerByPart(part: BasePart, name: string?): Player?
	if name and part.Name ~= name then return end

	local Character = part.Parent
	if not Character or not Character:IsA("Model") then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	if Humanoid.Health <= 0 then return end

	return PlayersService:GetPlayerFromCharacter(Character)
end

return Module
