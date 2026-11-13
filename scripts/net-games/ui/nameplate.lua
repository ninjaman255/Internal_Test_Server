--[[
net-games/ui/nameplate.lua – BN‑style nameplate with 3‑slice sprite and text.
Uses AnimationEngine for unfolding and bob animations.
Now uses a registry to persist nameplate data across getTextBoxData calls.
]]

local Log = require("scripts/net-games/logging").get("NAMEPLATE")
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
            Log:debug("Error in nameplate player_disconnect:", err)
        end
    end)

    return o
end

-- Inject the Text API (called from displayer:init() after Text is ready)
function Nameplate:setTextAPI(api)
    self.text_api = api
end

-- Nameplate textures are cached PER PLAYER AND PER SKIN. Different bots can
-- display different plate art at the same time without reusing sprite assets
-- from a prior definition. Defaults retain the original 5/3/5 slicing.
local function plate_textures(self, textures)
    textures = type(textures) == "table" and textures or {}
    return {
        left = textures.left or self.tex_left,
        middle = textures.middle or self.tex_mid,
        right = textures.right or self.tex_right,
        frame_left = textures.frame_left or self.tex_left_frame,
        frame_middle = textures.frame_middle or self.tex_mid_frame,
        frame_right = textures.frame_right or self.tex_right_frame,
    }
end

function Nameplate:ensureAssets(player_id, textures, required_mids)
    local paths = plate_textures(self, textures)
    local key = table.concat({paths.left, paths.middle, paths.right,
        paths.frame_left, paths.frame_middle, paths.frame_right}, "|")
    local cache = self.player_assets[player_id]
    if not cache then cache = {}; self.player_assets[player_id] = cache end
    local assets = cache[key]
    if not assets then
        self.player_asset_serial = (self.player_asset_serial or 0) + 1
        local prefix = "np_asset_" .. tostring(self.player_asset_serial) .. "_" .. tostring(player_id)
        assets = {paths = paths, prefix = prefix, base_mid = {}, frame_mid = {}, mid_count = 0}
        for _, path in pairs(paths) do Net.provide_asset_for_player(player_id, path) end
        assets.base_left  = prefix .. "_base_left"
        assets.base_right = prefix .. "_base_right"
        Net.player_alloc_sprite(player_id, assets.base_left, {texture_path = paths.left})
        Net.player_alloc_sprite(player_id, assets.base_right, {texture_path = paths.right})
        assets.frame_left  = prefix .. "_frame_left"
        assets.frame_right = prefix .. "_frame_right"
        Net.player_alloc_sprite(player_id, assets.frame_left, {texture_path = paths.frame_left})
        Net.player_alloc_sprite(player_id, assets.frame_right, {texture_path = paths.frame_right})
        cache[key] = assets
        Log:debug_data("Nameplate texture set allocated", {
            player_id = player_id, texture_key = key,
        })
    end
    -- Allocate only the pieces used by this nameplate, not 120 middle sprites
    -- per skin at player join. Larger names can extend this cached set later.
    local target = math.min(self.MAX_MIDS,
        math.max(0, math.floor(tonumber(required_mids) or 0)))
    for i = assets.mid_count, target - 1 do
        local base = assets.prefix .. "_base_mid_" .. tostring(i)
        local frame = assets.prefix .. "_frame_mid_" .. tostring(i)
        Net.player_alloc_sprite(player_id, base, {texture_path = paths.middle})
        Net.player_alloc_sprite(player_id, frame, {texture_path = paths.frame_middle})
        assets.base_mid[i] = base
        assets.frame_mid[i] = frame
    end
    assets.mid_count = math.max(assets.mid_count, target)
    return assets
end

function Nameplate:cleanupPlayer(player_id)
    local cache = self.player_assets[player_id]
    if not cache then return end
    for _, assets in pairs(cache) do
        Net.player_dealloc_sprite(player_id, assets.base_left)
        Net.player_dealloc_sprite(player_id, assets.base_right)
        for _, sid in pairs(assets.base_mid) do Net.player_dealloc_sprite(player_id, sid) end
        Net.player_dealloc_sprite(player_id, assets.frame_left)
        Net.player_dealloc_sprite(player_id, assets.frame_right)
        for _, sid in pairs(assets.frame_mid) do Net.player_dealloc_sprite(player_id, sid) end
    end
    self.player_assets[player_id] = nil
    self.nameplate_registry[player_id] = nil
    Log:info_data("Nameplate assets released", {player_id = player_id})
end

