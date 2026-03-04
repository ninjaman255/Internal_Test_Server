--=====================================================
-- prog_banner_dialogue.lua
-- Tiled-spawned NPC that triggers net-games Marquee
--=====================================================

local Direction = require("scripts/libs/direction")
local Displayer  = require("scripts/displayer/displayer")

local DEBUG = true
local function dbg(msg)
    if DEBUG then print("[prog_banner_dialogue] " .. msg) end
end

--=====================================================
-- Backdrop handling (solid white sprite)
--=====================================================
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"
local player_backdrop_sprite = {}

local function ensure_backdrop_sprite(player_id)
    if player_backdrop_sprite[player_id] then return end
    local sprite_id = "banner_backdrop_" .. player_id
    Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
    Net.player_alloc_sprite(player_id, sprite_id, { texture_path = BACKDROP_TEXTURE })
    player_backdrop_sprite[player_id] = sprite_id
end

local function draw_backdrop(player_id, backdrop, z)
    if not backdrop then return nil end
    ensure_backdrop_sprite(player_id)
    local sprite_id = player_backdrop_sprite[player_id]
    local x = backdrop.x or 0
    local y = backdrop.y or 0
    local width = backdrop.width or 240
    local height = backdrop.height or 30
    local r = backdrop.r or 0
    local g = backdrop.g or 0
    local b = backdrop.b or 0
    local opacity = backdrop.opacity or 200
    local a = backdrop.a or 255
    local draw_id = "banner_backdrop_" .. player_id
    Net.player_draw_sprite(player_id, sprite_id, {
        id = draw_id,
        x = x * 2,
        y = y * 2,
        z = z - 1,
        sx = width * 2,
        sy = height * 2,
        r = r, g = g, b = b,
        opacity = opacity,
        a = a,
        color_mode = 0,
    })
    return draw_id
end

local function erase_backdrop(player_id)
    Net.player_erase_sprite(player_id, "banner_backdrop_" .. player_id)
end

--=====================================================
-- Area / placement
--=====================================================
local area_id = "default"
local obj_name = "ProgBannerDialogue"

local bot_pos = Net.get_object_by_name(area_id, obj_name)
assert(bot_pos, "[prog_banner_dialogue] Missing Tiled object named '" .. obj_name .. "' in area: " .. tostring(area_id))

local bot_id = Net.create_bot({
    name = "Banner Prog",
    area_id = area_id,
    texture_path = "/server/assets/ow/prog/prog_ow.png",
    animation_path = "/server/assets/ow/prog/prog_ow.animation",
    x = bot_pos.x,
    y = bot_pos.y,
    z = bot_pos.z or 0,
    direction = Direction.Down,
    solid = true,
})

dbg("LOADED bot_id=" .. tostring(bot_id))

--=====================================================
-- Per‑player guard
--=====================================================
local marquee_active = {}

-- Tick handler to detect when marquee is removed
local TICK_ATTACHED = false
local function ensure_tick()
    if TICK_ATTACHED then return end
    TICK_ATTACHED = true
    Net:on("tick", function()
        for player_id, _ in pairs(marquee_active) do
            local bd = Displayer.Text.getTextBoxData(player_id, "prog_marquee")
            if not bd then
                marquee_active[player_id] = nil
                dbg("marquee finished for player " .. tostring(player_id))
                erase_backdrop(player_id)
            end
        end
    end)
end

--=====================================================
-- Interaction handler
--=====================================================
Net:on("actor_interaction", function(event)
    if event.actor_id ~= bot_id then return end
    local player_id = event.player_id

    if marquee_active[player_id] then
        return
    end
    marquee_active[player_id] = true

    -- Face the player
    local player_pos = Net.get_player_position(player_id)
    Net.set_bot_direction(bot_id, Direction.from_points(bot_pos, player_pos))

    local marquee_id = "prog_marquee"

    local backdrop = {
        x = 0,
        y = 0,
        width = 240,
        height = 30,
        padding_x = 6,
        padding_y = 0,
        loops = "once",
        keep_backdrop = false,
    }

    -- Draw backdrop
    draw_backdrop(player_id, backdrop, 100)

    -- Compute text y position (virtual) using backdrop padding
    local text_y = backdrop.y + (backdrop.padding_y or 0)

    -- Options for marquee
    local options = {
        font = "THICK",
        scale = 2.0,
        z = 100,
        speed = 60,
        loops = 1,          -- once
    }

    Displayer.Text.drawMarquee(
        player_id,
        marquee_id,
        "Yo! I hope you like what I've got done so far. This is BANNER mode. set inside the NPC. I pretty much am addicted at this point. :)",
        text_y,
        options
    )

    ensure_tick()
end)

Net:on("player_disconnect", function(event)
    marquee_active[event.player_id] = nil
    erase_backdrop(event.player_id)
end)