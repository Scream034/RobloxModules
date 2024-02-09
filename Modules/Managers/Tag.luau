--!strict
--!native

local CollectionService = game:GetService("CollectionService")

local Module = {}

return function()
	local tagsManager = {}
	local tags = {}

	tagsManager.Add = function <a>(tagName: string, tagRegisteredCallback: (a) -> (), unregisterTagCallback: (() -> ())?): boolean
		if tags[tagName] then 
			warn(`There is already a tag named {tagName}.`) 
			return false
		end
		
		local unregisterTagCallback = unregisterTagCallback or function() end

		tags[tagName] = {tagRegisteredCallback, unregisterTagCallback}
		return true
	end

	tagsManager.Remove = function(tagName: string): boolean
		if not tags[tagName] then
			warn(`No such tag ({tagName}) was found.`)
			return false
		end
		
		tags[tagName] = nil
		return true
	end

	tagsManager.Edit = function <a>(tagName: string, tagRegisteredCallback: (a) -> (), unregisterTagCallback: (() -> ())?): boolean
		local callbacks = tags[tagName]
		if not callbacks then
			warn(`No such tag ({tagName}) was found.`)
			return false
		end

		if unregisterTagCallback then
			callbacks[2] = unregisterTagCallback
		end

		callbacks[1] = tagRegisteredCallback :: (...any) -> ()
		return true
	end

	tagsManager.Apply = function(tagName: string): boolean
		local callbacks = tags[tagName]
		if not callbacks then 
			warn(`No such tag ({tagName}) was found.`)
			return false
		end

		local tagRegisteredCallback = callbacks[1]
		local unregisterTagCallback = callbacks[2] :: () -> ()

		for _, instance in pairs(CollectionService:GetTagged(tagName)) do
			tagRegisteredCallback(instance)
		end

		CollectionService:GetInstanceAddedSignal(tagName):Connect(tagRegisteredCallback)

		CollectionService:GetInstanceRemovedSignal(tagName):Connect(function() 
			unregisterTagCallback()
		end)
		
		return true
	end

	tagsManager.ApplyAll = function()
		for tagName, _ in pairs(tags) do
			if not tagsManager.Apply(tagName) then
				warn(`Error with tag: {tagName}.`)
			end
		end
	end

	return tagsManager
end
