-- scripts/net-games/dialogue/prompt.lua
-- Hardened YES/NO prompt using the public TextLayout service.

local Displayer  = require("scripts/displayer/displayer")
local TextLayout = require("scripts/displayer/text-layout")
local TextDisplay = require("scripts/displayer/text-display")
local Input      = require("scripts/input/input")

local Prompt = {}
Prompt.instances = {}
Prompt._tick_attached = false

local CURSOR_TEXTURE = "/server/assets/net-games/cursors/text_cursor.png"
local CURSOR_ANIM    = "/server/assets/net-games/cursors/text_cursor.animation"
local CURSOR_MOVE_SFX_PATH = "/server/assets/net-games/sfx/cursor_move.ogg"
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

local player_cursor_asset = {}
local player_backdrop_asset = {}

local function has_asset(path)
    if not Net.has_asset then return true end
    local ok, exists = pcall(Net.has_asset, path)
    return (not ok) or exists ~= false
end

local function safe_provide(player_id, path)
    if not path or path == "" or not has_asset(path) then return false end
    local ok = pcall(Net.provide_asset_for_player, player_id, path)
    return ok
end

local function play_cursor_move_sfx(player_id)
    if not safe_provide(player_id, CURSOR_MOVE_SFX_PATH) then return end
    if Net.play_sound_for_player then pcall(Net.play_sound_for_player, player_id, CURSOR_MOVE_SFX_PATH)
    elseif Net.play_sound then pcall(Net.play_sound, player_id, CURSOR_MOVE_SFX_PATH) end
end

local function ensure_backdrop_asset(player_id)
    if player_backdrop_asset[player_id] then return true end
    if not safe_provide(player_id, BACKDROP_TEXTURE) then return false end
    local id = "prompt_backdrop_asset_" .. tostring(player_id)
    Net.player_alloc_sprite(player_id, id, { texture_path = BACKDROP_TEXTURE })
    player_backdrop_asset[player_id] = id
    return true
end

local function draw_backdrop(player_id, backdrop, z)
    if not backdrop or not ensure_backdrop_asset(player_id) then return nil end
    local draw_id = "prompt_backdrop_" .. tostring(player_id)
    Net.player_draw_sprite(player_id, player_backdrop_asset[player_id], {
        id = draw_id,
        x = math.floor(((backdrop.x or 0) * 2) + 0.5),
        y = math.floor(((backdrop.y or 0) * 2) + 0.5),
        z = (z or 100) - 1,
        sx = (backdrop.width or 240) * 2,
        sy = (backdrop.height or 160) * 2,
        r = backdrop.r or 0, g = backdrop.g or 0, b = backdrop.b or 0,
        opacity = backdrop.opacity or 200,
        a = backdrop.a or 255,
        color_mode = backdrop.color_mode or 0,
    })
    return draw_id
end

local function erase_backdrop(player_id)
    Net.player_erase_sprite(player_id, "prompt_backdrop_" .. tostring(player_id))
end

local function ensure_cursor_asset(player_id)
    if player_cursor_asset[player_id] then return true end
    if not safe_provide(player_id, CURSOR_TEXTURE) or not safe_provide(player_id, CURSOR_ANIM) then return false end
    local id = "prompt_cursor_asset_" .. tostring(player_id)
    Net.player_alloc_sprite(player_id, id, {
        texture_path = CURSOR_TEXTURE,
        anim_path = CURSOR_ANIM,
        anim_state = "CURSOR_RIGHT",
    })
    player_cursor_asset[player_id] = id
    return true
end

local function selector_draw(player_id, draw_id, virtual_x, virtual_y, z, scale)
    if not ensure_cursor_asset(player_id) then return end
    Net.player_draw_sprite(player_id, player_cursor_asset[player_id], {
        id = draw_id,
        x = math.floor(virtual_x * 2 + 0.5),
        y = math.floor(virtual_y * 2 + 0.5),
        z = z,
        sx = scale or 2.0, sy = scale or 2.0,
        anim_state = "CURSOR_RIGHT",
    })
end

