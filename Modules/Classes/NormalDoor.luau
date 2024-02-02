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


local TweenService = game:GetService("TweenService")
local BaseDoorClass = require(game:GetService("ServerScriptService").Modules.Classes:WaitForChild("BaseDoor"))

local Module = {}

--- Параметры:
---- movingModel = Модель, которую нужно двигать
---- openTweenInfo = TweenInfo для открытии двери
---- closeTweenInfo = TweenInfo для закрытии двери
function Module.New(movingModel: Model,
	openTweenInfo: TweenInfo, closeTweenInfo: TweenInfo)
	
	-- Открывает дверь
	local function Open(): never
		local parent = movingModel.Parent
		
		local openTween = TweenService:Create(movingModel.PrimaryPart, openTweenInfo, { CFrame = parent:GetAttribute("OpenCFrame") })
		parent:SetAttribute("Opened", true)
		openTween:Play()
	end
	
	-- Закрывает дверь
	local function Close(): never
		local parent = movingModel.Parent
		
		local closeTween = TweenService:Create(movingModel.PrimaryPart, closeTweenInfo, { CFrame = parent:GetAttribute("CloseCFrame") })
		parent:SetAttribute("Opened", false)
		closeTween:Play()
	end

	return BaseDoorClass.New(movingModel, Open, Close)
end

return Module
