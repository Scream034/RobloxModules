--!native

local Module = {}

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

return table.freeze(Module)