local function selector_erase(player_id, draw_id)
    Net.player_erase_sprite(player_id, draw_id)
end

local function normalize_ui(ui)
    ui = ui or {}
    local o = {
        box_id = ui.box_id,
        font = ui.font or "THIN_BLACK",
        scale = ui.scale or 2.0,
        z = ui.z or 100,
        x = ui.x or 8, y = ui.y or 110,
        w = ui.w or 224, h = ui.h or 42,
        backdrop = ui.backdrop or ui.backdrop_config,
        mugshot = ui.mugshot,
        nameplate = ui.nameplate,
        typing_speed = ui.typing_speed or 99999,
        type_sfx_path = ui.type_sfx_path,
        type_sfx_min_dt = ui.type_sfx_min_dt,
    }
    if o.backdrop then
        local px, py = o.backdrop.padding_x or 0, o.backdrop.padding_y or 0
        if o.backdrop.x ~= nil then o.x = o.backdrop.x + px end
        if o.backdrop.y ~= nil then o.y = o.backdrop.y + py end
        if o.backdrop.width ~= nil then o.w = o.backdrop.width - px * 2 end
        if o.backdrop.height ~= nil then o.h = o.backdrop.height - py * 2 end
    end
    return o
end

local OPTIONS_INDENT = "       "
local OPTIONS_TEXT = OPTIONS_INDENT .. "Yes    No"

