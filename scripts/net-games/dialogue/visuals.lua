-- Shared native visual layer for net-games dialogue/prompt screens.
-- NPC textbox presets use screen pixels (480x320). TextDisplay uses virtual
-- coordinates (240x160). Convert ONLY at the TextDisplay boundary.
-- The menu layout and Net.player_draw_sprite continue to use screen pixels.
-- This is rendering code, not a legacy input/controller compatibility layer.

local Visuals = {}
local DebugLog = require("scripts/logger/logger").register_subsystem("net-games-dialogue", "VISUALS", {console = false, maxBufferSize = 1})
local players = {}  -- per-player allocated sprite assets and active draw instances

local PANEL_TEXTURE = "/server/assets/net-games/displayer/textbox.png"
local PANEL_ANIMATION = "/server/assets/net-games/displayer/textbox.animation"
local PANEL_FRAME = "/server/assets/net-games/displayer/textbox_frame_gray.png"
local SOLID_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"
local SOLID_TEXTURE_SIZE = 4  -- actual source image is 4x4 pixels

local function player_data(player_id)
    local data = players[player_id]
    if not data then
        data = {assets = {}, count = 0, draws = {}, surfaces = {}}
        players[player_id] = data
    end
    return data
end

local function asset(player_id, texture, animation, initial_state)
    if not texture then return nil end
    local data = player_data(player_id)
    local key = texture .. "|" .. tostring(animation or "")
    if data.assets[key] then return data.assets[key] end
    Net.provide_asset_for_player(player_id, texture)
    if animation then Net.provide_asset_for_player(player_id, animation) end
    data.count = data.count + 1
    local sprite_id = "ng_dialogue_visual_" .. tostring(data.count) .. "_" .. tostring(player_id)
    local def = {texture_path = texture}
    if animation then
        def.anim_path = animation
        def.anim_state = initial_state or "OPEN_IDLE"
    end
    Net.player_alloc_sprite(player_id, sprite_id, def)
    data.assets[key] = sprite_id
    return sprite_id
end

-- Normalize the text rectangle; custom UI without a backdrop retains the
-- Displayer's native virtual-coordinate convention.
function Visuals.text_rect(ui)
    local x = tonumber(ui.x) or 8
    local y = tonumber(ui.y) or 110
    local w = tonumber(ui.w) or 224
    local h = tonumber(ui.h) or 42
    if ui.backdrop then
        -- The earlier textbox renderer reserved the mugshot's width for
        -- dialogue glyphs. The modern TextDisplay lays out only its own
        -- rectangle, so the caller must provide the unobstructed region.
        local mug = ui.mugshot
        if type(mug) == "table" and mug.enabled ~= false then
            local reserve_w = tonumber(mug.reserve_w or mug.sprite_w) or 0
            if reserve_w > 0 then
                local scale = tonumber(ui.scale) or 2.0
                local gap = tonumber(mug.gap_px)
                if gap == nil then gap = 3 * scale end
                local occupied_px = reserve_w * scale + gap
                -- Never create a negative layout rectangle for small panels.
                occupied_px = math.min(occupied_px, math.max(0, w - 1))
                x = x + occupied_px
                w = w - occupied_px
            end
        end
        return x / 2, y / 2, w / 2, h / 2
    end
    return x, y, w, h
end

-- Fonts are selected by the NPC caller without remapping.
-- Displayer and its font metrics remain the rendering authority.

-- The NPC nameplate anchors to the original padded textbox rectangle,
-- not to the narrower, mugshot-excluding rectangle used by the text engine.
-- Pass a copy to Nameplate.attach so its original UI position is preserved.
function Visuals.nameplate_box_data(ui, data)
    if type(data) ~= "table" or type(ui) ~= "table" then return data end
    local b = ui.backdrop
    if type(b) ~= "table" then return data end
    local copy = {}
    for k, v in pairs(data) do copy[k] = v end
    local px, py = tonumber(b.padding_x) or 0, tonumber(b.padding_y) or 0
    copy.x = (tonumber(b.x) or 0) + px
    copy.y = (tonumber(b.y) or 0) + py
    copy.width = math.max(1, (tonumber(b.width) or copy.width or 0) - 2 * px)
    copy.height = math.max(1, (tonumber(b.height) or copy.height or 0) - 2 * py)
    copy.inner_x, copy.inner_y = copy.x, copy.y
    -- Nameplate.attach positions its frame relative to the *visible* textbox.
    -- getTextBoxData returns a snapshot without the sprite backdrop offsets.
    -- Preserve them here so the original NPC gap_y (59 screen pixels) offsets
    -- the real panel position instead of pushing the plate too far upward.
    -- Keep the source backdrop untouched (other overlays may reuse it).
    copy.backdrop = {
        render_offset_x = tonumber(b.render_offset_x) or 0,
        render_offset_y = tonumber(b.render_offset_y) or 0,
    }
    return copy
