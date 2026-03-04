--=====================================================
-- prog_basic_freedraw.lua
-- Tiled-spawned NPC that draws ALL available fonts on screen
-- WITHOUT using Dialogue / textbox pipeline.
--=====================================================

local Direction  = require("scripts/libs/direction")
local Displayer  = require("scripts/displayer/displayer")

local DEBUG = true
local function dbg(msg)
    if DEBUG then print("[prog_basic_freedraw] " .. msg) end
end

--=====================================================
-- Area / placement
--=====================================================
local area_id  = "default"
local obj_name = "ProgBasicFreeDraw"

local bot_pos = Net.get_object_by_name(area_id, obj_name)
assert(bot_pos, "[prog_basic_freedraw] Missing Tiled object named '" .. obj_name .. "' in area: " .. tostring(area_id))

local bot_id = Net.create_bot({
    name = "FreeDraw Prog",
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
-- Font list (all names from font-system.lua)
--=====================================================
local FONT_TESTS = {
    { font = "THICK",       label = "THICK",       sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "THICK_BLACK", label = "THICK_BLACK", sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "BATTLE",      label = "BATTLE",      sample = "<PROG_EXE> ABC 0123 !?" },
    { font = "THIN",        label = "THIN",        sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "TINY",        label = "TINY",        sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "WIDE",        label = "WIDE",        sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "GRADIENT",    label = "GRADIENT",    sample = "ABC abc 0123 !?.,:;()[]+-*/" },
    { font = "GRADIENT_BLACK", label = "GRADIENT_BLACK", sample = "ABC abc 0123 !?.,:;()[]+-*/" },
}

--=====================================================
-- Per‑player state: store text IDs for each line
--=====================================================
local active_texts = {}  -- player_id -> { id1, id2, ... }

local function display_id_for(font_name)
    return "freedraw_font_" .. tostring(font_name)
end

local function show(player_id)
    -- Ensure dark font texture is provided
    pcall(function()
        Net.provide_asset_for_player(player_id, "/server/assets/net-games/fonts/fonts_dark_compressed.png")
    end)

    local x = 12   -- virtual x
    local y = 10   -- virtual y
    local z = 100
    local line_step = 16

    local ids = {}
    for i, t in ipairs(FONT_TESTS) do
        local text = string.format("%s: %s", t.label, t.sample)
        local text_id = display_id_for(t.font)

        Displayer.Text.drawStatic(
            player_id,
            text_id,
            text,
            x,
            y + (i - 1) * line_step,
            {
                font = t.font,
                scale = 2.0,
                z = z,
                r = 255, g = 255, b = 255,
                opacity = 255, a = 255,
            }
        )
        table.insert(ids, text_id)
    end
    active_texts[player_id] = ids
end

local function hide(player_id)
    local ids = active_texts[player_id]
    if ids then
        for _, text_id in ipairs(ids) do
            Displayer.Text.removeStatic(player_id, text_id)
        end
        active_texts[player_id] = nil
    end
end

--=====================================================
-- Interaction handler
--=====================================================
Net:on("actor_interaction", function(event)
    if event.actor_id ~= bot_id then return end
    if event.button ~= 0 then return end

    local player_id = event.player_id

    -- Face the player
    local player_pos = Net.get_player_position(player_id)
    Net.set_bot_direction(bot_id, Direction.from_points(bot_pos, player_pos))

    if active_texts[player_id] then
        hide(player_id)
    else
        show(player_id)
    end
end)

Net:on("player_disconnect", function(event)
    hide(event.player_id)
end)