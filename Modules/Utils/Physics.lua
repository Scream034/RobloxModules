-- Для работы с физикой
-- Автор: paralax034

local Module = {}

--- Применяет импульса силы на время.
--- @param basePart BasePart: Оригинальный парт.
--- @param velocity Vector3: Сила и напраление.
--- @param duration number?: (Опционально) Время импульса.
function Module.ApplyImpulse(basePart: BasePart, velocity: Vector3, duration: number?): ()
	duration = duration or 0.005
	
	local bodyVelocity = Instance.new("BodyVelocity", basePart)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = velocity
	
	wait(duration)
	
	bodyVelocity:Remove()
end

--- Применяет импульса силы в сторону, куда смотрит переданный парт на время.
--- @param basePart BasePart: Оригинальный парт.
--- @param basePartLook BasePart: Парт для направления.
--- @param velocity Vector3: Сила и напраление.
--- @param duration number?: (Опционально) Время импульса.
function Module.ApplyImpulseFromLook(basePart: BasePart, basePartLook: BasePart, velocity: Vector3, duration: number?): ()
	duration = duration or 0.005

	Module.ApplyImpulse(basePart, basePartLook.CFrame.LookVector * velocity, duration)
end

return Module
