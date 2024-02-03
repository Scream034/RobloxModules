--!strict
--!native

local PlayersService = game:GetService("Players")

local Module = {}

local function IsPartEqualsPassedName(partName: string, enableExactSearchMethod: boolean?, name: string?): boolean
	return if enableExactSearchMethod then partName ~= name else partName:find(name or "") == nil
end

function Module.GetHumanoidByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Humanoid?
	if IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = part.Parent
	if not (character and character:IsA("Model")) then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not (humanoid and humanoid.Health > 0) then return end

	return humanoid
end

function Module.GetPlayerByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Player?
	if IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = part.Parent
	if not (character and character:IsA("Model")) then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not (humanoid and humanoid.Health > 0) then return end

	return PlayersService:GetPlayerFromcharacter(character)
end

return table.freeze(Module)