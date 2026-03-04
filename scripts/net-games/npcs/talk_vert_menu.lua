--=====================================================
-- talk_vert_menu.lua
-- Talk-mode wrapper for PromptVertical
--=====================================================

local Talk          = require("scripts/net-games/npcs/talk")
local TalkPresets   = require("scripts/net-games/npcs/talk_presets")

local Dialogue      = require("scripts/net-games/dialogue/dialogue")
local Prompt        = require("scripts/net-games/dialogue/prompt")
local PromptVertical= require("scripts/net-games/dialogue/prompt_vertical")

local Displayer     = require("scripts/displayer/displayer")
local Input         = require("scripts/input/input")

local TalkVertMenu = {}

--=====================================================
-- Internal state (per-player)
--=====================================================
local pending_ack = {}
local exit_pending = {}
local confirm_pending = {}
local goodbye_closing = {}

local TICK_ATTACHED = false

--=====================================================
-- Small helpers
--=====================================================
local function play_sfx(player_id, path)
    if not path then return end
    Net.provide_asset_for_player(player_id, path)
    if Net.play_sound_for_player then
        pcall(function() Net.play_sound_for_player(player_id, path) end)
    elseif Net.play_sound then
        pcall(function() Net.play_sound(path) end)
    end
end

local function set_menu_locked(menu, locked)
    if not menu then return end
    if type(menu.set_locked) == "function" then
        menu:set_locked(locked == true)
    end
end

local function set_textbox_indicator(ui, enabled)
    if not (ui and ui.backdrop and ui.backdrop.indicator) then return end
    ui.backdrop.indicator.enabled = enabled and true or false
end

-- ====================================================
-- Reset a text box by creating a new one with the same ID
-- (uses the backdrop coordinates from ui)
-- ====================================================
local function reset_box_text(player_id, box_id, ui, text, indicator_enabled)
    -- Build options table for createTextBox
    local options = {
        font = ui.font,
        scale = ui.scale,
        z = ui.z,
        speed = ui.typing_speed,
        type_sound = ui.type_sfx_path,
        type_sound_min_dt = ui.type_sfx_min_dt,
    }

    if indicator_enabled ~= nil then
        set_textbox_indicator(ui, indicator_enabled)
    end

    -- Use backdrop coordinates (virtual 240×160)
    local x = ui.backdrop and ui.backdrop.x or 1
    local y = ui.backdrop and ui.backdrop.y or 209
    local w = ui.backdrop and ui.backdrop.width or 478
    local h = ui.backdrop and ui.backdrop.height or 104

    Displayer.Text.createTextBox(
        player_id,
        box_id,
        text,
        x, y, w, h,
        options
    )
end

local function resolve_frame(frame_key_or_table)
    if not frame_key_or_table then return nil end
    if type(frame_key_or_table) == "table" then
        return frame_key_or_table
    end
    return TalkPresets.frames[frame_key_or_table] or nil
end

local function apply_default_layout_frame(talk_cfg, layout)
    layout = layout or {}
    if layout.frame ~= nil then return layout end
    local f = resolve_frame(talk_cfg and talk_cfg.frame)
    if f then
        layout.frame = {
            r = f.r, g = f.g, b = f.b, a = f.a,
            color_mode = f.color_mode,
        }
    end
    return layout
end

