-- upload file

curl = require("lcurl")

usage = [[
path/to/save [url]
]]

if not arg[1] or arg[1] == "" then
    print("path/to/file cannot be nil\n")
    print("Usage:")
    print(arg[0], usage)
    os.exit()
end

file_to_upload = arg[1]
remote_url = "http://test.muabaobao.com/record/upload"

local post = curl.form()
-- post file from filesystem
post:add_file  ("filename", file_to_upload)

p = function ()
    print("#")
end

c = curl.easy{
    url = remote_url,
    [curl.OPT_VERBOSE] = true,
    [curl.OPT_NOPROGRESS] = false;
}

c:setopt_httppost(post)
c:setopt_progressfunction(p)

c:perform()

print("File: " .. file_to_upload)
print("Upload to: " .. remote_url)

c:close()

print("Done")
