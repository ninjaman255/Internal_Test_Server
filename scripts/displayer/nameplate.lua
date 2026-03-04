--[[
nameplate.lua – BN‑style nameplate with 3‑slice sprite and text.
Uses AnimationEngine for unfolding and bob animations.
Now uses a registry to persist nameplate data across getTextBoxData calls.
]]

local Nameplate = {}
Nameplate.__index = Nameplate

local AnimationEngine = require("scripts/animation-engine/animation-engine")
local ceil_div = function(a, b) return math.floor((a + b - 1) / b) end

function Nameplate:new(font_system)
    local o = setmetatable({}, self)
    o.font_system = font_system
    o.text_api = nil   -- will be injected from displayer after Text API is ready

    o.tex_left  = "/server/assets/net-games/displayer/textbox_bn6_nameplate_left.png"
    o.tex_mid   = "/server/assets/net-games/displayer/textbox_bn6_nameplate_middle.png"
    o.tex_right = "/server/assets/net-games/displayer/textbox_bn6_nameplate_right.png"

    o.tex_left_frame  = "/server/assets/net-games/displayer/textbox_bn6_nameplate_left_frame_gray.png"
    o.tex_mid_frame   = "/server/assets/net-games/displayer/textbox_bn6_nameplate_middle_frame_gray.png"
    o.tex_right_frame = "/server/assets/net-games/displayer/textbox_bn6_nameplate_right_frame_gray.png"

    o.w_left  = 5
    o.w_mid   = 3
    o.w_right = 5
    o.h_plate = 13

    o.MAX_MIDS = 60

    o.player_assets = {}
    o.nameplate_registry = {}  -- player_id -> { box_id = np }

    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
            local player_id = event.player_id
            if player_id then
                o:cleanupPlayer(player_id)
            end
        end)
        if not ok then
            print("Error in nameplate player_disconnect:", err)
        end
    end)

    return o
end

-- Inject the Text API (called from displayer:init() after Text is ready)
function Nameplate:setTextAPI(api)
    self.text_api = api
end

-- Ensure all required sprite assets are allocated for a player.
function Nameplate:ensureAssets(player_id)
    if self.player_assets[player_id] then return end

    local assets = {}

    Net.provide_asset_for_player(player_id, self.tex_left)
    Net.provide_asset_for_player(player_id, self.tex_mid)
    Net.provide_asset_for_player(player_id, self.tex_right)
    Net.provide_asset_for_player(player_id, self.tex_left_frame)
    Net.provide_asset_for_player(player_id, self.tex_mid_frame)
    Net.provide_asset_for_player(player_id, self.tex_right_frame)

    assets.base_left  = "np_base_left_" .. player_id
    assets.base_right = "np_base_right_" .. player_id
    Net.player_alloc_sprite(player_id, assets.base_left,  { texture_path = self.tex_left })
    Net.player_alloc_sprite(player_id, assets.base_right, { texture_path = self.tex_right })

    assets.base_mid = {}
    for i = 0, self.MAX_MIDS - 1 do
        local sid = "np_base_mid_" .. i .. "_" .. player_id
        Net.player_alloc_sprite(player_id, sid, { texture_path = self.tex_mid })
        assets.base_mid[i] = sid
    end

    assets.frame_left  = "np_frame_left_" .. player_id
    assets.frame_right = "np_frame_right_" .. player_id
    Net.player_alloc_sprite(player_id, assets.frame_left,  { texture_path = self.tex_left_frame })
    Net.player_alloc_sprite(player_id, assets.frame_right, { texture_path = self.tex_right_frame })

    assets.frame_mid = {}
    for i = 0, self.MAX_MIDS - 1 do
        local sid = "np_frame_mid_" .. i .. "_" .. player_id
        Net.player_alloc_sprite(player_id, sid, { texture_path = self.tex_mid_frame })
        assets.frame_mid[i] = sid
    end

    self.player_assets[player_id] = assets
end

