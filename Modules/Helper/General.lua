-- Общий Helper
-- Автор paralax034

local PlayersService = game:GetService("Players")

local Module = {}

-- Получить игрока через парт и его имя
function Module.GetPlayerByPart(part: BasePart, name: string?): Player?
	if name and part.Name ~= name then return end

	local Character = part.Parent
	if not Character or not Character:IsA("Model") then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end

	if Humanoid.Health <= 0 then return end

	return PlayersService:GetPlayerFromCharacter(Character)
end

-- Создаёт звук на время проигравания
function Module.PlaySound(part: BasePart, id: number): ()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. tostring(id)  -- ID звука из каталога Roblox
	sound.Parent = part
	sound.RollOffMaxDistance = 128
	sound.RollOffMinDistance = 4
	sound.RollOffMode = Enum.RollOffMode.Linear

	sound:Play()

	sound.Ended:Wait()

	sound:Remove()
end

-- Получить путь объекта
function Module.GetInstancePath(instance: Instance): string?
	if not instance:IsDescendantOf(game) then
		return nil
	end

	local path = instance.Name
	local parent = instance.Parent

	while parent and parent ~= game do
		path = parent.Name .. "/" .. path
		parent = parent.Parent
	end

	return path
end

-- Получить объект по пути
function Module.GetInstanceFromPath(path: string): Instance?
	local parts = path:split("/")
	local result = game
	
	for _, value in ipairs(parts) do
		if value == "" then
			break
		end
		
		result = result:FindFirstChild(value)
	end
	
	return result
end


return Module
