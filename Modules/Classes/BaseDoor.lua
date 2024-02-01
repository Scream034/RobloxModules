-- Важная информация!
--
--- ToggleEvent - Возращает:
---- -1 = дверь закрыта
---- 0 = дверь заперта на ключ
---- 1 = дверь открыта
--
--- У двери должны быть аттрибуты:
---- Opened = boolean - открыта ли дверь
---- OpenCFrame = CFrame - CFrame в открытом положении
---- CloseCFrame = CFrame - CFrame в закрытом положении
---- Locked = boolean - заперта ли дверь на ключ


local Module = {}

--- Параметры:
---- movingModel = Модель, которую нужно двигать
---- onOpen = Функция при открытии двери
---- onClose = Функция при закрытии двери
function Module.New(movingModel: Model,
	onOpen: "function"?, onClose: "function"?)
	
	-- Проверяю есть ли родитель у переданной модели
	assert(movingModel.Parent, "The MovingModel does not have a parent!")
	
	local parent = movingModel.Parent
	
	assert(parent:GetAttribute("Opened") ~= nil and
		parent:GetAttribute("OpenCFrame") ~= nil and
		parent:GetAttribute("CloseCFrame") ~= nil and
		parent:GetAttribute("Locked") ~= nil,
		"The MovingModel parent is missing one or more required attributes: Opened, OpenCFrame, CloseCFrame, Locked!")
	
	local baseDoor = {}
	local events = Instance.new("BindableEvent", movingModel.Parent)
	events.Name = "ToggleEvent"
	
	-- Сообщает что дверь закрыта через событие
	local function sendLockedEvent(locked: boolean): never
		if locked then
			events:Fire(0)
		end
	end
	
	-- Отрывает или закрывает дверь основываясь на её состоянии
	function baseDoor:Toggle(): never
		local locked = parent:GetAttribute("Locked")
		sendLockedEvent(locked)
		if locked then return end
		
		if parent:GetAttribute("Opened") then
			baseDoor:Close()
		else
			baseDoor:Open()
		end
	end
	
	-- Открывает дверь
	function baseDoor:Open(): never
		pcall(function() onOpen() end)
		
		events:Fire(1)
	end
	
	-- Закрывает дверь
	function baseDoor:Close(): never
		pcall(function() onClose() end)
		
		events:Fire(-1)
	end
	
	return setmetatable(baseDoor, {__index = Module})
end

return Module
