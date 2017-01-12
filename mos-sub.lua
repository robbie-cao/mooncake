local mqtt = require("mosquitto")
local client = mqtt.new()


local BROKER = "test.muabaobao.com"

local UPDATE_TOPIC_NAME           = "/mua/sys/upgrade"
local TEST_UPDATE_TOPIC_NAME      = "/mua/test/upgrade"
local MSM_TOPIC_DOMAIN            = "/mua/msm/"
local MSM_DEFAULT_TOPIC_NAME      = "/mua/msm/general"
local MSM_DEFAULT_TEST_TOPIC_NAME = "/mua/msm/general_test"

client.ON_CONNECT = function()
    print("connected")
    client:subscribe(MSM_TOPIC_DOMAIN)
    local mid = client:subscribe(MSM_DEFAULT_TOPIC_NAME, 2)
end

client.ON_MESSAGE = function(mid, topic, payload)
    print(topic, payload)
end

client:connect(BROKER)
client:loop_forever()
