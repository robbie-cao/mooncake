local uv = require('luv')

-- Create a handle to a uv_timer_t
local timer = uv.new_timer()


local f = function ()
    -- timer here is the value we passed in before from new_timer.
    print ("Awake!")
end

--[[
-- This will wait 1000ms and then continue inside the callback
timer:start(1000, 0, f)
--]]

print("Sleeping");

-- Simple echo program
local stdin = uv.new_tty(0, true)

stdin:read_start(function (err, data)
    assert(not err, err)
    if data then
        if string.find(data, "start") then
            print("START")
            timer:start(1000, 0, f)
        elseif string.find(data, "repeat") then
            print("repeat")
            timer:start(0, 1000, f)
        elseif string.find(data, "stop") then
            print("STOP")
            timer:stop()
        elseif string.find(data, "quit") then
            print("QUIT")
            timer:close()
            uv.stop()
        else
            print("UNKNOWN")
        end
    else
        stdin:close()
    end
end)

-- uv.run will block and wait for all events to run.
-- When there are no longer any active handles, it will return
uv.run()

--[[
-- You must always close your uv handles or you'll leak memory
-- We can't depend on the GC since it doesn't know enough about libuv.
timer:close()
--]]
