local uv = require('luv')

local step = 10

hare = function (step, ...)
    local uv = require('luv')
    while step > 0 do
        step = step - 1
        uv.sleep(1000)
        print("+ Hare ran another step")
    end
    print("** Hare done running!")
end

tortoise = function (step, ...)
    local uv = require('luv')
    while step > 0 do
        step = step - 1
        uv.sleep(500)
        print("- Tortoise ran another step")
    end
    print("** Tortoise done running!")
end

local hare_id = uv.new_thread(hare, step, true, 'abcd', 'false')

local tortoise_id = uv.new_thread(tortoise, step, 'abcd', 'false')

print(hare_id == hare_id, uv.thread_equal(hare_id, hare_id))
print(tortoise_id == hare_id, uv.thread_equal(tortoise_id, hare_id))

uv.thread_join(hare_id)
uv.thread_join(tortoise_id)

