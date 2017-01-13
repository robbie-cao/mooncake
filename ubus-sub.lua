#!/usr/bin/env lua

--[[
  A demo of ubus subscriber binding. Should be run after publisher.lua
--]]

require "ubus"
require "uloop"

local posix = require("posix")

-- Use first arg as tag, use current time HHMMSS as default
tag = arg[1]

if not tag or tag == "" then
    tag = tostring(os.date("%H%M%S"))
end

-- Save standard print to P
P = print
-- Customized print(): add timestamp and tag before content
local function print(...)
    t = posix.gettimeofday()
    P(string.format("%08d.%06d", t.tv_sec, t.tv_usec), tag, ...)
end

uloop.init()

local conn = ubus.connect()
if not conn then
	error("Failed to connect to ubus")
end

local sub = {
	notify = function(msg)
		print("Receive: ", msg["msg"])
	end,
}

conn:subscribe("test", sub)

uloop.run()
