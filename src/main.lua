
local discordia = require( 'discordia' )
local client = discordia.Client()
local config = require( './config.lua' )
local log = require( './functions/log.lua' )
local task = require( './functions/task.lua' )
local timer = require( 'timer' )
local fs = require( 'fs' )
discordia.extensions()


-- // Event Handler
local eventHandler = require( './handlers/eventHandler.lua' )
local eventloaded, eventerror = pcall( function() eventHandler:Init({ client = client, log = log, config = config }) end )
if not eventerror then log:Success('Event handler loaded.') else log:Error('Event handler failed to load. Error: ' .. eventerror) end

-- // Command Handler
local commandHandler = require( './handlers/commandHandler.lua' )
local commandsloaded, commandserror = pcall( function() commandHandler:Init({ log = log, client = client, config = config }) end )
if not commandserror then log:Success('Command handler loaded.') else log:Error('Command handler failed to load. Error: ' .. commandserror) end

client:on('messageCreate', function(message)
    if message.author.bot then return end
    if not message.guild then return end
    local slice = string.sub(message.content, 1, 1)
    if not slice == config.prefix then return end
    local cmdrun, err = pcall(function()
        if commandHandler.commands[message.content:gsub(config.prefix, ''):split(' ')[1]] then
            commandHandler:RunCommand({
                log = log,
                config = config,
                discordia = discordia,
                message = message,
                client = client,
                command = string.split(string.gsub(message.content, config.prefix, ''), ' ')[1],
                args = string.split(string.gsub(message.content, config.prefix, ''), ' '),
            })
        end
    end)
    if not cmdrun then
        log:Error(err)
    end
end)


client:run( 'Bot ' .. config.token )