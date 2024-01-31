-- Для работы с физикой.
-- Автор: paralax034

local Module = {}

-- Применяет импульса силы на время.
--
--- Параметры:
---- basePart = Оригинальный парт.
---- velocity = Сила и напраление.
---- duration = (Опционально) Время импульса.
function Module.ApplyForce(basePart: BasePart, velocity: Vector3, duration: number?): never
	duration = duration or 0.005

	local bodyVelocity = Instance.new("BodyVelocity", basePart)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = velocity

	wait(duration)

	bodyVelocity:Remove()
end

-- Применяет импульса силы в сторону, куда смотрит переданный парт на время.
--
--- Параметры:
---- basePart = Оригинальный парт.
---- basePartLook =  Парт для направления.
---- velocity = Сила и напраление.
---- duration = (Опционально) Время импульса.
function Module.ApplyForceFromLook(basePart: BasePart, basePartLook: BasePart, velocity: Vector3, duration: number?): never
	duration = duration or 0.005

	Module.ApplyForce(basePart, basePartLook.CFrame.LookVector * velocity, duration)
end

return Module