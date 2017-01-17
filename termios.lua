local posix = require "posix"
local dev = arg[1] or "/dev/ttyS1"

-- Open serial port and do settings

local fds, err = posix.open(dev, posix.O_RDWR + posix.O_NOCTTY + posix.O_NONBLOCK);
if not fds then
    print("Could not open serial port " .. dev .. ":", err)
    os.exit(1)
end

posix.tcsetattr(fds, posix.TCSANOW, {
    cflag = posix.B115200 + posix.CS8 + posix.CLOCAL + posix.CREAD,
    iflag = posix.IGNPAR,
    oflag = 0,
    lflag = 0,
    cc = {
        [posix.VTIME] = 0,
        [posix.VMIN] = 1
    }
})

-- Set stdin to non canonical mode. Save current settings

local save = posix.tcgetattr(0)
posix.tcsetattr(0, 0, {
    cc = {
        [posix.VTIME] = 0,
        [posix.VMIN] = 1
    }
})

-- Loop, reading and writing between ports. ^C stops

local set = {
    [0]   = { events = { IN = true } },
    [fds] = { events = { IN = true } },
}

posix.write(1, "Starting terminal, hit ^C to exit\r\n")

local function exit(msg)
    posix.tcsetattr(0, 0, save)
    print("\n")
    print(msg)
    os.exit(0)
end

while true do
    local r = posix.poll(set, -1)
    for fd, d in pairs(set) do
        if d.revents and d.revents.IN then
            if fd == 0 then
                local d, err = posix.read(0, 1024)
                if not d then
                    exit(err)
                end
                if d == string.char(3) then
                    exit("Bye")
                end
                local ok, err = posix.write(fds, d)
                if not ok then
                    exit(err)
                end
            end
            if fd == fds then
                local d, err = posix.read(fds, 1024)
                if not d then
                    exit(err)
                end
                local ok, err = posix.write(1, d)
                if not ok then
                    exit(err)
                end
            end
        end
    end
end
