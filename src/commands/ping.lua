local command = {}

command.name = "ping"

function command:Execute(Info)
    local log = Info.log
    local message = Info.message
    local args = Info.args
    local client = Info.client
    local discordia = Info.discordia
    local stopwatch = discordia.Stopwatch()

    local success, msg = pcall(function()
        message.channel:send("Ping: `"..math.floor(stopwatch:getTime():toMilliseconds()+0.5).." ms`")
    end)
    if not success then
        return log:Error("Error with ping command: " .. msg)
    else
        return log:Warning('Ping command used by: ' .. message.author.name)
    end
end

return command