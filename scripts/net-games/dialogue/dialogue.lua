-- scripts/net-games/dialogue/dialogue.lua
-- Hardened net-games dialogue lifecycle.
-- Keeps the creator-side Displayer architecture while preserving production
-- behavior learned from shadis_hp: held-input handoff protection, real visual
-- teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

require("scripts/net-games/main")

local Displayer   = require("scripts/displayer/displayer")
local TextDisplay = require("scripts/displayer/text-display")
local Input       = require("scripts/input/input")
local C           = require("scripts/net-games/dialogue/constants")
local Prompt      = require("scripts/net-games/dialogue/prompt")
local PromptVertical = require("scripts/net-games/dialogue/prompt_vertical")

local Dialogue = {}
Dialogue.instances = {}

local LISTENER_ATTACHED = false

local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"
local player_backdrop_sprite = {}

local function ensure_backdrop_sprite(player_id)
    if player_backdrop_sprite[player_id] then return true end
    if Net.has_asset then
        local ok, exists = pcall(Net.has_asset, BACKDROP_TEXTURE)
        if ok and exists == false then return false end
    end
    Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
    local sprite_id = "dialogue_backdrop_asset_" .. tostring(player_id)
    Net.player_alloc_sprite(player_id, sprite_id, { texture_path = BACKDROP_TEXTURE })
    player_backdrop_sprite[player_id] = sprite_id
    return true
end

local function draw_backdrop(player_id, backdrop, z)
    if not backdrop or not ensure_backdrop_sprite(player_id) then return nil end
    local sprite_id = player_backdrop_sprite[player_id]
    local draw_id = "dialogue_backdrop_" .. tostring(player_id)
    Net.player_draw_sprite(player_id, sprite_id, {
        id = draw_id,
        x = math.floor(((backdrop.x or 0) * 2) + 0.5),
        y = math.floor(((backdrop.y or 0) * 2) + 0.5),
        z = (z or 100) - 1,
        sx = (backdrop.width or 240) * 2,
        sy = (backdrop.height or 160) * 2,
        r = backdrop.r or 0,
        g = backdrop.g or 0,
        b = backdrop.b or 0,
        opacity = backdrop.opacity or 200,
        a = backdrop.a or 255,
        color_mode = backdrop.color_mode or 0,
    })
    return draw_id
end

local function erase_backdrop(player_id)
    Net.player_erase_sprite(player_id, "dialogue_backdrop_" .. tostring(player_id))
end

local function set_input_locked(player_id, locked)
    if not Net then return false end
    if locked and Net.lock_player_input then
        return pcall(Net.lock_player_input, Net, player_id)
    elseif (not locked) and Net.unlock_player_input then
        return pcall(Net.unlock_player_input, Net, player_id)
    end
    return false
end

local function ensure_listener()
    if LISTENER_ATTACHED then return end
    LISTENER_ATTACHED = true
    -- Compatibility Input is now a facade over InputController; this is a no-op
    -- there, but keeping the call preserves the dialogue module's public contract.
    Input.attach_virtual_input_listener()
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

local function gate_handoff_input(player_id, seconds)
    Input.consume(player_id)
    Input.swallow(player_id, seconds or 0.10)
    Input.require_release(player_id, { "confirm", "cancel" })
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

    gate_handoff_input(player_id, 0.10)

    if inst.opts and inst.opts.debug then
        print("[Dialogue] begin-close player=" .. tostring(player_id) .. " reason=" .. tostring(reason))
    end
end

local function finish_instance(player_id, inst)
    -- Visual ownership ends only after the textbox actually disappeared from
    -- TextDisplay. This avoids the closing A/B press leaking into the world/menu.
    if inst.backdrop_id then
        erase_backdrop(player_id)
        inst.backdrop_id = nil
    end

    if inst.on_complete and not inst._on_complete_ran then
        inst._on_complete_ran = true
        pcall(inst.on_complete)
    end

    if inst.opts and inst.opts.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then
        set_input_locked(player_id, false)
    end

    gate_handoff_input(player_id, 0.08)
    Dialogue.instances[player_id] = nil
