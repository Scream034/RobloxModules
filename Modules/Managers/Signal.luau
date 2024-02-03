--!strict
--!native

local Module = {}

local Signals = {}

function Module.AddSignal(signalName: string, callbacks: {(...any) -> ()}): ()
	if Signals[signalName] then return Signals[signalName] end
	
	Signals[signalName] = callbacks
end

function Module.AddCallbackTo(signalName: string, callback: (...any) -> ()): ()
	assert(Signals[signalName] ~= nil, `A signal named {signalName} was not found.`)	

	table.insert(Signals[signalName], callback)
end

function Module.SetCallbackAt(signalName: string, callback: (...any) -> (), position: number): ()
	assert(Signals[signalName] ~= nil, `A signal named {signalName} was not found.`)	
	
	Signals[signalName][position] = callback
end

function Module.RemoveCallbackAt(signalName: string, position: number): ()
	local signal = Signals[signalName]
	assert(signal ~= nil, `A signal named {signalName} was not found.`)
	local signalLength = #signal
	assert(signalLength < position, `position ({position}) > length ({signalLength}) of Signals[{signalName}]`)
	
	table.remove(Signals[signalName], position)
end

function Module.FireTo(signalName: string, arguments: {[number]: {any}}): ()
	local signal = Signals[signalName]
	assert(signal ~= nil, `A signal named {signalName} was not found.`)
	
	for index, handler in ipairs(signal) do
		handler(unpack(arguments[index]))
	end
end

function Module.WaitSignal(signalName: string, timeout: number?): boolean
	local timeout = timeout or 10
	local startTime = os.clock()
	
	while true do
		if Signals[signalName] then  
			return true
		end

		local elapsedTime = os.clock() - startTime
		if elapsedTime > timeout then
			error(`Timeout exceeded while waiting for signal {signalName}.`) 
		end

		wait(0.1) 
	end
	
	return false
end

function Module.WaitForCallbacksToReachLength(signalName: string, length: number, timeout: number?): boolean
	assert(Signals[signalName] ~= nil, `A signal named {signalName} was not found.`)
	local timeout = timeout or 10
	
	local startTime = os.clock()

	while true do
		if #Signals[signalName] >= length then  
			return true
		end

		local elapsedTime = os.clock() - startTime
		if elapsedTime > timeout then
			error(`Timeout exceeded while waiting for the callbacks of signal {signalName} to reach the specified length.`) 
		end

		wait(0.1) 
	end

	return false
end


return table.freeze(Module)