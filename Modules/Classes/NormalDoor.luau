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

local TweenService: TweenService = game:GetService("TweenService")
local Modules: Folder = game:GetService("ServerScriptService"):FindFirstChild("Modules")
local Types = require(Modules:WaitForChild("Types"))
local BaseDoorClass = require(Modules:FindFirstChild("Classes"):WaitForChild("BaseDoor"))

--[[
	Параметры:
		movingModel = Модель, которую нужно двигать
		openTweenInfo = TweenInfo для открытии двери
		closeTweenInfo = TweenInfo для закрытии двери
]]
return function(movingModel: Model,
	openTweenInfo: TweenInfo, closeTweenInfo: TweenInfo): Types.IBaseDoor
	
	-- Открывает дверь
	local function Open(): ()
		local parent = movingModel.Parent :: Model
		local primaryPart = movingModel.PrimaryPart :: Part
			
		local openTween = TweenService:Create(primaryPart, openTweenInfo, { CFrame = parent:GetAttribute("OpenCFrame") })
		parent:SetAttribute("Opened", true)
		openTween:Play()
	end
	
	-- Закрывает дверь
	local function Close(): ()
		local parent = movingModel.Parent :: Model
		local primaryPart = movingModel.PrimaryPart :: Part
		
		local closeTween = TweenService:Create(primaryPart, closeTweenInfo, { CFrame = parent:GetAttribute("CloseCFrame") })
		parent:SetAttribute("Opened", false)
		closeTween:Play()
	end

	return table.freeze(BaseDoorClass(movingModel, Open, Close))
end
