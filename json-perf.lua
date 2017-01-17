function print_timestamp(tag)
    local posix = require("posix")
    local t = posix.gettimeofday()

    print(tag, string.format("%08d.%06d", t.sec, t.usec))
end

local count = 100000000
local t1, t2

print_timestamp("CJSON - Start")
t1 = os.clock()
for i = 1, count do
    require("json-cjson")
end
print_timestamp("CJSON - End")
t2 = os.clock()
print ("Time:", t2 - t1)


t1 = os.clock()
print_timestamp("dkjson - Start")
for i = 1, count do
    require("json-dk")
end
print_timestamp("dkjson - End")
t2 = os.clock()
print ("Time:", t2 - t1)

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
