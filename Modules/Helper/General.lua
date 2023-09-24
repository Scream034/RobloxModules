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

-- Создаёт звук
function Module.PlaySound(originPart: BasePart, id: number, minDistance: number, maxDistance: number, isWait: boolean, looped: boolean?, callback: "function"?): ()
	local part = Instance.new("Part", workspace)
	part.Name = "SoundPart_" .. tostring(id)
	part.Anchored = true
	part.Transparency = 1
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Position = originPart.Position
	
	originPart:GetPropertyChangedSignal("CFrame"):Connect(function() 
		part.Position = originPart.Position
	end)
	
	local sound = Instance.new("Sound", part)
	sound.Looped = looped ~= nil
	sound.SoundId = "rbxassetid://" .. tostring(id)  -- ID звука из каталога Roblox
	sound.RollOffMaxDistance = maxDistance
	sound.RollOffMinDistance = minDistance
	
	if callback then
		sound.Ended:Connect(callback)
	end
	
	sound:Play()
	
	if isWait then
		sound.Ended:Wait()
	end
	
	if not looped then
		spawn(function() 
			wait(sound.TimeLength)
			part:Remove()
		end)
	end
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

-- Копирование всех дочерних элементов
function Module.CopyChildren(From: Instance, To: Instance): ()
	for _, Child in ipairs(From:GetChildren()) do
		local Clone = Child:Clone()
		Clone.Parent = To
	end
end

return Module
