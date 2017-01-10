-- download file at the url

url = arg[1]

usage = [[
url [path/to/save]
]]

if (not url) then
    print("URL cannot be nil\n")
    print("Usage:")
    print(arg[0], usage)
    os.exit()
end

-- curl URL -o path/to/save
os.execute("curl " .. tostring(url) .. " -o dl-" .. os.date("%Y%m%d-%H%M%S"))
