-- Разные UI анимации с помощью Tween
-- Автор: paralax034

local TweenService = game:GetService("TweenService")

local Module = {}

--- Плавный уход
--- @param obj GuiObject: Исходный объект анимации
--- @param side number: Номер стороны
---- 0 - лево
---- 1 - вверх
---- 2 - вправо
---- 3 - вниз
---- 4 - левый угол
---- 5 - правый угол
---- 6 - правый нижний угол
---- 7 - левый нижний угол
--- @param tweenInfo TweenInfo: Информация о анимации
--- @param isRemove boolean?: Удалять ли объект после анимации
function Module.Slide(obj: GuiObject, side: number, tweenInfo: TweenInfo, isRemove: boolean?): ()
	local startPos = obj.Position

	local targetPosition
	if side == 0 then
		targetPosition = startPos - UDim2.new(1, 0, 0, 0)
	elseif side == 1 then
		targetPosition = startPos - UDim2.new(0, 0, 1, 0)
	elseif side == 2 then
		targetPosition = startPos + UDim2.new(1, 0, 0, 0)
	elseif side == 3 then
		targetPosition = startPos + UDim2.new(0, 0, 1, 0)
	elseif side == 4 then
		targetPosition = startPos - UDim2.new(1, 0, 1, 0)
	elseif side == 5 then
		targetPosition = startPos + UDim2.new(1, 0, -1, 0)
	elseif side == 6 then
		targetPosition = startPos + UDim2.new(1, 0, 1, 0)
	elseif side == 7 then
		targetPosition = startPos - UDim2.new(1, 0, 1, 0)
	end

	local tween = TweenService:Create(obj, tweenInfo, {Position = targetPosition})
	tween:Play()

	if isRemove then
		tween.Completed:Once(function(playbackState) 
			obj:Remove()
		end)
	end
end

--- Плавная прозачность
--- @param obj GuiObject: Исходный объект анимации
--- @param tweenInfo TweenInfo: Информация о анимации
--- @param isRemove boolean?: Удалять ли объект после анимации
function Module.Fade(obj: GuiObject, tweenInfo: TweenInfo, isRemove: boolean?): ()
	local tweenInfo = tweenInfo

	local tween = TweenService:Create(obj, tweenInfo, {
		BackgroundTransparency = 1
	})
	tween:Play()

	if isRemove then
		tween.Completed:Once(function(playbackState) 
			obj:Remove()
		end)
	end
end

return Module