-- Deallocate all nameplate assets for a player.
function Nameplate:cleanupPlayer(player_id)
    local assets = self.player_assets[player_id]
    if not assets then return end

    Net.player_dealloc_sprite(player_id, assets.base_left)
    Net.player_dealloc_sprite(player_id, assets.base_right)
    for _, sid in pairs(assets.base_mid) do
        Net.player_dealloc_sprite(player_id, sid)
    end
    Net.player_dealloc_sprite(player_id, assets.frame_left)
    Net.player_dealloc_sprite(player_id, assets.frame_right)
    for _, sid in pairs(assets.frame_mid) do
        Net.player_dealloc_sprite(player_id, sid)
    end

    self.player_assets[player_id] = nil
    self.nameplate_registry[player_id] = nil
end

-- Redraw the nameplate based on current np.mids_drawn, np.y, etc.
function Nameplate:_redraw(player_id, np, assets)
    local scale = np.scale
    local z = np.z
    local y = np.y   -- already includes bob offset
    local mids = np.mids_drawn or 0

    -- Debug: print redraw during close
    if np.closing then
        print("Nameplate _redraw (closing): mids_drawn =", mids)
    end

    local total_w = (self.w_left + self.w_right) * scale + (mids * np.mid_w)
    local left_x = math.floor((np.center_x - total_w / 2) + 0.5)

    -- Base left
    Net.player_draw_sprite(player_id, assets.base_left, {
        id = np.idp .. "_L",
        x = left_x, y = y, z = z,
        sx = scale, sy = scale,
        r = 255, g = 255, b = 255,
        opacity = 255, a = 255,
        color_mode = 0,
    })

    -- Base right
    local right_x = left_x + self.w_left * scale + mids * np.mid_w
    Net.player_draw_sprite(player_id, assets.base_right, {
        id = np.idp .. "_R",
        x = right_x, y = y, z = z,
        sx = scale, sy = scale,
        r = 255, g = 255, b = 255,
        opacity = 255, a = 255,
        color_mode = 0,
    })

    -- Base middle pieces
    for i = 0, mids - 1 do
        local mx = left_x + self.w_left * scale + i * np.mid_w
        Net.player_draw_sprite(player_id, assets.base_mid[i], {
            id = np.idp .. "_M" .. i,
            x = mx, y = y, z = z,
            sx = scale, sy = scale,
            r = 255, g = 255, b = 255,
            opacity = 255, a = 255,
            color_mode = 0,
        })
    end
    for i = mids, self.MAX_MIDS - 1 do
        Net.player_erase_sprite(player_id, np.idp .. "_M" .. i)
    end

    -- Frame overlay
    if np.frame and np.frame.a > 0 then
        local fz = z + 1
        local fr, fg, fb, fa, fmode = np.frame.r, np.frame.g, np.frame.b, np.frame.a, np.frame.color_mode

        Net.player_draw_sprite(player_id, assets.frame_left, {
            id = np.idp .. "_FL",
            x = left_x, y = y, z = fz,
            sx = scale, sy = scale,
            r = fr, g = fg, b = fb,
            opacity = 255, a = fa,
            color_mode = fmode,
        })

        Net.player_draw_sprite(player_id, assets.frame_right, {
            id = np.idp .. "_FR",
            x = right_x, y = y, z = fz,
            sx = scale, sy = scale,
            r = fr, g = fg, b = fb,
            opacity = 255, a = fa,
            color_mode = fmode,
        })

        for i = 0, mids - 1 do
            local mx = left_x + self.w_left * scale + i * np.mid_w
            Net.player_draw_sprite(player_id, assets.frame_mid[i], {
                id = np.idp .. "_FM" .. i,
                x = mx, y = y, z = fz,
                sx = scale, sy = scale,
                r = fr, g = fg, b = fb,
                opacity = 255, a = fa,
                color_mode = fmode,
            })
        end
        for i = mids, self.MAX_MIDS - 1 do
            Net.player_erase_sprite(player_id, np.idp .. "_FM" .. i)
        end
    else
        Net.player_erase_sprite(player_id, np.idp .. "_FL")
        Net.player_erase_sprite(player_id, np.idp .. "_FR")
        for i = 0, self.MAX_MIDS - 1 do
            Net.player_erase_sprite(player_id, np.idp .. "_FM" .. i)
        end
    end

    -- Draw name text when fully unfolded and not closing
    if np.complete and not np.closing and np.text then
        local text_x = math.floor((left_x + self.w_left * scale + np.pad_px) + 0.5)
        local text_y = math.floor((y + (3 * scale) + 2) + 0.5)

        if np.text_glyph_ids then
            for _, id in ipairs(np.text_glyph_ids) do
                self.font_system:eraseGlyph(player_id, id)
            end
        end

        local glyph_ids = {}
        local cx = text_x
        for i = 1, #np.text do
            local ch = np.text:sub(i,i)
            if ch ~= " " then
                local inst_id = self.font_system:drawGlyph(player_id, np.font, ch, cx, text_y, {
                    scale = np.text_scale,
                    z = z + 2,
                    r = 255, g = 255, b = 255,
                    opacity = 255, a = 255,
                })
                if inst_id then
                    table.insert(glyph_ids, inst_id)
                end
            end
            local w, _ = self.font_system:getGlyphDimensions(np.font, ch)
            cx = cx + w * np.text_scale + 1 * np.text_scale
        end
        np.text_glyph_ids = glyph_ids
    else
        if np.text_glyph_ids then
            for _, id in ipairs(np.text_glyph_ids) do
                self.font_system:eraseGlyph(player_id, id)
            end
            np.text_glyph_ids = nil
        end
    end
