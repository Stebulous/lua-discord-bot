local log = {}
local colors = require( '../modules/colors.lua' )
function log:Success( message )
    print( colors.green('[Success] ') .. message )
end

function log:Error( message )
    print( colors.red('[Error] ') .. message )
end

function log:Warning( message )
    print( colors.yellow('[Warning] ') .. message )
end

return log