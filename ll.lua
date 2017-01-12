-- import extension and initialize
lanes = require "lanes".configure()

-- thread 1 function
local function loop1( )
    while true do
        print("+ loop1")
        os.execute("sleep 0.1")
    end
end

-- thread 2 function
function loop2()
    while true do
        print("- loop2")
        os.execute("sleep 0.1")
    end
end

-- create and start the threads, notice the ‘()’ to start the thread. you can parameters to the function.
thread1 = lanes.gen("*", loop1)()
thread2 = lanes.gen("*", loop2)()
