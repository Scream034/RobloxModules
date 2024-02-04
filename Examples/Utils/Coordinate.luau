--!strict
--!native

--- Создаст парт, который будет на верху нашего родительского CFrame

-- Наш модуль
local CoordinateUtils = require(game:GetService("ServerScriptService").Modules.Utils:WaitForChild("Coordinate"))

-- Родитель
local Parent = script.Parent

-- Получаем позицию на верхней нормали
local Result = CoordinateUtils.GetPositionOnNormal(Parent.CFrame, Parent.Size, Enum.NormalId.Top)

-- Парт, который будет на верху
local Part = Instance.new("Part", workspace)
Part.Anchored = true
Part.CFrame = CFrame.new(Result + Vector3.new(0, Part.Size.Y / 2, 0))
