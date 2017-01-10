-- download file

curl = require("lcurl")

usage = [[
url [path/to/save]
]]

if not arg[1] or arg[1] == "" then
    print("URL cannot be nil\n")
    print("Usage:")
    print(arg[0], usage)
    os.exit()
end

remote_url = arg[1]

path_to_save = os.date("%Y%m%d-%H%M%S")
if (arg[2] and arg[2] ~= "") then
    path_to_save = arg[2]
end

f = assert(io.open(path_to_save, "w"))
p = function ()
    print("#")
end

c = curl.easy{
    url = remote_url,
    [curl.OPT_VERBOSE] = true,
    [curl.OPT_NOPROGRESS] = false;
}

c:setopt_writefunction(f)
c:setopt_progressfunction(p)

c:perform()
-- curl URL -o path/to/save
--os.execute("curl " .. tostring(url) .. " -o " .. path_to_save)

print("Download: " .. remote_url)
print("Saved to: " .. path_to_save)

c:close()
f:close()

print("Done")
