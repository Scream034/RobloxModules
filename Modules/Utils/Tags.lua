-- Для работы с тегами
-- Находится в тестах
-- Автор: paralax034

local CollectionService = game:GetService("CollectionService")


local Module = {}

--- Инициализация модуля
function Module.Initialize()
	Module.Tags = {}
end

--- Добавить новый тег и зарегистрировать его
--- @param string tagName: Имя тега
--- @param function handleFn: Имя тега
--- @param function initFn: Имя тега
function Module:Add(tagName: string, handleFn, initFn)
	Module.Tags[tagName] = {}
	Module.Tags[tagName].Name = tagName
	Module.Tags[tagName].HandleFn = handleFn
	Module.Tags[tagName].InitFn = initFn
end

--- Удалить тег
--- @param string tagName: Имя тега
function Module:Remove(tagName: string)
	Module.Tags[tagName] = nil
end

--- Обновить тег, точнее инициализировать функции указанные у тегов. вызывается в конце или после Add()
--- @param string tagName: Имя тега
function Module:Update()
	for _, Tag in pairs(Module.Tags) do
		for _, Object in pairs(CollectionService:GetTagged(Tag.Name)) do
			Tag.InitFn(Object)
		end
	end
end

return Module
