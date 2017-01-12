local BROKER = "test.muabaobao.com"

local UPDATE_TOPIC_NAME           = "/mua/sys/upgrade"
local TEST_UPDATE_TOPIC_NAME      = "/mua/test/upgrade"
local MSM_TOPIC_DOMAIN            = "/mua/msm/"
local MSM_DEFAULT_TOPIC_NAME      = "/mua/msm/general"
local MSM_DEFAULT_TEST_TOPIC_NAME = "/mua/msm/general_test"

local lanes = require("lanes").configure()
local cmd = lanes.linda()

-- Chat receiving
local function chat_recv(name)
    local mqtt = require("mosquitto")
    local client = mqtt.new()
    print("Start receiver", name)

    client.ON_CONNECT = function()
        print("Receiver connected to " .. BROKER)
        client:subscribe(MSM_TOPIC_DOMAIN)

        local mid = client:subscribe(MSM_DEFAULT_TOPIC_NAME, 2)
        client:subscribe(MSM_DEFAULT_TEST_TOPIC_NAME)

        client:publish(MSM_TOPIC_DOMAIN, "Hello mua, waiting for message ...")
    end

    client.ON_PUBLISH = function()
        print("Send a message")
    end

    client.ON_MESSAGE = function(mid, topic, payload)
        print("Receive messge: ", topic, payload)
    end

    client:connect(BROKER)
    client:loop_forever()
end

-- Chat sender
local function chat_send(name)
    local mqtt = require("mosquitto")
    local client = mqtt.new()

    print("Start sender", name)
    client.ON_CONNECT = function(...)
        print("Sender connected to " .. BROKER, ...)
        client:publish(MSM_TOPIC_DOMAIN, "Hello mua, will send message ...")
    end

    client.ON_PUBLISH = function(...)
        print("Sent a message", ...)
    end

    client:connect(BROKER)
    while true do
        local key, val = cmd:receive("msg")    -- timeout in seconds
        if val == nil then
            print("timed out")
            break
        end
        print(tostring(cmd) .. " msg: " .. val)
        -- Publish input message to MQTT broker
        client:publish(MSM_TOPIC_DOMAIN, val)
    end
end

local function input(name)
    -- Use luv(libuv) to receive input from stdin
    local uv = require('luv')
    local stdin = uv.new_tty(0, true)

    print("Start input", name)
    stdin:read_start(function (err, data)
        assert(not err, err)
        if data then
            print("Input: ", data)
            cmd:send("msg", data)
        else
            stdin:close()
        end
    end)

    uv.run()

    -- Close loop
    uv.loop_close()
end

a = lanes.gen("*", chat_recv)("A")
b = lanes.gen("*", chat_send)("B")
c = lanes.gen("*", input)("C")

a:join()
b:join()
c:join()

print("After join")

print("End")
