local sys_stat = require "posix.sys.stat"
local bit = require("bit")

if #arg < 1 then
    print(string.format("Usage: %s path", arg[0]))
    return
end

local path = arg[1]

function stmode(mode)
    if bit.band(mode, sys_stat.S_IFBLK) ~= 0  then return "block device"     end
    if bit.band(mode, sys_stat.S_IFCHR) ~= 0  then return "character device" end
    if bit.band(mode, sys_stat.S_IFDIR) ~= 0  then return "directory"        end
    if bit.band(mode, sys_stat.S_IFIFO) ~= 0  then return "FIFO/pipe"        end
    --[[
    if bit.band(mode, sys_stat.S_IFLNK) ~= 0  then return "symlink"          end
    --]]
    if bit.band(mode, sys_stat.S_IFREG) ~= 0  then return "regular file"     end
    if bit.band(mode, sys_stat.S_IFSOCK) ~= 0 then return "socket"           end

    return "unknown?"
end

sb = sys_stat.stat(path)

print(string.format("File type               : %s", stmode(sb.st_mode)))
print(string.format("I-node number           : %d", sb.st_ino))
print(string.format("Mode                    : %o (octal)", sb.st_mode))
print(string.format("Link count              : %d", sb.st_nlink))
print(string.format("Ownership               : UID=%d  GID=%d", sb.st_uid, sb.st_gid))
print(string.format("Preferred I/O block size: %d bytes", sb.st_blksize))
print(string.format("File size               : %d bytes", sb.st_size))
print(string.format("Blocks allocated        : %d", sb.st_blocks))
print(string.format("Last status change      : %s", sb.st_ctime))
print(string.format("Last file access        : %s", sb.st_atime))
print(string.format("Last file modification  : %s", sb.st_mtime))
