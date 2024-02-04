--!strict
--!native

local PlayersService = game:GetService("Players")

local Module = {}

local function IsPartEqualsPassedName(partName: string, enableExactSearchMethod: boolean?, name: string?): boolean
	return not enableExactSearchMethod and partName == name or partName:find(name or "") ~= nil
end

local function GetCharacterFromPart(part: BasePart): Model?
	local character = part.Parent
	return character and character:IsA("Model") and character or nil
end

local function GetHumanoidFromCharacter(character: Model): Humanoid?
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	return humanoid and humanoid.Health > 0 and humanoid or nil
end

function Module.GetHumanoidByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Humanoid?
	if not IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = GetCharacterFromPart(part)
	if not character then return end

	return GetHumanoidFromCharacter(character)
end

function Module.GetPlayerByPart(part: BasePart, enableExactSearchMethod: boolean?, name: string?): Player?
	if not IsPartEqualsPassedName(part.Name, enableExactSearchMethod, name) then return end

	local character = GetCharacterFromPart(part)
	if not character then return end

	local humanoid = GetHumanoidFromCharacter(character)
	if not humanoid then return end

	return PlayersService:GetPlayerFromcharacter(character)
end

return table.freeze(Module)
