-- scripts/net-games/dialogue/dialogue.lua
require("scripts/net-games/main")

local Displayer = require("scripts/displayer/displayer")
local Input     = require("scripts/input/input")
local C         = require("scripts/net-games/dialogue/constants")
local Prompt    = require("scripts/net-games/dialogue/prompt")
local PromptVertical = require("scripts/net-games/dialogue/prompt_vertical")

local Dialogue = {}
Dialogue.instances = {}

local LISTENER_ATTACHED = false

-- Backdrop handling (solid white sprite)
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"
local player_backdrop_sprite = {}

local function ensure_backdrop_sprite(player_id)
    if player_backdrop_sprite[player_id] then return end
    local sprite_id = "dialogue_backdrop_" .. player_id
    Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
    Net.player_alloc_sprite(player_id, sprite_id, { texture_path = BACKDROP_TEXTURE })
    player_backdrop_sprite[player_id] = sprite_id
end

local function draw_backdrop(player_id, backdrop, z)
    if not backdrop then return nil end
    ensure_backdrop_sprite(player_id)
    local sprite_id = player_backdrop_sprite[player_id]
    local x = backdrop.x or 0
    local y = backdrop.y or 0
    local width = backdrop.width or 240
    local height = backdrop.height or 160
    local r = backdrop.r or 0
    local g = backdrop.g or 0
    local b = backdrop.b or 0
    local opacity = backdrop.opacity or 200
    local a = backdrop.a or 255
    local draw_id = "dialogue_backdrop_" .. player_id
    Net.player_draw_sprite(player_id, sprite_id, {
        id = draw_id,
        x = x * 2,
        y = y * 2,
        z = z - 1,
        sx = width * 2,
        sy = height * 2,
        r = r, g = g, b = b,
        opacity = opacity,
        a = a,
        color_mode = 0,
    })
    return draw_id
end

local function erase_backdrop(player_id)
    Net.player_erase_sprite(player_id, "dialogue_backdrop_" .. player_id)
end

-- Input lock helper
local function set_input_locked(player_id, locked)
    if not Net then
        print("[Dialogue] Net is nil; cannot lock input")
        return false
    end
    if locked then
        if Net.lock_player_input then
            local ok = pcall(Net.lock_player_input, Net, player_id)
            if not ok then print("[Dialogue] input lock FAIL") end
            return ok
        end
        print("[Dialogue] WARNING: Net.lock_player_input missing")
        return false
    else
        if Net.unlock_player_input then
            local ok = pcall(Net.unlock_player_input, Net, player_id)
            return ok
        end
        print("[Dialogue] WARNING: Net.unlock_player_input missing")
        return false
    end
end

local function ensure_listener()
    if LISTENER_ATTACHED then return end
    LISTENER_ATTACHED = true
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
    if not b then return a end
    for k, v in pairs(b) do a[k] = v end
    return a
end

local function mk_box_id(player_id, ui)
    if ui and ui.box_id then
        return tostring(ui.box_id)
    end
    return "ng_dialogue_" .. tostring(player_id)
end

local function close_instance(player_id, reason)
    local inst = Dialogue.instances[player_id]
    if not inst then return end
    if inst.closing then return end

    inst.closing = true
    inst.close_reason = reason

    if inst.box_id then
        Displayer.Text.closeTextBox(player_id, inst.box_id)
    end

    if inst.backdrop_id then
        erase_backdrop(player_id)
    end

    Input.consume(player_id)
    Input.swallow(player_id, 0.10)

    if inst.opts and inst.opts.debug then
        print("[Dialogue] begin-close player=" .. tostring(player_id) .. " reason=" .. tostring(reason))
    end
end

local function attach_tick()
    if Dialogue._tick_attached then return end
    Dialogue._tick_attached = true

    Net:on("tick", function(event)
        for player_id, inst in pairs(Dialogue.instances) do
            local bd = Displayer.Text.getTextBoxData(player_id, inst.box_id)
            local state = Displayer.Text.getTextBoxState(player_id, inst.box_id)

            if not bd then
                if inst.on_complete and not inst._on_complete_ran then
                    inst._on_complete_ran = true
                    pcall(inst.on_complete)
                end
                if inst.opts and inst.opts.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then
                    set_input_locked(player_id, false)
                end
                Dialogue.instances[player_id] = nil
            else
                if inst.closing then
                    Input.consume(player_id)
                    Input.swallow(player_id, 0.05)
                else
                    if state == "waiting" and inst.last_state ~= "waiting" then
                        Input.consume(player_id)
                        Input.swallow(player_id, 0.08)
                    end
                    inst.last_state = state

                    -- Cancel (B)
                    if Input.pop(player_id, "cancel") then
                        local beh = (inst.opts and inst.opts.cancel_behavior) or "battle_network"
                        if beh == "close_dialogue" then
                            close_instance(player_id, "cancel")
                        elseif beh == "battle_network" then
                            if state == "printing" then
                                if inst.opts.confirm_during_typing then
                                    Displayer.Text.advanceTextBox(player_id, inst.box_id)
                                end
                            end
                        end
                    -- Confirm (A)
                    elseif Input.pop(player_id, "confirm") then
                        if state == "printing" then
                            if inst.opts.confirm_during_typing then
                                Displayer.Text.advanceTextBox(player_id, inst.box_id)
                            end
                        elseif state == "waiting" then
                            Displayer.Text.advanceTextBox(player_id, inst.box_id)
                            local bd2 = Displayer.Text.getTextBoxData(player_id, inst.box_id)
                            local st2 = Displayer.Text.getTextBoxState(player_id, inst.box_id)
                            if not bd2 or st2 == "completed" then
                                close_instance(player_id, "finish")
                            end
                        elseif state == "completed" then
                            close_instance(player_id, "finish")
                        end
                    end
                end
            end
        end
    end)
