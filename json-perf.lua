local posix = require("posix")

local t = nil
local count = 100000000

print("CJSON")
t = posix.gettimeofday()
print("Start", string.format("%08d.%06d", t.sec, t.usec))

for i = 1, count do
    require("json-cjson")
end

t = posix.gettimeofday()
print("End", string.format("%08d.%06d", t.sec, t.usec))


print("dkjson")
t = posix.gettimeofday()
print("Start", string.format("%08d.%06d", t.sec, t.usec))

for i = 1, count do
    require("json-dk")
end

t = posix.gettimeofday()
print("End", string.format("%08d.%06d", t.sec, t.usec))

--[[
--
-- Result:
-- CJSON
-- Start   1484630133.567560
-- End     1484630141.001715
-- dkjson
-- Start   1484630141.001742
-- End     1484630148.406336
--
--]]
