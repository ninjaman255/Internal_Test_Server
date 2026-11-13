-- scripts/net-games/dialogue/dialogue.lua
-- Hardened net-games dialogue lifecycle.
-- Keeps the creator-side Displayer architecture while preserving production
-- behavior learned from shadis_hp: held-input handoff protection, real visual
-- teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

require("scripts/net-games/main")

local Displayer   = require("scripts/displayer/displayer")
local TextDisplay = require("scripts/displayer/text-display")
local Visuals = require("scripts/net-games/dialogue/visuals")
local PlayerControl = require("scripts/player-control/main")
local C           = require("scripts/net-games/dialogue/constants")
local Prompt      = require("scripts/net-games/dialogue/prompt")
local PromptVertical = require("scripts/net-games/dialogue/prompt_vertical")

local Dialogue = {}
Dialogue.instances = {}


local function draw_backdrop(player_id, ui)
    return Visuals.draw(player_id, "dialogue_backdrop_" .. tostring(player_id), ui)
end

local function erase_backdrop(player_id)
    Visuals.erase(player_id, "dialogue_backdrop_" .. tostring(player_id))
end

-- Dialogue owns a real PlayerControl session while it handles button input.
-- An explicit parent_session permits a Talk menu to keep its original capture
-- and to recover its selection when this child dialogue finishes.
local function begin_session(player_id, opts)
    if opts.input_mode == C.InputMode.OVERLAY_ONLY then return nil end
    local parent = opts.parent_session
    local options = {profile = "menu", owner = "net-games:dialogue", parent = parent,
        capture = parent == nil, handoff_free_camera = opts.handoff_free_camera == true}
    return PlayerControl.begin(player_id, options)
end

local function guard_session(session, seconds)
    if session and session:is_current() then
        session:guard_input(seconds or 0.10, {"Confirm", "Cancel"})
    end
end

local function session_button(session, action)
    if not session then return false end
    local ctrl, owner = session:input()
    return ctrl and ctrl:is_action_pressed(action, owner) or false
end

local function default_opts()
    return {
        x = 8, y = 110, w = 224, h = 42,
        font = "THICK",
        scale = 2.0,
        z = 100,
        typing_speed = 30,
        page_advance = C.PageAdvance.WAIT_FOR_CONFIRM,
        advance_delay = 2.0,
        confirm_during_typing = true,
        input_mode = C.InputMode.DIALOGUE_OWNS_INPUT,
        cancel_behavior = "battle_network",
        debug = false,
    }
end

local function merge(a, b)
    if b then for k, v in pairs(b) do a[k] = v end end
    return a
end

local function mk_box_id(player_id, ui)
    return (ui and ui.box_id and tostring(ui.box_id)) or ("ng_dialogue_" .. tostring(player_id))
end

local function close_instance(player_id, reason)
    local inst = Dialogue.instances[player_id]
    if not inst or inst.closing then return end

    inst.closing = true
    inst.close_reason = reason

    local bd = inst.box_id and Displayer.Text.getTextBoxData(player_id, inst.box_id) or nil
    if bd and inst.ui and inst.ui.nameplate then
        -- Nameplate owns its own close animation. Text teardown can proceed in
        -- parallel; the input lock remains until the textbox registry entry is gone.
        pcall(Displayer.Nameplate.begin_close, player_id, nil, bd, inst.ui.nameplate)
    end

    if inst.box_id then
        Displayer.Text.closeTextBox(player_id, inst.box_id)
    end

    guard_session(inst.control_session, 0.10)

    if inst.opts and inst.opts.debug then
        print("[Dialogue] begin-close player=" .. tostring(player_id) .. " reason=" .. tostring(reason))
    end
end

local function finish_instance(player_id, inst)
    if inst.finished then return end
    inst.finished = true
    -- Remove the record and release ownership BEFORE running user callbacks.
    -- Callbacks may synchronously open another prompt or dialogue using the same box.
    if Dialogue.instances[player_id] == inst then Dialogue.instances[player_id] = nil end
    if inst.backdrop_id and not inst.keep_backdrop then
        erase_backdrop(player_id)
        inst.backdrop_id = nil
    end
    local session = inst.control_session
    if session and session:is_alive() then
        guard_session(session, 0.10)
        session:close()
    end
    if inst.on_complete and not inst._on_complete_ran then
        inst._on_complete_ran = true
        local ok, err = pcall(inst.on_complete)
        if not ok then print("[Dialogue] completion callback error: "..tostring(err)) end
    end
