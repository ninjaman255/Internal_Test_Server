-- Custom plugin aggregator.
-- Keep custom gameplay modules here so ezlibs' main dispatcher can fan out
-- event callbacks to each module without duplicate Net:on subscriptions.

local plugins = {
    require("scripts/ezlibs-custom/nebulous-liberations/main"),
    require("scripts/ezlibs-custom/footbomb/main"),
    require("scripts/ezlibs-custom/endless-runner/endless-runner")
}
local EndlessRunner = require("scripts/ezlibs-custom/endless-runner/endless-runner")

EndlessRunner.setup({
    -- "endless-runner" is what Net.list_areas() reports
    -- (see: [ezmemory] loaded area memory for endless-runner)
    base_area_id  = "endless-runner",
    enter_options = {
        loop       = true,
        lock_input = false,
    },
})

local custom = {}

local function dispatch(method_name, ...)
    local results = nil
    for _, plugin in ipairs(plugins) do
        local handler = plugin and plugin[method_name]
        if type(handler) == "function" then
            local result = handler(...)
            if result ~= nil then
                results = result
            end
        end
    end
    return results
end

local forwarded_methods = {
    "on_tick",
    "handle_tile_interaction",
    "handle_object_interaction",
    "handle_actor_interaction",
    "handle_textbox_response",
    "handle_battle_results",
    "handle_player_avatar_change",
    "handle_player_transfer",
    "handle_player_request",
    "handle_player_disconnect",
    "handle_player_move",
    "handle_player_join",
    "handle_post_selection",
    "handle_board_close",
    "handle_shop_purchase",
    "handle_shop_close",
    "handle_custom_warp"
}

for _, method_name in ipairs(forwarded_methods) do
    local forwarded_method = method_name
    custom[forwarded_method] = function(...)
        return dispatch(forwarded_method, ...)
    end
end

return custom
