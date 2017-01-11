local uv = require('luv')

local download = function (url, path, ...)
    if not url or url == "" then
        print("URL cannot be nil\n")
        return
    end

    path_to_save = os.date("%Y%m%d-%H%M%S")
    if (path and path ~= "") then
        path_to_save = path
    end

    f = assert(io.open(path_to_save, "w"))
    p = function ()
        print("#")
    end

    curl = require("lcurl")

    ---[[
    c = curl.easy({
        [curl.OPT_URL] = url,
        [curl.OPT_VERBOSE] = true,
        [curl.OPT_NOPROGRESS] = false;
    })
    ---]]

    --[[
    -- Equivalent to above
    c = curl.easy()
    c:setopt_url(c:unescape(url))
    c:setopt({
        [curl.OPT_VERBOSE] = true,
        [curl.OPT_NOPROGRESS] = false;
    })
    --]]
    c:setopt_writefunction(f)
    c:setopt_progressfunction(p)

    c:perform()

    print("Download: " .. url)
    print("Saved to: " .. path_to_save)

    c:close()
    f:close()
end

local after = function (...)
    print("After", ...)
end

local work = uv.new_work(download, after)

local stdin = uv.new_tty(0, true)

stdin:read_start(function (err, data)
    assert(not err, err)
    if data then
        if string.find(data, "download") then
            print("--DOWNLOAD--")
            -- Remove control character, eg \r, \n
            input = string.gsub(data, "%c", "")
            s, e = string.find(input, "download")
            local remote_url = string.sub(input, e + 2)
            uv.queue_work(work, remote_url)
            print("Done")
        elseif string.find(data, "upload") then
            print("--UPLOAD--")
        elseif string.find(data, "stop") then
            print("--STOP--")
        elseif string.find(data, "quit") then
            print("QUIT")
            uv.stop()
        else
            print("--UNKNOWN--")
        end
    else
        stdin:close()
    end
end)

-- Create a new signal handler
local sigint = uv.new_signal()
-- Define a handler function
uv.signal_start(sigint, "sigint", function(signal)
    print("Got " .. signal .. ", shutting down")
    uv.stop()
    -- os.exit()
end)

uv.run()

-- Cleanup

-- Close loop
uv.loop_close()

print("End")