local function build_prompt_text(question, ui)
    local max_lines = math.max(2, tonumber(ui.backdrop and ui.backdrop.max_lines) or math.floor(ui.h / (12 * ui.scale / 2)))
    local qlayout = TextLayout.layout(question, {
        font = ui.font, scale = ui.scale,
        x = ui.x, y = ui.y, width = ui.w,
        -- Deliberately do not paginate this measurement pass.
        max_lines = 9999,
    })
    local qlines = {}
    for _, page in ipairs(qlayout.pages or {}) do
        for _, line in ipairs(page) do qlines[#qlines + 1] = line end
    end
    if #qlines == 0 then qlines[1] = tostring(question or "Continue?") end

    local pages = {}
    local index = 1
    local remaining = #qlines
    local final_capacity = max_lines - 1

    while remaining > final_capacity do
        local take = math.min(max_lines, math.max(1, remaining - final_capacity))
        local page = {}
        for _ = 1, take do page[#page + 1] = qlines[index]; index = index + 1 end
        pages[#pages + 1] = page
        remaining = remaining - take
    end

    local final = {}
    while index <= #qlines do final[#final + 1] = qlines[index]; index = index + 1 end
    -- Keep the choices on a predictable final line where practical.
    while #final < final_capacity do final[#final + 1] = "" end
    final[#final + 1] = OPTIONS_TEXT
    pages[#pages + 1] = final

    local page_strings = {}
    for _, page in ipairs(pages) do page_strings[#page_strings + 1] = table.concat(page, "{end_line}") end
    return table.concat(page_strings, "{end_page}"), #pages
end

local function options_visible(player_id, box_id)
    local bd = Displayer.Text.getTextBoxData(player_id, box_id)
    if not bd or not bd.pages then return false end
    local page = bd.pages[bd.current_page or 1]
    if not page then return false end
    for _, line in ipairs(page) do if tostring(line):find("Yes", 1, true) then return true end end
    return false
end

local function find_option_virtual_positions(player_id, box_id, selection)
    local bd = Displayer.Text.getTextBoxData(player_id, box_id)
    if not bd or not bd.page_layouts then return 10, 120 end
    local page = bd.page_layouts[bd.current_page or 1]
    if not page then return 10, 120 end

    for _, line in ipairs(page.lines or {}) do
        local yes_col = tostring(line.text or ""):find("Yes", 1, true)
        local no_col = tostring(line.text or ""):find("No", 1, true)
        if yes_col and no_col then
            local col = selection == 1 and yes_col or no_col
            local glyph = line.glyphs and line.glyphs[col]
            local x = glyph and glyph.x or line.x
            local y = glyph and glyph.y or line.y
            -- Position cursor slightly left and vertically centered on the line.
            return x - (3 * (bd.scale or 2) / 2), y + (4 * (bd.scale or 2) / 2)
        end
    end
    return bd.virtual_x or 10, bd.virtual_y or 120
end

local function set_input_locked(player_id, locked)
    if locked and Net.lock_player_input then pcall(Net.lock_player_input, Net, player_id)
    elseif (not locked) and Net.unlock_player_input then pcall(Net.unlock_player_input, Net, player_id) end
end

local function mk_id(player_id) return "ng_prompt_" .. tostring(player_id) end

local PromptInstance = {}
PromptInstance.__index = PromptInstance

function PromptInstance:new(player_id, opts)
    local o = setmetatable({}, self)
    opts = opts or {}
    o.player_id = player_id
    o.ui = normalize_ui(opts.ui)
    o.box_id = o.ui.box_id or mk_id(player_id)
    o.question = opts.question or "Continue?"
    o.on_yes = opts.on_yes or function() end
    o.on_no = opts.on_no or function() end
    o.on_cancel = opts.on_cancel or function() end
    o.cancel_behavior = opts.cancel_behavior or "select_no"
    o.reuse_existing_box = opts.reuse_existing_box == true
    local selected = math.floor(tonumber(opts.default_selection) or 1)
    o.selection = (selected == 2) and 2 or 1
    o.ready_for_input = false
    o.cursor_id = o.box_id .. "_selcursor"
    o.cursor_phase = 0
    o.cursor_base_x, o.cursor_base_y = nil, nil
    o.backdrop_id = nil
    o:render_initial()
    return o
end

function PromptInstance:render_initial()
    local ui, player_id = self.ui, self.player_id
    if ui.backdrop then self.backdrop_id = draw_backdrop(player_id, ui.backdrop, ui.z) end

    local text = build_prompt_text(tostring(self.question or "Continue?"), ui)
    local existing = Displayer.Text.getTextBoxData(player_id, self.box_id)
    local text_options = {
        font = ui.font, scale = ui.scale, z = ui.z,
        speed = ui.typing_speed,
        type_sound = ui.type_sfx_path,
        type_sound_min_dt = ui.type_sfx_min_dt,
        max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
    }

    if existing and self.reuse_existing_box then
        TextDisplay:resetTextBox(player_id, self.box_id, text, {
            x = ui.x, y = ui.y, width = ui.w, height = ui.h,
            font = ui.font, scale = ui.scale, z = ui.z,
            speed = ui.typing_speed,
            type_sound = ui.type_sfx_path,
            type_sound_min_dt = ui.type_sfx_min_dt,
            max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
        })
    else
        if existing then Displayer.Text.closeTextBox(player_id, self.box_id) end
        Displayer.Text.createTextBox(player_id, self.box_id, text, ui.x, ui.y, ui.w, ui.h, text_options)
    end

    if (not (existing and self.reuse_existing_box)) and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(player_id, self.box_id)
        if bd then Displayer.Nameplate.attach(player_id, nil, self.box_id, bd, ui.nameplate) end
    end
end

function PromptInstance:render_cursor()
    local x, y = find_option_virtual_positions(self.player_id, self.box_id, self.selection)
    self.cursor_base_x, self.cursor_base_y = x, y
    selector_draw(self.player_id, self.cursor_id, x, y, self.ui.z + 2, self.ui.scale)
end

function PromptInstance:update(dt)
    local player_id = self.player_id
    local state = Displayer.Text.getTextBoxState(player_id, self.box_id)

    if state == "printing" then
        Input.consume(player_id)
        if Input.is_down(player_id, "confirm") then
            Input.pop(player_id, "confirm")
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            Input.require_release(player_id, { "confirm" })
        end
        return
    end

    if not self.ready_for_input then
        if (state == "waiting" or state == "completed") and options_visible(player_id, self.box_id) then
            self.ready_for_input = true
            Input.consume(player_id)
            local held = {}
            for _, key in ipairs({ "left", "right", "up", "down", "confirm", "cancel" }) do
                if Input.is_down(player_id, key) then held[#held + 1] = key end
            end
            if #held > 0 then Input.require_release(player_id, held) end
            self:render_cursor()
            return
        end
        if state == "waiting" and Input.pop(player_id, "confirm") then
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            Input.consume(player_id)
            Input.require_release(player_id, { "confirm" })
        else
            Input.pop(player_id, "cancel")
        end
        return
    end

    -- Small BN-style cursor nudge. Position is pixel-snapped before transport.
    dt = math.min(tonumber(dt) or 0, 1 / 30)
    self.cursor_phase = (self.cursor_phase + dt * 3.8) % 1
    local eased = 1 - (1 - self.cursor_phase) * (1 - self.cursor_phase)
    local push = eased * (self.ui.scale or 1)
    if self.cursor_base_x then
        selector_draw(player_id, self.cursor_id, self.cursor_base_x + push, self.cursor_base_y,
            self.ui.z + 2, self.ui.scale)
    end

    if Input.pop(player_id, "left") or Input.pop(player_id, "right") then
        self.selection = self.selection == 1 and 2 or 1
        play_cursor_move_sfx(player_id)
        self:render_cursor()
        return
    end

    if Input.pop(player_id, "confirm") then
        local selection = self.selection
        Prompt.close(player_id, "confirm", { keep_textbox = true })
        if selection == 1 then self.on_yes() else self.on_no() end
        return
    end

    if Input.pop(player_id, "cancel") then
        local behavior = self.cancel_behavior
        if behavior == "close" then
            Prompt.close(player_id, "cancel")
            self.on_cancel()
        elseif behavior == "ignore" then
            return
        elseif self.selection ~= 2 then
            self.selection = 2
            play_cursor_move_sfx(player_id)
            self:render_cursor()
        else
            Prompt.close(player_id, "cancel_no", { keep_textbox = true })
            self.on_no()
        end
    end
end

local function ensure_tick()
    if Prompt._tick_attached then return end
    Prompt._tick_attached = true
    Net:on("tick", function(event)
        for player_id, inst in pairs(Prompt.instances) do
            if not Displayer.Text.getTextBoxData(player_id, inst.box_id) then
                Prompt.close(player_id, "textbox_missing")
            else
                inst:update(event and event.delta_time or 0)
            end
        end
    end)
end

function Prompt.yesno(player_id, opts)
    Input.attach_virtual_input_listener()
    ensure_tick()
    if Prompt.instances[player_id] then Prompt.close(player_id, "replace") end
    set_input_locked(player_id, true)
    Input.consume(player_id)
    Input.swallow(player_id, 0.10)
    Input.require_release(player_id, { "confirm", "cancel" })
    local inst = PromptInstance:new(player_id, opts or {})
    Prompt.instances[player_id] = inst
    return inst.box_id
end

function Prompt.close(player_id, _reason, opts)
    local inst = Prompt.instances[player_id]
    if not inst then return end
    opts = opts or {}
    local keep = opts.keep_textbox == true

    selector_erase(player_id, inst.cursor_id)
    if inst.backdrop_id and not keep then erase_backdrop(player_id) end

    if not keep then
        local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
        if bd and inst.ui.nameplate then pcall(Displayer.Nameplate.begin_close, player_id, nil, bd, inst.ui.nameplate) end
        Displayer.Text.closeTextBox(player_id, inst.box_id)
    end

    set_input_locked(player_id, false)
    Input.consume(player_id)
    Input.swallow(player_id, 0.10)
    Input.require_release(player_id, { "confirm", "cancel" })
    Prompt.instances[player_id] = nil
end

Net:on("player_disconnect", function(event)
    if not event or not event.player_id then return end
    local player_id = event.player_id
    local inst = Prompt.instances[player_id]
    if inst then
        selector_erase(player_id, inst.cursor_id)
        erase_backdrop(player_id)
        Prompt.instances[player_id] = nil
    end
    player_cursor_asset[player_id] = nil
    player_backdrop_asset[player_id] = nil
end)

return Prompt
