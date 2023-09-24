-- Для работы со звуками
-- Автор: paralax034

local Module = {}

--- Создаёт звук и воспроизводит его, затем удаляет или циклирует.
--- @param originPart BasePart: Парт, относительно которого проигрывается звук.
--- @param id number: ID звука из каталога Roblox.
--- @param minDistance number: Минимальное расстояние, на котором звук всегда будет слышен.
--- @param maxDistance number: Максимальное расстояние, на котором звук будет слышен с уменьшением громкости соответствующим образом.
--- @param isWait boolean: Ожидать ли окончания проигрывания звука перед удалением объекта Part.
--- @param looped boolean|nil: (Опционально) Нужно ли циклически проигрывать звук. По умолчанию false.
--- @param callback function|nil: (Опционально) Функция обратного вызова, вызываемая после завершения проигрывания звука.
function Module.Play(originPart: BasePart, id: number, minDistance: number, maxDistance: number, isWait: boolean, looped: boolean?, callback: "function"?): ()
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

return Module
