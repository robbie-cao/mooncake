lanes = require("lanes").configure()

local linda = lanes.linda()

local function loop(max)
    for i = 1, max do
        print("sending: " .. i)
        linda:send("x", i)    -- linda as upvalue
    end
end

a = lanes.gen("", loop)(10000)

while true do
    local key, val = linda:receive(3.0, "x")    -- timeout in seconds
    if val == nil then
        print("timed out")
        break
    end
    print(tostring(linda) .. " received: " .. val)
end
