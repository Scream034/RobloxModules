-- Упрощает работу с тегами в Roblox
-- Автор: paralax034

local CollectionService = game:GetService("CollectionService")

local Module = {}

-- Инициализация модуля
function Module.Initialize()
	local tagsManager = {}
	
	-- Добавить новый тег и зарегистрировать его
	--
	--- Параметры:
	---- tagName = Имя тега
	---- tagRegisteredCallback = Функция добавлении тега
	---- unregisterTagCallback = Функция при удалении тега
	function tagsManager:Add(tagName: string, tagRegisteredCallback: "function", unregisterTagCallback: "function"?): never
		unregisterTagCallback = unregisterTagCallback or function()
			tagsManager[tagName] = nil
		end

		tagsManager[tagName] = {}
		table.insert(tagsManager[tagName], tagName)
		table.insert(tagsManager[tagName], tagRegisteredCallback)
		table.insert(tagsManager[tagName], unregisterTagCallback)
	end

	-- Удалить тег
	--
	--- Параметр:
	---- tagName = Имя тега
	function tagsManager:Remove(tagName: string)
		tagsManager[tagName][3]()
	end
	
	-- Изменить функции в существующем теге
	--
	--- Параметры:
	---- tagName = Имя тега
	---- tagRegisteredCallback = Функция добавлении тега
	---- unregisterTagCallback = Функция при удалении тега
	function tagsManager:Edit(tagName: string, tagRegisteredCallback: "function", unregisterTagCallback: "function"?): never
		if not table.find(tagsManager, tagName, 4) then
			return error("No such tag was found!")
		end
		
		if unregisterTagCallback then
			tagsManager[tagName][3] = unregisterTagCallback
		end

		tagsManager[tagName][2] = tagRegisteredCallback
	end
	
	--- Обновить тег, точнее инициализировать функции указанные у тегов.
	--- Вызывается в конце или после Add()
	function tagsManager:Update(): never
		for _, Tag in pairs(tagsManager) do
			-- Чтобы не было лишних ошибок
			local succes = pcall(function(...) if Tag[1] ~= nil then return end end)
			if not succes then continue end

			for _, instance in pairs(CollectionService:GetTagged(Tag[1])) do
				Tag[2](instance)
			end
		end
	end


	return setmetatable(tagsManager, {__index = Module})
end

return table.freeze(Module)