end

-- Public API
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
    if _G and _G.NG_TEXTBOX_DEBUG then
        print("[TBDBG] Dialogue.start player=" .. tostring(player_id) .. " active=" .. tostring(Dialogue.instances[player_id] ~= nil))
    end

    if Dialogue.instances[player_id] then
        close_instance(player_id, "cancel")
    end

    local o = merge(default_opts(), opts or {})

    if o.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then
        local ok = set_input_locked(player_id, true)
        if o.debug then
            print("[Dialogue] set_input_locked(true) => " .. tostring(ok))
        end
    end

    if not o.from_prompt then
        Input.consume(player_id)
        Input.swallow(player_id, 0.10)
    end

    local pages = {}
    if type(script) == "string" then
        pages = { script }
    elseif type(script) == "table" then
        if script.pages then
            for _, p in ipairs(script.pages) do
                table.insert(pages, p.text or "")
            end
        else
            for _, p in ipairs(script) do
                table.insert(pages, tostring(p))
            end
        end
    else
        pages = { "" }
    end
    local full_text = table.concat(pages, "\n")

    local ui = o.ui or o.textbox or nil
    if ui then
        if ui.font         then o.font = ui.font end
        if ui.scale        then o.scale = ui.scale end
        if ui.z            then o.z = ui.z end
        if ui.typing_speed then o.typing_speed = ui.typing_speed end
        if ui.type_sfx_path   then o.type_sfx_path = ui.type_sfx_path end
        if ui.type_sfx_min_dt then o.type_sfx_min_dt = ui.type_sfx_min_dt end

        if ui.backdrop then
            if ui.backdrop.x then
                o.x = ui.backdrop.x + (ui.backdrop.padding_x or 0)
            end
            if ui.backdrop.y then
                o.y = ui.backdrop.y + (ui.backdrop.padding_y or 0)
            end
            if ui.backdrop.width then
                o.w = ui.backdrop.width - ((ui.backdrop.padding_x or 0) * 2)
            end
            if ui.backdrop.height then
                o.h = ui.backdrop.height - ((ui.backdrop.padding_y or 0) * 2)
            end
        end
    end

    if o.debug then
        print("[Dialogue] ui.font=" .. tostring(ui and ui.font) .. " -> o.font=" .. tostring(o.font))
    end

    local box_id = mk_box_id(player_id, ui)
    local backdrop = (ui and (ui.backdrop or ui.backdrop_config)) or nil
    local reuse = (o.reuse_existing_box == true)
    local existing_bd = Displayer.Text.getTextBoxData(player_id, box_id)
    local can_reuse = reuse and existing_bd ~= nil and existing_bd.marked_for_removal ~= true

    -- Options for createTextBox
    local text_options = {
        font = o.font,
        scale = o.scale,
        z = o.z,
        speed = o.typing_speed,
        type_sound = o.type_sfx_path,
        type_sound_min_dt = o.type_sfx_min_dt,
    }

    -- Draw backdrop if provided
    local backdrop_id = nil
    if backdrop then
        backdrop_id = draw_backdrop(player_id, backdrop, o.z)
    end

    -- Create or reset text box
    if can_reuse then
        -- Simply create again (overwrites)
        Displayer.Text.createTextBox(player_id, box_id, full_text, o.x, o.y, o.w, o.h, text_options)
    else
        Displayer.Text.createTextBox(player_id, box_id, full_text, o.x, o.y, o.w, o.h, text_options)
    end

    -- Attach nameplate if provided and not reusing
    if not can_reuse and ui and ui.nameplate then
        local bd = Displayer.Text.getTextBoxData(player_id, box_id)
        if bd then
            Displayer.Nameplate.attach(player_id, nil, box_id, bd, ui.nameplate)
        end
    end

    local bd = Displayer.Text.getTextBoxData(player_id, box_id)
    if not bd then
        if o.input_mode == C.InputMode.DIALOGUE_OWNS_INPUT then
            set_input_locked(player_id, false)
        end
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

    if o.debug then
        print("[Dialogue] start OK player=" .. tostring(player_id) .. " box_id=" .. tostring(box_id) .. " reuse=" .. tostring(can_reuse))
    end

    return box_id
end

function Dialogue.close(player_id)
    close_instance(player_id, "cancel")
end

return Dialogue