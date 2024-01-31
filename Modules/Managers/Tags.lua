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
	---- registerFn = Имя функции регистрации тега
	function tagsManager:Add(tagName: string, tagRegisteredCallback: "function", unregisterTagCallback: "function"?)
		unregisterTagCallback = unregisterTagCallback or function()
			tagsManager[tagName] = nil
		end

		tagsManager[tagName] = {}
		table.insert(tagsManager[tagName], tagName)
		table.insert(tagsManager[tagName], tagRegisteredCallback)
		table.insert(tagsManager[tagName], unregisterTagCallback)
	end

	--- Удалить тег
	--
	--- Параметр:
	---- tagName = Имя тега
	function tagsManager:Remove(tagName: string)
		tagsManager[tagName][3]()
	end

	--- Обновить тег, точнее инициализировать функции указанные у тегов.
	--- Вызывается в конце или после Add()
	function tagsManager:Update()
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

return Module