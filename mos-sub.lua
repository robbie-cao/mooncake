#!/usr/bin/env lua

local posix = require("posix")
local mqtt = require("mosquitto")
local client = mqtt.new()

local BROKER = "test.muabaobao.com"

local UPDATE_TOPIC_NAME           = "/mua/sys/upgrade"
local TEST_UPDATE_TOPIC_NAME      = "/mua/test/upgrade"
local MSM_TOPIC_DOMAIN            = "/mua/msm/"
local MSM_DEFAULT_TOPIC_NAME      = "/mua/msm/general"
local MSM_DEFAULT_TEST_TOPIC_NAME = "/mua/msm/general_test"

tag = arg[1]

if not tag or tag == "" then
    tag = tostring(os.date("%H%M%S"))
end

P = print
local function print(...)
    t = posix.gettimeofday()
    P(string.format("%08d.%06d", t.sec, t.usec), tag, ...)
end

client.ON_CONNECT = function(...)
    print("Subuscriber Connected", ...)
    client:subscribe(MSM_TOPIC_DOMAIN)
end

client.ON_MESSAGE = function(mid, topic, payload, ...)
    print("Receive:", mid, topic, payload, ...)
end

--[[
client.ON_MESSAGE = function(...)
    print(...)
end
--]]

client:connect(BROKER)
client:loop_forever()
