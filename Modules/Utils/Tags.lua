-- Для работы с тегами
-- Находится в тестах
-- Автор: paralax034

local CollectionService = game:GetService("CollectionService")

local Module = {}

--- Инициализация модуля
function Module.Initialize()
	local self = {}	
	
	--- Добавить новый тег и зарегистрировать его
	--- @param string tagName: Имя тега
	--- @param function registerFn: Имя функции регистрации тега
	function self:Add(tagName: string, registerFn: "function", removeFn: "function"?)
		removeFn = removeFn or function()
			self[tagName] = nil
		end
		
		self[tagName] = {}
		table.insert(self[tagName], tagName)
		table.insert(self[tagName], registerFn)
		table.insert(self[tagName], removeFn)
	end
	
	--- Удалить тег
	--- @param string tagName: Имя тега
	function self:Remove(tagName: string)
		self[tagName][3]()
	end

	--- Обновить тег, точнее инициализировать функции указанные у тегов. вызывается в конце или после Add()
	--- @param string tagName: Имя тега
	function self:Update()
		for _, Tag in pairs(self) do
			-- Чтобы не было лишних ошибок
			local succes = pcall(function(...) if Tag[1] ~= nil then return end end)
			if not succes then continue end
			
			for _, instance in pairs(CollectionService:GetTagged(Tag[1])) do
				Tag[2]()
			end
		end
	end

	
	return self
end

return Module
