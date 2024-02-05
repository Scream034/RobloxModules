--!strict
--!native

local Module = {}

function Module.FindInstance(fullName: string): Instance?
	local parts = string.split(fullName, ".")
	local currentObject = nil

	for _, part in ipairs(parts) do
		currentObject = currentObject:FindFirstChild(part)
		if not currentObject then
			return nil
		end
	end

	return currentObject
end

return Module
