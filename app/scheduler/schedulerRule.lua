local cstDef = require("src.define.const")
local httpDispatcher = require("scheduler.dispatcher.message.http")
local captureDispatcher = require("scheduler.dispatcher.message.capture")
local tcpDispatcher = require("scheduler.dispatcher.message.tcp")

return {
	[cstDef.DISPATCH_MODE.MESSAGE.HTTP] = httpDispatcher,
    [cstDef.DISPATCH_MODE.MESSAGE.CAPTURE] = captureDispatcher,
	[cstDef.DISPATCH_MODE.MESSAGE.TCP] = tcpDispatcher
}