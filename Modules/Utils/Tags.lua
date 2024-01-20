-- Упрощает работу с тегами в Roblox
-- Находится в тестах
-- Автор: paralax034

local CollectionService = game:GetService("CollectionService")

local Module = {}

--- Инициализация модуля
function Module.Initialize()
	local module = {}
	
	--- Добавить новый тег и зарегистрировать его
	--- @param string tagName: Имя тега
	--- @param function registerFn: Имя функции регистрации тега
	function module:Add(tagName: string, registerFn: "function", removeFn: "function"?)
		removeFn = removeFn or function()
			module[tagName] = nil
		end
		
		module[tagName] = {}
		table.insert(module[tagName], tagName)
		table.insert(module[tagName], registerFn)
		table.insert(module[tagName], removeFn)
	end
	
	--- Удалить тег
	--- @param string tagName: Имя тега
	function module:Remove(tagName: string)
		module[tagName][3]()
	end

	--- Обновить тег, точнее инициализировать функции указанные у тегов. вызывается в конце или после Add()
	--- @param string tagName: Имя тега
	function module:Update()
		for _, Tag in pairs(module) do
			-- Чтобы не было лишних ошибок
			local succes = pcall(function(...) if Tag[1] ~= nil then return end end)
			if not succes then continue end
			
			for _, instance in pairs(CollectionService:GetTagged(Tag[1])) do
				Tag[2](instance)
			end
		end
	end

	
	return setmetatable(module, {__index = Module})
end

return Module
