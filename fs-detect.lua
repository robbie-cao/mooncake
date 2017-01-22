#!/usr/bin/env lua

pl = require("pl")
posix = require("posix")
local uv = require("luv")

local path = arg[1] or "."

local fdir = posix.dir(path)
local fset = Set(fdir)
pretty.dump(fdir)
pretty.dump(fset)

local fse = uv.new_fs_event()
assert(uv.fs_event_start(fse, path, {
    -- "watch_entry" = true,
    -- "stat" = true,
    recursive = false
}, function (err, fname, status)
    if err then
        print("Error " .. err)
    else
        print(string.format("Change detected in %s", uv.fs_event_getpath(fse)))
        if status["change"] == true then
            print("change: " .. (fname and fname or ""))
        elseif status["rename"] == true then
            print("rename: " .. (fname and fname or ""))
            fdir2 = posix.dir(path)
            fset2 = Set(fdir2)
            removed = fset - fset2
            added = fset2 - fset
            if #removed > 0 then
                print("Node removed:")
                pretty.dump(removed)
            end
            if #added > 0 then
                print("Node added:")
                pretty.dump(added)
            end
            -- Store current file nodes for next comparison
            fset = fset2
        else
            print("unknow: " .. (fname and fname or ""))
        end
    end
end))

uv.run("default")
uv.loop_close()
