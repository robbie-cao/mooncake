function print_timestamp(tag)
    local posix = require("posix")
    local t = posix.gettimeofday()

    print(tag, string.format("%08d.%06d", t.sec, t.usec))
end

local t = nil
local count = 100000000

print_timestamp("CJSON - Start")
for i = 1, count do
    require("json-cjson")
end
print_timestamp("CJSON - End")


print_timestamp("dkjson - Start")
for i = 1, count do
    require("json-dk")
end
print_timestamp("dkjson - End")

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