end

-- Attach a nameplate to a text box.
function Nameplate:attach(player_id, player_data, box_id, box_data, cfg)
    if not cfg then return end

    local text = type(cfg) == "string" and cfg or cfg.text
    if not text or text == "" then return end

    self:ensureAssets(player_id)

    -- Initialize registry for this player if needed
    if not self.nameplate_registry[player_id] then
        self.nameplate_registry[player_id] = {}
    end

    -- If there's already a nameplate for this box_id, erase it first
    if self.nameplate_registry[player_id][box_id] then
        local old_np = self.nameplate_registry[player_id][box_id]
        if old_np then
            if old_np.unfold_anim_id then AnimationEngine.stop_animation(old_np.unfold_anim_id) end
            if old_np.bob_anim_id then AnimationEngine.stop_animation(old_np.bob_anim_id) end
            if old_np.close_anim_id then AnimationEngine.stop_animation(old_np.close_anim_id) end
        end
    end

    local scale = box_data.scale or 2.0
    local z = (box_data.z_order or 100) + 3

    local bx = box_data.x or 0
    local by = box_data.y or 0
    if box_data.backdrop then
        bx = bx + (tonumber(box_data.backdrop.render_offset_x) or 0)
        by = by + (tonumber(box_data.backdrop.render_offset_y) or 0)
    end

    local font_name  = "TINY_BLACK"
    local text_scale = (type(cfg) == "table" and cfg.text_scale) or scale
    local pad_px     = (type(cfg) == "table" and cfg.pad_px) or (4 * scale)

    -- Compute text width
    local text_w = 0
    for i = 1, #text do
        local ch = text:sub(i,i)
        local w, _ = self.font_system:getGlyphDimensions(font_name, ch)
        text_w = text_w + w * text_scale
        if i < #text then text_w = text_w + 1 * text_scale end
    end

    local inner_needed = math.max(1, math.floor(text_w + pad_px * 2))
    local mid_w = self.w_mid * scale
    local mids_target = math.min(self.MAX_MIDS, math.max(1, ceil_div(inner_needed, mid_w)))
    local total_w = (self.w_left + self.w_right) * scale + (mids_target * mid_w)

    local gap_x = (type(cfg) == "table" and cfg.gap_x) or (6 * scale)
    local gap_y = (type(cfg) == "table" and cfg.gap_y) or (4 * scale)

    local anchor = (type(cfg) == "table" and cfg.anchor) or "above_left"
    local align  = (type(cfg) == "table" and cfg.align)  or "left"

    local bw = box_data.width or 0

    local x, y
    if anchor == "above" then
        if align == "center" then
            x = bx + (bw - total_w) / 2
        elseif align == "right" then
            x = bx + bw - total_w - gap_x
        else
            x = bx + gap_x
        end
        y = by - (self.h_plate * scale) - gap_y
    else
        x = bx - total_w - gap_x
        y = by - (self.h_plate * scale) - gap_y
    end

    if type(cfg) == "table" then
        if cfg.x ~= nil then x = cfg.x end
        if cfg.y ~= nil then y = cfg.y end
    end

    local center_x = x + total_w / 2
    local idp = tostring(box_id) .. "_np"

    local frame_tint = nil
    if type(cfg) == "table" and type(cfg.frame) == "table" then
        local f = cfg.frame
        frame_tint = {
            r = tonumber(f.r) or 255,
            g = tonumber(f.g) or 255,
            b = tonumber(f.b) or 255,
            a = tonumber(f.a) or 255,
            color_mode = tonumber(f.color_mode) or 2,
        }
    end

    local assets = self.player_assets[player_id]

    -- Nameplate data
    local np = {
        box_id = box_id,
        idp = idp,
        text = text,
        font = font_name,
        text_scale = text_scale,
        pad_px = pad_px,

        scale = scale,

        base_x = x, base_y = y,
        y = y,
        z = z,

        frame = frame_tint,

        bob_amp = (type(cfg) == "table" and cfg.bob_amp) or (3 * scale),
        bob_speed = (type(cfg) == "table" and cfg.bob_speed) or 1.0,
        bob_offset = 0,

        mids_target = mids_target,
        mid_w = mid_w,
        total_w_full = total_w,
        center_x = center_x,

        mids_drawn = 0,
        complete = false,

        text_glyph_ids = nil,
        closing = false,

        unfold_anim_id = nil,
        bob_anim_id = nil,
        close_anim_id = nil,

        erasing = false,  -- re‑entrancy guard
    }

    -- Store in registry
    self.nameplate_registry[player_id][box_id] = np
    print("Registered nameplate for box", box_id, "at player", player_id)

    -- Prevent text box from auto-removing while nameplate is attached
    if self.text_api and self.text_api.setKeepAlive then
        self.text_api.setKeepAlive(player_id, box_id, true)
        print("  -> Set keep_alive true")
    end

    -- Also store in box_data for backward compatibility
    box_data.nameplate = np
    box_data._box_id = box_id

    -- Unfold animation
    np.unfold_anim_id = AnimationEngine.animate(
        { progress = 0 },
        { progress = 1 },
        (type(cfg) == "table" and cfg.dur) or 0.14,
        {
            easing = "ease_out",
            on_update = function(values)
                np.mids_drawn = math.max(1, math.floor(np.mids_target * values.progress + 0.5))
                if values.progress >= 1 then
                    np.complete = true
                end
                self:_redraw(player_id, np, assets)
            end,
        }
    )

    -- Bob animation
    np.bob_anim_id = AnimationEngine.animate(
        { offset = 0 },
        { offset = np.bob_amp },
        np.bob_speed * 2,
        {
            easing = "sine_in_out",
            loop = true,
            ping_pong = true,
            on_update = function(values)
                np.bob_offset = values.offset
                np.y = np.base_y + np.bob_offset
                self:_redraw(player_id, np, assets)
            end,
        }
    )
