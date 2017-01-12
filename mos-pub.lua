mqtt = require("mosquitto")
client = mqtt.new()

local BROKER = "test.muabaobao.com"

local UPDATE_TOPIC_NAME           = "/mua/sys/upgrade"
local TEST_UPDATE_TOPIC_NAME      = "/mua/test/upgrade"
local MSM_TOPIC_DOMAIN            = "/mua/msm/"
local MSM_DEFAULT_TOPIC_NAME      = "/mua/msm/general"
local MSM_DEFAULT_TEST_TOPIC_NAME = "/mua/msm/general_test"

client.ON_CONNECT = function()
    client:publish(MSM_TOPIC_DOMAIN, "hello mua")
    local qos = 1
    local retain = true
    local mid = client:publish(MSM_DEFAULT_TOPIC_NAME, "my payload", qos, retain)
end

client.ON_PUBLISH = function()
    client:disconnect()
end

client:connect(BROKER)
client:loop_forever()
