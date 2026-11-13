-- Talk-mode vertical menu with native PlayerControl parent/child ownership.
-- The menu owns its normal UI session. Confirmations and follow-up text
-- temporarily take CHILD sessions, then yield back to the same menu and its
-- previous selection. No secondary input listener or repeating lock calls.

local Talk = require("scripts/net-games/npcs/talk")
local TalkPresets = require("scripts/net-games/npcs/talk_presets")
local Dialogue = require("scripts/net-games/dialogue/dialogue")
local Prompt = require("scripts/net-games/dialogue/prompt")
local PromptVertical = require("scripts/net-games/dialogue/prompt_vertical")

local TalkVertMenu = {}
local flows = {}
local tick_attached = false

local function play_sfx(player_id, path)
    if not path then return end
    Net.provide_asset_for_player(player_id, path)
    if Net.play_sound_for_player then
        pcall(Net.play_sound_for_player, player_id, path)
    elseif Net.play_sound then
        pcall(Net.play_sound, path)
    end
end

local function set_menu_locked(menu, locked)
    if menu and type(menu.set_locked) == "function" then
        menu:set_locked(locked == true)
    end
end

local function set_indicator(ui, enabled)
    if ui and ui.backdrop and ui.backdrop.indicator then
        ui.backdrop.indicator.enabled = enabled == true
    end
end

local function apply_default_layout_frame(talk_cfg, layout)
    layout = layout or {}
    if layout.frame ~= nil then return layout end
    local key = talk_cfg and talk_cfg.frame
    local frame = type(key) == "table" and key or (TalkPresets.frames[key] or nil)
    if frame then
        layout.frame = {r = frame.r, g = frame.g, b = frame.b, a = frame.a,
            color_mode = frame.color_mode}
    end
    return layout
end

local function pending_menu(pid, state)
    return state and state.menu and state.menu.control_session
        and state.menu.control_session:is_alive()
end

-- A returning dialogue keeps the underlying textbox so that the next
-- selection/confirmation can reuse the window without a close/open flicker.
local function say_with_menu(pid, state, text, finish_on_waiting, on_done)
    if flows[pid] ~= state or not pending_menu(pid, state) then
        flows[pid] = nil
        return nil, "menu session no longer available"
    end
    set_indicator(state.ui, true)
    local box_id, err = Dialogue.start(pid, {text}, {
        reuse_existing_box = true,
        parent_session = state.menu.control_session,
        ui = state.ui,
        keep_textbox_on_complete = true,
        finish_on_waiting = finish_on_waiting == true,
        on_complete = function()
            if flows[pid] == state and on_done then on_done() end
        end,
    })
    if not box_id then
        print("[TalkVertMenu] could not start child dialogue: "..tostring(err))
        set_menu_locked(state.menu, false)
    end
    return box_id, err
end

local function ask_for_more(pid, state, text)
    -- The old menu resumes immediately when the second line is fully printed,
    -- without requiring a second confirmation press.
    say_with_menu(pid, state, text, true, function()
        set_indicator(state.ui, false)
        set_menu_locked(state.menu, false)
    end)
end

local function show_post_selection(pid, state, choice_id, choice_text)
    local flow = state.flow
    if flow.post_select.enabled == false or state.post_skip[choice_id] then
        set_menu_locked(state.menu, false)
        return
    end
    local fmt = flow.post_select.text_format or 'You got "%s".'
    say_with_menu(pid, state, string.format(fmt, choice_text), false, function()
        ask_for_more(pid, state, flow.after_yes_text or flow.after_text
            or "Thank you!{p_1} Is there anything else you'd like?")
    end)
end

local function begin_confirmation(pid, state, choice_id, choice_text)
    local flow = state.flow
    local menu = state.menu
    if not pending_menu(pid, state) then return end
    local fmt = flow.confirm.text_format or 'Are you sure you want "%s"?'
    local box_id, err = Prompt.yesno(pid, {
        ui = state.ui,
        parent_session = menu.control_session,
        reuse_existing_box = true,
        question = string.format(fmt, choice_text),
        cancel_behavior = "select_no",
        on_yes = function()
            if flows[pid] ~= state then return end
            play_sfx(pid, flow.sfx.confirm)
            show_post_selection(pid, state, choice_id, choice_text)
        end,
        on_no = function()
            if flows[pid] ~= state then return end
            play_sfx(pid, flow.sfx.close)
            ask_for_more(pid, state, flow.after_no_text or flow.after_text
                or "Is there anything else you'd like?")
        end,
    })
    if not box_id then
        print("[TalkVertMenu] confirmation could not open: "..tostring(err))
        set_menu_locked(menu, false)
    end
