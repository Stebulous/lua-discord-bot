local command = {}

command.name = "say"

function command:Execute(Info)
    local log = Info.log
    local message = Info.message
    local args = Info.args
    local client = Info.client
    local config = Info.config

    local text = string.gsub(message.content, config.prefix .. command.name, '')
    local success, msg = pcall(function()
        message:delete()
        message.channel:send(text)
    end)
    if not success then
        return log:Error("Error sending message: " .. msg)
    else
        return log:Warning('Message sent by: ' .. message.author.name)
    end
end

return command