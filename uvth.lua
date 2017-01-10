local uv = require('luv')

local step = 10

hare = function (step, ...)
    local uv = require('luv')
    while step > 0 do
        print("+ Hare ran step " .. tostring(step), ...)
        step = step - 1
        uv.sleep(1000)
    end
    print("** Hare done running!")
end

tortoise = function (step, msg, ...)
    local uv = require('luv')
    while step > 0 do
        print("- Tortoise ran step " .. tostring(step), msg, ...)
        step = step - 1
        uv.sleep(500)
    end
    print("** Tortoise done running!")
end

snail = function (step, ...)
    local uv = require('luv')
    while step > 0 do
        print("- Snail ran step " .. tostring(step), ...)
        step = step - 1
        uv.sleep(1500)
    end
    print("** Snail done running!")
end

-- only the fist two params are necessary
local hare_id = uv.new_thread(hare, step, true, 'abcd', 'false')
local tortoise_id = uv.new_thread(tortoise, step, 'abcd', 'false')
local snail_id = uv.new_thread(snail, step)

do
    -- evaluate
    print("hare_id:", hare_id, type(hare_id))
    print("tortoise_id:", tortoise_id, type(tortoise_id))
    print("snail_id:", snail_id, type(snail_id))
    print(hare_id == hare_id, uv.thread_equal(hare_id, hare_id))
    print(tortoise_id == hare_id, uv.thread_equal(tortoise_id, hare_id))
end

uv.thread_join(hare_id)
uv.thread_join(tortoise_id)
uv.thread_join(snail_id)