end

local function ensure_tick()
    if tick_attached then return end
    tick_attached = true
    Net:on("tick", function()
        for pid, state in pairs(flows) do
            if state.exiting and not PromptVertical.instances[pid] then
                state.exiting = false
                set_indicator(state.ui, true)
                local box_id, err = Dialogue.start(pid,
                    {state.flow.exit_goodbye_text or "Thanks for stopping by!"}, {
                        reuse_existing_box = true,
                        ui = state.ui,
                        on_complete = function()
                            if flows[pid] == state then flows[pid] = nil end
                        end,
                    })
                if not box_id then
                    print("[TalkVertMenu] goodbye could not open: "..tostring(err))
                    flows[pid] = nil
                end
            elseif not state.exiting and not pending_menu(pid, state)
                and not Prompt.instances[pid] and not Dialogue.is_active(pid) then
                flows[pid] = nil
            end
        end
    end)
end

Net:on("player_disconnect", function(event)
    if event and event.player_id then flows[event.player_id] = nil end
end)

function TalkVertMenu.is_busy(player_id)
    if not player_id then return false end
    return flows[player_id] ~= nil
        or Prompt.instances[player_id] ~= nil
        or PromptVertical.instances[player_id] ~= nil
        or Dialogue.is_active(player_id)
end

function TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)
    if TalkVertMenu.is_busy(player_id) then return nil, "dialogue or menu already active" end
    ensure_tick()
    talk_cfg = talk_cfg or {}
    menu_cfg = menu_cfg or {}
    local ui = Talk._build_ui(talk_cfg, bot_name or (talk_cfg.name or ""), {mode = "prompt"})
    local flow = menu_cfg.flow or {}
    flow.confirm = flow.confirm or {}
    flow.post_select = flow.post_select or {}
    flow.sfx = flow.sfx or {}
    local state = {
        ui = ui, flow = flow,
        exit_id = menu_cfg.exit_id or "exit",
        confirm_skip = flow.confirm.skip_ids or {},
        post_skip = flow.post_select.skip_ids or {},
        menu = nil, exiting = false,
    }
    local menu_id, err = PromptVertical.menu(player_id, {
        reuse_existing_box = true,
        keep_textbox = true,
        ui = ui,
        layout = apply_default_layout_frame(talk_cfg, menu_cfg.layout or {}),
        assets = menu_cfg.assets,
        question = tostring(menu_cfg.intro_text or "Choose:"),
        options = menu_cfg.options or {{id = state.exit_id, text = "Exit"}},
        default_index = tonumber(menu_cfg.default_index or 1) or 1,
        cancel_behavior = menu_cfg.cancel_behavior or "jump_to_exit",
        exit_index = menu_cfg.exit_index and tonumber(menu_cfg.exit_index) or nil,
        keep_menu_open = flow.keep_menu_open ~= false,
        selection_behavior = "callback_only",
        lock_dim_alpha = tonumber(flow.lock_dim_alpha or 0.35) or 0.35,
        hide_cursor_when_locked = flow.hide_cursor_when_locked ~= false,
        on_choose = function(choice, index, menu)
            if flows[player_id] ~= state then return end
            state.menu = menu
            local choice_id = (choice and choice.id) or index
            local choice_text = tostring(choice and choice.text or "???")
            if choice_id == state.exit_id then
                play_sfx(player_id, flow.sfx.close)
                state.exiting = true
                PromptVertical.close(player_id, "exit", {keep_textbox = true})
                return
            end
            play_sfx(player_id, flow.sfx.desc)
            set_menu_locked(menu, true)
            if flow.confirm.enabled == false or state.confirm_skip[choice_id] then
                show_post_selection(player_id, state, choice_id, choice_text)
            else
                begin_confirmation(player_id, state, choice_id, choice_text)
            end
        end,
    })
    if not menu_id then return nil, err end
    state.menu = PromptVertical.instances[player_id]
    flows[player_id] = state
    return menu_id
end

return TalkVertMenu