end

-- Erase a nameplate
function Nameplate:erase(player_id, player_data, box_data)
    print("Nameplate.erase called for player", player_id)

    -- Try to get np from registry using box_data._box_id
    local np = nil
    if box_data and box_data._box_id then
        local box_id = box_data._box_id
        print("  -> Looking up registry for box_id:", box_id)
        if self.nameplate_registry[player_id] then
            np = self.nameplate_registry[player_id][box_id]
            if np then
                print("  -> Found in registry")
            else
                print("  -> Not found in registry")
            end
        else
            print("  -> No registry for player")
        end
    end

    -- Fallback to box_data.nameplate
    if not np and box_data and box_data.nameplate then
        print("  -> Falling back to box_data.nameplate")
        np = box_data.nameplate
    end

    if not np then
        print("  -> No nameplate data to erase")
        return
    end

    -- Re‑entrancy guard
    if np.erasing then
        print("  -> Already erasing, returning")
        return
    end
    np.erasing = true

    -- Allow text box to auto-remove now
    if self.text_api and self.text_api.setKeepAlive then
        self.text_api.setKeepAlive(player_id, np.box_id, false)
        print("  -> Set keep_alive false")
    end

    local assets = self.player_assets[player_id]
    if not assets then
        print("  -> No assets found for player")
        return
    end

    -- Stop animations
    if np.unfold_anim_id then
        print("  -> Stopping unfold animation")
        AnimationEngine.stop_animation(np.unfold_anim_id)
    end
    if np.bob_anim_id then
        print("  -> Stopping bob animation")
        AnimationEngine.stop_animation(np.bob_anim_id)
    end
    if np.close_anim_id then
        print("  -> Stopping close animation")
        AnimationEngine.stop_animation(np.close_anim_id)
    end

    -- Erase sprites
    print("  -> Erasing sprites with prefix:", np.idp)
    Net.player_erase_sprite(player_id, np.idp .. "_L")
    Net.player_erase_sprite(player_id, np.idp .. "_R")
    for i = 0, self.MAX_MIDS - 1 do
        Net.player_erase_sprite(player_id, np.idp .. "_M" .. i)
    end

    Net.player_erase_sprite(player_id, np.idp .. "_FL")
    Net.player_erase_sprite(player_id, np.idp .. "_FR")
    for i = 0, self.MAX_MIDS - 1 do
        Net.player_erase_sprite(player_id, np.idp .. "_FM" .. i)
    end

    if np.text_glyph_ids then
        print("  -> Erasing text glyphs, count:", #np.text_glyph_ids)
        for _, id in ipairs(np.text_glyph_ids) do
            self.font_system:eraseGlyph(player_id, id)
        end
    end

    -- Remove from registry
    if np.box_id and self.nameplate_registry[player_id] then
        print("  -> Removing from registry, box_id:", np.box_id)
        self.nameplate_registry[player_id][np.box_id] = nil
    end

    if box_data then
        box_data.nameplate = nil
        box_data._box_id = nil
    end
    print("Nameplate.erase complete")
end

-- Begin the closing animation
function Nameplate:begin_close(player_id, player_data, box_data, cfg)
    print("Nameplate.begin_close called for player", player_id)

    -- Try to get np from registry using box_data._box_id
    local np = nil
    if box_data and box_data._box_id then
        local box_id = box_data._box_id
        print("  -> Looking up registry for box_id:", box_id)
        if self.nameplate_registry[player_id] then
            np = self.nameplate_registry[player_id][box_id]
            if np then
                print("  -> Found in registry")
            else
                print("  -> Not found in registry")
            end
        else
            print("  -> No registry for player")
        end
    end

    -- Fallback to box_data.nameplate
    if not np and box_data and box_data.nameplate then
        print("  -> Falling back to box_data.nameplate")
        np = box_data.nameplate
    end

    if not np then
        print("  -> No nameplate data to close")
        return
    end

    if np.closing then
        print("  -> Already closing")
        return
    end

    np.closing = true
    local close_dur = (cfg and cfg.close_dur) or np.close_dur or (cfg and cfg.dur) or np.dur or 0.12
    print("  -> close_dur =", close_dur)

    -- Stop unfold and bob animations
    if np.unfold_anim_id then
        AnimationEngine.stop_animation(np.unfold_anim_id)
        np.unfold_anim_id = nil
    end
    if np.bob_anim_id then
        AnimationEngine.stop_animation(np.bob_anim_id)
        np.bob_anim_id = nil
    end

    -- Start closing animation
    np.close_anim_id = AnimationEngine.animate(
        { progress = 1 },
        { progress = 0 },
        close_dur,
        {
            easing = "ease_in",
            on_update = function(values)
                np.mids_drawn = math.max(0, math.floor(np.mids_target * values.progress + 0.5))
                self:_redraw(player_id, np, self.player_assets[player_id])
            end,
            on_complete = function()
                print("Nameplate close animation on_complete fired")
                self:erase(player_id, player_data, box_data)
            end,
        }
    )

    if np.text_glyph_ids then
        print("  -> Erasing text glyphs immediately")
        for _, id in ipairs(np.text_glyph_ids) do
            self.font_system:eraseGlyph(player_id, id)
        end
        np.text_glyph_ids = nil
    end
end

function Nameplate:update(player_id, player_data, box_data, dt)
    -- Nothing to do
end

return Nameplate