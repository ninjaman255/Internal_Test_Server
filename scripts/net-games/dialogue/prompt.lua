local PlayerControl = require("scripts/player-control/main")
-- scripts/net-games/dialogue/prompt.lua
-- Hardened YES/NO prompt using the public TextLayout service.

local Nameplate = require("scripts/net-games/ui/nameplate-service")
local Displayer  = require("scripts/displayer/displayer")
local TextLayout = require("scripts/displayer/text-layout")
local TextDisplay = require("scripts/displayer/text-display")
local Visuals = require("scripts/net-games/ui/textbox-surface")
local DebugLog = require("scripts/net-games/logging").get("PROMPT")


local Prompt = {}
Prompt.instances = {}
Prompt._tick_attached = false

local CURSOR_TEXTURE = "/server/assets/net-games/cursors/text_cursor.png"
local CURSOR_ANIM    = "/server/assets/net-games/cursors/text_cursor.animation"
local CURSOR_MOVE_SFX_PATH = "/server/assets/net-games/sfx/cursor_move.ogg"
local player_cursor_asset = {}

local function has_asset(path)
    if not Net.has_asset then return true end
    local ok, exists = pcall(Net.has_asset, path)
    return (not ok) or exists ~= false
end

local function safe_provide(player_id, path)
    if not path or path == "" or not has_asset(path) then return false end
    return pcall(Net.provide_asset_for_player, player_id, path)
end

local function play_cursor_move_sfx(player_id)
    if not safe_provide(player_id, CURSOR_MOVE_SFX_PATH) then return end
    if Net.play_sound_for_player then pcall(Net.play_sound_for_player, player_id, CURSOR_MOVE_SFX_PATH)
    elseif Net.play_sound then pcall(Net.play_sound, player_id, CURSOR_MOVE_SFX_PATH) end
end

local function draw_backdrop(player_id, ui)
    return Visuals.draw(player_id, "prompt_backdrop_" .. tostring(player_id), ui)
end

local function erase_backdrop(player_id)
    Visuals.erase(player_id, "prompt_backdrop_" .. tostring(player_id))
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

-- TextLayout normalizes repeated spaces, so separate Yes/No text cannot
-- share a single wrapped line if they must occupy distinct visual columns.
-- The prompt keeps line three blank and uses Displayer.Text.drawStatic for each
-- option after the typewriter question reaches the last page.
local CHOICE_YES_SUFFIX = "_yes_label"
local CHOICE_NO_SUFFIX = "_no_label"
-- Shared vertical adjustment for both labels and their cursor anchors.
-- Positions here are virtual 240x160 units (2 = four screen pixels).
local CHOICE_VERTICAL_OFFSET = 2

