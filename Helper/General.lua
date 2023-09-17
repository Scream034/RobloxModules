-- Общий Helper
-- Автор paralax034

local PlayersService = game:GetService("Players")

local module = {}

-- Получить игрока через парт и его имя
function module.GetPlayerByPart(part: BasePart, name: string?): Player?
	if name and part.Name ~= name then return end

	local Character = part.Parent
	if not Character or not Character:IsA("Model") then return end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return end
	
	if Humanoid.Health <= 0 then return end
	
	return PlayersService:GetPlayerFromCharacter(Character)
end

-- Создаёт звук на время проигравания
function module.PlaySound(part: BasePart, id: number)
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


return module
