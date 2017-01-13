#!/usr/bin/env lua

--[[
A demo of ubus publisher binding. Should be run before subscriber.lua
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

local ubus_objects = {
	test = {
        hello = {
            function(req, msg)
                conn:reply(req, { message="foo" });
                print("Call to function 'hello'")
                for k, v in pairs(msg) do
                    print("key = " .. k .. " value = " .. tostring(v))
                end
            end,
            { id = ubus.INT32, msg = ubus.STRING }
        },
		__subscriber_cb = function(subs)
			print("Total subs: ", subs)
		end
	}
}

conn:add(ubus_objects)
print("Objects added, starting loop")

-- start time
local timer
function t()
    local t = posix.gettimeofday()
    local body = "Message - timestamp: " .. string.format("%08d.%06d", t.tv_sec, t.tv_usec)
	local params = {
		msg = body
	}
	conn:notify(ubus_objects.test.__ubusobj, "test.alarm", params)
    print("Send: ", body)
    local delay = math.random(1000)
	timer:set(delay)
end
timer = uloop.timer(t)
timer:set(100)

uloop.run()