end

local function attach_tick()
    if Dialogue._tick_attached then return end
    Dialogue._tick_attached = true

    Net:on("tick", function(_event)
        for player_id, inst in pairs(Dialogue.instances) do
            local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
            local state = Displayer.Text.getTextBoxState(player_id, inst.box_id)

            if not bd then
                finish_instance(player_id, inst)
            elseif inst.closing then
                -- Keep all transition input quarantined until teardown finishes.
                Input.consume(player_id)
                Input.swallow(player_id, 0.05)
                Input.require_release(player_id, { "confirm", "cancel" })
            else
                if state == "waiting" and inst.last_state ~= "waiting" then
                    Input.consume(player_id)
                    Input.swallow(player_id, 0.08)
                end
                inst.last_state = state

                if Input.pop(player_id, "cancel") then
                    local behavior = (inst.opts and inst.opts.cancel_behavior) or "battle_network"
                    if behavior == "close_dialogue" then
                        close_instance(player_id, "cancel")
                    elseif behavior == "battle_network" and state == "printing" and inst.opts.confirm_during_typing then
                        Displayer.Text.advanceTextBox(player_id, inst.box_id)
                    end
                elseif Input.pop(player_id, "confirm") then
                    if state == "printing" then
                        if inst.opts.confirm_during_typing then
                            Displayer.Text.advanceTextBox(player_id, inst.box_id)
                        end
                    elseif state == "waiting" then
                        Displayer.Text.advanceTextBox(player_id, inst.box_id)
                        local after = Displayer.Text.getTextBoxState(player_id, inst.box_id)
                        if after == "completed" then close_instance(player_id, "finish") end
                    elseif state == "completed" then
                        close_instance(player_id, "finish")
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
    ensure_listener()
    attach_tick()

    if Dialogue.instances[player_id] then
        -- Replacement is synchronous from the caller's perspective. Clean the old
        -- visual state immediately but preserve the handoff gate for the new box.
        local old = Dialogue.instances[player_id]
        if old.box_id then Displayer.Text.closeTextBox(player_id, old.box_id) end
        if old.backdrop_id then erase_backdrop(player_id) end
        Dialogue.instances[player_id] = nil
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

    if o.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then
        set_input_locked(player_id, true)
    end
    if not o.from_prompt then gate_handoff_input(player_id, 0.10) end

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

    local backdrop_id = backdrop and draw_backdrop(player_id, backdrop, o.z) or nil

    if can_reuse then
        TextDisplay:resetTextBox(player_id, box_id, full_text, {
            x = o.x, y = o.y, width = o.w, height = o.h,
            font = o.font, scale = o.scale, z = o.z,
            speed = o.typing_speed,
            type_sound = o.type_sfx_path,
            type_sound_min_dt = o.type_sfx_min_dt,
            max_lines = backdrop and backdrop.max_lines or nil,
        })
    else
        Displayer.Text.createTextBox(player_id, box_id, full_text, o.x, o.y, o.w, o.h, text_options)
    end

    if (not can_reuse) and ui and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(player_id, box_id)
        if bd then Displayer.Nameplate.attach(player_id, nil, box_id, bd, ui.nameplate) end
    end

    if not Displayer.Text.getTextBoxData(player_id, box_id) then
        if o.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then set_input_locked(player_id, false) end
        if backdrop_id then erase_backdrop(player_id) end
        return nil
    end

    Dialogue.instances[player_id] = {
        player_id = player_id,
        box_id = box_id,
        opts = o,
        script = script,
        ui = ui,
        closing = false,
        on_complete = o.on_complete,
        _on_complete_ran = false,
        backdrop_id = backdrop_id,
    }

    return box_id
end

function Dialogue.close(player_id)
    close_instance(player_id, "cancel")
end

return Dialogue
