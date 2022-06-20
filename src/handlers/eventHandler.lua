local eventHandler = {}

function eventHandler:Init( Info )
    local log = Info.log
    local client = Info.client
    local config = Info.config


    client:on( 'ready', function()

        log:Success( 'Logged in as ' .. client.user.username .. '.' )
    
        local phrases = {
            "dude im a lua bot wtf",
            "this is fucking crazy",
            "why would you make me in lua",
            "send help i have a family",
            "i havent seen my wife in years",
            "#ifshe13im13",
            "gobble on this shlong meat",
            "made by dosage-senpai",
            "with discordia",
            "first lua bot (real)",
          }
        
        local function getPhrase()
            return phrases[ math.random( #phrases ) ]
        end
    
        client:setGame( getPhrase() )
    
        log:Success( 'Set activity.' )
    end)
end

return eventHandler