--!strict


local SignalManager = {}

local Signals = {}

-- In FireRange
local HANDLERS_PER_BATCH = 20
local MAX_BATCH_SIZE = 500
local MIN_BATCH_SIZE = 2

function SignalManager.AddSignal(name: string)
	if Signals[name] then error(`Signal already exists: {name}.`) end
	
	Signals[name] = {}
end

function SignalManager.RemoveSignal(name: string)
	Signals[name] = nil
end

function SignalManager.Connect(name: string, func: (...any) -> (), index: number?)
	local callbacks = Signals[name]
	if not callbacks then error(`Signal does not exist: {name}.`) end
	
	if index then
		callbacks[index] = func
	else
		table.insert(callbacks, func)
	end

end

function SignalManager.FireRange(name: string, startIndex: number?, endIndex: number?, args: {{}}?)
	local startIndex = startIndex or 1
	
	if startIndex < 1 then
		error("Invalid start index!")
	end

	local callbacks = Signals[name]
	if not callbacks then error(`Signal does not exist: {name}.`) end

	local length = #callbacks
	if length == 0 then 
		warn("Callback length cannot be 0.")
		return
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
		error("Invalid end index or arguments!")
	end
	
	processBatch(startIndex, endIndex)
end


function SignalManager.WaitSignal(name: string, timeout: number?)
	local timeout = timeout or 10
	local startTime = os.clock()
	
	while true do
		if Signals[name] then return end
		if os.clock() - startTime > timeout then
			error(`Timeout exceeded while waiting for signal {name}.`)
		end
		wait(0.1)
	end
end

function SignalManager.WaitSignalAndFireRange(name: string, startIndex: number, endIndex: number, args: {{}}, timeout: number?)
	SignalManager.WaitSignal(name, timeout)
	SignalManager.FireRange(name, startIndex, endIndex, args)
end

function SignalManager.WaitSignalAndConnect(name: string, func: (...any) -> (), index: number?, timeout: number?)
	SignalManager.WaitSignal(name, timeout)
	SignalManager.Connect(name, func, index)
end

return table.freeze(SignalManager)
