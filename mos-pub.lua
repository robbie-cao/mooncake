#!/usr/bin/env lua

local posix = require("posix")
mqtt = require("mosquitto")
client = mqtt.new()

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
    print("Publisher Connected", ...)
end

client.ON_PUBLISH = function(...)
    print("Send:", ...)
end

client:connect(BROKER)

while true do
    t = posix.gettimeofday()
    msg = "Message - timestamp: " .. string.format("%08d.%06d", t.sec, t.usec)
    client:publish(MSM_TOPIC_DOMAIN, msg)
    print("Send: " .. msg)
    sleep = "sleep " .. tostring(math.random())
    os.execute(sleep)
end

client:loop_forever()