end

local function draw_mug(player_id, draw_id, ui, state, d)
    local mug = ui.mugshot
    if type(mug) ~= "table" or mug.enabled == false or not mug.texture_path then return end
    local sprite_id = asset(player_id, mug.texture_path, mug.anim_path,
        mug.idle_anim_state or mug.anim_state or "IDLE")
    if not sprite_id then return end
    local b = ui.backdrop or {}
    -- Older mugshot offsets were authored relative to the text origin in
    -- *screen pixels*, not the virtual glyph position.
    local origin_x = type(ui.backdrop) == "table" and b.x or ui.x
    local origin_y = type(ui.backdrop) == "table" and b.y or ui.y
    local x = (tonumber(origin_x) or 0) + (tonumber(b.render_offset_x) or 0)
        + (tonumber(mug.offset_x) or 0)
    local y = (tonumber(origin_y) or 0) + (tonumber(b.render_offset_y) or 0)
        + (tonumber(mug.offset_y) or 0)
    local desired = state == "printing"
        and (mug.talk_anim_state or mug.idle_anim_state or "IDLE")
        or (mug.idle_anim_state or mug.anim_state or "IDLE")
    if d.mug_state == desired and d.mug_sprite_id == sprite_id then return end
    Net.player_draw_sprite(player_id, sprite_id, {
        id = draw_id .. "_mug", x = x, y = y,
        z = (tonumber(ui.z) or 100) + (tonumber(mug.z_bias) or 0),
        sx = tonumber(mug.scale) or tonumber(ui.scale) or 2.0,
        sy = tonumber(mug.scale) or tonumber(ui.scale) or 2.0,
        anim_state = desired,
    })
    d.mug_state = desired
    d.mug_sprite_id = sprite_id
end

