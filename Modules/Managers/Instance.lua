--!strict
--!native

local Module = {}

function Module.GetAllElementsOfType(from: Instance, typeIs: string)
	local elements: {Instance} = {}
	for _, element in pairs(from:GetDescendants()) do
		if element:IsA(typeIs) then
			table.insert(elements, element)
		end
	end

	return elements
end

function Module.CopyChildren(from: Instance, to: Instance): ()
	for _, Child in ipairs(from:GetChildren()) do
		local Clone = Child:Clone()
		Clone.Parent = to
	end
end

return table.freeze(Module)