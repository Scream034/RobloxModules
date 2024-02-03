--!strict
--!native

--[[ 
		Важная информация!

	ToggleEvent - Возращает:
		-1 = дверь закрыта
		0 = дверь заперта на ключ
		1 = дверь открыта

	У двери должны быть аттрибуты:
		Opened = boolean - открыта ли дверь
		OpenCFrame = CFrame - CFrame в открытом положении
		CloseCFrame = CFrame - CFrame в закрытом положении
		Locked = boolean - заперта ли дверь на ключ
]]

local Types = require(game:GetService("ServerScriptService"):FindFirstChild("Modules"):WaitForChild("Types"))

--[[
	Параметры:
		movingModel = Модель, которую нужно двигать
		childOpen = Функция при открытии двери
		childClose = Функция при закрытии двери
]]
return function(movingModel: Model, childOpen: () -> (), childClose: () -> ()): Types.IBaseDoor
	childOpen = childOpen or function() end
	childClose = childClose or function() end
	
	-- Проверяю есть ли родитель у переданной модели, также на PrimaryPart
	assert(typeof(movingModel.Parent) ~= "Model", "The MovingModel does not have a parent with the Model class!")
	assert(typeof(movingModel.PrimaryPart) ~= "Part", "The MovingModel does not have a PrimaryPart with the Part class!")
	
	local parent: Model = movingModel.Parent
	
	assert(parent:GetAttribute("Opened") ~= nil and
		parent:GetAttribute("OpenCFrame") ~= nil and
		parent:GetAttribute("CloseCFrame") ~= nil and
		parent:GetAttribute("Locked") ~= nil,
		"The MovingModel parent is missing one or more required attributes: Opened, OpenCFrame, CloseCFrame, Locked!")
	
	local baseDoor = {}
	local events: BindableEvent = Instance.new("BindableEvent", movingModel.Parent)
	events.Name = "ToggleEvent"
	
	-- Сообщает что дверь закрыта через событие
	local function sendLockedEvent(locked: boolean): ()
		if locked then
			events:Fire(0)
		end
	end
	
	-- Отрывает или закрывает дверь основываясь на её состоянии
	function baseDoor:Toggle(): ()
		local locked: boolean = parent:GetAttribute("Locked")
		sendLockedEvent(locked)
		if locked then return end
		
		if parent:GetAttribute("Opened") then
			baseDoor:Close()
		else
			baseDoor:Open()
		end
	end
	
	-- Открывает дверь
	function baseDoor:Open(): ()
		childOpen()
		
		events:Fire(1)
	end
	
	-- Закрывает дверь
	function baseDoor:Close(): ()
		childClose()
		
		events:Fire(-1)
	end
	
	return baseDoor :: Types.IBaseDoor
end