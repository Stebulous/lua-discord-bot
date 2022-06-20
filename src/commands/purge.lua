local command = {}

command.name = 'purge'

function command:Execute(Info)
    local log = Info.log
    local message = Info.message
    local args = Info.args
    local client = Info.client
    local config = Info.config

    if message then message:delete() end

    local num = tonumber(args[2])

    if not num then
        return log:Error("You must specify a number.")
    elseif num <2 or num >100 then
        return log:Error("Number must be between 2 and 100.")
    end

    local messages = message.channel:getMessagesAfter(args[1], num)

    local success, msg = pcall(function()
        message.channel:bulkDelete(messages)
    end)
    if not success then
        return log:Error("Error with purge command: " .. msg)
    else
        return log:Warning('Purge command used by: ' .. message.author.name .. '. Messages deleted: ' .. num)
    end

end

return command