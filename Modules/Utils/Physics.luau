--!strict
--!native

local Module = {}

function Module.ApplyForce(basePart: BasePart, velocity: Vector3, duration: number?)
	duration = duration or 0.005

	local bodyVelocity = Instance.new("BodyVelocity", basePart)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = velocity

	wait(duration)

	bodyVelocity:Remove()
end

function Module.ApplyForceFromLook(basePart: BasePart, basePartLook: BasePart, velocity: Vector3, duration: number?)
	local duration = duration or 0.005

	Module.ApplyForce(basePart, basePartLook.CFrame.LookVector * velocity, duration)
end

return Module