end

local function attach_tick()
    if Dialogue._tick_attached then return end
    Dialogue._tick_attached = true

    Net:on("tick", function(_event)
        for player_id, inst in pairs(Dialogue.instances) do
            local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
            local state = bd and Displayer.Text.getTextBoxState(player_id, inst.box_id)
            local session = inst.control_session
            if inst.backdrop_id then
                Visuals.update(player_id, inst.backdrop_id, inst.visual_ui, state)
            end
            if not bd then
                finish_instance(player_id, inst)
            elseif inst.closing then
                -- The visual teardown may last multiple ticks. Maintain capture
                -- until the box is truly absent; never reclaim ownership here.
                guard_session(session, 0.05)
            elseif not session or session:is_current() then
                if inst.opts.finish_on_waiting and state == "waiting"
                    and (bd.current_page or 1) >= (bd.page_count or 1) then
                    finish_instance(player_id, inst)
                elseif session then
                    if state == "waiting" and inst.last_state ~= "waiting" then
                        guard_session(session, 0.08)
                    end
                    inst.last_state = state
                    if session_button(session, "Cancel") then
                        local behavior = (inst.opts and inst.opts.cancel_behavior) or "battle_network"
                        if behavior == "close_dialogue" then
                            close_instance(player_id, "cancel")
                        elseif behavior == "battle_network" and state == "printing"
                            and inst.opts.confirm_during_typing then
                            Displayer.Text.advanceTextBox(player_id, inst.box_id)
                        end
                    elseif session_button(session, "Confirm") then
                        if state == "printing" then
                            if inst.opts.confirm_during_typing then
                                Displayer.Text.advanceTextBox(player_id, inst.box_id)
                            end
                        elseif state == "waiting" then
                            Displayer.Text.advanceTextBox(player_id, inst.box_id)
                            if Displayer.Text.getTextBoxState(player_id, inst.box_id) == "completed" then
                                if inst.opts.keep_textbox_on_complete then
                                    finish_instance(player_id, inst)
                                else
                                    close_instance(player_id, "finish")
                                end
                            end
                        elseif state == "completed" then
                            if inst.opts.keep_textbox_on_complete then
                                finish_instance(player_id, inst)
                            else
                                close_instance(player_id, "finish")
                            end
                        end
                    end
                end
            end
        end
    end)
end

function Dialogue.is_active(player_id)
    return Dialogue.instances[player_id] ~= nil
end

function Dialogue.prompt_yesno(player_id, opts)
    return Prompt.yesno(player_id, opts)
end

function Dialogue.prompt_menu(player_id, opts)
    return PromptVertical.menu(player_id, opts)
end