-- Draw a textbox background using actual available server assets. Keep every
-- part scoped to draw_id so nested prompt/dialogue transitions cannot erase
-- another screen's background or mugshot.
function Visuals.draw(player_id, draw_id, ui)
    if not ui then return nil end
    local b = ui.backdrop
    local mug = ui.mugshot
    if not b and not mug then return nil end
    local data = player_data(player_id)
    -- Dialogue, Yes/No and its parent vertical menu can all reuse one
    -- TextDisplay box. They must NOT layer separate textbox backgrounds at
    -- the same z: insertion order otherwise makes the tint appear to reset.
    -- A caller keeps its own handle; the actual backdrop is one shared draw.
    local handle_id = draw_id
    local key = (type(ui.box_id) == "string" and ui.box_id ~= "")
        and ("box:" .. ui.box_id) or ("draw:" .. draw_id)
    local existing = data.surfaces[key]
    if existing then
        DebugLog:debug_data("Textbox visuals shared with existing owner", {
            player_id = player_id, box_id = ui.box_id, draw_id = handle_id,
            surface_key = key,
        })
        existing.owners[handle_id] = true
        data.draws[handle_id] = existing
        draw_mug(player_id, existing.native_draw_id, ui, "printing", existing)
        return handle_id
    end
    DebugLog:info_data("Textbox visuals created", {
        player_id = player_id, box_id = ui.box_id,
        draw_id = handle_id, surface_key = key,
        backdrop_style = b and b.style, has_mugshot = mug ~= nil,
    })
    local d = {
        native_draw_id = (key:sub(1, 4) == "box:")
            and ("ng_dialogue_box_" .. tostring(player_id) .. "_" .. ui.box_id)
            or draw_id,
        surface_key = key,
        owners = {[handle_id] = true},
    }
    data.surfaces[key] = d
    data.draws[handle_id] = d
    draw_id = d.native_draw_id
    local z = (tonumber(ui.z) or 100) - 1
    local scale = tonumber(ui.scale) or 2.0
    if type(b) == "table" then
        local style = b.style or "black_box"
        if style == "textbox_panel" or style == "textbox_panel_frame_tint" then
            local sprite_id = asset(player_id, PANEL_TEXTURE, PANEL_ANIMATION, "OPEN_IDLE")
            local x = (tonumber(b.x) or tonumber(ui.x) or 0) + (tonumber(b.render_offset_x) or 0)
            local y = (tonumber(b.y) or tonumber(ui.y) or 0) + (tonumber(b.render_offset_y) or 0)
            -- Existing textbox.animation uses the 240x63 OPEN_IDLE frame; its
            -- sprite origin and 2x scale are the same as the original renderer.
            Net.player_draw_sprite(player_id, sprite_id, {
                id = draw_id, x = x, y = y, z = z,
                sx = scale, sy = scale, anim_state = "OPEN_IDLE",
                r = 255, g = 255, b = 255, a = 255, opacity = 255,
            })
            if style == "textbox_panel_frame_tint" then
                local frame = asset(player_id, PANEL_FRAME, PANEL_ANIMATION, "OPEN_IDLE")
                Net.player_draw_sprite(player_id, frame, {
                    id = draw_id .. "_frame", x = x, y = y, z = z + 0.01,
                    sx = scale, sy = scale, anim_state = "OPEN_IDLE",
                    r = tonumber(b.r) or 255, g = tonumber(b.g) or 255,
                    b = tonumber(b.b) or 255, a = tonumber(b.a) or 255,
                    opacity = tonumber(b.opacity) or 255,
                    color_mode = tonumber(b.color_mode) or 2,
                })
            end
        else
            -- Black-box preset: use the 4x4 source as a solid rectangle.
            -- Sprite sx/sy are scale *multipliers*, not final pixel sizes.
            local sprite_id = asset(player_id, SOLID_TEXTURE)
            Net.player_draw_sprite(player_id, sprite_id, {
                id = draw_id,
                x = tonumber(b.x) or 0, y = tonumber(b.y) or 0,
                z = z,
                sx = (tonumber(b.width) or 240) / SOLID_TEXTURE_SIZE,
                sy = (tonumber(b.height) or 160) / SOLID_TEXTURE_SIZE,
                r = tonumber(b.r) or 0, g = tonumber(b.g) or 0,
                b = tonumber(b.b) or 0,
                opacity = tonumber(b.opacity) or 200,
                a = tonumber(b.a) or 255,
                color_mode = tonumber(b.color_mode) or 0,
            })
        end
    end
    draw_mug(player_id, draw_id, ui, "printing", d)
    return handle_id
end

function Visuals.update(player_id, draw_id, ui, textbox_state)
    local d = players[player_id] and players[player_id].draws[draw_id]
    if d and ui and ui.mugshot then
        draw_mug(player_id, d.native_draw_id, ui, textbox_state, d)
    end
end

function Visuals.erase(player_id, draw_id)
    if not draw_id then return end
    local data = players[player_id]
    local surface = data and data.draws[draw_id]
    if not surface then return end
    surface.owners[draw_id] = nil
    data.draws[draw_id] = nil
    -- Another nested screen still owns the same visible panel.
    if next(surface.owners) then
        DebugLog:debug_data("Textbox visuals owner released; other owner remains", {
            player_id = player_id, draw_id = draw_id, surface_key = surface.surface_key,
        })
        return
    end
    DebugLog:info_data("Textbox visuals erased after last owner released", {
        player_id = player_id, draw_id = draw_id, surface_key = surface.surface_key,
    })
    local native = surface.native_draw_id
    Net.player_erase_sprite(player_id, native)
    Net.player_erase_sprite(player_id, native .. "_frame")
    Net.player_erase_sprite(player_id, native .. "_mug")
    data.surfaces[surface.surface_key] = nil
end

Net:on("player_disconnect", function(event)
    if event and event.player_id then players[event.player_id] = nil end
end)

return Visuals
