-- Модуль для поиска персонажей.
-- Автор: paralax034

local PlayersService = game:GetService("Players")

local Module = {}

-- Функция проверки имен.
--
--- Возращает:
---- true = Если имена совпали.
---- false = Если имена несовпали.
local function IsPartEqualsPassedName(partName: string, enableExactSearchMethod: boolean?, name: string?)
	return if enableExactSearchMethod then partName ~= name else partName:find(name or "") == nil
end

-- Получает Humanoid, связанного с указанным партом, на основе имени партa.
--
--- Параметры:
---- part = Парт, для которого ищем игрока.
---- enableExactSearchMethod = (Опционально) искать ли соответсвия в строке или полностью по ней.
---- name = (Опционально) Имя партa, чтобы проверить соответствие.
--
--- Возращает:
---- Humanoid = Связанный с указанным партой.
---- nil = Если Humanoid не найден.
function Module.GethumanoidByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Humanoid?
	if IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = part.Parent
	if not (character and character:IsA("Model")) then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not (humanoid and humanoid.Health > 0) then return end

	return humanoid
end

-- Получает игрока, связанного с указанным партом, на основе имени партa.
--
--- Параметры:
---- part = Парт, для которого ищем игрока.
---- enableExactSearchMethod = (Опционально) искать ли соответсвия в строке или полностью по ней.
---- name = (Опционально) Имя партa, чтобы проверить соответствие.
--
--- Возращает:
---- Player = Игрок, связанный с указанным партом.
---- nil = Если игрок не найден.
function Module.GetPlayerByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Player?
	if IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = part.Parent
	if not (character and character:IsA("Model")) then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not (humanoid and humanoid.Health > 0) then return end

	return PlayersService:GetPlayerFromcharacter(character)
end

return table.freeze(Module)