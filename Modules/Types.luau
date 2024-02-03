--!strict

export type IBaseDoor = {
	Toggle: (self: {}) -> (),
	Open: (self: {}) -> (),
	Close: (self: {}) -> ()
}

return nil