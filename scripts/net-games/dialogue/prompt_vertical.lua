local PlayerControl = require("scripts/player-control/main")
-- scripts/net-games/dialogue/prompt_vertical.lua
-- Vertical menu prompt helper for net-games Dialogue (adapted to new displayer)
-- NOTE: This version preserves the original logic but marks areas where the new
-- displayer no longer exposes internal fields (pages, current_page, backdrop indicator).
-- These parts will need to be reimplemented using the available APIs.

local Nameplate = require("scripts/net-games/ui/nameplate-service")
local Displayer  = require("scripts/displayer/displayer")
local TextDisplay = require("scripts/displayer/text-display")
local Visuals = require("scripts/net-games/ui/textbox-surface")
local DebugLog = require("scripts/net-games/logging").get("VERTICAL-MENU")


local MENUDBG = true
local function mdbg(pid, msg)
    if not MENUDBG then return end
    DebugLog:debug_data("Menu animation", {player_id = pid, detail = tostring(msg)})
end

local PromptVertical = {}
PromptVertical.instances = {}
PromptVertical._tick_attached = false

-- Asset paths
local DEFAULT_ASSET = {
    menu_bg       = "/server/assets/net-games/ui/prompt_vert_menu_an.png",
    menu_bg_anim  = "/server/assets/net-games/ui/prompt_vert_menu_an.animation",
    menu_bg_frame = "/server/assets/net-games/ui/prompt_vert_menu_an_frame.png",
    highlight     = "/server/assets/net-games/ui/highlight_default.png",
    cursor        = "/server/assets/net-games/cursors/green_cursor.png",
    scrollbar     = "/server/assets/net-games/ui/scrollbar.png",
    shop_item     = "/server/assets/net-games/ui/card_shop_item.png",
    shop_exit     = "/server/assets/net-games/ui/card_shop_exit.png",
}

local function merge_assets(overrides)
    local out = {}
    for k, v in pairs(DEFAULT_ASSET) do out[k] = v end
    if overrides then
        for k, v in pairs(overrides) do out[k] = v end
    end
    return out
end

local MENU_W = 238
local MENU_H = 95

local CURSOR_MOVE_SFX_PATH = "/server/assets/net-games/sfx/cursor_move.ogg"
local function play_cursor_move_sfx(player_id)
    Net.provide_asset_for_player(player_id, CURSOR_MOVE_SFX_PATH)
    if Net.play_sound_for_player then
        pcall(function() Net.play_sound_for_player(player_id, CURSOR_MOVE_SFX_PATH) end)
    elseif Net.play_sound then
        pcall(function() Net.play_sound(player_id, CURSOR_MOVE_SFX_PATH) end)
    end
end

-- Panel frames and mugshots use native server rendering with existing assets.
local function draw_backdrop(player_id, ui)
    return Visuals.draw(player_id, "pvert_backdrop_" .. tostring(player_id), ui)
end

local function erase_backdrop(player_id)
    Visuals.erase(player_id, "pvert_backdrop_" .. tostring(player_id))
end

-- Text drawing helpers using Displayer.Font
local function get_text_width(text, font, scale)
    local w = 0
    for i = 1, #text do
        local ch = text:sub(i, i)
        local gw, _ = Displayer.Font.getGlyphDimensions(font, ch)
        w = w + gw * scale
        if i < #text then
            w = w + 1 * scale
        end
    end
    return w
end

