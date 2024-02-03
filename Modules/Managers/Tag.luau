--!strict
--!native

local CollectionService = game:GetService("CollectionService")

local Module = {}

function Module.Initialize()
	local tagsManager = {}
	local tags: {string | (Instance) -> ()} = {}
	tagsManager.Tags = tags


	function tagsManager:Add(tagName: string, tagRegisteredCallback: (Instance) -> (), unregisterTagCallback: () -> ())
		unregisterTagCallback = unregisterTagCallback or function() end

		table.insert(tags, tagName)
		table.insert(tags, tagRegisteredCallback)
		table.insert(tags, unregisterTagCallback)
	end

	function tagsManager:Remove(tagName: string)
		local position = table.find(tags, tagName) :: number
		assert(position ~= nil, "No such tag was found.")

		local unregisterTagCallback = tags[position + 2] :: () -> ()
		unregisterTagCallback()

		table.remove(tags, position)
		table.remove(tags, position + 1)
		table.remove(tags, position + 2)
	end

	function tagsManager:Edit(tagName: string, tagRegisteredCallback: (Instance) -> (), unregisterTagCallback: () -> ())
		local position = table.find(tags, tagName) :: number
		assert(position ~= nil, "No such tag was found.")

		if unregisterTagCallback then
			tags[position + 2] = unregisterTagCallback
		end

		tags[position + 1] = tagRegisteredCallback
	end

	function tagsManager:Update()
		for i = 1, #tags, 3 do
			local tagName = tags[i] :: string
			if not tagName then continue end

			local tagRegisteredCallback = tags[i + 1] :: (Instance) -> ()

			for _, instance in pairs(CollectionService:GetTagged(tagName)) do
				tagRegisteredCallback(instance)
			end
		end
	end

	return tagsManager
end

return table.freeze(Module)