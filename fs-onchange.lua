local uv = require("luv")

if #arg < 1 then
    print(string.format("Usage: %s <file1> [file2 ...]", arg[0]));
    return
end

for i = 1, #arg do
    local fse = uv.new_fs_event()
    assert(uv.fs_event_start(fse, arg[i], {
        -- "watch_entry" = true,
        -- "stat" = true,
        recursive = true
    }, function (err, fname, status)
        --[[
        require("pl")
        pretty.dump(status)
        --]]
        if err then
            print("Error " .. err)
        else
            print(string.format("Change detected in %s", uv.fs_event_getpath(fse)))
            if status["change"] == true then
                print("change: " .. (fname and fname or ""))
            elseif status["rename"] == true then
                print("rename: " .. (fname and fname or ""))
            else
                print("unknow: " .. (fname and fname or ""))
            end
        end
    end))
end

uv.run("default")
uv.loop_close()
