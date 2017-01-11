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

path_to_save = os.date("%Y%m%d-%H%M%S")
if (arg[2] and arg[2] ~= "") then
    path_to_save = arg[2]
end

print("Download: " .. url)
-- curl URL -o path/to/save
os.execute("curl " .. tostring(url) .. " -o " .. path_to_save)
print("Saved to: " .. path_to_save)
