--!strict
--!native

local CollectionService = game:GetService("CollectionService")

local Module = {}

return function()
	local tagsManager = {}
	local tags = {}

	tagsManager.Add = function <a>(tagName: string, tagRegisteredCallback: (a) -> (), unregisterTagCallback: (() -> ())?)
		if tags[tagName] then error(`There is already a tag named {tagName}.`) end
		local unregisterTagCallback = unregisterTagCallback or function() end

		tags[tagName] = {tagRegisteredCallback, unregisterTagCallback}
	end

	tagsManager.Remove = function(tagName: string)
		tags[tagName] = nil
	end

	tagsManager.Edit = function <a>(tagName: string, tagRegisteredCallback: (a) -> (), unregisterTagCallback: (() -> ())?)
		local callbacks = tags[tagName]
		if not callbacks then error("No such tag was found.") end

		if unregisterTagCallback then
			callbacks[2] = unregisterTagCallback
		end

		callbacks[1] = tagRegisteredCallback :: (...any) -> ()
	end

	tagsManager.Apply = function(tagName: string)
		local callbacks = tags[tagName]
		if not callbacks then error("No such tag was found.") end

		local tagRegisteredCallback = callbacks[1]
		local unregisterTagCallback = callbacks[2] :: () -> ()

		for _, instance in pairs(CollectionService:GetTagged(tagName)) do
			tagRegisteredCallback(instance)
		end

		CollectionService:GetInstanceAddedSignal(tagName):Connect(function(instance: any) 
			tagRegisteredCallback(instance)
		end)

		CollectionService:GetInstanceRemovedSignal(tagName):Connect(function() 
			unregisterTagCallback()
		end)
	end
	
	tagsManager.ApplyAll = function()
		for tagName, _ in pairs(tags) do
			tagsManager.Apply(tagName)
		end
	end

	return tagsManager
end
