local task = {}
local timer = require('timer')


function task.spawn(func)
    coroutine.wrap(func)()
end

return task