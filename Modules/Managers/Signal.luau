--!strict
--!native

local SignalManager = {}

local Signals = {}

function SignalManager.AddSignal(name: string)
	if Signals[name] then 
		warn(`Signal already exists: {name}`)
		return
	end
	
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

function SignalManager.FireRange(name: string, startIndex: number, endIndex: number, args: {{}})
	if endIndex < 1 or endIndex < startIndex or endIndex > #args then
		error("Invalid end index or arguments!")
	end
	if startIndex < 1 then
		error("Invalid start index!")
	end
	
	local callbacks = Signals[name]
	if not callbacks then error(`Signal does not exist: {name}.`) end

	for i = startIndex, endIndex do
		callbacks[i](unpack(args[i]))
	end
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
