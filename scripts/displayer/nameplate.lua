--[[
nameplate.lua – BN‑style nameplate with 3‑slice sprite and text.
Uses the font system for the name text and manages its own sprite assets.
All sprite instances are tracked for reliable updates and cleanup.
]]

local Nameplate = {}
Nameplate.__index = Nameplate

local ceil_div = function(a, b) return math.floor((a + b - 1) / b) end

---@class Nameplate
---@param font_system FontSystem
function Nameplate:new(font_system)
    local o = setmetatable({}, self)
    o.font_system = font_system

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

    -- Clean up when a player disconnects
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

-- Ensure all required sprite assets are allocated for a player.
---@param player_id string
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
---@param player_id string
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
end

-- Attach a nameplate to a text box.
---@param player_id string
---@param player_data table   # (unused, kept for compatibility)
---@param box_id string
---@param box_data table      # text box data containing position, scale, etc.
---@param cfg string|table    # configuration: either a string (the name) or a table with options
function Nameplate:attach(player_id, player_data, box_id, box_data, cfg)
    if not cfg then
        return
    end

    local text = type(cfg) == "string" and cfg or cfg.text
    if not text or text == "" then
        return
    end

    self:ensureAssets(player_id)

    if box_data.nameplate then
        self:erase(player_id, player_data, box_data)
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

    box_data.nameplate = {
        idp = idp,
        text = text,
        font = font_name,
        text_scale = text_scale,
        pad_px = pad_px,

        x = x,
        y = y,
        base_y = y,
        z = z,

        frame = frame_tint,

        bob_t = 0,
        bob_amp = (type(cfg) == "table" and cfg.bob_amp) or (3 * scale),
        bob_speed = (type(cfg) == "table" and cfg.bob_speed) or 1.0,

        mids_target = mids_target,
        mid_w = mid_w,
        total_w_full = total_w,
        center_x = center_x,

        t = 0,
        dur = (type(cfg) == "table" and cfg.dur) or 0.14,
        close_dur = (type(cfg) == "table" and cfg.close_dur) or nil,
        mids_drawn = 0,
        complete = false,

        text_display_id = "nameplate:" .. tostring(box_id),

        closing = false,
        close_t = 0,
    }
end

-- Erase a nameplate (remove all its sprite instances).
---@param player_id string
---@param player_data table
---@param box_data table
function Nameplate:erase(player_id, player_data, box_data)
    -- Guard against nil box_data or missing nameplate
    if not box_data or not box_data.nameplate then
        return
    end

    local np = box_data.nameplate
    local assets = self.player_assets[player_id]
    if not assets then
        return
    end

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
        for _, id in ipairs(np.text_glyph_ids) do
            self.font_system:eraseGlyph(player_id, id)
        end
    end

    box_data.nameplate = nil
end

-- Begin the closing animation (reverse unfold).
---@param player_id string
---@param player_data table
---@param box_data table
---@param cfg? table   # optional overrides
function Nameplate:begin_close(player_id, player_data, box_data, cfg)
    -- Guard against nil box_data or missing nameplate
    if not box_data or not box_data.nameplate then
        return
    end

    local np = box_data.nameplate
    if np.closing then return end

    np.closing = true
    np.close_t = 0

    local cd = (cfg and cfg.close_dur) or np.close_dur or (cfg and cfg.dur) or np.dur or 0.12
    np.close_dur = cd

    if np.text_glyph_ids then
        for _, id in ipairs(np.text_glyph_ids) do
            self.font_system:eraseGlyph(player_id, id)
        end
        np.text_glyph_ids = nil
    end
end

-- Update nameplate animation (called every tick).
---@param player_id string
---@param player_data table
---@param box_data table
---@param dt number
function Nameplate:update(player_id, player_data, box_data, dt)
    -- Guard against nil box_data or missing nameplate
    if not box_data or not box_data.nameplate then
        return
    end

    local np = box_data.nameplate
    dt = math.min(dt or 0, 1/30)

    local assets = self.player_assets[player_id]
    if not assets then
        return
    end

    local scale = box_data.scale or 2.0
    local z = np.z

    if np.closing then
        np.close_t = np.close_t + dt
        local p = np.close_t / np.close_dur
        if p >= 1 then
            self:erase(player_id, player_data, box_data)
            return
        end
        local remain = 1 - p
        np.mids_drawn = math.max(0, math.floor(np.mids_target * remain + 0.0001))
    else
        if not np.complete then
            np.t = np.t + dt
            local p = np.t / np.dur
            if p >= 1 then p = 1; np.complete = true end
            np.mids_drawn = math.max(1, math.floor(np.mids_target * p + 0.0001))
        end
    end

    local mids = np.mids_drawn
    local total_w = (self.w_left + self.w_right) * scale + (mids * np.mid_w)
    local left_x = math.floor((np.center_x - total_w / 2) + 0.5)

    np.bob_t = (np.bob_t or 0) + dt * (np.bob_speed or 1.0)
    local bob = math.floor((math.sin(np.bob_t) * (np.bob_amp or 0)) + 0.5)
    local y = math.floor(((np.base_y or np.y) + bob) + 0.5)

    -- Draw left slice (base)
    Net.player_draw_sprite(player_id, assets.base_left, {
        id = np.idp .. "_L",
        x = left_x, y = y, z = z,
        sx = scale, sy = scale,
        r = 255, g = 255, b = 255,
        opacity = 255, a = 255,
        color_mode = 0,
    })

    -- Draw right slice (base)
    local right_x = left_x + self.w_left * scale + mids * np.mid_w
    Net.player_draw_sprite(player_id, assets.base_right, {
        id = np.idp .. "_R",
        x = right_x, y = y, z = z,
        sx = scale, sy = scale,
        r = 255, g = 255, b = 255,
        opacity = 255, a = 255,
        color_mode = 0,
    })

    -- Draw middle pieces (base)
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
    -- Erase unused middle pieces
    for i = mids, self.MAX_MIDS - 1 do
        Net.player_erase_sprite(player_id, np.idp .. "_M" .. i)
    end

    -- Draw frame overlay if tinted
    if np.frame and np.frame.a > 0 then
        local fz = z + 1
        local fr, fg, fb, fa, fmode = np.frame.r, np.frame.g, np.frame.b, np.frame.a, np.frame.color_mode

        Net.player_draw_sprite(player_id, assets.frame_left, {
            id = np.idp .. "_FL",
            x = left_x, y = y, z = fz,
            sx = scale, sy = scale,
            r = fr, g = fg, b = fb,
            opacity = 255, a = fa,   -- overall opacity 255, alpha for tint is fa
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
    if np.complete and not np.closing then
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

return Nameplate