function Dialogue.start(player_id, script, opts)
    attach_tick()

    local old = Dialogue.instances[player_id]
    if old then
        -- Replacements must release their old session without destroying the
        -- textbox if the next screen will reuse it. Different IDs must be closed.
        local next_ui = opts and (opts.ui or opts.textbox)
        local next_id = mk_box_id(player_id, next_ui)
        Dialogue.instances[player_id] = nil
        old.finished = true
        if old.backdrop_id then pcall(erase_backdrop, player_id) end
        if old.box_id ~= next_id then
            pcall(Displayer.Text.closeTextBox, player_id, old.box_id)
        end
        if old.control_session and old.control_session:is_alive() then old.control_session:close() end
    end

    local o = merge(default_opts(), opts or {})
    local ui = o.ui or o.textbox

    if ui then
        if ui.font ~= nil then o.font = ui.font end
        if ui.scale ~= nil then o.scale = ui.scale end
        if ui.z ~= nil then o.z = ui.z end
        if ui.typing_speed ~= nil then o.typing_speed = ui.typing_speed end
        if ui.type_sfx_path ~= nil then o.type_sfx_path = ui.type_sfx_path end
        if ui.type_sfx_min_dt ~= nil then o.type_sfx_min_dt = ui.type_sfx_min_dt end

        local backdrop = ui.backdrop or ui.backdrop_config
        if backdrop then
            local px, py = backdrop.padding_x or 0, backdrop.padding_y or 0
            if backdrop.x ~= nil then o.x = backdrop.x + px end
            if backdrop.y ~= nil then o.y = backdrop.y + py end
            if backdrop.width ~= nil then o.w = backdrop.width - (px * 2) end
            if backdrop.height ~= nil then o.h = backdrop.height - (py * 2) end
        end
    end

    local control_session, control_error = begin_session(player_id, o)
    if o.input_mode ~= C.InputMode.OVERLAY_ONLY and not control_session then
        return nil, control_error
    end
    if control_session then
        guard_session(control_session, o.from_prompt and 0.05 or 0.10)
    end

    local pages = {}
    if type(script) == "string" then
        pages = { script }
    elseif type(script) == "table" and script.pages then
        for _, p in ipairs(script.pages) do pages[#pages + 1] = tostring((type(p) == "table" and p.text) or p or "") end
    elseif type(script) == "table" then
        for _, p in ipairs(script) do pages[#pages + 1] = tostring(p or "") end
    else
        pages = { "" }
    end
    -- Preserve script-level pages instead of flattening them into ordinary lines.
    local full_text = table.concat(pages, "{end_page}")

    local box_id = mk_box_id(player_id, ui)
    local backdrop = ui and (ui.backdrop or ui.backdrop_config) or nil
    local reuse = o.reuse_existing_box == true
    local existing = Displayer.Text.getTextBoxData(player_id, box_id)
    local can_reuse = reuse and existing and existing.marked_for_removal ~= true

    local text_options = {
        font = o.font,
        scale = o.scale,
        z = o.z,
        speed = o.typing_speed,
        type_sound = o.type_sfx_path,
        type_sound_min_dt = o.type_sfx_min_dt,
        max_lines = backdrop and backdrop.max_lines or nil,
    }

    local visual_ui = {
        x = o.x, y = o.y, w = o.w, h = o.h,
        font = o.font, scale = o.scale, z = o.z,
        backdrop = backdrop, mugshot = ui and ui.mugshot,
    }
    local x_v, y_v, w_v, h_v = Visuals.text_rect(visual_ui)
    local backdrop_id = draw_backdrop(player_id, visual_ui)

    if can_reuse then
        TextDisplay:resetTextBox(player_id, box_id, full_text, {
            x = x_v, y = y_v, width = w_v, height = h_v,
            font = o.font, scale = o.scale, z = o.z,
            speed = o.typing_speed,
            type_sound = o.type_sfx_path,
            type_sound_min_dt = o.type_sfx_min_dt,
            max_lines = backdrop and backdrop.max_lines or nil,
        })
    else
        Displayer.Text.createTextBox(player_id, box_id, full_text, x_v, y_v, w_v, h_v, text_options)
    end

    if (not can_reuse) and ui and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(player_id, box_id)
        if bd then Displayer.Nameplate.attach(player_id, nil, box_id,
            Visuals.nameplate_box_data(visual_ui, bd), ui.nameplate) end
    end

    if not Displayer.Text.getTextBoxData(player_id, box_id) then
        if control_session then control_session:close() end
        if backdrop_id then erase_backdrop(player_id) end
        return nil, "Displayer did not create dialogue textbox"
    end

    Dialogue.instances[player_id] = {
        player_id = player_id,
        box_id = box_id,
        opts = o,
        script = script,
        ui = ui,
        closing = false,
        on_complete = o.on_complete or o.on_finish,
        _on_complete_ran = false,
        control_session = control_session,
        backdrop_id = backdrop_id,
        visual_ui = visual_ui,
        keep_backdrop = o.keep_backdrop == true,
    }

    local inst = Dialogue.instances[player_id]
    if control_session then
        control_session:on_close(function()
            if Dialogue.instances[player_id] ~= inst or inst.finished then return end
            inst.finished = true
            Dialogue.instances[player_id] = nil
            if inst.backdrop_id then pcall(erase_backdrop, player_id) end
            pcall(Displayer.Text.closeTextBox, player_id, inst.box_id)
        end)
    end
    return box_id
end

function Dialogue.close(player_id)
    close_instance(player_id, "cancel")
end

Net:on("player_disconnect", function(event)
    local player_id = event and event.player_id
    if not player_id then return end
    local inst = Dialogue.instances[player_id]
    if inst then
        inst.finished = true
        Dialogue.instances[player_id] = nil
        if inst.control_session and inst.control_session:is_alive() then inst.control_session:close() end
    end
end)

return Dialogue
