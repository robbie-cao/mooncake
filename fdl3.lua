local uv = require('luv')

download = function (url, path, ...)
    if not url or url == "" then
        print("URL cannot be nil\n")
        return
    end

    path_to_save = os.date("%Y%m%d-%H%M%S")
    if (path and path ~= "") then
        path_to_save = path
    end

    w = assert(io.open(path_to_save, "w"))
    p = function (...)
        -- Callback for progress
        ---[[
        print("#", ...)
        --]]
    end
    h = function (...)
        -- Callback on receiving header
        --[[
        print("H", ...)
        --]]
    end
    r = function (...)
        -- Callback for read
        ---[[
        print("R", ...)
        --]]
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
    c:setopt_headerfunction(h)
    c:setopt_writefunction(w)
    c:setopt_readfunction(r)
    c:setopt_progressfunction(p)

    c:perform()

    print("Download: " .. url)
    print("Saved to: " .. path_to_save)

    c:close()
    w:close()

end

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
            local download_id = uv.new_thread(download, remote_url)
            uv.thread_join(download_id)
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