local function draw_text(inst, text, x, y, font, scale, z, id, tint)
    -- Stable glyph IDs keep scrolling and the per-frame text intro from
    -- allocating a new set of client sprites on every redraw. A reused ID
    -- updates the character in place; only characters absent from the new
    -- row are erased. FontSystem still owns all scaling and glyph animation.
    local vx, vy = x / 2, y / 2
    local opts = {
        scale = scale,
        z = z,
        r = tint and tint.r or 255,
        g = tint and tint.g or 255,
        b = tint and tint.b or 255,
        opacity = tint and tint.opacity or 255,
        a = tint and tint.a or 255,
        ro = 0,
        color_mode = 0,
    }
    local previous = (inst.text_glyphs and inst.text_glyphs[id]) or {}
    local old_ids = {}
    for _, glyph_id in ipairs(previous) do old_ids[glyph_id] = true end
    local next_ids = {}
    local cx = vx
    for i = 1, #text do
        local ch = text:sub(i, i)
        local glyph_id = tostring(id) .. "_glyph_" .. tostring(i)
        if ch ~= " " then
            opts.instance_id = glyph_id
            local drawn = Displayer.Font.drawGlyph(inst.player_id, font, ch, cx, vy, opts)
            if drawn then
                next_ids[#next_ids + 1] = glyph_id
                old_ids[glyph_id] = nil
            end
        end
        local gw, _ = Displayer.Font.getGlyphDimensions(font, ch)
        cx = cx + ((gw + 1) * scale) / 2
    end
    -- Remove glyphs that were in an earlier (possibly longer) row. This also
    -- handles new whitespace at locations where a glyph used to be drawn.
    for glyph_id in pairs(old_ids) do
        Displayer.Font.eraseGlyph(inst.player_id, glyph_id)
    end
    inst.text_glyphs = inst.text_glyphs or {}
    inst.text_glyphs[id] = #next_ids > 0 and next_ids or nil
end

local function erase_text(inst, id)
    if inst.text_glyphs and inst.text_glyphs[id] then
        for _, instance_id in ipairs(inst.text_glyphs[id]) do
            Displayer.Font.eraseGlyph(inst.player_id, instance_id)
        end
        inst.text_glyphs[id] = nil
    end
end

local function begin_session(player_id, opts)
    local parent = opts.parent_session
    return PlayerControl.begin(player_id, {
        profile = "menu", owner = "net-games:vertical-prompt", parent = parent,
        capture = parent == nil, handoff_free_camera = opts.handoff_free_camera == true,
    })
end

local function pressed(session, action, allow_repeat)
    if not session then return false end
    local ctrl, owner = session:input()
    if not ctrl then return false end
    if ctrl:is_action_pressed(action, owner) then return true end
    return allow_repeat and ctrl:is_action_repeated(action, owner) or false
end

local function guard(session, seconds)
    if session and session:is_current() then
        session:guard_input(seconds or 0, {"Up", "Down", "Left", "Right", "Confirm", "Cancel"})
    end
end

local function mk_id(player_id)
    return "ng_prompt_menu_" .. tostring(player_id)
end

local function clamp(v, a, b)
    if v < a then return a end
    if v > b then return b end
    return v
end

local function ensure_tick()
    if PromptVertical._tick_attached then return end
    PromptVertical._tick_attached = true
    Net:on("tick", function(event)
        for player_id, inst in pairs(PromptVertical.instances) do
            local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
            if not bd then
                PromptVertical._finalize_close(player_id, "textbox_missing")
            else
                inst:update(event and event.delta_time or 0)
            end
        end
    end)
end

local function provide_ui_assets(player_id, assets)
    Net.provide_asset_for_player(player_id, assets.menu_bg)
    Net.provide_asset_for_player(player_id, assets.menu_bg_frame)
    Net.provide_asset_for_player(player_id, assets.menu_bg_anim)
    Net.provide_asset_for_player(player_id, assets.highlight)
    Net.provide_asset_for_player(player_id, assets.cursor)
    Net.provide_asset_for_player(player_id, assets.scrollbar)
    Net.provide_asset_for_player(player_id, assets.shop_item)
    Net.provide_asset_for_player(player_id, assets.shop_exit)
end

local function alloc_ui_sprites(inst)
    if inst._sprites_allocated then return end
    inst._sprites_allocated = true
    local player_id = inst.player_id
    local A = inst.assets
    local S = inst.spr
    provide_ui_assets(player_id, A)
    Net.player_alloc_sprite(player_id, S.MENU_BG, {
        texture_path = A.menu_bg,
        anim_path    = A.menu_bg_anim,
        anim_state   = "OPEN_IDLE",
    })
    Net.player_alloc_sprite(player_id, S.MENU_FRAME, {
        texture_path = A.menu_bg_frame,
        anim_path    = A.menu_bg_anim,
        anim_state   = "OPEN_IDLE",
    })
    Net.player_alloc_sprite(player_id, S.HILITE, { texture_path = A.highlight })
    Net.player_alloc_sprite(player_id, S.CURSOR, { texture_path = A.cursor })
    Net.player_alloc_sprite(player_id, S.SCROLL, { texture_path = A.scrollbar })
    Net.player_alloc_sprite(player_id, S.SHOP_ITEM, { texture_path = A.shop_item })
    Net.player_alloc_sprite(player_id, S.SHOP_EXIT, { texture_path = A.shop_exit })
end

local function draw_sprite(inst, sprite_id, draw_id, x, y, z, s, anim_state)
    alloc_ui_sprites(inst)
    x = math.floor(x + 0.5)
    y = math.floor(y + 0.5)
    local opts = {
        id = draw_id,
        x = x, y = y, z = z,
        sx = s or 2.0,
        sy = s or 2.0,
    }
    if anim_state then
        opts.anim_state = anim_state
    end
    Net.player_draw_sprite(inst.player_id, sprite_id, opts)
end

local function draw_sprite_xy(inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state)
    alloc_ui_sprites(inst)
    x = math.floor(x + 0.5)
    y = math.floor(y + 0.5)
    local opts = {
        id = draw_id,
        x = x, y = y, z = z,
        sx = sx or 2.0,
        sy = sy or 2.0,
    }
    if anim_state then
        opts.anim_state = anim_state
    end
    Net.player_draw_sprite(inst.player_id, sprite_id, opts)
end

local function draw_menu_frame_overlay(inst, draw_id, x, y, z, s, anim_state, frame_cfg)
    if type(frame_cfg) ~= "table" then
        Net.player_erase_sprite(inst.player_id, draw_id)
        return
    end
    local a = tonumber(frame_cfg.a) or 255
    if a <= 0 then
        Net.player_erase_sprite(inst.player_id, draw_id)
        return
    end
    local opts = {
        id = draw_id,
        x = x, y = y, z = z,
        sx = s or 2.0,
        sy = s or 2.0,
        r = tonumber(frame_cfg.r) or 255,
        g = tonumber(frame_cfg.g) or 255,
        b = tonumber(frame_cfg.b) or 255,
        a = a,
        color_mode = tonumber(frame_cfg.color_mode) or 2,
    }
    if anim_state then
        opts.anim_state = anim_state
    end
    Net.player_draw_sprite(inst.player_id, inst.spr.MENU_FRAME, opts)
end

local function erase_sprite(player_id, draw_id)
    Net.player_erase_sprite(player_id, draw_id)
end

-- Layout normalization
local function normalize_ui(ui)
    local o = {
        box_id = ui.box_id,
        font  = (ui.font or "THIN_BLACK"),
        scale = ui.scale or 2.0,
        z     = ui.z or 100,
        x = ui.x or 8,
        y = ui.y or 110,
        w = ui.w or 224,
        h = ui.h or 42,
        backdrop  = ui.backdrop or ui.backdrop_config or nil,
        mugshot   = ui.mugshot or nil,
        nameplate = ui.nameplate,
        typing_speed    = ui.typing_speed or 12,
        type_sfx_path   = ui.type_sfx_path,
        type_sfx_min_dt = ui.type_sfx_min_dt,
    }
    if o.backdrop then
        local px = o.backdrop.padding_x or 0
        local py = o.backdrop.padding_y or 0
        if o.backdrop.x then o.x = o.backdrop.x + px end
        if o.backdrop.y then o.y = o.backdrop.y + py end
        if o.backdrop.width then o.w = o.backdrop.width - (px * 2) end
        if o.backdrop.height then o.h = o.backdrop.height - (py * 2) end
    end
    return o
end

local function normalize_layout(layout)
    layout = layout or {}
    local o = {
        anchor = layout.anchor or "textbox",
        x = layout.x,
        y = layout.y,
        offset_x = layout.offset_x or 0,
        offset_y = layout.offset_y or -200,
        gap      = layout.gap or 4,
        -- New layout behavior is explicitly opted into by a menu preset.
        -- Legacy layouts retain their original 2x pixel geometry.
        center_horizontal = layout.center_horizontal == true,
        align_above_textbox = layout.align_above_textbox == true,
        textbox_gap_px = tonumber(layout.textbox_gap_px) or 13,
        screen_width_px = tonumber(layout.screen_width_px) or 480,
        scale_screen_offsets = layout.scale_screen_offsets == true,
        align_row_elements = layout.align_row_elements == true,
        cursor_text_gap_px = tonumber(layout.cursor_text_gap_px) or 5,
        width  = layout.width  or 160,
        height = layout.height or 64,
        font  = (layout.font or "THIN_BLACK"),
        scale = layout.scale or 2.0,
        z     = layout.z or 130,
        frame = layout.frame,
        padding_x   = layout.padding_x or 12,
        padding_y   = layout.padding_y or 10,
        row_height  = layout.row_height or 12,
        visible_rows = tonumber(layout.visible_rows or 5) or 5,
        cursor_offset_x = layout.cursor_offset_x or 6,
        cursor_offset_y = layout.cursor_offset_y or 1,
        highlight_inset_x = layout.highlight_inset_x or 8,
        highlight_inset_y = layout.highlight_inset_y or 0,
        scrollbar_x = layout.scrollbar_x or 148,
        scrollbar_y = layout.scrollbar_y or 12,
        scrollbar_h = layout.scrollbar_h or 40,
        thumb_min_h = layout.thumb_min_h or 6,
        thumb_w     = layout.thumb_w or 6,
        text_intro_enabled        = (layout.text_intro_enabled == true),
        text_intro_frames         = tonumber(layout.text_intro_frames or 20) or 20,
        text_intro_stagger_frames = tonumber(layout.text_intro_stagger_frames or 3) or 3,
        text_intro_slide_px       = tonumber(layout.text_intro_slide_px or 10) or 10,
        monies_label_enabled = (layout.monies_label_enabled == true),
        monies_label_text    = layout.monies_label_text,
        monies_label_font    = (layout.monies_label_font),
        monies_label_pad_x   = layout.monies_label_pad_x,
        monies_label_pad_y   = layout.monies_label_pad_y,
        monies_label_z_add   = layout.monies_label_z_add,
        monies_amount_enabled  = (layout.monies_amount_enabled == true),
        monies_amount_text     = layout.monies_amount_text,
        monies_amount_font     = (layout.monies_amount_font),
        monies_amount_offset_x = layout.monies_amount_offset_x,
        monies_amount_offset_y = layout.monies_amount_offset_y,
        shop_item_enabled = (layout.shop_item_enabled == true),
        shop_item_pad_x   = layout.shop_item_pad_x,
        shop_item_pad_y   = layout.shop_item_pad_y,
        shop_item_z_add   = layout.shop_item_z_add,
        shop_item_swap_exit = (layout.shop_item_swap_exit == true),
        shop_item_intro_enabled = (layout.shop_item_intro_enabled == true),
        shop_item_intro_frames  = tonumber(layout.shop_item_intro_frames or 10) or 10,
        shop_item_w = tonumber(layout.shop_item_w or 0) or 0,
        shop_item_h = tonumber(layout.shop_item_h or 0) or 0,
        shop_exit_w = tonumber(layout.shop_exit_w or 0) or 0,
        shop_exit_h = tonumber(layout.shop_exit_h or 0) or 0,
        -- Optional two-column shop layout from the older server. Overflow is
        -- rendered by the current scale-aware, pixel-snapped Displayer marquee.
        shop_columns_enabled = layout.shop_columns_enabled == true,
        shop_price_col_x = tonumber(layout.shop_price_col_x) or 92,
        shop_price_width = tonumber(layout.shop_price_width) or 44,
        shop_name_speed = tonumber(layout.shop_name_speed) or 22,
        shop_price_speed = tonumber(layout.shop_price_speed) or 22,
        shop_compact_prices = layout.shop_compact_prices ~= false,
    }
    o.visible_rows = math.max(1, o.visible_rows)
    return o
end

local STATE = {
    TEXT      = "text",
    MENU      = "menu",
    SUBPROMPT = "subprompt",
    CLOSING   = "closing",
}

local PromptMenuInstance = {}
PromptMenuInstance.__index = PromptMenuInstance

function PromptMenuInstance:new(player_id, opts)
    local o = setmetatable({}, self)
    opts = opts or {}
    o.player_id = player_id
    o.box_id = (opts.ui and opts.ui.box_id) or mk_id(player_id)
    o.ui = normalize_ui(opts.ui or {})
    o.layout = normalize_layout(opts.layout or {})
    o.assets = merge_assets(opts.assets)
    local base = o.box_id
    o.spr = {
        MENU_BG    = "pv_" .. base .. "_spr_menu_bg",
        MENU_FRAME = "pv_" .. base .. "_spr_menu_frame",
        HILITE     = "pv_" .. base .. "_spr_hilite",
        CURSOR     = "pv_" .. base .. "_spr_cursor",
        SCROLL     = "pv_" .. base .. "_spr_scroll",
        SHOP_ITEM  = "pv_" .. base .. "_spr_shop_item",
        SHOP_EXIT  = "pv_" .. base .. "_spr_shop_exit",
    }
    o._sprites_allocated = false
    o.question = tostring(opts.question or "Choose:")
    o.options  = opts.options or { { text = "Exit" } }
    if #o.options == 0 then o.options[1] = {text = "Exit", id = "exit"} end
    for i = 1, #o.options do
        local v = o.options[i]
        if type(v) == "string" then
            o.options[i] = { text = v }
        else
            o.options[i].text = tostring(v.text or v[1] or ("Option " .. i))
        end
    end
    o.default_index = clamp(tonumber(opts.default_index or 1) or 1, 1, #o.options)
    o.selection_index = o.default_index
    o.scroll_top_index = 1
    o.cancel_behavior = opts.cancel_behavior or "jump_to_exit"
    o.exit_index = clamp(tonumber(opts.exit_index or #o.options) or #o.options, 1, #o.options)
    o.keep_textbox = (opts.keep_textbox ~= false)
    o.reuse_existing_box = (opts.reuse_existing_box == true)
    o.on_select = opts.on_select or function(_choice, _index) end
    o.on_cancel = opts.on_cancel or function() end
    o.keep_menu_open = (opts.keep_menu_open == true)
    o.selection_behavior = tostring(opts.selection_behavior or "close_then_callback")
    o.on_choose = opts.on_choose
    o.lock_dim_alpha = tonumber(opts.lock_dim_alpha or 0.35) or 0.35
    o.hide_cursor_when_locked = (opts.hide_cursor_when_locked ~= false)
    o.locked = false
    o.state = STATE.TEXT
    o.ready_for_input = false
    local base = o.box_id
    o.draw = {
        menu_bg   = base .. "_menu_bg",
        menu_frame= base .. "_menu_frame",
        hilite    = base .. "_menu_hilite",
        cursor    = base .. "_menu_cursor",
        scroll    = base .. "_menu_scroll",
        monies    = base .. "_menu_monies",
        monies_amount = base .. "_menu_monies_amount",
        shop_item = base .. "_menu_shop_item",
        shop_exit = base .. "_menu_shop_exit",
    }
    o.menu_text_ids = {}
    o.text_glyphs = {}  -- maps id -> list of glyph instance ids
    o.shop_marquees = {} -- only selected, overflowing name/price use Displayer.Text
    o.cursor_phase = 0
    o.cursor_base_x = nil
    o.cursor_base_y = nil
    o.menu_bg_needs_open = true
    o.menu_bg_set_idle_next = false
    o.wait_textbox_open_idle = true
    o.menu_contents_pending = true
    o._text_intro_active = false
    o._text_intro_t = 0
    o._text_intro_speed_mult = 1
    o._text_intro_boosted = false
    o._shop_item_intro_active = false
    o._shop_item_intro_t = 0
    o.menu_bg_open_t = 0
    o.menu_bg_open_total = 0.16
    o.menu_bg_open_playing = false
    o.menu_bg_close_t = 0
    o.menu_bg_close_total = 0.12
    o.menu_bg_close_playing = false
    o.pending_close = false
    o.pending_close_keep_textbox = false
    o.pending_close_reason = nil
    o.backdrop_id = nil

    DebugLog:info_data("Vertical menu rendering started", {
        player_id = player_id, box_id = o.box_id,
        font = o.ui.font, option_count = #o.options,
        default_index = o.default_index,
        reuse_existing_box = o.reuse_existing_box,
    })
    o:render_textbox()
    o.menu_contents_pending = true
    return o
end

function PromptMenuInstance:render_textbox()
    local ui = self.ui
    local text_options = {
        font = ui.font,
        scale = ui.scale,
        z = ui.z,
        speed = ui.typing_speed,
        type_sound = ui.type_sfx_path,
        type_sound_min_dt = ui.type_sfx_min_dt,
        max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
    }

    -- Draw backdrop if provided
    if ui.backdrop or ui.mugshot then
        self.backdrop_id = draw_backdrop(self.player_id, ui)
    end

    local x_v, y_v, w_v, h_v = Visuals.text_rect(ui)
    local existing = Displayer.Text.getTextBoxData(self.player_id, self.box_id)
    local can_reuse = self.reuse_existing_box and existing
        and existing.marked_for_removal ~= true
    DebugLog:info_data("Vertical menu textbox create or reuse", {
        player_id = self.player_id, box_id = self.box_id,
        existing = existing ~= nil, reused = not not can_reuse,
        x = x_v, y = y_v, width = w_v, height = h_v,
    })
    if can_reuse then
        -- Reset rather than destroying the textbox. The old server deliberately
        -- retained the same window/nameplate between Yes/No and menu screens.
        -- The modern TextDisplay owns pagination, scale and glyph cleanup.
        TextDisplay:resetTextBox(self.player_id, self.box_id, self.question, {
            x = x_v, y = y_v, width = w_v, height = h_v,
            font = ui.font, scale = ui.scale, z = ui.z,
            speed = ui.typing_speed,
            type_sound = ui.type_sfx_path,
            type_sound_min_dt = ui.type_sfx_min_dt,
            max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
        })
    else
        Displayer.Text.createTextBox(self.player_id, self.box_id, self.question,
                                     x_v, y_v, w_v, h_v, text_options)
    end

    -- Attach nameplate only if a new textbox was actually created.
    if not can_reuse and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(self.player_id, self.box_id)
        if bd then
            Nameplate.attach(self.player_id, nil, self.box_id,
                Visuals.nameplate_box_data(ui, bd), ui.nameplate)
        end
    end
end

function PromptMenuInstance:menu_origin()
    local L = self.layout
    local bd = Displayer.Text.getTextBoxData(self.player_id, self.box_id)
    if L.anchor == "absolute" or not bd then
        return (L.x or 24), (L.y or 32)
    end
    local tx = (self.ui.backdrop and self.ui.backdrop.x) or bd.x or self.ui.x or 0
    local ty = (self.ui.backdrop and self.ui.backdrop.y) or bd.y or self.ui.y or 0
    local mx = tx + (L.offset_x or 0)
    local my = ty + (L.offset_y or 0) - (L.gap or 0)
    -- Sprite animation frames have a bottom-right origin. Position their
    -- bottom-right at menu_origin + MENU_W/H * scale (see render_menu_window).
    -- Optional centered/above-textbox placement keeps the whole frame on-screen
    -- when using a smaller visual scale, without moving the textbox itself.
    if L.center_horizontal then
        mx = (L.screen_width_px - MENU_W * L.scale) / 2 + (L.offset_x or 0)
    end
    if L.align_above_textbox then
        my = ty - L.textbox_gap_px - MENU_H * L.scale
    end
    return mx, my
end

function PromptMenuInstance:start_close(reason, keep_textbox)
    if self.state == STATE.CLOSING or self.pending_close then return end
    self.pending_close = true
    self.pending_close_reason = reason
    DebugLog:info_data("Vertical menu closing animation started", {
        player_id = self.player_id, box_id = self.box_id,
        reason = reason, keep_textbox = keep_textbox == true,
    })
    self.pending_close_keep_textbox = (keep_textbox == true)
    self.state = STATE.CLOSING
    self.ready_for_input = false
    erase_sprite(self.player_id, self.draw.hilite)
    erase_sprite(self.player_id, self.draw.cursor)
    erase_sprite(self.player_id, self.draw.scroll)
    erase_sprite(self.player_id, self.draw.shop_item)
    erase_sprite(self.player_id, self.draw.shop_exit)
    erase_text(self, self.draw.monies)
    erase_text(self, self.draw.monies_amount)
    self:clear_menu_text()
    self.menu_bg_open_playing = false
    local L = self.layout
    local x, y = self:menu_origin()
    x = x + (MENU_W * L.scale)
    y = y + (MENU_H * L.scale)
    mdbg(self.player_id, "MENU_BG anim_state => CLOSE")
    draw_sprite(self, self.spr.MENU_BG, self.draw.menu_bg, x, y, L.z, L.scale, "CLOSE")
    draw_menu_frame_overlay(self, self.draw.menu_frame, x, y, L.z + 1, L.scale, "CLOSE", L.frame)
    self.menu_bg_close_t = 0
    self.menu_bg_close_playing = true
end

function PromptMenuInstance:render_menu_window()
    local L = self.layout
    local x, y = self:menu_origin()
    x = x + (MENU_W * L.scale)
    y = y + (MENU_H * L.scale)
    local anim = nil
    if self.menu_bg_needs_open then
        mdbg(self.player_id, "MENU_BG anim_state => OPEN")
        anim = "OPEN"
        self.menu_bg_needs_open = false
        self.menu_bg_open_t = 0
        self.menu_bg_open_playing = true
    end
    draw_sprite(self, self.spr.MENU_BG, self.draw.menu_bg, x, y, L.z, L.scale, anim)
    draw_menu_frame_overlay(self, self.draw.menu_frame, x, y, L.z + 1, L.scale, anim, L.frame)
end

function PromptMenuInstance:clear_shop_marquees()
    for id in pairs(self.shop_marquees) do
        Displayer.Text.removeMarquee(self.player_id, id)
        self.shop_marquees[id] = nil
    end
end

function PromptMenuInstance:clear_menu_text()
    self:clear_shop_marquees()
    for _, id in ipairs(self.menu_text_ids) do
        erase_text(self, id)
        erase_text(self, id .. "_name")
        erase_text(self, id .. "_price")
    end
    self.menu_text_ids = {}
end

function PromptMenuInstance:update_scroll_for_selection(force)
    local L = self.layout
    local total = #self.options
    local rows = L.visible_rows
    local sel = self.selection_index
    local top = self.scroll_top_index
    if sel < top then
        top = sel
    elseif sel > (top + rows - 1) then
        top = sel - (rows - 1)
    end
    local max_top = math.max(1, total - rows + 1)
    top = clamp(top, 1, max_top)
    local changed = (top ~= self.scroll_top_index)
    self.scroll_top_index = top
    return force or changed
end

local function set_textbox_indicator_enabled(player_id, box_id, enabled)
    -- TextDisplay exposes a read-only snapshot of backdrop configuration.
    -- Do not mutate this snapshot or replace the upgraded Displayer renderer.
    -- Menu cursor/highlight already convey the interactive state.
end

function PromptMenuInstance:menu_overlays_visible()
    return (self.state == STATE.MENU) and (self.ready_for_input == true) and (self.locked ~= true)
end

function PromptMenuInstance:set_locked(locked)
    DebugLog:debug_data("Vertical menu lock changed", {
        player_id = self.player_id, box_id = self.box_id, locked = locked == true,
    })
    self.locked = (locked == true)
    if self.locked then
        self.ready_for_input = false
        if self.hide_cursor_when_locked then
            erase_sprite(self.player_id, self.draw.cursor)
            self.cursor_base_x = nil
            self.cursor_base_y = nil
        end
    else
        self.ready_for_input = true
        set_textbox_indicator_enabled(self.player_id, self.box_id, false)
    end
    self:update_scroll_for_selection(true)
    self:render_menu_contents(true)
end

function PromptMenuInstance:update_cursor_bob(dt)
    if not self:menu_overlays_visible() then return end
    if not self.cursor_base_x or not self.cursor_base_y then return end
    dt = math.min(dt or 0, 1/30)
    local cycle_sec = 0.36
    local snap_left = 2.0
    local push_right = 3.0
    local push_portion = 0.70
    local scale = tonumber(self.layout.scale) or 2.0
    local snap_px = snap_left * scale
    local push_px = push_right * scale
    self.cursor_phase = (self.cursor_phase or 0) + dt
    if self.cursor_phase >= cycle_sec then
        self.cursor_phase = self.cursor_phase - cycle_sec
    end
    local t = self.cursor_phase / cycle_sec
    local function ease_out_quad(x) return 1 - (1 - x) * (1 - x) end
    local x
    if t < push_portion then
        local p = ease_out_quad(t / push_portion)
        x = (self.cursor_base_x - snap_px) + (push_px * p)
    else
        x = (self.cursor_base_x - snap_px) + push_px
    end
    draw_sprite(self, self.spr.CURSOR, self.draw.cursor, x, self.cursor_base_y,
                (self.layout.z + 3), self.layout.scale)
end

-- Old shop-column *behavior*, without its character-index scroll algorithm.
-- The modern Displayer owns text measurement, scaling, clipping and scrolling.
local function compact_price(value)
    if type(value) ~= "number" then return tostring(value or "") end
    local n = math.max(0, math.floor(value))
    if n >= 1000000 then return (string.format("%.1fm", n / 1000000):gsub("%.0m$", "m")) end
    if n >= 1000 then return (string.format("%.1fk", n / 1000):gsub("%.0k$", "k")) end
    return tostring(n)
end

local function fit_text(text, font, scale, max_width)
    if get_text_width(text, font, scale) <= max_width then return text end
    local fitted = ""
    for i = 1, #text do
        local next_text = text:sub(1, i)
        if get_text_width(next_text, font, scale) > max_width then break end
        fitted = next_text
    end
    return fitted
end

local function render_shop_column(inst, text, x, y, width, id, selected, speed, tint)
    -- screen x/y and available width are converted to the virtual coordinates
    -- expected by the upgraded TextDisplay renderer.
    local scale = tonumber(inst.layout.scale) or 2.0
    local font = inst.layout.font
    if selected and not inst.locked and not inst._text_intro_active
        and get_text_width(text, font, scale) > width then
        erase_text(inst, id)
        local marquee_id = id .. "_marquee"
        local signature = table.concat({text, tostring(x), tostring(y),
            tostring(width), tostring(scale), tostring(speed), tostring(tint.opacity)}, ":")
        inst._shop_marquee_seen[marquee_id] = true
        -- Keep the current marquee animation alive across unrelated redraws
        -- (such as the shop-item intro), rather than restarting every tick.
        if inst.shop_marquees[marquee_id] ~= signature then
            if inst.shop_marquees[marquee_id] then
                Displayer.Text.removeMarquee(inst.player_id, marquee_id)
            end
            Displayer.Text.drawMarquee(inst.player_id, marquee_id, text, y / 2, {
                x = x / 2, font = font, scale = scale, z = inst.layout.z + 2,
                speed = speed, loops = true, pixel_snap = true,
                opacity = tint.opacity,
                viewport = {x = x / 2, y = y / 2,
                    width = width / 2, height = (8 * scale) / 2},
            })
            inst.shop_marquees[marquee_id] = signature
        end
    else
        local marquee_id = id .. "_marquee"
        if inst.shop_marquees[marquee_id] then
            Displayer.Text.removeMarquee(inst.player_id, marquee_id)
            inst.shop_marquees[marquee_id] = nil
        end
        draw_text(inst, fit_text(text, font, scale, width), x, y,
            font, scale, inst.layout.z + 2, id, tint)
    end
end

-- Older menu layout offsets are authored as screen pixels at a 2x sprite
-- scale; scale these only for presets that opt into a smaller frame.
local function frame_offset(layout, value)
    if layout.scale_screen_offsets then
        return value * ((tonumber(layout.scale) or 2.0) / 2.0)
    end
    return value
end

function PromptMenuInstance:render_menu_contents(force)
    if self.menu_bg_open_playing or self.menu_bg_needs_open then
        self:clear_menu_text()
        self._text_cache_top = nil
        self._text_cache_rows = nil
        self._text_cache_total = nil
        erase_sprite(self.player_id, self.draw.hilite)
        erase_sprite(self.player_id, self.draw.cursor)
        erase_sprite(self.player_id, self.draw.scroll)
        erase_text(self, self.draw.monies)
        erase_text(self, self.draw.monies_amount)
        return
    end

    local L = self.layout
    local x0, y0 = self:menu_origin()

    -- Monies label
    if L.monies_label_enabled then
        local scale = tonumber(L.scale) or 2.0
        local text  = tostring(L.monies_label_text or "MONIES")
        local font  = tostring(L.monies_label_font or "WIDE_BLACK")
        local pad_x = (tonumber(L.monies_label_pad_x) or 6) * scale
        local pad_y = (tonumber(L.monies_label_pad_y) or 4) * scale
        local zadd  = tonumber(L.monies_label_z_add) or 4
        local tw = get_text_width(text, font, scale)
        local mx = x0 + (MENU_W * scale) - pad_x - tw
        local my = y0 + pad_y
        draw_text(self, text, mx, my, font, scale, (L.z + zadd), self.draw.monies)

        if L.monies_amount_enabled then
            local atext = tostring(L.monies_amount_text or "0$")
            local afont = tostring(L.monies_amount_font or "THIN")
            local ax_off = (tonumber(L.monies_amount_offset_x) or 0) * scale
            local ay_off = (tonumber(L.monies_amount_offset_y) or 10) * scale
            local atw = get_text_width(atext, afont, scale)
            local ax = (mx + tw) - atw + ax_off
            local ay = my + ay_off
            draw_text(self, atext, ax, ay, afont, scale, (L.z + zadd), self.draw.monies_amount)
        else
            erase_text(self, self.draw.monies_amount)
        end

        if L.shop_item_enabled then
            local scale = tonumber(L.scale) or 2.0
            local ix = x0 + (MENU_W * scale) - (tonumber(L.shop_item_pad_x) or 0)
            local iy = y0 + (tonumber(L.shop_item_pad_y) or 0)
            local zadd = tonumber(L.shop_item_z_add) or 3
            local cur = (self.options and self.selection_index) and self.options[self.selection_index] or nil
            local cur_id = cur and cur.id or nil
            local cur_text = cur and cur.text or nil
            local is_exit_hover = (self.selection_index == self.exit_index) or
                                   (cur_id ~= nil and tostring(cur_id) == "exit") or
                                   (cur_text ~= nil and string.lower(tostring(cur_text)) == "exit")
            if (L.shop_item_swap_exit == true) and is_exit_hover then
                erase_sprite(self.player_id, self.draw.shop_item)
                local w = tonumber(L.shop_exit_w) or 0
                local h = tonumber(L.shop_exit_h) or 0
                local sx = scale
                local sy = scale
                local dx = ix
                local dy = iy
                if self._shop_item_intro_active and w > 0 then
                    local frames = tonumber(L.shop_item_intro_frames) or 10
                    local dur = frames / 60
                    local raw = math.min(1, (self._shop_item_intro_t or 0) / math.max(0.0001, dur))
                    local t = raw * raw * raw
                    local min_p = 0.05
                    local p = math.max(min_p, t)
                    sx = scale * p
                    local cx = ix + (w * scale) / 2
                    dx = cx - (w * sx) / 2
                end
                draw_sprite_xy(self, self.spr.SHOP_EXIT, self.draw.shop_exit, dx, dy, (L.z + zadd), sx, sy)
            else
                erase_sprite(self.player_id, self.draw.shop_exit)
                local w = tonumber(L.shop_item_w) or 0
                local h = tonumber(L.shop_item_h) or 0
                local sx = scale
                local sy = scale
                local dx = ix
                local dy = iy
                if self._shop_item_intro_active and w > 0 then
                    local frames = tonumber(L.shop_item_intro_frames) or 10
                    local dur = frames / 60
                    local raw = math.min(1, (self._shop_item_intro_t or 0) / math.max(0.0001, dur))
                    local t = raw * raw * raw
                    local min_p = 0.05
                    local p = math.max(min_p, t)
                    sx = scale * p
                    local cx = ix + (w * scale) / 2
                    dx = cx - (w * sx) / 2
                end
                draw_sprite_xy(self, self.spr.SHOP_ITEM, self.draw.shop_item, dx, dy, (L.z + zadd), sx, sy)
            end
        else
            erase_sprite(self.player_id, self.draw.shop_item)
            erase_sprite(self.player_id, self.draw.shop_exit)
        end
    else
        erase_text(self, self.draw.monies)
        erase_text(self, self.draw.monies_amount)
    end

    local rows = L.visible_rows
    local total = #self.options
    local top = self.scroll_top_index
    local sel = self.selection_index

    local redraw_text = force or (self._text_cache_top ~= top) or (self._text_cache_rows ~= rows) or (self._text_cache_total ~= total)
    if redraw_text then
        if not self.menu_text_ids or #self.menu_text_ids ~= rows then
            self:clear_menu_text()
            self.menu_text_ids = {}
            for i = 1, rows do
                self.menu_text_ids[i] = self.box_id .. "_menu_row_" .. tostring(i)
            end
        end
        self._text_cache_top = top
        self._text_cache_rows = rows
        self._text_cache_total = total
    end

    local scale = tonumber(L.scale) or 2.0
    local row_h = (tonumber(L.row_height) or 12) * scale
    local cx = x0 + frame_offset(L, L.padding_x or 0)
    local cy = y0 + frame_offset(L, L.padding_y or 0)

    if redraw_text then
        self._shop_marquee_seen = {}
        for i = 0, rows - 1 do
            local idx = top + i
            local tx = cx
            local ty = cy + (i * row_h)
            local display_id = self.menu_text_ids[i + 1]
            if idx <= total then
                local text = tostring(self.options[idx].text or "")
                local opacity = 255
                local xoff = 0
                if self._text_intro_active and self.layout.text_intro_enabled then
                    local dur = (tonumber(self.layout.text_intro_frames) or 20) / 60
                    local stagger = (tonumber(self.layout.text_intro_stagger_frames) or 3) / 60
                    local row_t = (self._text_intro_t or 0) - (i * stagger)
                    local p = 0
                    if row_t > 0 and dur > 0 then
                        p = clamp(row_t / dur, 0, 1)
                    end
                    local eased = p * p * (3 - 2 * p)
                    opacity = math.floor(255 * eased)
                    xoff = (tonumber(self.layout.text_intro_slide_px) or 10) * (1 - eased) * scale
                end
                if self.locked and (idx ~= sel) then
                    opacity = math.floor(opacity * (self.lock_dim_alpha or 0.35))
                end
                local opt = self.options[idx]
                if L.shop_columns_enabled and type(opt) == "table"
                    and opt.shop_name ~= nil and opt.shop_price ~= nil then
                    erase_text(self, display_id)
                    local price_x = cx + L.shop_price_col_x * scale
                    local name_width = math.max(1, (price_x - tx) / 2 - 2 * scale)
                    local price_width = math.max(1, L.shop_price_width * scale / 2)
                    local price_text = L.shop_compact_prices and compact_price(opt.shop_price)
                        or tostring(opt.shop_price)
                    render_shop_column(self, tostring(opt.shop_name), tx + xoff, ty,
                        name_width, display_id .. "_name", idx == sel,
                        L.shop_name_speed, {opacity = opacity})
                    render_shop_column(self, price_text, price_x + xoff, ty,
                        price_width, display_id .. "_price", idx == sel,
                        L.shop_price_speed, {opacity = opacity})
                else
                    erase_text(self, display_id .. "_name")
                    erase_text(self, display_id .. "_price")
                    draw_text(self, text, tx + xoff, ty, L.font, scale,
                        (L.z + 2), display_id, { opacity = opacity })
                end
            else
                erase_text(self, display_id)
                erase_text(self, display_id .. "_name")
                erase_text(self, display_id .. "_price")
            end
        end
        -- When rows scroll or the selection moves, retire marquees that no
        -- longer represent the active selected shop row.
        for id in pairs(self.shop_marquees) do
            if not self._shop_marquee_seen[id] then
                Displayer.Text.removeMarquee(self.player_id, id)
                self.shop_marquees[id] = nil
            end
        end
        self._shop_marquee_seen = nil
    end

    local sel_row = sel - top
    if sel_row >= 0 and sel_row < rows then
        if self.state == STATE.MENU then
            local hx = x0 + frame_offset(L, L.highlight_inset_x or 0)
            local hy = cy + (sel_row * row_h) + ((L.highlight_inset_y or 0) * scale)
            local curx = x0 + frame_offset(L, L.cursor_offset_x or 0)
            local cury = cy + (sel_row * row_h) + ((L.cursor_offset_y or 0) * scale)
            if L.align_row_elements then
                -- All three share the same row rectangle. The source cursor
                -- is 11px tall and the highlight 13px tall; glyph height is
                -- taken from the active font, not guessed from layout scale.
                local _, font_h = Displayer.Font.getGlyphDimensions(L.font, "A")
                local glyph_h = (tonumber(font_h) or 15) * scale
                local text_row_top = cy + (sel_row * row_h)
                local cursor_h, highlight_h = 11 * scale, 13 * scale
                -- Center the overlays on the visible text height, clamped
                -- to the row so long glyphs cannot overlap adjacent rows.
                local text_center_y = text_row_top + math.min(row_h, glyph_h) / 2
                hy = text_center_y - highlight_h / 2
                cury = text_center_y - cursor_h / 2
                -- Keep the cursor immediately before the actual text origin.
                curx = cx - (11 * scale) - L.cursor_text_gap_px
            end
            draw_sprite(self, self.spr.HILITE, self.draw.hilite, hx, hy, (L.z + 1), L.scale)
            self.cursor_base_x = curx
            self.cursor_base_y = cury
            if not (self.locked and self.hide_cursor_when_locked) then
                draw_sprite(self, self.spr.CURSOR, self.draw.cursor, curx, cury, (L.z + 3), L.scale)
            else
                erase_sprite(self.player_id, self.draw.cursor)
            end
        else
            self.cursor_base_x = nil
            self.cursor_base_y = nil
            erase_sprite(self.player_id, self.draw.hilite)
            erase_sprite(self.player_id, self.draw.cursor)
        end
    else
        self.cursor_base_x = nil
        self.cursor_base_y = nil
        erase_sprite(self.player_id, self.draw.hilite)
        erase_sprite(self.player_id, self.draw.cursor)
    end

    if total > rows then
        local track_x = x0 + frame_offset(L, L.scrollbar_x or 0)
        local track_y = y0 + frame_offset(L, L.scrollbar_y or 0)
        local track_h = frame_offset(L, L.scrollbar_h or 0)
        local scale = tonumber(L.scale) or 2.0
        local indicator_h = (tonumber(L.scroll_indicator_h) or 8) * scale
        local max_top = math.max(1, total - rows + 1)
        local t = 0
        if max_top > 1 then
            t = (top - 1) / (max_top - 1)
        end
        local travel = math.max(0, track_h - indicator_h)
        local thumb_y = track_y + (travel * t)
        thumb_y = math.floor(thumb_y + 0.5)
        draw_sprite(self, self.spr.SCROLL, self.draw.scroll, track_x, thumb_y, (L.z + 3), L.scale)
    else
        erase_sprite(self.player_id, self.draw.scroll)
    end
end

function PromptMenuInstance:start_text_intro()
    if not (self.layout and self.layout.text_intro_enabled) then
        self._text_intro_active = false
        self._text_intro_t = 0
        self._text_intro_speed_mult = 1
        self._text_intro_boosted = false
        return
    end
    self._text_intro_active = true
    self._text_intro_t = 0
    self._text_intro_speed_mult = 1
    self._text_intro_boosted = false
end

function PromptMenuInstance:become_ready()
    DebugLog:info_data("Vertical menu accepting input", {
        player_id = self.player_id, box_id = self.box_id,
        selection = self.selection_index, scroll_top = self.scroll_top_index,
    })
    self.state = STATE.MENU
    self.ready_for_input = true
    set_textbox_indicator_enabled(self.player_id, self.box_id, false)
    self.cursor_phase = 0
    if self.menu_bg_open_playing or self.menu_bg_needs_open then
        self.menu_contents_pending = true
    else
        self.menu_contents_pending = false
        self:update_scroll_for_selection(true)
        self:start_text_intro()
        if self.layout.shop_item_intro_enabled then
            self._shop_item_intro_active = true
            self._shop_item_intro_t = 0
        end
        self:render_menu_contents(true)
    end
    guard(self.control_session, 0)
end

function PromptMenuInstance:select_current()
    local idx = self.selection_index
    local choice = self.options[idx]
    DebugLog:info_data("Vertical menu selection confirmed", {
        player_id = self.player_id, box_id = self.box_id,
        index = idx, choice_id = choice and choice.id,
        choice_text = choice and choice.text,
        selection_behavior = self.selection_behavior,
    })
    if self.selection_behavior == "callback_only" and type(self.on_choose) == "function" then
        local ok, err = pcall(self.on_choose, choice, idx, self)
        if not ok then DebugLog:error_data("Vertical menu choice callback failed", {
            player_id = self.player_id, box_id = self.box_id, error = tostring(err),
        }) end
        return
    end
    self._post_close_cb = function() self.on_select(choice, idx) end
    self:start_close("select", self.keep_textbox)
end

function PromptMenuInstance:do_cancel()
    local beh = self.cancel_behavior or "jump_to_exit"
    DebugLog:info_data("Vertical menu Cancel pressed", {
        player_id = self.player_id, box_id = self.box_id,
        behavior = beh, selection = self.selection_index, exit_index = self.exit_index,
    })
    if beh == "ignore" then
        return
    end
    if beh == "close" then
        self._post_close_cb = function() self.on_cancel() end
        self:start_close("cancel", self.keep_textbox)
        return
    end
    if self.selection_index ~= self.exit_index then
        self.selection_index = self.exit_index
        self:restart_shop_item_intro()
        local sc_changed = self:update_scroll_for_selection(false)
        play_cursor_move_sfx(self.player_id)
        self:render_menu_contents(true)
        return
    end
    self:select_current()
end

function PromptMenuInstance:restart_shop_item_intro()
    if not (self.layout and self.layout.shop_item_intro_enabled) then return end
    self._shop_item_intro_active = true
    self._shop_item_intro_t = 0
end

function PromptMenuInstance:update(_dt)
    local dt = math.min(_dt or 0, 1/30)
    local player_id = self.player_id
    local session = self.control_session
    if not session or not session:is_current() then return end
    local st = Displayer.Text.getTextBoxState(player_id, self.box_id)
    if self._logged_text_state ~= st then
        DebugLog:debug_data("Vertical menu text state changed", {
            player_id = player_id, box_id = self.box_id,
            state = st, previous = self._logged_text_state,
        })
        self._logged_text_state = st
    end
    if self.backdrop_id then
        Visuals.update(player_id, self.backdrop_id, self.ui, st)
    end

    if self.wait_textbox_open_idle then
        if st == "opening" then
            return
        end
        self.wait_textbox_open_idle = false
        self:render_menu_window()
    end

    if self.menu_bg_close_playing then
        self.menu_bg_close_t = self.menu_bg_close_t + dt
        if self.menu_bg_close_t >= (self.menu_bg_close_total or 0.60) then
            self.menu_bg_close_playing = false
            PromptVertical._finalize_close(player_id, self.pending_close_reason, {
                keep_textbox = self.pending_close_keep_textbox
            })
            return
        end
        guard(session, 0)
        return
    end

    if self.menu_bg_open_playing then
        self.menu_bg_open_t = self.menu_bg_open_t + dt
        if self.menu_bg_open_t >= (self.menu_bg_open_total or 0.58) then
            self.menu_bg_open_playing = false
            local L = self.layout
            local x, y = self:menu_origin()
            x = x + (MENU_W * L.scale)
            y = y + (MENU_H * L.scale)
            draw_sprite(self, self.spr.MENU_BG, self.draw.menu_bg, x, y, L.z, L.scale, "OPEN_IDLE")
            draw_menu_frame_overlay(self, self.draw.menu_frame, x, y, L.z + 1, L.scale, "OPEN_IDLE", L.frame)
            if self.menu_contents_pending then
                self.menu_contents_pending = false
                self:update_scroll_for_selection(true)
                self:start_text_intro()
                if self.layout.shop_item_intro_enabled then
                    self._shop_item_intro_active = true
                    self._shop_item_intro_t = 0
                end
                self:render_menu_contents(true)
            end
        end
    end

    if self._shop_item_intro_active then
        self._shop_item_intro_t = (self._shop_item_intro_t or 0) + dt
        local frames = tonumber(self.layout.shop_item_intro_frames) or 10
        local dur = frames / 60
        if self._shop_item_intro_t >= dur then
            self._shop_item_intro_active = false
            self._shop_item_intro_t = dur
        end
        self:render_menu_contents(true)
    end

    if self._text_intro_active then
        local dt_intro = dt * (self._text_intro_speed_mult or 1)
        self._text_intro_t = (self._text_intro_t or 0) + dt_intro
        local dur = (tonumber(self.layout.text_intro_frames) or 20) / 60
        local stagger = (tonumber(self.layout.text_intro_stagger_frames) or 3) / 60
        local rows = tonumber(self.layout.visible_rows) or 5
        local end_t = dur + math.max(0, (rows - 1) * stagger)
        if self._text_intro_t >= end_t then
            self._text_intro_active = false
            self._text_intro_speed_mult = 1
            self._text_intro_boosted = false
        end
        self:render_menu_contents(true)
    end

    if st == "printing" then
        -- The current Displayer exposes accurate page_count/current_page.
        -- Only the final page should transition into selectable menu mode.
        if pressed(session, "Confirm") then
            if self._text_intro_active and not self._text_intro_boosted then
                self._text_intro_boosted = true
                self._text_intro_speed_mult = 5
            end
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            guard(session, 0)
        end
        return
    end

    if st == "waiting" and self.state == STATE.TEXT then
        local bd = Displayer.Text.getTextBoxData(player_id, self.box_id)
        local last_page = bd and (bd.current_page or 1) >= (bd.page_count or 1)
        if last_page then
            set_textbox_indicator_enabled(player_id, self.box_id, false)
            self:become_ready()
        elseif pressed(session, "Confirm") then
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            guard(session, 0)
        end
        return
    end

    if self.state ~= STATE.MENU then return end
    if self.locked then return end

    local total = #self.options
    self:update_cursor_bob(dt)

    if pressed(session, "Up", true) then
        local prev = self.selection_index
        if self.selection_index <= 1 then
            self.selection_index = total
        else
            self.selection_index = self.selection_index - 1
        end
        if self.selection_index ~= prev then
            DebugLog:info_data("Vertical menu selection moved", {
                player_id = player_id, box_id = self.box_id,
                from = prev, to = self.selection_index, direction = "Up",
            })
            self:restart_shop_item_intro()
            local sc_changed = self:update_scroll_for_selection(false)
            play_cursor_move_sfx(player_id)
            self:render_menu_contents(true)
        end
        return
    end

    if pressed(session, "Down", true) then
        local prev = self.selection_index
        if self.selection_index >= total then
            self.selection_index = 1
        else
            self.selection_index = self.selection_index + 1
        end
        if self.selection_index ~= prev then
            DebugLog:info_data("Vertical menu selection moved", {
                player_id = player_id, box_id = self.box_id,
                from = prev, to = self.selection_index, direction = "Down",
            })
            self:restart_shop_item_intro()
            local sc_changed = self:update_scroll_for_selection(false)
            play_cursor_move_sfx(player_id)
            self:render_menu_contents(true)
        end
        return
    end

    if pressed(session, "Confirm") then
        self:select_current()
        return
    end

    if pressed(session, "Cancel") then
        self:do_cancel()
        return
    end
end

-- Public API
function PromptVertical.menu(player_id, opts)
    ensure_tick()
    -- Replacing an animating menu must finalize its visual/resource ownership
    -- immediately, not leave two sessions and two sets of sprites alive.
    if PromptVertical.instances[player_id] then
        PromptVertical._finalize_close(player_id, "replace", { keep_textbox = true })
    end
    opts = opts or {}
    DebugLog:info_data("Vertical menu requested", {
        player_id = player_id, box_id = opts.ui and opts.ui.box_id,
        parent_session = opts.parent_session ~= nil, reuse_existing_box = opts.reuse_existing_box == true,
    })
    local session, err = begin_session(player_id, opts)
    if not session then
        DebugLog:warn_data("Vertical menu input ownership rejected", {player_id = player_id, error = tostring(err)})
        return nil, err
    end
    guard(session, 0.10)
    local ok, inst = pcall(PromptMenuInstance.new, PromptMenuInstance, player_id, opts)
    if not ok then
        DebugLog:error_data("Vertical menu constructor failed", {
            player_id = player_id, error = tostring(inst),
        })
        session:close()
        return nil, inst
    end
    inst.control_session = session
    PromptVertical.instances[player_id] = inst
    session:on_close(function()
        if PromptVertical.instances[player_id] ~= inst then return end
        -- Abnormal teardown (disconnect, owner closed): remove our overlays.
        PromptVertical._finalize_close(player_id, "session_closed")
    end)
    return inst.box_id
end

function PromptVertical._finalize_close(player_id, _reason, opts)
    local inst = PromptVertical.instances[player_id]
    if not inst then return end
    opts = opts or {}
    local keep = opts.keep_textbox == true
    DebugLog:info_data("Vertical menu finalized", {
        player_id = player_id, box_id = inst.box_id,
        reason = _reason, keep_textbox = keep,
    })
    PromptVertical.instances[player_id] = nil

    erase_sprite(player_id, inst.draw.menu_bg)
    erase_sprite(player_id, inst.draw.menu_frame)
    erase_sprite(player_id, inst.draw.hilite)
    erase_sprite(player_id, inst.draw.cursor)
    erase_sprite(player_id, inst.draw.scroll)
    erase_sprite(player_id, inst.draw.shop_item)
    erase_sprite(player_id, inst.draw.shop_exit)
    inst:clear_menu_text()
    erase_text(inst, inst.draw.monies)
    erase_text(inst, inst.draw.monies_amount)
    -- Sweep tracked glyphs, including any row or shop-column IDs left by a
    -- transition/replacement. These IDs are owned only by this menu instance.
    local remaining_ids = {}
    for text_id in pairs(inst.text_glyphs or {}) do
        remaining_ids[#remaining_ids + 1] = text_id
    end
    for _, text_id in ipairs(remaining_ids) do erase_text(inst, text_id) end
    local handoff = (keep and inst._post_close_cb and inst.backdrop_id)
        and Visuals.hold(player_id, inst.backdrop_id) or nil
    if inst.backdrop_id then erase_backdrop(player_id) end

    if not keep then
        Displayer.Text.closeTextBox(player_id, inst.box_id)
    else
        set_textbox_indicator_enabled(player_id, inst.box_id, false)
    end

    guard(inst.control_session, 0.10)
    if inst.control_session and inst.control_session:is_alive() then
        inst.control_session:close()
    end
    -- Callbacks run only after the old session is released, so they can
    -- safely open their next prompt or dialogue in the same tick.
    if inst._post_close_cb and _reason ~= "replace" and _reason ~= "session_closed"
        and _reason ~= "textbox_missing" then
        local cb = inst._post_close_cb
        inst._post_close_cb = nil
        local ok, err = pcall(cb)
        if not ok then DebugLog:error_data("Vertical menu selection callback failed", {
            player_id = player_id, box_id = inst.box_id, error = tostring(err),
        }) end
    end
    Visuals.release_hold(handoff)
end

function PromptVertical.close(player_id, _reason, opts)
    local inst = PromptVertical.instances[player_id]
    if not inst then return end
    opts = opts or {}
    local keep = (opts.keep_textbox == true)
    inst:start_close(_reason or "close", keep)
end

return PromptVertical