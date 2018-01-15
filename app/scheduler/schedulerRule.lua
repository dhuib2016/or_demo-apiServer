local cstDef = require("src.define.const")
local httpDispatcher = nil
local tcpDispatcher = require("scheduler.dispatcher.message.tcp")

return {
	[cstDef.DISPATCH_MODE.HTTP] = httpDispatcher,
	[cstDef.DISPATCH_MODE.TCP] = tcpDispatcher
}