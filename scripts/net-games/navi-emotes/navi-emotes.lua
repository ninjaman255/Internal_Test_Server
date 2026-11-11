local NaviEmotes = {}
local NetGames = require("scripts/net-games/main")

NaviEmotes.activate = function(player_id)
    -- Display-only: no engine input capture required.
    NetGames.add_ui_element("Test", player_id, "assets/card.png", nil, nil, 0, 0, 0)
end

Net:on("player_join", function(event)
    print(event)
    NaviEmotes.activate(event.player_id)
end)