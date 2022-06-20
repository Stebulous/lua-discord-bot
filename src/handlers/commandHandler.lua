local commandHandler = {}
local fs = require('fs')
local uv = require('uv')
uv.chdir('./src')

commandHandler.name = "commandHandler"

commandHandler.commands = {}


function commandHandler:Init( Info )

    local log = Info.log
    local client = Info.client
    local config = Info.config

    for name, type in fs.scandirSync('./commands') do
        if name:match('%.lua$') then
            local command = require( './commands/' .. name:gsub('%.lua$', '') )
            commandHandler.commands[name:gsub('%.lua$', '')] = command
            log:Success( 'Loaded command: ' .. name:gsub('%.lua$', '') )
        end
    end
 
end

function commandHandler:RunCommand( Info )
    local log = Info.log
    local command = commandHandler.commands[ Info.command ]
    if command then
        local success, err = pcall( function() command:Execute(Info) end )
        if not success then return log:Error('Command failed to execute. Command: ' .. command.name .. 'Error: ' .. err) end
    else
        return log:Warning('Command not found. Command: ' .. Info.command)
    end
end

return commandHandler