--=====================================================
-- Tick loop (fixed getTextBoxData → getTextBoxState)
--=====================================================
local function ensure_tick()
    if TICK_ATTACHED then return end
    TICK_ATTACHED = true

    Net:on("tick", function()
        -- Keep input locked until textbox is fully removed
        for player_id, g in pairs(goodbye_closing) do
            local box_id = g.box_id

            if Net.lock_player_input then
                pcall(function() Net.lock_player_input(player_id) end)
            end
            Input.consume(player_id)
            Input.swallow(player_id, 0.05)

            local st = Displayer.Text.getTextBoxState(player_id, box_id)
            if not st or st == "completed" then
                goodbye_closing[player_id] = nil
                if Net.unlock_player_input then
                    pcall(function() Net.unlock_player_input(player_id) end)
                end
                Input.consume(player_id)
                Input.clear_require_release(player_id, { "confirm", "cancel" })
                Input.require_release(player_id, { "confirm", "cancel" })
                Input.swallow(player_id, 0.12)
            end
        end

        -- Deferred EXIT goodbye (only after PromptVertical finalizes)
        for player_id, ex in pairs(exit_pending) do
            if not (PromptVertical.instances and PromptVertical.instances[player_id]) then
                local box_id = ex.box_id
                local ui = ex.ui          -- now contains normalized fields (x,y,w,h)
                local flow = ex.flow

                reset_box_text(player_id, box_id, ui, (flow.exit_goodbye_text or "Thanks for stopping by!"), true)

                pending_ack[player_id] = {
                    box_id = box_id,
                    ui = ui,
                    menu = nil,
                    phase = 1,
                    choice_id = "exit",
                    choice_text = "exit",
                    flow = flow,
                }

                exit_pending[player_id] = nil

                Input.consume(player_id)
                Input.clear_require_release(player_id, { "confirm", "cancel" })
                Input.swallow(player_id, 0.10)
            end
        end

        -- Deferred CONFIRM yes/no
        for player_id, c in pairs(confirm_pending) do
            if PromptVertical.instances and PromptVertical.instances[player_id] then
                confirm_pending[player_id] = nil

                local box_id = c.box_id
                local ui = c.ui
                local menu = c.menu
                local flow = c.flow
                local choice_id = c.choice_id
                local choice_text = c.choice_text

                set_menu_locked(menu, true)

                local qfmt = flow.confirm.text_format or 'Are you sure you want "%s"?'
                Prompt.yesno(player_id, {
                    ui = ui,
                    reuse_existing_box = true,
                    question = string.format(qfmt, choice_text),

                    on_yes = function()
                        play_sfx(player_id, flow.sfx.confirm)
                        local fmt = flow.post_select.text_format or 'You got "%s".'
                        reset_box_text(player_id, box_id, ui, string.format(fmt, choice_text), true)

                        pending_ack[player_id] = {
                            box_id = box_id,
                            ui = ui,
                            menu = menu,
                            phase = 1,
                            choice_id = choice_id,
                            choice_text = choice_text,
                            flow = flow,
                        }
                    end,

                    on_no = function()
                        play_sfx(player_id, flow.sfx.close)

                        if Net.lock_player_input then
                            pcall(function() Net.lock_player_input(player_id) end)
                        end

                        reset_box_text(
                            player_id,
                            box_id,
                            ui,
                            (flow.after_no_text or flow.after_text or "Is there anything else you'd like?"),
                            false
                        )

                        pending_ack[player_id] = {
                            box_id = box_id,
                            ui = ui,
                            menu = menu,
                            phase = 2,
                            choice_id = choice_id,
                            choice_text = choice_text,
                            flow = flow,
                        }
                    end,

                    cancel_behavior = "select_no",
                })
                return
            else
                confirm_pending[player_id] = nil
            end
        end

        -- Pending ACK phases
        for player_id, p in pairs(pending_ack) do
            local st = Displayer.Text.getTextBoxState(player_id, p.box_id)

            if not st or st == "completed" then
                pending_ack[player_id] = nil
            else
                if Net.lock_player_input then
                    pcall(function() Net.lock_player_input(player_id) end)
                end

                if st == "printing" then
                    if Input.pop(player_id, "confirm") then
                        Displayer.Text.advanceTextBox(player_id, p.box_id)
                        Input.consume(player_id)
                        Input.require_release(player_id, { "confirm" })
                    end

                elseif st == "waiting" then
                    if p.phase == 2 then
                        set_textbox_indicator(p.ui, false)
                        if p.menu then
                            set_menu_locked(p.menu, false)
                        end
                        pending_ack[player_id] = nil

                    elseif Input.pop(player_id, "confirm") then
                        Input.consume(player_id)
                        Input.clear_require_release(player_id, { "confirm", "cancel" })
                        Input.swallow(player_id, 0.10)

                        if p.choice_id == "exit" then
                            Displayer.Text.closeTextBox(player_id, p.box_id)
                            pending_ack[player_id] = nil

                            goodbye_closing[player_id] = { box_id = p.box_id }

                            Input.consume(player_id)
                            Input.clear_require_release(player_id, { "confirm", "cancel" })
                            Input.require_release(player_id, { "confirm", "cancel" })
                            Input.swallow(player_id, 0.12)
                            return
                        end

                        reset_box_text(
                            player_id,
                            p.box_id,
                            p.ui,
                            (p.flow.after_yes_text or p.flow.after_text or "Thank you!{p_1} Is there anything else you'd like?"),
                            false
                        )
                        p.phase = 2
                    end
                end
            end
        end
    end)
