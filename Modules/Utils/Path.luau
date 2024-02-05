--!strict
--!native

local Module = {}

function Module.FindInstance(fullName: string): Instance?
	local parts = string.split(fullName, ".")
	local currentObject = game

	for _, part in ipairs(parts) do
		currentObject = currentObject:FindFirstChild(part)
		if not currentObject then
			return nil
		end
	end
	
	return currentObject.Name ~= "game" and currentObject or nil
end

return Module
