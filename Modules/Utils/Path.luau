--!strict
--!native

local Module = {}

function Module.FindInstance(root: Instance, fullName: string): Instance?
	local parts = string.split(fullName, ".")
	local currentObject = root

	for _, part in ipairs(parts) do
		currentObject = currentObject:FindFirstChild(part)
		if not currentObject then
			return nil
		end
	end

	return currentObject
end

return Module