end

--=====================================================
-- Busy guard
--=====================================================
function TalkVertMenu.is_busy(player_id)
    if not player_id then return false end
    if goodbye_closing[player_id] then return true end
    if pending_ack[player_id] then return true end
    if exit_pending[player_id] then return true end
    if Prompt.instances and Prompt.instances[player_id] then return true end
    if PromptVertical.instances and PromptVertical.instances[player_id] then return true end
    if Dialogue.is_active and Dialogue.is_active(player_id) then return true end
    return false
end

--=====================================================
-- Public API
--=====================================================
function TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)
    ensure_tick()

    talk_cfg = talk_cfg or {}
    menu_cfg = menu_cfg or {}

    local ui = Talk._build_ui(talk_cfg, bot_name or (talk_cfg.name or ""), { mode = "prompt" })
    local box_id = ui.box_id

    local flow = menu_cfg.flow or {}
    flow.confirm = flow.confirm or {}
    flow.post_select = flow.post_select or {}
    flow.sfx = flow.sfx or {}

    local exit_id = menu_cfg.exit_id or "exit"

    local confirm_skip = flow.confirm.skip_ids or {}
    local post_skip = flow.post_select.skip_ids or {}

    local layout = apply_default_layout_frame(talk_cfg, menu_cfg.layout or {})

    PromptVertical.menu(player_id, {
        reuse_existing_box = true,
        keep_textbox = true,

        ui = ui,
        layout = layout,

        assets = menu_cfg.assets,

        question = tostring(menu_cfg.intro_text or "Choose:"),
        options = menu_cfg.options or { { id = exit_id, text = "Exit" } },
        default_index = tonumber(menu_cfg.default_index or 1) or 1,

        cancel_behavior = menu_cfg.cancel_behavior or "jump_to_exit",
        exit_index = menu_cfg.exit_index and tonumber(menu_cfg.exit_index) or nil,

        keep_menu_open = (flow.keep_menu_open ~= false),
        selection_behavior = "callback_only",

        lock_dim_alpha = tonumber(flow.lock_dim_alpha or 0.35) or 0.35,
        hide_cursor_when_locked = (flow.hide_cursor_when_locked ~= false),

        on_choose = function(choice, index, menu)
            if menu then
                menu.lock_dim_alpha = tonumber(flow.lock_dim_alpha or 0.35) or 0.35
                menu.hide_cursor_when_locked = (flow.hide_cursor_when_locked ~= false)
            end

            local choice_id = (choice and choice.id) or index
            local choice_text = tostring(choice and choice.text or "???")

            if choice_id == exit_id then
                play_sfx(player_id, flow.sfx.close)

                -- Store the normalized UI table for later reuse
                exit_pending[player_id] = {
                    box_id = box_id,
                    ui = ui,          -- ui already contains x,y,w,h
                    flow = flow,
                }

                PromptVertical.close(player_id, "exit", { keep_textbox = true })
                return
            end

            play_sfx(player_id, flow.sfx.desc)
            set_menu_locked(menu, true)

            local function do_post_text_then_ack()
                if flow.post_select.enabled == false then
                    set_menu_locked(menu, false)
                    return
                end
                if post_skip[choice_id] then
                    set_menu_locked(menu, false)
                    return
                end

                local fmt = flow.post_select.text_format or 'You got "%s".'
                reset_box_text(player_id, box_id, ui, string.format(fmt, choice_text), true)

                pending_ack[player_id] = {
                    box_id = box_id,
                    ui = ui,
                    menu = menu,
                    phase = 1,
                    choice_id = choice_id,
                    choice_text = choice_text,
                    flow = flow,
                }
            end

            local confirm_enabled = (flow.confirm.enabled ~= false)
            if (not confirm_enabled) or confirm_skip[choice_id] then
                do_post_text_then_ack()
                return
            end

            local qfmt = flow.confirm.text_format or 'Are you sure you want "%s"?'

            confirm_pending[player_id] = {
                box_id = box_id,
                ui = ui,
                menu = menu,
                flow = flow,
                choice_id = choice_id,
                choice_text = choice_text,
            }
        end,
    })
end

return TalkVertMenu