-- Redraw the nameplate based on current np.mids_drawn, np.y, etc.
function Nameplate:_redraw(player_id, np, assets)
    local scale = np.scale
    local z = np.z
    local y = np.y   -- already includes bob offset
    local mids = np.mids_drawn or 0

    local total_w = (np.w_left + np.w_right) * scale + (mids * np.mid_w)
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
    local right_x = left_x + np.w_left * scale + mids * np.mid_w
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
        local mx = left_x + np.w_left * scale + i * np.mid_w
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
            local mx = left_x + np.w_left * scale + i * np.mid_w
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

    -- Draw name text when fully unfolded and not closing.
    --
    -- Coordinates throughout this block are computed in *screen* pixels (the
    -- same space as the plate frame above). FontSystem:drawGlyph expects
    -- *virtual* 240x160 coordinates and doubles them internally, so we convert
    -- the origin once and let getVirtualAdvance advance in virtual units.
    if np.complete and not np.closing and np.text then
        local text_x_px = math.floor((left_x + np.w_left * scale + np.pad_px) + 0.5)
        local text_y_px = math.floor((y + (3 * scale) + 2) + 0.5)
        local text_x_v  = text_x_px / 2
        local text_y_v  = text_y_px / 2

        -- A bob animation can redraw every tick. Keep deterministic glyph IDs
        -- instead of erasing and allocating new client-side draw instances
        -- for every letter on every frame. FontSystem remains authoritative
        -- for glyph states, origins and scales.
        local glyph_ids = {}
        local cx = text_x_v
        for i = 1, #np.text do
            local ch = np.text:sub(i, i)
            if ch ~= " " then
                local glyph_id = np.idp .. "_text_" .. tostring(i)
                local drawn_id = self.font_system:drawGlyph(player_id, np.font, ch, cx, text_y_v, {
                    instance_id = glyph_id,
                    scale = np.text_scale,
                    z = z + 2,
                    r = 255, g = 255, b = 255,
                    opacity = 255, a = 255,
                })
                if drawn_id then glyph_ids[#glyph_ids + 1] = drawn_id end
            end
            cx = cx + self.font_system:getVirtualAdvance(np.font, ch, np.text_scale)
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
            -- A new name may be shorter than the previous one. Retire its
            -- stable glyph IDs before replacing this box's nameplate.
            if old_np.text_glyph_ids then
                for _, glyph_id in ipairs(old_np.text_glyph_ids) do
                    self.font_system:eraseGlyph(player_id, glyph_id)
                end
                old_np.text_glyph_ids = nil
            end
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

    local font_name  = (type(cfg) == "table" and cfg.font) or "TINY_BLACK"
    local text_scale = (type(cfg) == "table" and cfg.text_scale) or scale
    local pad_px     = (type(cfg) == "table" and cfg.pad_px) or (4 * scale)

    -- Compute text width
    local text_w = 0
    for i = 1, #text do
        local ch = text:sub(i,i)
        local w, _ = self.font_system:getGlyphDimensions(font_name, ch)
        text_w = text_w + w * text_scale
        if i < #text then
            local spacing = self.font_system:isBattleFont(font_name) and 0 or 1
            text_w = text_w + spacing * text_scale
        end
    end

    local inner_needed = math.max(1, math.floor(text_w + pad_px * 2))
    local w_left = (type(cfg) == "table" and tonumber(cfg.left_width)) or self.w_left
    local w_mid = (type(cfg) == "table" and tonumber(cfg.middle_width)) or self.w_mid
    local w_right = (type(cfg) == "table" and tonumber(cfg.right_width)) or self.w_right
    local h_plate = (type(cfg) == "table" and tonumber(cfg.height)) or self.h_plate
    local mid_w = w_mid * scale
    local mids_target = math.min(self.MAX_MIDS, math.max(1, ceil_div(inner_needed, mid_w)))
    local total_w = (w_left + w_right) * scale + (mids_target * mid_w)
    local assets = self:ensureAssets(player_id,
        type(cfg) == "table" and cfg.textures or nil, mids_target)

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
        y = by - (h_plate * scale) - gap_y
    else
        x = bx - total_w - gap_x
        y = by - (h_plate * scale) - gap_y
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

    -- Nameplate data
    local np = {
        box_id = box_id,
        idp = idp,
        assets = assets,
        w_left = w_left,
        w_right = w_right,
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
        callbacks = type(cfg) == "table" and cfg or nil,
        closing = false,

        unfold_anim_id = nil,
        bob_anim_id = nil,
        close_anim_id = nil,

        erasing = false,  -- re‑entrancy guard
    }

    -- Store in registry
    self.nameplate_registry[player_id][box_id] = np
    Log:info_data("Nameplate attached", {player_id = player_id, box_id = box_id, name = text})

    -- Prevent text box from auto-removing while nameplate is attached
    if self.text_api and self.text_api.setKeepAlive then
        self.text_api.setKeepAlive(player_id, box_id, true)
        Log:debug("  -> Set keep_alive true")
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
            on_complete = function(_, interrupted)
                -- The text should appear on the completed plate even if a
                -- frame callback was skipped at the end of the unfold.
                if interrupted or np.closing or np.erasing then return end
                np.mids_drawn = np.mids_target
                np.complete = true
                self:_redraw(player_id, np, assets)
                if type(cfg) == "table" and type(cfg.on_open) == "function" and not np._opened_cb then
                    np._opened_cb = true
                    local ok, err = pcall(cfg.on_open, player_id, box_id, np.text)
                    if not ok then Log:error_data("Nameplate on_open failed", {
                        player_id = player_id, box_id = box_id, error = tostring(err),
                    }) end
                end
                if np.text:match("%S") and (not np.text_glyph_ids or #np.text_glyph_ids == 0) then
                    Log:debug("[Nameplate] No glyphs drawn for " .. tostring(np.text)
                        .. " using " .. tostring(np.font))
                end
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
    Log:debug("Nameplate.erase called for player", player_id)

    -- Try to get np from registry using box_data._box_id
    local np = nil
    if box_data and box_data._box_id then
        local box_id = box_data._box_id
        Log:debug("  -> Looking up registry for box_id:", box_id)
        if self.nameplate_registry[player_id] then
            np = self.nameplate_registry[player_id][box_id]
            if np then
                Log:debug("  -> Found in registry")
            else
                Log:debug("  -> Not found in registry")
            end
        else
            Log:debug("  -> No registry for player")
        end
    end

    -- Fallback to box_data.nameplate
    if not np and box_data and box_data.nameplate then
        Log:debug("  -> Falling back to box_data.nameplate")
        np = box_data.nameplate
    end

    if not np then
        Log:debug("  -> No nameplate data to erase")
        return
    end

    -- Re‑entrancy guard
    if np.erasing then
        Log:debug("  -> Already erasing, returning")
        return
    end
    np.erasing = true

    -- Allow text box to auto-remove now
    if self.text_api and self.text_api.setKeepAlive then
        self.text_api.setKeepAlive(player_id, np.box_id, false)
        Log:debug("  -> Set keep_alive false")
    end

    local assets = np.assets
    if not assets then
        Log:debug("  -> No assets found for player")
        return
    end

    -- Stop animations
    if np.unfold_anim_id then
        Log:debug("  -> Stopping unfold animation")
        AnimationEngine.stop_animation(np.unfold_anim_id)
    end
    if np.bob_anim_id then
        Log:debug("  -> Stopping bob animation")
        AnimationEngine.stop_animation(np.bob_anim_id)
    end
    if np.close_anim_id then
        Log:debug("  -> Stopping close animation")
        AnimationEngine.stop_animation(np.close_anim_id)
    end

    -- Erase sprites
    Log:debug("  -> Erasing sprites with prefix:", np.idp)
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
        Log:debug("  -> Erasing text glyphs, count:", #np.text_glyph_ids)
        for _, id in ipairs(np.text_glyph_ids) do
            self.font_system:eraseGlyph(player_id, id)
        end
    end

    -- Remove from registry
    if np.box_id and self.nameplate_registry[player_id] then
        Log:debug("  -> Removing from registry, box_id:", np.box_id)
        self.nameplate_registry[player_id][np.box_id] = nil
    end

    if box_data then
        box_data.nameplate = nil
        box_data._box_id = nil
    end
    Log:info_data("Nameplate erased", {player_id = player_id, box_id = np.box_id})
    if not np._closed_cb and np.callbacks and type(np.callbacks.on_close) == "function" then
        np._closed_cb = true
        local ok, err = pcall(np.callbacks.on_close, player_id, np.box_id, np.text)
        if not ok then Log:error_data("Nameplate on_close failed", {
            player_id = player_id, box_id = np.box_id, error = tostring(err),
        }) end
    end
end

-- Begin the closing animation
function Nameplate:begin_close(player_id, player_data, box_data, cfg)
    Log:info_data("Nameplate closing", {player_id = player_id, box_id = box_data and box_data._box_id})

    -- Try to get np from registry using box_data._box_id
    local np = nil
    if box_data and box_data._box_id then
        local box_id = box_data._box_id
        Log:debug("  -> Looking up registry for box_id:", box_id)
        if self.nameplate_registry[player_id] then
            np = self.nameplate_registry[player_id][box_id]
            if np then
                Log:debug("  -> Found in registry")
            else
                Log:debug("  -> Not found in registry")
            end
        else
            Log:debug("  -> No registry for player")
        end
    end

    -- Fallback to box_data.nameplate
    if not np and box_data and box_data.nameplate then
        Log:debug("  -> Falling back to box_data.nameplate")
        np = box_data.nameplate
    end

    if not np then
        Log:debug("  -> No nameplate data to close")
        return
    end

    if np.closing then
        Log:debug("  -> Already closing")
        return
    end

    np.closing = true
    local close_dur = (cfg and cfg.close_dur) or np.close_dur or (cfg and cfg.dur) or np.dur or 0.12
    Log:debug("  -> close_dur =", close_dur)

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
                self:_redraw(player_id, np, np.assets)
            end,
            on_complete = function(_, interrupted)
                -- stop_animation() invokes on_complete with interrupted=true.
                -- In particular, erase() stops np.close_anim_id; without this
                -- guard a completed close recursively calls erase() again.
                if interrupted or np.erasing then return end
                local registry = self.nameplate_registry[player_id]
                if not registry or registry[np.box_id] ~= np then return end
                -- The timer is completing now. Do not stop it again from erase().
                np.close_anim_id = nil
                self:erase(player_id, player_data, box_data)
            end,
        }
    )

    if np.text_glyph_ids then
        Log:debug("  -> Erasing text glyphs immediately")
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