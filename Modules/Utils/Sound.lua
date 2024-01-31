-- Для простой работы со звуками.
-- Автор: paralax034

local Module = {}

-- Создаёт звук и воспроизводит его, затем удаляет или циклирует.
--
--- Параметры:
---- originPart = Парт, относительно которого проигрывается звук.
---- id = ID звука из каталога Roblox.
---- minDistance = Минимальное расстояние, на котором звук всегда будет слышен.
---- maxDistance = Максимальное расстояние, на котором звук будет слышен с уменьшением громкости соответствующим образом.
---- isWait = Ожидать ли окончания проигрывания звука перед удалением объекта Part.
---- looped = (Опционально) Нужно ли циклически проигрывать звук. По умолчанию false.
---- callback = (Опционально) Функция обратного вызова, вызываемая после завершения проигрывания звука.
function Module.Play(originPart: BasePart, id: number, minDistance: number, maxDistance: number, isWait: boolean, looped: boolean?, callback: "function"?): never
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