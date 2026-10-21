--[[
    Cosmo cosmetic NPC
    Extracted from the older Net Games demo and updated to use the current
    Net Games module and Tiled-driven NPC setup.

    Tiled setup:
      - Create an object named "CosmeticRoll" in the desired map.
      - The object position is used to place the Cosmo NPC.
      - The cosmetic itself is toggled per player by interacting with Cosmo.

    Cosmetic behavior:
      - First interaction equips the "confetti" cosmetic.
      - Second interaction removes it.
      - Player state is cleaned up on join/disconnect.
]]

local games = require("scripts/net-games/main")
local NetHelpers = require("scripts/net-games/helpers/net-helpers")

NetHelpers.patch_net()

local COSMO_OBJECT_NAME = "CosmeticRoll"
local COSMO_BOT_ID = "cosmo"

local COSMO_TEXTURE = "/server/assets/demo/roll.png"
local COSMO_ANIMATION = "/server/assets/demo/roll.animation"

local COSMETIC_ID = "confetti"
local COSMETIC_TEXTURE = "/server/assets/demo/shock.png"
local COSMETIC_ANIMATION = "/server/assets/demo/shock.animation"
local COSMETIC_STATE = "cosmetic"

-- Values retained from the original demo:
-- scale 2, screen offsets (2, -40), visible to the owner, player x-offset -2.
local COSMETIC_SCREEN_X = 2
local COSMETIC_SCREEN_Y = -40
local COSMETIC_VISIBLE = true
local COSMETIC_PLAYER_XOFFSET = -2
local COSMETIC_PLAYER_YOFFSET = -2

local cosmo_enabled = {}

local function log(message)
    print("[cosmo] " .. tostring(message))
end

local function spawn_cosmo_from_tiled()
    if not Net.list_areas or not Net.list_objects or not Net.get_object_by_id then
        log("Cannot auto-spawn Cosmo: Tiled object APIs are unavailable.")
        return
    end

    local areas = Net.list_areas() or {}
    local spawned = false

    for _, area_value in ipairs(areas) do
        local area_id = tostring(area_value)
        local object_ids = Net.list_objects(area_id) or {}

        for _, object_id in ipairs(object_ids) do
            local object = Net.get_object_by_id(area_id, object_id)

            if object and object.name == COSMO_OBJECT_NAME then
                -- Net bot IDs are global, so don't overwrite an existing Cosmo.
                if not Net.is_bot or not Net.is_bot(COSMO_BOT_ID) then
                    Net.create_bot(COSMO_BOT_ID, {
                        name = "",
                        area_id = area_id,
                        warp_in = false,
                        texture_path = COSMO_TEXTURE,
                        animation_path = COSMO_ANIMATION,
                        x = object.x,
                        y = object.y,
                        z = object.z or 0,
                        solid = true
                    })
                    log("Spawned Cosmo from Tiled object in area " .. area_id)
                else
                    log("Cosmo bot already exists; leaving existing bot in place.")
                end

                spawned = true
                break
            end
        end

        if spawned then
            break
        end
    end

    if not spawned then
        log('No Tiled object named "' .. COSMO_OBJECT_NAME .. '" was found; Cosmo was not spawned.')
    end
end

local function enable_cosmetic(player_id)
    -- set_cosmetic is the current Net Games cosmetic API. Keep the arguments
    -- compatible with the current framework's screen-sprite + attached-bot
    -- implementation.
    games.set_cosmetic(
        COSMETIC_ID,
        player_id,
        COSMETIC_TEXTURE,
        COSMETIC_ANIMATION,
        COSMETIC_STATE,
        COSMETIC_SCREEN_X,
        COSMETIC_SCREEN_Y,
        COSMETIC_VISIBLE,
        COSMETIC_PLAYER_XOFFSET
    )

    cosmo_enabled[player_id] = true
    Net.message_player(player_id, "Cosmetic enabled. So shiny!")
end

local function disable_cosmetic(player_id)
    games.remove_cosmetic(COSMETIC_ID, player_id)
    cosmo_enabled[player_id] = nil
    Net.message_player(player_id, "Cosmetic removed!")
end

Net:on("actor_interaction", function(event)
    if event.actor_id ~= COSMO_BOT_ID or event.button ~= 0 then
        return
    end

    local player_id = event.player_id
    if not player_id then
        return
    end

    if cosmo_enabled[player_id] then
        disable_cosmetic(player_id)
    else
        enable_cosmetic(player_id)
    end
end)

Net:on("player_join", function(event)
    if event.player_id then
        -- A joining player starts with no cosmetic enabled by this module.
        cosmo_enabled[event.player_id] = nil
    end
end)

Net:on("player_disconnect", function(event)
    local player_id = event.player_id
    if not player_id then
        return
    end

    -- Net Games also cleans its cosmetic bot/sprite state during disconnect.
    -- Clear this module's toggle state so reconnecting starts cleanly.
    cosmo_enabled[player_id] = nil
end)

spawn_cosmo_from_tiled()

return {
    spawn = spawn_cosmo_from_tiled,
    is_enabled = function(player_id)
        return cosmo_enabled[player_id] == true
    end
}
