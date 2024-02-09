--!strict
--!native

local SignalManager = {}

local Signals = {}

-- In FireRange
local HANDLERS_PER_BATCH = 20
local MAX_BATCH_SIZE = 500
local MIN_BATCH_SIZE = 2

function SignalManager.AddSignal(signalName: string): boolean
	if not Signals[signalName] then 
		warn(`[SignalManger.AddSignal]: Signal does not exist: {signalName}.`) 
		return false
	end
	
	Signals[signalName] = {}
	return true
end

function SignalManager.RemoveSignal(signalName: string): boolean
	if not Signals[signalName] then 
		warn(`[SignalManger.RemoveSignal]: Signal does not exist: {signalName}.`) 
		return false
	end
	
	Signals[signalName] = nil
	return true
end

function SignalManager.Connect(signalName: string, func: (...any) -> (), index: number?): boolean
	local callbacks = Signals[signalName]
	if not callbacks then 
		warn(`[SignalManger.Connect]: Signal does not exist: {signalName}.`) 
		return false
	end
	
	if index then
		callbacks[index] = func
	else
		table.insert(callbacks, func)
	end
	
	return true
end

function SignalManager.Disconnect(signalName: string, index: number): boolean
	local callbacks = Signals[signalName]
	if not callbacks then 
		warn(`[SignalManger.Disconnect]: Signal does not exist: {signalName}.`) 
		return false
	end
	
	if not callbacks[index] then
		warn(`[SignalManger.Disconnect]: Callback function not found at index {index}: {signalName}.`) 
		return false
	end

	Signals[signalName][index] = nil
	return true
end

function SignalManager.FireRange(signalName: string, startIndex: number?, endIndex: number?, args: {{}}?)
	local startIndex = startIndex or 1
	
	if startIndex < 1 then
		error("[SignalManger.FireRange]: Invalid start index!")
	end

	local callbacks = Signals[signalName]
	if not callbacks then error(`Signal does not exist: {signalName}.`) end

	local length = #callbacks
	if length == 0 then 
		warn("[SignalManger.FireRange]: Callback length cannot be 0.")
		return false
	end
	
	local endIndex = endIndex == -1 and length or endIndex :: number
	
	local batchSize = math.ceil(#callbacks / HANDLERS_PER_BATCH) 
	batchSize = math.min(batchSize, MAX_BATCH_SIZE)
	batchSize = math.max(batchSize, MIN_BATCH_SIZE)
	
	local function processBatch(start: number, stop: number)
		for i = start, stop, batchSize do
			local batchEnd = math.min(i + batchSize, length)
			if args then
				for j = i, batchEnd do
					callbacks[i](unpack(args[i] or args[1]))
				end
			else
				for j = i, batchEnd do
					callbacks[i]()
				end
			end

			task.wait()
		end
	end
	
	if args and endIndex < 1 or endIndex < startIndex then
		error("[SignalManger.FireRange]: Invalid end index or arguments!")
	end
	
	processBatch(startIndex, endIndex)
	return true
end


function SignalManager.WaitSignal(signalName: string, timeout: number?): boolean
	local timeout = timeout or 10
	local startTime = os.clock()
	
	while true do
		if Signals[signalName] then return true end
		
		if os.clock() - startTime > timeout then
			warn(`[SignalManger.WaitSignal]: Timeout exceeded while waiting for signal {signalName}.`)
			return false
		end
		
		wait(0.1)
	end
end

function SignalManager.WaitSignalAndFireRange(signalName: string, startIndex: number, endIndex: number, args: {{}}, timeout: number?)
	if not (SignalManager.WaitSignal(signalName, timeout) and SignalManager.FireRange(signalName, startIndex, endIndex, args)) then
		return false
	end
	return true
end

function SignalManager.WaitSignalAndConnect(signalName: string, func: (...any) -> (), index: number?, timeout: number?)
	if not (SignalManager.WaitSignal(signalName, timeout) and SignalManager.Connect(signalName, func, index)) then
		return false
	end
	return true
end

return table.freeze(SignalManager)
