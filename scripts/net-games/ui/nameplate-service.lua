-- Net Games owns BN-style nameplate state, asset lifecycle and animations.
-- Displayer is used for font primitives and textbox keep-alive only.
local Displayer = require("scripts/displayer/displayer")
local FontSystem = require("scripts/displayer/font-system")
local NameplateClass = require("scripts/net-games/ui/nameplate")
local instance = NameplateClass:new(FontSystem)
instance:setTextAPI(Displayer.Text)
local Service = {}
function Service.attach(player_id, player_data, box_id, box_data, cfg)
    return instance:attach(player_id, player_data, box_id, box_data, cfg)
end
function Service.begin_close(player_id, player_data, box_data, cfg)
    return instance:begin_close(player_id, player_data, box_data, cfg)
end
function Service.erase(player_id, player_data, box_data)
    return instance:erase(player_id, player_data, box_data)
end
function Service.cleanup_player(player_id)
    return instance:cleanupPlayer(player_id)
end
return Service
