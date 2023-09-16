-- Помощь по векторам
-- Автор paralax034

local module = {}

local function isNan(value: number): boolean
	return value ~= value
end

-- Sign фукнция на условиях
function module.Sign(value: Vector3 | Vector2 | number): Vector3 | Vector2 | number
	local _type = typeof(value)
	
	assert(_type == "Vector3" or _type == "Vector2" or _type == "number", "incorrect vector type, expected Vector3 or Vector2")
	
	if _type == "number" then
		return value > 0 and 1 or -1
	end
	
	local signX = value.X > 0 and 1 or -1
	local signY = value.Y > 0 and 1 or -1

	if _type == "Vector3" then
		local signZ = value.Z > 0 and 1 or -1
		return Vector3.new(signX, signY, signZ)
	end
	
	return Vector2.new(signX, signY)
end

-- Abs фукнция
function module.Abs(value: Vector3 | Vector2 | number): Vector3 | Vector2 | number
	local _type = typeof(value)

	assert(_type == "Vector3" or _type == "Vector2" or _type == "number", "incorrect vector type, expected Vector3 or Vector2")

	if _type == "number" then
		return value > 0 and 1 or -1
	end

	local absX = math.abs(value.X)
	local absY = math.abs(value.Y)

	if _type == "Vector3" then
		local absZ = math.abs(value.Z)
		return Vector3.new(absX, absY, absZ)
	end

	return Vector2.new(absX, absY)
end

-- Изменение одной оси вектора
function module.ChangeAxis(vector: Vector3 | Vector2, axis: number, value: number): Vector3 | Vector2
	local _type = typeof(vector)
	
	assert(_type == "Vector3" or _type == "Vector2", "incorrect vector type, expected Vector3 or Vector2")
	assert(axis >= 1 and axis <= 3, "incorrect axis value, expected a number between 1 and 3")

	if typeof(vector) == "Vector3" then
		assert(typeof(value) == "number", "incorrect value type, expected number")

		if axis == 1 then
			return Vector3.new(value, vector.Y, vector.Z)
		elseif axis == 2 then
			return Vector3.new(vector.X, value, vector.Z)
		elseif axis == 3 then
			return Vector3.new(vector.X, vector.Y, value)
		end
	elseif typeof(vector) == "Vector2" then
		assert(typeof(value) == "number", "incorrect value type, expected number")

		if axis == 1 then
			return Vector2.new(value, vector.Y)
		elseif axis == 2 then
			return Vector2.new(vector.X, value)
		end
	end

	return vector
end

-- Изменение одной оси вектора (добавленте)
function module.AddAxis(vector: Vector3 | Vector2, axis: number, value: number): Vector3 | Vector2
	if axis == 1 then
		value = vector.X + value
	elseif axis == 2  then
		value = vector.Y + value
	elseif axis == 3  then
		value = vector.Z + value
	end
	
	return module.ChangeAxis(vector, axis, value)
end

-- Измение Nan и INF на 0
function module.RemoveNANandINF(value: Vector3 | Vector2 | number): Vector3 | Vector2 | number
	local _type = typeof(value)
	local INF = math.huge
	
	assert(_type == "number" or _type == "Vector2" or _type == "Vector3", "incorrect value1 type: " .. _type .. ", expected Vector3, Vector2, or number")
	
	if _type == "number" then
		if value ~= value or math.abs(value) == INF then
			value = 0
		end
		
		return value
	end
	
	if value.X ~= value.X or math.abs(value.X) == INF then
		value = module.ChangeAxis(value, 1, 0)
	end
	
	if value.Y ~= value.Y or math.abs(value.Y) == INF then
		value = module.ChangeAxis(value, 2, 0)
	end
	
	if _type == "Vector3" then
		if value.Z ~= value.Z or math.abs(value.Z) == INF then
			value = module.ChangeAxis(value, 3, 0)
		end
	end
	
	return value
end

-- Умножение векторов
function module.Multiply(value1: Vector3 | Vector2 | number, value2: Vector3 | Vector2 | number, preserveSign: boolean?): Vector3 | Vector2 | number
	local _type1 = typeof(value1)
	local _type2 = typeof(value2)

	assert(_type1 == "number" or _type1 == "Vector2" or _type1 == "Vector3", "incorrect value1 type: " .. _type1 .. ", expected Vector3, Vector2, or number")
	assert(_type2 == "number" or _type2 == "Vector2" or _type2 == "Vector3", "incorrect value2 type: " .. _type2 .. ", expected Vector3, Vector2, or number")

	local result = nil

	if _type1 == "Vector3" and _type2 == "Vector3" then
		result = Vector3.new(
			value1.X * value2.X,
			value1.Y * value2.Y,
			value1.Z * value2.Z
		)
	elseif _type1 == "Vector2" and _type2 == "Vector2" then
		result = Vector2.new(
			value1.X * value2.X,
			value1.Y * value2.Y
		)
	elseif _type1 == "Vector3" and _type2 == "Vector2" then
		result = Vector3.new(
			value1.X * value2.X,
			value1.Y * value2.Y,
			value1.Z
		)
	elseif _type1 == "Vector2" and _type2 == "Vector3" then
		result = Vector3.new(
			value1.X * value2.X,
			value1.Y * value2.Y,
			value2.Z
		)
	elseif _type1 == "number" or _type2 == "number" then
		result = value1 * value2
	end
	
	local _type = typeof(result)
	
	-- Проверяем, нужно ли сохранять знаки у значений
	if preserveSign then
		result = module.Abs(result) * module.Sign(value1)
	end
	
	result = module.RemoveNANandINF(result)
	
	return result
end

-- Деление векторов
function module.Divide(value1: Vector3 | Vector2 | number, value2: Vector3 | Vector2 | number, preserveSign: boolean?): Vector3 | Vector2 | number
	local _type1 = typeof(value1)
	local _type2 = typeof(value2)

	assert(_type1 == "number" or _type1 == "Vector2" or _type1 == "Vector3", "incorrect value1 type: " .. _type1 .. ", expected Vector3, Vector2, or number")
	assert(_type2 == "number" or _type2 == "Vector2" or _type2 == "Vector3", "incorrect value2 type: " .. _type2 .. ", expected Vector3, Vector2, or number")

	local result = nil

	if _type1 == "Vector3" and _type2 == "Vector3" then
		result = Vector3.new(
			value1.X / value2.X,
			value1.Y / value2.Y,
			value1.Z / value2.Z
		)
	elseif _type1 == "Vector2" and _type2 == "Vector2" then
		result = Vector2.new(
			value1.X / value2.X,
			value1.Y / value2.Y
		)
	elseif _type1 == "Vector3" and _type2 == "Vector2" then
		result = Vector3.new(
			value1.X / value2.X,
			value1.Y / value2.Y,
			value1.Z
		)
	elseif _type1 == "Vector2" and _type2 == "Vector3" then
		result = Vector3.new(
			value1.X / value2.X,
			value1.Y / value2.Y,
			value2.Z
		)
	elseif _type1 == "number" or _type2 == "number" then
		result = value1 / value2
	end

	local _type = typeof(result)

	-- Проверяем, нужно ли сохранять знаки у значений
	if preserveSign then
		result = module.Abs(result) * module.Sign(value1)
	end
	
	result = module.RemoveNANandINF(result)
	
	return result
end

return module