local function build_prompt_text(question, ui)
    local max_lines = math.max(2, tonumber(ui.backdrop and ui.backdrop.max_lines) or math.floor(ui.h / (12 * ui.scale / 2)))
    local text_x, text_y, text_w = Visuals.text_rect(ui)
    local qlayout = TextLayout.layout(question, {
        font = ui.font, scale = ui.scale,
        x = text_x, y = text_y, width = text_w,
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
    -- Reserve the third line for independently positioned choices. The modern
    -- TextLayout wrapper removes repeated spaces; keeping one "Yes    No" line
    -- would force the labels together regardless of the number of spaces.
    final[#final + 1] = ""
    pages[#pages + 1] = final

    local page_strings = {}
    for _, page in ipairs(pages) do page_strings[#page_strings + 1] = table.concat(page, "{end_line}") end
    return table.concat(page_strings, "{end_page}"), #pages
end

local function options_visible(player_id, box_id)
    local bd = Displayer.Text.getTextBoxData(player_id, box_id)
    return bd ~= nil and (bd.current_page or 1) >= (bd.page_count or 1)
end

local function remove_choices(player_id, inst)
    if not inst then return end
    Displayer.Text.removeStatic(player_id, inst.box_id .. CHOICE_YES_SUFFIX)
    Displayer.Text.removeStatic(player_id, inst.box_id .. CHOICE_NO_SUFFIX)
    inst.choices_drawn = false
    inst.choice_positions = nil
end

local function begin_session(player_id, opts)
    local parent = opts.parent_session
    return PlayerControl.begin(player_id, {
        profile = "menu", owner = "net-games:yesno", parent = parent,
        capture = parent == nil, handoff_free_camera = opts.handoff_free_camera == true,
    })
end

local function pressed(session, action)
    if not session then return false end
    local ctrl, owner = session:input()
    return ctrl and ctrl:is_action_pressed(action, owner) or false
end

local function guard(session, seconds)
    if session and session:is_current() then
        session:guard_input(seconds or 0.10,
            {"Left", "Right", "Up", "Down", "Confirm", "Cancel"})
    end
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
    o.choice_positions = nil
    o.choices_drawn = false
    o.backdrop_id = nil
    DebugLog:info_data("Yes/No prompt rendering started", {
        player_id = player_id, box_id = o.box_id, font = o.ui.font,
        question = tostring(o.question), selection = o.selection,
        reuse_existing_box = o.reuse_existing_box,
    })
    o:render_initial()
    return o
end

function PromptInstance:render_initial()
    local ui, player_id = self.ui, self.player_id
    self.backdrop_id = draw_backdrop(player_id, ui)

    local text = build_prompt_text(tostring(self.question or "Continue?"), ui)
    local x_v, y_v, w_v, h_v = Visuals.text_rect(ui)
    local existing = Displayer.Text.getTextBoxData(player_id, self.box_id)
    DebugLog:info_data("Prompt textbox create or reuse", {
        player_id = player_id, box_id = self.box_id,
        existing = existing ~= nil, reuse = self.reuse_existing_box,
        x = x_v, y = y_v, width = w_v, height = h_v, font = ui.font,
    })
    local text_options = {
        font = ui.font, scale = ui.scale, z = ui.z,
        speed = ui.typing_speed,
        type_sound = ui.type_sfx_path,
        type_sound_min_dt = ui.type_sfx_min_dt,
        max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
    }

    if existing and self.reuse_existing_box then
        TextDisplay:resetTextBox(player_id, self.box_id, text, {
            x = x_v, y = y_v, width = w_v, height = h_v,
            font = ui.font, scale = ui.scale, z = ui.z,
            speed = ui.typing_speed,
            type_sound = ui.type_sfx_path,
            type_sound_min_dt = ui.type_sfx_min_dt,
            max_lines = ui.backdrop and ui.backdrop.max_lines or nil,
        })
    else
        if existing then Displayer.Text.closeTextBox(player_id, self.box_id) end
        Displayer.Text.createTextBox(player_id, self.box_id, text, x_v, y_v, w_v, h_v, text_options)
    end

    if (not (existing and self.reuse_existing_box)) and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(player_id, self.box_id)
        if bd then Nameplate.attach(player_id, nil, self.box_id,
            Visuals.nameplate_box_data(ui, bd), ui.nameplate) end
    end
end

-- Two independent labels laid out in virtual coordinates. Their separation
-- is calculated using Displayer's own text measurement, not space counts.
function PromptInstance:render_choices()
    if self.choices_drawn then return end
    local bd = Displayer.Text.getTextBoxData(self.player_id, self.box_id)
    if not bd or not bd.page_layouts then return end
    local page = bd.page_layouts[bd.current_page or 1]
    if not page or not page.lines or #page.lines == 0 then return end

    local last_line = page.lines[#page.lines]
    local font = bd.font or self.ui.font
    local scale = bd.scale or self.ui.scale or 2.0
    local base_x = bd.virtual_x or last_line.x or 0
    local width = bd.virtual_width or 180
    local yes_width = TextLayout.measureLine("Yes", {font = font, scale = scale})
    local no_width = TextLayout.measureLine("No", {font = font, scale = scale})
    -- A modest inset leaves clear room for the mugshot and right-facing arrow.
    local yes_x = base_x + math.min(12, width * 0.08)
    local no_x = math.min(yes_x + math.max(54, yes_width + 22),
                          base_x + width - no_width - 4)
    no_x = math.max(no_x, yes_x + yes_width + 6)
    local y = last_line.y + CHOICE_VERTICAL_OFFSET
    local options = {font = font, scale = scale, z = (self.ui.z or 100) + 1}

    Displayer.Text.drawStatic(self.player_id, self.box_id .. CHOICE_YES_SUFFIX,
                             "Yes", yes_x, y, options)
    Displayer.Text.drawStatic(self.player_id, self.box_id .. CHOICE_NO_SUFFIX,
                             "No", no_x, y, options)
    -- FontSystem draws text glyphs from their top edge, whereas the
    -- CURSOR_RIGHT animation is centered on its originy (6 of 13 pixels).
    -- Place that cursor anchor at the *rendered* label's vertical center.
    -- A fixed +4 virtual-unit offset was too high for THIN's 15px glyphs.
    -- Use Displayer's public font metrics instead of an additional direct
    -- dependency on the FontSystem singleton. If a font is unavailable while
    -- assets are being reloaded, retain a safe cursor position rather than
    -- throwing from the prompt tick callback.
    local function glyph_height(char)
        if Displayer.Font and type(Displayer.Font.getGlyphDimensions) == "function" then
            local ok, _, height = pcall(Displayer.Font.getGlyphDimensions, font, char)
            if ok and type(height) == "number" and height > 0 then
                return height
            end
        end
        return 12 -- FontSystem's own missing-glyph height fallback
    end
    local yes_height = glyph_height("Y")
    local no_height = glyph_height("N")
    self.choice_positions = {
        {x = yes_x, y = y + (yes_height * scale / 4), scale = scale},
        {x = no_x, y = y + (no_height * scale / 4), scale = scale},
    }
    self.choices_drawn = true
    DebugLog:info_data("Yes/No choices drawn", {
        player_id = self.player_id, box_id = self.box_id,
        yes_x = yes_x, no_x = no_x, y = y, font = font, scale = scale,
    })
end

function PromptInstance:render_cursor()
    self:render_choices()
    local choice = self.choice_positions and self.choice_positions[self.selection]
    if not choice then return end
    local scale = choice.scale or self.ui.scale or 2.0
    -- CURSOR_RIGHT uses originx=8, originy=6: its x anchor is the tip,
    -- and its y anchor is the center. Keep the existing horizontal gap.
    local x, y = choice.x - 5, choice.y
    self.cursor_base_x, self.cursor_base_y = x, y
    selector_draw(self.player_id, self.cursor_id, x, y, self.ui.z + 2, scale)
end

function PromptInstance:update(dt)
    local player_id = self.player_id
    local session = self.control_session
    if not session or not session:is_current() then return end
    local state = Displayer.Text.getTextBoxState(player_id, self.box_id)
    if self._last_logged_state ~= state then
        DebugLog:debug_data("Prompt text state changed", {
            player_id = player_id, box_id = self.box_id, previous = self._last_logged_state,
            state = state, has_choices = self.choices_drawn,
        })
        self._last_logged_state = state
    end
    if self.backdrop_id then
        Visuals.update(player_id, self.backdrop_id, self.ui, state)
    end

    if state == "printing" then
        if pressed(session, "Confirm") then
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            guard(session, 0)
        end
        return
    end

    if not self.ready_for_input then
        if (state == "waiting" or state == "completed") and options_visible(player_id, self.box_id) then
            self.ready_for_input = true
            DebugLog:info_data("Prompt accepting Yes/No input", {
                player_id = player_id, box_id = self.box_id, selection = self.selection,
            })
            guard(session, 0)
            self:render_cursor()
            return
        end
        if state == "waiting" and pressed(session, "Confirm") then
            Displayer.Text.advanceTextBox(player_id, self.box_id)
            guard(session, 0)
        end
        return
    end

    dt = math.min(tonumber(dt) or 0, 1 / 30)
    self.cursor_phase = (self.cursor_phase + dt * 3.8) % 1
    local eased = 1 - (1 - self.cursor_phase) * (1 - self.cursor_phase)
    local choice = self.choice_positions and self.choice_positions[self.selection]
    local cursor_scale = (choice and choice.scale) or self.ui.scale or 2.0
    local push = eased * cursor_scale
    if self.cursor_base_x then
        selector_draw(player_id, self.cursor_id, self.cursor_base_x + push, self.cursor_base_y,
            self.ui.z + 2, cursor_scale)
    end

    if pressed(session, "Left") or pressed(session, "Right") then
        self.selection = self.selection == 1 and 2 or 1
        DebugLog:info_data("Prompt selection changed", {
            player_id = player_id, box_id = self.box_id, selection = self.selection,
        })
        play_cursor_move_sfx(player_id)
        self:render_cursor()
        return
    end

    if pressed(session, "Confirm") then
        local selection = self.selection
        DebugLog:info_data("Prompt confirmed", {
            player_id = player_id, box_id = self.box_id,
            selection = selection, choice = selection == 1 and "yes" or "no",
        })
        local handoff = Visuals.hold(player_id, self.backdrop_id)
        Prompt.close(player_id, "confirm", { keep_textbox = true })
        local ok, err
        if selection == 1 then ok, err = pcall(self.on_yes) else ok, err = pcall(self.on_no) end
        local active_surface = Visuals.release_hold(handoff)
        -- If neither a nested menu nor a follow-up dialogue took ownership,
        -- discard the old prompt text rather than leave orphan glyphs behind.
        if handoff and not active_surface then
            Displayer.Text.closeTextBox(player_id, self.box_id)
        end
        if not ok then DebugLog:error_data("Prompt selection callback failed", {
            player_id = player_id, box_id = self.box_id, error = tostring(err),
        }) end
        return
    end

    if pressed(session, "Cancel") then
        DebugLog:info_data("Prompt Cancel pressed", {
            player_id = player_id, box_id = self.box_id,
            behavior = self.cancel_behavior, selection = self.selection,
        })
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
            local handoff = Visuals.hold(player_id, self.backdrop_id)
            Prompt.close(player_id, "cancel_no", { keep_textbox = true })
            local ok, err = pcall(self.on_no)
            local active_surface = Visuals.release_hold(handoff)
            if handoff and not active_surface then
                Displayer.Text.closeTextBox(player_id, self.box_id)
            end
            if not ok then DebugLog:error_data("Prompt No callback failed", {
                player_id = player_id, box_id = self.box_id, error = tostring(err),
            }) end
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
    ensure_tick()
    if Prompt.instances[player_id] then Prompt.close(player_id, "replace") end
    opts = opts or {}
    DebugLog:info_data("Prompt requested", {
        player_id = player_id,
        box_id = opts.ui and opts.ui.box_id,
        question = opts.question,
        parent_session = opts.parent_session ~= nil,
        reuse_existing_box = opts.reuse_existing_box == true,
    })
    local session, err = begin_session(player_id, opts)
    if not session then
        DebugLog:warn_data("Prompt input ownership rejected", {player_id = player_id, error = tostring(err)})
        return nil, err
    end
    guard(session, 0.10)
    local ok, inst = pcall(PromptInstance.new, PromptInstance, player_id, opts)
    if not ok then
        DebugLog:error_data("Prompt constructor failed", {
            player_id = player_id, box_id = opts.ui and opts.ui.box_id,
            error = tostring(inst),
        })
        session:close()
        return nil, inst
    end
    inst.control_session = session
    Prompt.instances[player_id] = inst
    session:on_close(function()
        if Prompt.instances[player_id] ~= inst then return end
        Prompt.instances[player_id] = nil
        pcall(selector_erase, player_id, inst.cursor_id)
        pcall(remove_choices, player_id, inst)
        if inst.backdrop_id then pcall(erase_backdrop, player_id) end
        pcall(Displayer.Text.closeTextBox, player_id, inst.box_id)
    end)
    return inst.box_id
end

function Prompt.close(player_id, _reason, opts)
    local inst = Prompt.instances[player_id]
    if not inst then return end
    opts = opts or {}
    local keep = opts.keep_textbox == true
    DebugLog:info_data("Prompt closing", {
        player_id = player_id, box_id = inst.box_id,
        reason = _reason, keep_textbox = keep,
    })

    selector_erase(player_id, inst.cursor_id)
    remove_choices(player_id, inst)
    -- Only the *textbox* is reused. The previous prompt's backdrop belongs to
    -- this prompt and must not leak beneath the next screen.
    if inst.backdrop_id then erase_backdrop(player_id) end

    if not keep then
        local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
        if bd and inst.ui.nameplate then pcall(Nameplate.begin_close, player_id, nil, bd, inst.ui.nameplate) end
        Displayer.Text.closeTextBox(player_id, inst.box_id)
    end

    Prompt.instances[player_id] = nil
    guard(inst.control_session, 0.10)
    if inst.control_session and inst.control_session:is_alive() then
        inst.control_session:close()
    end
end

Net:on("player_disconnect", function(event)
    if not event or not event.player_id then return end
    local player_id = event.player_id
    local inst = Prompt.instances[player_id]
    if inst then
        DebugLog:info_data("Prompt player disconnected", {player_id = player_id, box_id = inst.box_id})
        selector_erase(player_id, inst.cursor_id)
        remove_choices(player_id, inst)
        erase_backdrop(player_id)
        Prompt.instances[player_id] = nil
        if inst.control_session and inst.control_session:is_alive() then
            inst.control_session:close()
        end
    end
    player_cursor_asset[player_id] = nil
end)

return Prompt
