-- FootBomb Controller and match-instance entry point.
-- Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

local logger = require("scripts/ezlibs-scripts/ezlogger").get("footbomb")
local object_registry = require("scripts/ezlibs-scripts/object_registry")
local EzMapInstance = require("scripts/ezlibs-scripts/ezmapinstance")
local games = require("scripts/net-games/main")
local UISafe = require("scripts/net-games/ui-safe")
local EzExplosions = require("scripts/ezlibs-scripts/ezexplosions")
local TextLayout = require("scripts/displayer/text-layout")
local InputAPI = require("scripts/input-controller/main")
local Boom = require("scripts/boom/main")
local EzBus = require("scripts/ezlibs-scripts/ezbus")
local EventEmitter = require("scripts/ezlibs-scripts/ezemitter")

local Config = require("scripts/ezlibs-custom/footbomb/constants")
local AnimationStates = require("scripts/ezlibs-custom/footbomb/animation_states")
local NAVI_OPTIONS = require("scripts/ezlibs-custom/footbomb/navi_options")
local BOMB_OPTIONS = require("scripts/ezlibs-custom/footbomb/bomb_options")
local WorldAttachment = require("scripts/world-attachment")
local ResultTimeline = require("scripts/ezlibs-custom/footbomb/result_timeline")
local SfxDriver = require("scripts/ezlibs-custom/footbomb/sfx_driver")
local Displayer = require("scripts/displayer/displayer")

local FootBomb = {}
local State = require("scripts/ezlibs-custom/footbomb/state")




local BOMB_PREVIEW_ANIMATION = AnimationStates.BOMB_PREVIEW





-- Role panel (9-slice box + icons + text). Coordinates are in the same raw
-- pixel space used by Net.player_draw_sprite (480x320), which matches the
-- displayer's getScreenDimensions(). The current role text was at Y≈142 in
-- the 240x160 logical space used by games.draw_text, so the equivalent raw
-- pixel Y is near the bottom of the 320-tall raw screen.

-- Build role-specific 9-slice styles once. Both textures share the same
-- role-box-9slice.animation slicing definition; only the artwork differs.
-- Asset loading remains lazy inside sliced-sprite.lua.
local role_panel_styles = {
    Kicker = Displayer.Builder.sliceStyle9(
        Config.ASSETS.ROLE_PANEL_TEXTURE_KICKER,
        Config.ASSETS.ROLE_PANEL_ANIMATION
    ),
    Defender = Displayer.Builder.sliceStyle9(
        Config.ASSETS.ROLE_PANEL_TEXTURE_DEFENDER,
        Config.ASSETS.ROLE_PANEL_ANIMATION
    ),
}



local function log(message)
    logger:info("[footbomb] " .. tostring(message))
end

-- Shorthand for async/await
local function async(p)
  local co = coroutine.create(p)
  return Async.promisify(co)
end
local function await(v) return Async.await(v) end

-- FootBomb parses each Navi animation once and reuses the parsed result across
-- rounds. This cache is populated eagerly during round setup (see
-- prime_round_bot_animations) so the result-planning block never stalls on a
-- cold Boom.load. That keeps the BOMB_LAUNCHED THUD in the same server tick as
-- the bomb's first movement keyframe instead of trailing behind a parse.
local footbomb_animation_cache = {}
local function get_footbomb_animation(path)
    if type(path) ~= "string" or path == "" then
        return nil, "animation path is missing"
    end
    local cached = footbomb_animation_cache[path]
    if cached then return cached end
    local ok, animation, load_error = pcall(Boom.load, path)
    if not ok or type(animation) ~= "table" then
        return nil, tostring(load_error or animation)
    end
    if animation.version ~= "2.0" then
        return nil, "expected v2.0 animation, detected v" .. tostring(animation.version)
    end
    footbomb_animation_cache[path] = animation
    return animation
end

-- ---------------------------------------------------------------------------
-- Semantic round-phase events
--
-- Emitted on a per-round EzBus that exists from resolve_round_winner's start
-- until that round's transition out. Subscribers (SFX, effects, camera,
-- diagnostics, analytics) can react to phase transitions without any code
-- in resolve_round_winner needing to know who is listening.
--
-- The bus is destroyed at the end of each round (see destroy_round_events),
-- which also tears down all listeners. SfxDriver re-attaches fresh each round.
-- ---------------------------------------------------------------------------

State.round_events = State.round_events or {}

local ROUND_EVENT = {
    KICKER_STEP_STARTED         = "kicker_step_started",
    KICKER_STEP_COMPLETE        = "kicker_step_complete",
    KICKER_IDLE_STARTED         = "kicker_idle_started",

    DEFENDER_JUMP_LAUNCHED      = "defender_jump_launched",
    DEFENDER_LANDING_FRAME      = "defender_landing_frame",
    DEFENDER_ARC_COMPLETE       = "defender_arc_complete",
    DEFENDER_HOLD_STARTED       = "defender_hold_started",

    BOMB_LAUNCHED               = "bomb_launched",
    BOMB_CATCH_CONTACT          = "bomb_catch_contact",
    BOMB_TARGET_REACHED         = "bomb_target_reached",
    BOMB_EXPLODING              = "bomb_exploding",

    ROUND_RESPONSE_COMPLETE     = "round_response_complete",
    ROUND_HOLD_COMPLETE         = "round_hold_complete",
    ROUND_CAMERA_FADE_STARTED   = "round_camera_fade_started",
    ROUND_CAMERA_FADED          = "round_camera_faded",
    ROUND_COMPLETE              = "round_complete",
}

local function ensure_round_events(instance_id)
    if not instance_id then return nil end
    local events = State.round_events[instance_id]
    if not events then
        events = EzBus.new()
        State.round_events[instance_id] = events
    end
    return events
end

local function get_round_events(instance_id)
    if not instance_id then return nil end
    return State.round_events[instance_id]
end

local function destroy_round_events(instance_id)
    if not instance_id then return end
    local events = State.round_events[instance_id]
    if events then
        events:destroy()
        State.round_events[instance_id] = nil
    end
end


-- ---------------------------------------------------------------------------
-- Role-event infrastructure (forward declarations)
-- ---------------------------------------------------------------------------

State.instance_role_events = State.instance_role_events or {}

local ensure_role_events
local destroy_role_events
local emit_async
local assign_bot_role

EzMapInstance.events:on("created", function(instance_id)
    log("INSTANCE_FLOW: created id=" .. tostring(instance_id))
end)

EzMapInstance.events:on("removed", function(instance_id)
    log("INSTANCE_FLOW: removed id=" .. tostring(instance_id))
end)

EzMapInstance.events:on("player_joined", function(instance_id, player_id)
    log("INSTANCE_FLOW: player joined instance=" .. tostring(instance_id)
        .. " player=" .. tostring(player_id))
end)

EzMapInstance.events:on("player_left", function(instance_id, player_id)
    log("INSTANCE_FLOW: player left instance=" .. tostring(instance_id)
        .. " player=" .. tostring(player_id))
end)

EzMapInstance.events:on("host_changed", function(instance_id, new_host_id, old_host_id)
    if not EzMapInstance.get(instance_id) then
        return
    end
    log("INSTANCE_FLOW: host changed instance=" .. tostring(instance_id)
        .. " new=" .. tostring(new_host_id)
        .. " old=" .. tostring(old_host_id))
end)

local AnimationDiagnostics = require("scripts/ezlibs-custom/footbomb/animation_diagnostics")
if Config.DIAGNOSTICS.RUN_ANIMATION_DIAGNOSTICS then
    local diagnostics_ok, diagnostics_error = pcall(AnimationDiagnostics.run, NAVI_OPTIONS, log)
    if not diagnostics_ok then
        log("ANIM_DIAGNOSTICS: unexpected diagnostic failure: " .. tostring(diagnostics_error))
    end
end

local RESULT_TARGET_BY_DIRECTION = {
    Left = "Bomb 1",
    Up = "Bomb 2",
    Right = "Bomb 3",
}

local function run_direction_mapping_test()
    local directions = { "Left", "Up", "Right" }
    local instance_id = "direction-mapping-test"

    log("RESULT_FLOW: starting direction mapping test instance=" .. instance_id)

    for _, kicker_direction in ipairs(directions) do
        for _, defender_direction in ipairs(directions) do
            local target_name = RESULT_TARGET_BY_DIRECTION[kicker_direction]
            local winner = (kicker_direction == defender_direction)
                and "Defender" or "Kicker"

            log("RESULT_FLOW: starting result animation instance=" .. instance_id
                .. " kicker_direction=" .. kicker_direction
                .. " defender_direction=" .. defender_direction
                .. " predicted_winner=" .. winner
                .. " bomb_target=" .. tostring(target_name))

            log("SCORE_FLOW: direction mapping test kicker_direction=" .. kicker_direction
                .. " defender_direction=" .. defender_direction
                .. " winner=" .. winner
                .. " bomb_target=" .. tostring(target_name))
        end
    end

    log("RESULT_FLOW: direction mapping test complete instance=" .. instance_id)
end

if Config.DIAGNOSTICS.RUN_DIRECTION_MAPPING_TEST then
    run_direction_mapping_test()
end

local function draw_confirm_prompt(player_id, text_id)
    local prompt_width = TextLayout.measureLine(
        Config.UI.CONFIRM_PROMPT,
        { font = "THICK", scale = Config.UI.CONFIRM_PROMPT_SCALE }
    )
    local prompt_x = math.max(
        0, math.floor((Config.UI.SCREEN_WIDTH - prompt_width) / 2)
    )
    pcall(
        games.draw_text,
        text_id, player_id, Config.UI.CONFIRM_PROMPT,
        prompt_x, Config.UI.CONFIRM_PROMPT_Y, 100, "THICK", Config.UI.CONFIRM_PROMPT_SCALE
    )
end

local function hide_role_text(player_id, rep)
    if not rep then return end
    rep.role_text_enabled = false
    rep.role_panel_role = nil
    if rep.role_panel_id then
        pcall(Displayer.SlicedPanel.remove, player_id, rep.role_panel_id)
    end
    if rep.role_text_id then
        pcall(games.remove_text, rep.role_text_id, player_id)
    end
end

-- Build the role panel from a sprite+text+sprite row. Returns the panel
-- object on success, nil on failure. Does NOT touch rep.role_panel_role;
-- that is managed by draw_role_text.
local function build_role_panel(player_id, rep, role)
    if not rep or not role or not rep.role_panel_id then
        return nil
    end
    local role_panel_style = role_panel_styles[role]
    if not role_panel_style then
        log("ROLE_FLOW: no 9-slice style configured for role=" .. tostring(role))
        return nil
    end

    local icon_state = (role == "Kicker")
        and Config.UI.ROLE_ICON_STATE_KICKER
        or  Config.UI.ROLE_ICON_STATE_DEFENDER

    -- Same sprite def used for both left and right icons.
    local icon_sprite = Displayer.Builder.spriteDef(
        Config.ASSETS.ROLE_ICONS_TEXTURE, Config.ASSETS.ROLE_ICONS_ANIMATION, icon_state,
        { sx = 1, sy = 1 }
    )

    local function make_icon_child()
        return Displayer.Builder.panelSpritesChild({ icon_sprite }, {
            sprite_scale = Config.UI.ROLE_ICON_SCALE,
            columns = 1,
            column_spacing = 0,
            row_spacing = 0,
            sprite_align = "center",
            valign = "middle",
        })
    end

    local children = {
        make_icon_child(),
        Displayer.Builder.panelTextChild(tostring(role), {
            font = "THICK",
            scale = Config.UI.ROLE_TEXT_SCALE,
            color = { r = 255, g = 255, b = 255, a = 255 },
            halign = "center",
            valign = "middle",
        }),
        make_icon_child(),
    }

    local options = Displayer.Builder.rowPanelOptions({
        auto_size = true,
        padding = Config.UI.ROLE_PANEL_PADDING,
        -- Inset each icon/text child; sliced-sprite includes these in auto-size.
        child_padding = Config.UI.ROLE_PANEL_CHILD_PADDING,
        -- Explicit main-axis spacing between icon, text, and icon in this row.
        main_axis_spacing = Config.UI.ROLE_ICON_GAP,
        z = 101,
        slice_scale = Config.UI.ROLE_PANEL_SLICE_SCALE,
        children = children,
    })

    -- Create at x=0 first; auto_size must run once to know our width, then
    -- we reposition to the centered X. This is two redraws on the same
    -- logical_id, but only happens at round start / role swap.
    local panel, err = Displayer.SlicedPanel.createWithChildren(
        player_id, rep.role_panel_id,
        0, Config.UI.ROLE_PANEL_Y,
        role_panel_style,
        options
    )
    if not panel then
        log("ROLE_FLOW: role panel build failed player=" .. tostring(player_id)
            .. " role=" .. tostring(role) .. " error=" .. tostring(err))
        return nil
    end

    local panel_width, panel_height = panel:getSize()
    if not panel_width or panel_width <= 0 or not panel_height or panel_height <= 0 then
        log("ROLE_FLOW: role panel has invalid size player=" .. tostring(player_id)
            .. " role=" .. tostring(role)
            .. " w=" .. tostring(panel_width) .. " h=" .. tostring(panel_height))
        Displayer.SlicedPanel.remove(player_id, rep.role_panel_id)
        return nil
    end

    local screen_w = Displayer:getScreenDimensions()  -- 480, 320
    local panel_x = math.max(0, math.floor((screen_w - panel_width) / 2))
    panel:setPosition(panel_x, Config.UI.ROLE_PANEL_Y)
    return panel
end

local function draw_role_text(player_id, rep, role)
    if not rep or not role or State.player_representations[player_id] ~= rep then
        return false
    end
    if rep.role_text_suppressed then
        if rep.role_panel_id then
            pcall(Displayer.SlicedPanel.remove, player_id, rep.role_panel_id)
        end
        if rep.role_text_id then
            pcall(games.remove_text, rep.role_text_id, player_id)
        end
        rep.role_panel_role = nil
        return false
    end
    if rep.role_panel_role == role and rep.role_text_enabled then
        return true
    end

    -- Preferred path: sprite+text sprite panel.
    local panel = build_role_panel(player_id, rep, role)
    if panel then
        rep.role_text_enabled = true
        rep.role_panel_role = role
        return true
    end

    -- Fallback: old text drawing. Keeps the match playable if the panel
    -- assets (role-box-9slice / role-icons) are missing or malformed, so
    -- broken UI assets cannot block gameplay.
    log("ROLE_FLOW: falling back to text role indicator player=" .. tostring(player_id)
        .. " role=" .. tostring(role))
    local label = tostring(role)
    local width = TextLayout.measureLine(label, {
        font = "THICK", scale = Config.UI.ROLE_TEXT_SCALE
    })
    local x = math.max(0, math.floor((Config.UI.SCREEN_WIDTH - width) / 2))
    local ok, err = pcall(
        games.draw_text,
        rep.role_text_id, player_id, label,
        x, Config.UI.ROLE_TEXT_Y, 101, "THICK", Config.UI.ROLE_TEXT_SCALE
    )
    if not ok then
        log("ROLE_FLOW: role text draw failed player="
            .. tostring(player_id) .. " role=" .. label
            .. " error=" .. tostring(err))
        return false
    end
    rep.role_text_enabled = true
    rep.role_panel_role = nil
    return true
end

local function begin_role_text_suppression(player_id)
    local rep = State.player_representations[player_id]
    if not rep then return nil end
    rep.role_text_suppression_count = (rep.role_text_suppression_count or 0) + 1
    rep.role_text_suppressed = true
    if rep.role_panel_id then
        pcall(Displayer.SlicedPanel.remove, player_id, rep.role_panel_id)
    end
    rep.role_panel_role = nil
    if rep.role_text_id then
        pcall(games.remove_text, rep.role_text_id, player_id)
    end
    return rep
end

local function end_role_text_suppression(player_id, rep)
    if not rep or State.player_representations[player_id] ~= rep then return end
    rep.role_text_suppression_count = math.max(
        0, (rep.role_text_suppression_count or 1) - 1
    )
    if rep.role_text_suppression_count > 0 then return end
    rep.role_text_suppressed = false
    if not rep.role_text_enabled then return end
    local bots = State.instance_bots[rep.instance_id]
    local bot = bots and bots[rep.slot]
    if bot then
        draw_role_text(player_id, rep, bot.role)
    end
end

local function await_player_message(player_id, ...)
    local rep = begin_role_text_suppression(player_id)
    local result = await(Async.message_player(player_id, ...))
    end_role_text_suppression(player_id, rep)
    return result
end

local function await_player_quiz(player_id, ...)
    local rep = begin_role_text_suppression(player_id)
    local result = await(Async.quiz_player(player_id, ...))
    end_role_text_suppression(player_id, rep)
    return result
end

local function draw_navi_name(player_id, rep, name)
    local width = TextLayout.measureLine(name, {
        font = "THICK", scale = Config.UI.NAVI_NAME_SCALE
    })
    local x = math.max(0, math.floor((Config.UI.SCREEN_WIDTH - width) / 2))
    pcall(
        games.draw_text, rep.skin_text_id, player_id, name,
        x, ((Config.UI.SCREEN_HEIGHT / 2) + 4), 100, "THICK", Config.UI.NAVI_NAME_SCALE
    )
end

local function as_string(value, fallback)
    if value == nil or value == "" then return fallback end
    return tostring(value)
end

local function as_number(value, fallback)
    local parsed = tonumber(value)
    if parsed == nil then return fallback end
    return parsed
end

local function ensure_area_refs(area_id)
    State.npc_refs[area_id] = State.npc_refs[area_id] or {}
    return State.npc_refs[area_id]
end

local function create_ref_npc(area_id, object)
    if not object then return nil end
    local properties = object.custom_properties or {}
    local asset_name = as_string(properties["Asset Name"], Config.DEFAULTS.ASSET_NAME)
    local animation_name = as_string(properties["Animation Name"], asset_name)
    local mugshot_name = as_string(properties.Mugshot, Config.DEFAULTS.MUGSHOT_NAME)
    local mug_animation_name = as_string(properties["Mug Animation Name"], nil)
    local actor_id = "footbomb-ref-" .. tostring(area_id)
        .. "-" .. tostring(object.id)
    local animation_path = Config.ASSETS.BOT_FOLDER .. animation_name .. ".animation"
    local mug_animation_path =
        mug_animation_name
        and (Config.ASSETS.MUG_FOLDER .. mug_animation_name .. ".animation")
        or Config.ASSETS.DEFAULT_MUG_ANIMATION
    local bot_id = Net.create_bot(actor_id, {
        name = as_string(object.name, "FootBomb Controller"),
        area_id = area_id,
        texture_path = Config.ASSETS.BOT_FOLDER .. asset_name .. ".png",
        animation_path = animation_path,
        animation = AnimationStates.IDLE_DR,
        x = as_number(object.x, 0),
        y = as_number(object.y, 0),
        z = as_number(object.z, 0),
        direction = as_string(properties.Direction, "Down"),
        solid = true, size = 0.2, warp_in = false,
        dont_face_player = properties["Dont Face Player"] == true
    })
    if not bot_id then
        log("Net.create_bot failed for FootBomb Controller object " .. tostring(object.id))
        return nil
    end
    local reference = {
        object = object,
        npc = {
            bot_id = bot_id,
            actor_id = actor_id,
            mug_texture_path = Config.ASSETS.MUG_FOLDER .. mugshot_name .. ".png",
            mug_animation_path = mug_animation_path
        }
    }
    ensure_area_refs(area_id)[tostring(actor_id)] = reference
    ensure_area_refs(area_id)[tostring(bot_id)] = reference
    log("Created FootBomb Controller " .. tostring(bot_id) .. " in " .. tostring(area_id))
    return reference.npc
end

object_registry.register_handler("FootBomb Controller", function(area_id, object)
    create_ref_npc(area_id, object)
end)

local function player_is_available(player_id)
    if player_id == nil then return false end
    if type(Net.is_player) == "function" then
        local ok, result = pcall(Net.is_player, player_id)
        if ok then return result == true end
    end
    if type(Net.get_player_area) == "function" then
        local ok, area = pcall(Net.get_player_area, player_id)
        return ok and area ~= nil
    end
    return false
end

local function find_named_spawn_points(area_id)
    if type(Net.list_objects) ~= "function"
        or type(Net.get_object_by_id) ~= "function" then
        return nil, "Net object lookup is unavailable"
    end
    local ok, object_ids = pcall(Net.list_objects, area_id)
    if not ok or type(object_ids) ~= "table" then
        return nil, "could not list objects in instance area " .. tostring(area_id)
    end
    local found = {}
    local required_names = {
        ["Player 1 Spawn"] = true, ["Player 2 Spawn"] = true,
        ["Kicker"] = true, ["Move Forward"] = true,
        ["Defender 1"] = true, ["Defender 2"] = true, ["Defender 3"] = true,
        ["Bomb"] = true, ["Bomb 1"] = true, ["Bomb 2"] = true, ["Bomb 3"] = true,
        ["Camera Focus"] = true
    }
    for _, object_id in pairs(object_ids) do
        local got, object = pcall(Net.get_object_by_id, area_id, object_id)
        if got and type(object) == "table" then
            local name = object.name
            if required_names[name] and not found[name] then
                local x, y = tonumber(object.x), tonumber(object.y)
                if x and y then
                    found[name] = { x = x, y = y, z = as_number(object.z, 0) }
                end
            end
        end
    end
    local missing = {}
    for _, name in ipairs({
        "Player 1 Spawn", "Player 2 Spawn", "Kicker", "Move Forward",
        "Defender 1", "Defender 2", "Defender 3", "Bomb",
        "Bomb 1", "Bomb 2", "Bomb 3", "Camera Focus"
    }) do
        if not found[name] then missing[#missing + 1] = '"' .. name .. '"' end
    end
    if #missing > 0 then
        return nil, "FootBomb map is missing point object(s): "
            .. table.concat(missing, ", ")
    end
    return {
        found["Player 1 Spawn"],
        found["Player 2 Spawn"],
        Kicker = found["Kicker"],
        MoveForward = found["Move Forward"],
        ["Defender 1"] = found["Defender 1"],
        ["Defender 2"] = found["Defender 2"],
        ["Defender 3"] = found["Defender 3"],
        Bomb = found["Bomb"],
        ["Bomb 1"] = found["Bomb 1"],
        ["Bomb 2"] = found["Bomb 2"],
        ["Bomb 3"] = found["Bomb 3"],
        CameraFocus = found["Camera Focus"]
    }
end

local function safe_remove_bot(bot_id)
    if bot_id then pcall(Net.remove_bot, bot_id, false) end
end

local function set_bot_animation_state(bot_id, animation_state, should_loop)
    local setter = Net.animate_bot
    if type(setter) ~= "function" then
        return false, "bot animation setter is unavailable"
    end
    if should_loop == nil then should_loop = true end
    local ok, result = pcall(setter, bot_id, animation_state, should_loop)
    if not ok or result == false then return false, result end
    return true
end

local function ensure_bot_direction(bot, direction)
    if not bot or not bot.id then return false end
    if type(direction) ~= "string" or direction == "" then return true end
    if bot.current_direction == direction then return true end
    if type(Net.set_bot_direction) ~= "function" then return false end
    local ok, result = pcall(Net.set_bot_direction, bot.id, direction)
    if ok and result ~= false then
        bot.current_direction = direction
        return true
    end
    log("DIR_FLOW: set_bot_direction failed bot=" .. tostring(bot.id)
        .. " direction=" .. tostring(direction)
        .. " error=" .. tostring(result))
    return false
end

local function cancel_hold(bot, reason)
    if not bot then return end
    if bot._hold_token then
        log("HOLD_FLOW: hold cancelled by " .. tostring(reason)
            .. " bot=" .. tostring(bot.id))
        bot._hold_token = nil
    end
end

local function create_match_bots(instance, spawn_points, vs_npc)
    local prefix = "footbomb-match-"
        .. tostring(instance.id):gsub("[^%w_%-]", "_")
    local actor_ids = { prefix .. "-player1", prefix .. "-player2" }
    local labels = {
        "FootBomb Player 1",
        vs_npc and "FootBomb Opponent" or "FootBomb Player 2"
    }
    local created = {}
    for _, option in ipairs(NAVI_OPTIONS) do
        pcall(Net.provide_asset_for_player, instance.host_id, option.texture)
        pcall(Net.provide_asset_for_player, instance.host_id, option.animation)
    end
    for slot = 1, 2 do
        local position = spawn_points[slot]
        local skin_index = (vs_npc and slot == 2)
            and math.random(1, #NAVI_OPTIONS) or 1
        local skin = NAVI_OPTIONS[skin_index]
        local ok, bot_id = pcall(Net.create_bot, actor_ids[slot], {
            name = labels[slot],
            area_id = instance.area_id,
            texture_path = skin.texture,
            animation_path = skin.animation,
            animation = AnimationStates.IDLE_D,
            x = position.x, y = position.y, z = position.z,
            direction = "Down",
            solid = false, size = 0.2, warp_in = false, dont_face_player = true
        })
        if not ok or not bot_id then
            for _, previous in ipairs(created) do safe_remove_bot(previous.id) end
            return nil, "could not create both match bots (slot "
                .. tostring(slot) .. "): " .. tostring(bot_id)
        end
        created[#created + 1] = {
            id = bot_id,
            actor_id = actor_ids[slot],
            area_id = instance.area_id,
            slot = slot,
            current_direction = "Down",
            _round_instance_id = instance.id,
            position = { x = position.x, y = position.y, z = position.z },
            skin_index = skin_index,
            fixed_skin = vs_npc and slot == 2,
            navi_name = skin.name,
            texture_path = skin.texture,
            animation_path = skin.animation,
            mug_texture_path = skin.texture:gsub("%.png$", "-mug.png"),
            mug_animation_path = Config.ASSETS.DEFAULT_MUG_ANIMATION
        }
    end
    State.instance_bots[instance.id] = created
    State.instance_spawn_points[instance.id] = spawn_points
    return created
end

local function provide_match_assets(player_id)
    local provided = 0
    local failed = 0
    local function provide(path)
        if type(path) ~= "string" or path == "" then
            failed = failed + 1
            log("Skipping invalid match asset path for " .. tostring(player_id))
            return
        end
        local ok, result = pcall(Net.provide_asset_for_player, player_id, path)
        if ok and result ~= false then
            provided = provided + 1
        else
            failed = failed + 1
            log("Could not provide match asset to " .. tostring(player_id)
                .. " path=" .. path .. " error=" .. tostring(result))
        end
    end
    for _, option in ipairs(NAVI_OPTIONS) do
        provide(option.texture)
        provide(option.animation)
        provide(option.texture:gsub("%.png$", "-mug.png"))
    end
    provide(Config.ASSETS.DEFAULT_MUG_ANIMATION)
    for _, option in ipairs(BOMB_OPTIONS) do
        provide(Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".png")
        provide(Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".animation")
    end
    provide(Config.ASSETS.CURSOR_SFX)
    provide(Config.ASSETS.CURSOR_TEXTURE)
    provide(Config.ASSETS.CURSOR_ANIMATION)
    provide(Config.ASSETS.THUD_SFX)
    provide(Config.ASSETS.ROLE_PANEL_TEXTURE_KICKER)
    provide(Config.ASSETS.ROLE_PANEL_TEXTURE_DEFENDER)
    provide(Config.ASSETS.ROLE_PANEL_ANIMATION)
    provide(Config.ASSETS.ROLE_ICONS_TEXTURE)
    provide(Config.ASSETS.ROLE_ICONS_ANIMATION)
    log("Match assets provided for " .. tostring(player_id)
        .. ": success=" .. tostring(provided) .. " failed=" .. tostring(failed))
    return failed == 0
end

local function transfer_match_players(instance, player_ids, spawn_points)
    local transferred = {}
    for slot, player_id in ipairs(player_ids) do
        local assets_ready = provide_match_assets(player_id)
        if not assets_ready then
            log("ASSET_FLOW: refusing player transfer because asset preflight failed"
                .. " player=" .. tostring(player_id)
                .. " instance=" .. tostring(instance.id)
                .. " slot=" .. tostring(slot))
            break
        end
        local spawn = spawn_points[slot]
        local ok, result = pcall(
            EzMapInstance.transfer_player,
            instance.id, player_id, spawn.x, spawn.y, spawn.z, false
        )
        if ok and result ~= false then
            transferred[#transferred + 1] = player_id
            local post_ready = provide_match_assets(player_id)
            if not post_ready then
                log("ASSET_FLOW: post-transfer asset delivery reported failures"
                    .. " player=" .. tostring(player_id)
                    .. " instance=" .. tostring(instance.id)
                    .. "; pre-transfer delivery succeeded")
            end
        else
            log("Transfer failed for " .. tostring(player_id)
                .. ": " .. tostring(result))
        end
    end
    return transferred
end

local function remove_instance_bots(instance_id)
    local bots = State.instance_bots[instance_id] or {}
    for _, bot in ipairs(bots) do
        bot._removed = true
        bot._hold_token = nil
        safe_remove_bot(bot.id)
    end
    if bots.bomb_bot then
        bots.bomb_bot._removed = true
        bots.bomb_bot._hold_token = nil
        safe_remove_bot(bots.bomb_bot.id)
    end
    if destroy_role_events then destroy_role_events(instance_id) end
    destroy_round_events(instance_id)
    State.instance_bots[instance_id] = nil
    State.instance_spawn_points[instance_id] = nil
end

local function cleanup_empty_instance(instance)
    if not instance
        or type(instance.player_ids) ~= "table"
        or #instance.player_ids > 0 then
        return
    end
    if not EzMapInstance.get(instance.id) then
        remove_instance_bots(instance.id)
        return
    end
    remove_instance_bots(instance.id)
    local ok, err = EzMapInstance.remove(instance.id)
    if not ok then
        log("Could not remove empty instance "
            .. tostring(instance.id) .. ": " .. tostring(err))
    end
end

EzMapInstance.events:on("player_left", function(instance_id, player_id)
    local record = EzMapInstance.get(instance_id)
    if record
        and record.metadata
        and record.metadata.game == "footbomb"
        and #record.player_ids == 0 then
        cleanup_empty_instance(record)
    end
end)

local function server_asset_file_exists(path)
    if type(path) ~= "string" or path == "" then return false end
    local file = io.open(path, "rb")
    if file then file:close(); return true end
    local relative = path:gsub("^/server/", "")
    if relative ~= path then
        file = io.open(relative, "rb")
        if file then file:close(); return true end
    end
    return false
end

local function provide_instance_asset(area_id, path)
    if type(area_id) ~= "string" or area_id == ""
        or type(path) ~= "string" or path == "" then
        return false, "invalid area or asset path"
    end
    if not server_asset_file_exists(path) then
        log("ASSET_FLOW: required server asset file is missing area="
            .. tostring(area_id) .. " path=" .. tostring(path))
        return false, "server file missing: " .. tostring(path)
    end
    if type(Net.provide_asset) ~= "function" then
        log("ASSET_FLOW: Net.provide_asset unavailable area=" .. tostring(area_id)
            .. " path=" .. tostring(path))
        return false, "Net.provide_asset is unavailable"
    end
    local ok, result = pcall(Net.provide_asset, area_id, path)
    if not ok or result == false then
        log("ASSET_FLOW: area asset provision failed area=" .. tostring(area_id)
            .. " path=" .. tostring(path) .. " pcall_ok=" .. tostring(ok)
            .. " return=" .. tostring(result))
        return false, "could not provide " .. tostring(path) .. ": " .. tostring(result)
    end
    log("ASSET_FLOW: area asset provided area=" .. tostring(area_id)
        .. " path=" .. tostring(path) .. " pcall_ok=true return=" .. tostring(result))
    return true
end

local function read_png_dimensions(path)
    if type(path) ~= "string" or path == "" then
        return nil, nil, "empty texture path"
    end
    local candidates = { path }
    local relative = path:gsub("^/server/", "")
    if relative ~= path then candidates[#candidates + 1] = relative end
    for _, candidate in ipairs(candidates) do
        local file = io.open(candidate, "rb")
        if file then
            local header = file:read(24)
            file:close()
            if type(header) == "string" and #header >= 24
                and header:byte(1) == 137 and header:sub(2, 4) == "PNG" then
                local function u32(offset)
                    local a, b, c, d = header:byte(offset, offset + 3)
                    return ((a * 256 + b) * 256 + c) * 256 + d
                end
                return u32(17), u32(21)
            end
            return nil, nil, "file is not a readable PNG: " .. candidate
        end
    end
    return nil, nil, "texture file not found: " .. path
end

local function validate_animation_states(path, required_states, label, texture_path)
    local ok, animation, load_error = pcall(Boom.load, path)
    if not ok or type(animation) ~= "table" then
        local detail = tostring(load_error or animation)
        log("ASSET_FLOW: animation parse failed label=" .. tostring(label)
            .. " path=" .. tostring(path) .. " error=" .. detail)
        return false, "cannot parse " .. tostring(path) .. ": " .. detail
    end
    if animation.version ~= "2.0" then
        local detail = "expected animation v2.0, got v" .. tostring(animation.version)
        log("ASSET_FLOW: unsupported animation version label=" .. tostring(label)
            .. " path=" .. tostring(path) .. " detail=" .. detail)
        return false, detail
    end
    local texture_width, texture_height, texture_error
    if texture_path then
        texture_width, texture_height, texture_error = read_png_dimensions(texture_path)
        if not texture_width or not texture_height then
            local detail = texture_error or "could not read texture dimensions"
            log("ASSET_FLOW: texture dimension validation failed label=" .. tostring(label)
                .. " texture=" .. tostring(texture_path) .. " error=" .. detail)
            return false, detail
        end
    end
    for _, state_name in ipairs(required_states or {}) do
        local state = animation.states and animation.states[state_name]
        if type(state) ~= "table" or type(state.framelist) ~= "table"
            or #state.framelist == 0 then
            local detail = "missing/empty state " .. tostring(state_name)
            log("ASSET_FLOW: required animation state missing label=" .. tostring(label)
                .. " path=" .. tostring(path) .. " state=" .. tostring(state_name))
            return false, detail
        end
        -- Jump states must have at least a movement frame + a hold frame.
        if state_name == AnimationStates.FOOTBOMB_JUMP_LEFT
            or state_name == AnimationStates.FOOTBOMB_JUMP_RIGHT then
            if #state.framelist < 2 then
                local detail = state_name .. " needs >=2 frames (movement + extended landing hold); got "
                    .. tostring(#state.framelist)
                log("ASSET_FLOW: jump state has too few frames label=" .. tostring(label)
                    .. " path=" .. tostring(path) .. " state=" .. tostring(state_name)
                    .. " frames=" .. tostring(#state.framelist))
                return false, detail
            end
        end
        -- Patch 3: END poses are single-frame holds; verify exactly one frame.
        if state_name == AnimationStates.FOOTBOMB_JUMP_LEFT_END
            or state_name == AnimationStates.FOOTBOMB_JUMP_RIGHT_END then
            if #state.framelist ~= 1 then
                local detail = state_name .. " must have exactly 1 frame (single-frame hold); got "
                    .. tostring(#state.framelist)
                log("ASSET_FLOW: END state has wrong frame count label=" .. tostring(label)
                    .. " path=" .. tostring(path) .. " state=" .. tostring(state_name)
                    .. " frames=" .. tostring(#state.framelist))
                return false, detail
            end
        end
        for frame_index, frame in ipairs(state.framelist) do
            local x, y = tonumber(frame.x), tonumber(frame.y)
            local w, h = tonumber(frame.w), tonumber(frame.h)
            if not x or not y or not w or not h or x < 0 or y < 0 or w <= 0 or h <= 0 then
                local detail = "invalid frame rectangle state=" .. tostring(state_name)
                    .. " frame=" .. tostring(frame_index)
                log("ASSET_FLOW: invalid animation frame label=" .. tostring(label)
                    .. " path=" .. tostring(path) .. " " .. detail)
                return false, detail
            end
            if texture_width and (x + w > texture_width or y + h > texture_height) then
                local detail = "frame outside texture bounds state=" .. tostring(state_name)
                    .. " frame=" .. tostring(frame_index)
                    .. " rect=" .. tostring(x) .. "," .. tostring(y) .. ","
                    .. tostring(w) .. "," .. tostring(h)
                    .. " texture=" .. tostring(texture_width) .. "x" .. tostring(texture_height)
                log("ASSET_FLOW: animation frame exceeds texture bounds label=" .. tostring(label)
                    .. " path=" .. tostring(path) .. " texture=" .. tostring(texture_path)
                    .. " " .. detail)
                return false, detail
            end
        end
    end
    log("ASSET_FLOW: animation states and frame bounds validated label=" .. tostring(label)
        .. " path=" .. tostring(path) .. " texture=" .. tostring(texture_path or "unspecified")
        .. " texture_size=" .. tostring(texture_width or "unknown") .. "x"
        .. tostring(texture_height or "unknown"))
    return true
end

local function provide_instance_bot_assets(area_id)
    local paths, seen = {}, {}
    local function add(path)
        if type(path) == "string" and path ~= "" and not seen[path] then
            seen[path] = true
            paths[#paths + 1] = path
        end
    end
    -- Patch 1: END states are now required during asset preflight.
    local required_navi_states = {
        AnimationStates.IDLE_D,
        AnimationStates.IDLE_U,
        AnimationStates.IDLE_UR,
        AnimationStates.WALK_U,
        AnimationStates.WALK_UR,
        AnimationStates.FOOTBOMB_IDLE_DEFENSE,
        AnimationStates.FOOTBOMB_READY_DEFENSE,
        AnimationStates.FOOTBOMB_JUMP_LEFT,
        AnimationStates.FOOTBOMB_JUMP_RIGHT,
        AnimationStates.FOOTBOMB_JUMP_LEFT_END,
        AnimationStates.FOOTBOMB_JUMP_RIGHT_END,
    }
    local required_bomb_states = {
        AnimationStates.SMALL_BOMB,
        AnimationStates.BIG_BOMB,
        AnimationStates.BOMB_PREVIEW,
    }
    for _, option in ipairs(NAVI_OPTIONS) do
        local valid, detail = validate_animation_states(
            option.animation, required_navi_states,
            "Navi " .. tostring(option.name), option.texture)
        if not valid then return false, detail end
        add(option.texture)
        add(option.animation)
        add(option.texture:gsub("%.png$", "-mug.png"))
    end
    add(Config.ASSETS.DEFAULT_MUG_ANIMATION)
    for _, option in ipairs(BOMB_OPTIONS) do
        local texture = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".png"
        local animation_path = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".animation"
        local valid, detail = validate_animation_states(
            animation_path, required_bomb_states, "bomb " .. tostring(option.name))
        if not valid then return false, detail end
        add(texture)
        add(animation_path)
    end
    -- Role panel + role icon UI assets. Provided without hard validation
    -- because draw_role_text() already falls back to plain text if the panel
    -- cannot be built at runtime.
    add(Config.ASSETS.ROLE_PANEL_TEXTURE_KICKER)
    add(Config.ASSETS.ROLE_PANEL_TEXTURE_DEFENDER)
    add(Config.ASSETS.ROLE_PANEL_ANIMATION)
    add(Config.ASSETS.ROLE_ICONS_TEXTURE)
    add(Config.ASSETS.ROLE_ICONS_ANIMATION)
    local provided = 0
    for _, path in ipairs(paths) do
        local ok, detail = provide_instance_asset(area_id, path)
        if not ok then return false, detail end
        provided = provided + 1
    end
    log("ASSET_FLOW: instance bot asset preload complete area=" .. tostring(area_id)
        .. " assets=" .. tostring(provided)
        .. " navi_skins=" .. tostring(#NAVI_OPTIONS)
        .. " bomb_skins=" .. tostring(#BOMB_OPTIONS))
    return true
end

local source_area_assets_ready = {}

local function provide_source_area_assets(area_id, reason)
    area_id = area_id or Config.DEFAULTS.SOURCE_AREA
    log("ASSET_FLOW: source-area preload starting area=" .. tostring(area_id)
        .. " reason=" .. tostring(reason or "unspecified"))
    if source_area_assets_ready[area_id] then
        log("ASSET_FLOW: source-area preload already complete area=" .. tostring(area_id))
        return true
    end
    local ok, detail = provide_instance_bot_assets(area_id)
    if not ok then
        log("ASSET_FLOW: source-area Navi/bomb preload failed area="
            .. tostring(area_id) .. " reason=" .. tostring(detail))
        return false, detail
    end
    local ui_paths = {
        Config.ASSETS.CURSOR_TEXTURE, Config.ASSETS.VIBRANT_CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        Config.ASSETS.CURSOR_SFX, Config.ASSETS.THUD_SFX, Config.ASSETS.SCOREBOARD_TEXTURE, Config.ASSETS.SCOREBOARD_ANIMATION,
    }
    for _, path in ipairs(ui_paths) do
        local provided, provision_error = provide_instance_asset(area_id, path)
        if not provided then
            log("ASSET_FLOW: source-area UI asset preload failed area="
                .. tostring(area_id) .. " path=" .. tostring(path)
                .. " reason=" .. tostring(provision_error))
            return false, provision_error
        end
    end
    source_area_assets_ready[area_id] = true
    log("ASSET_FLOW: source-area preload complete area=" .. tostring(area_id)
        .. " reason=" .. tostring(reason or "unspecified")
        .. " navi_skins=" .. tostring(#NAVI_OPTIONS)
        .. " bomb_skins=" .. tostring(#BOMB_OPTIONS)
        .. " ui_assets=" .. tostring(#ui_paths))
    return true
end

local function make_instance(player_id, source_area_id, object, mode)
    local props = object.custom_properties or {}
    local instance_id = "footbomb_"
        .. tostring(player_id):gsub("[^%w_%-]", "_")
        .. "_" .. tostring(os.time())
    local configured_points = math.floor(as_number(
        props["Points to Win"], Config.DEFAULTS.POINTS_TO_WIN
    ))
    if configured_points < 1 then configured_points = Config.DEFAULTS.POINTS_TO_WIN end
    local instance, err = EzMapInstance.create(
        as_string(props["Instance Map"], Config.DEFAULTS.SOURCE_AREA),
        instance_id,
        {
            host_id = player_id,
            player_ids = {},
            party_id = "footbomb_" .. tostring(player_id),
            metadata = {
                game = "footbomb", mode = mode,
                return_area_id = source_area_id,
                points_to_win = configured_points,
                party = { host_id = player_id, members = {} }
            }
        }
    )
    if not instance then return nil, err end
    local assets_ok, assets_error = provide_instance_bot_assets(instance.area_id)
    if not assets_ok then
        pcall(EzMapInstance.remove, instance.id)
        return nil, "FootBomb instance asset preflight failed: " .. tostring(assets_error)
    end
    local spawn_points, spawn_error = find_named_spawn_points(instance.area_id)
    if not spawn_points then
        EzMapInstance.remove(instance.id)
        return nil, spawn_error
    end
    local bots, bot_error = create_match_bots(instance, spawn_points, mode == "npc")
    if not bots then
        EzMapInstance.remove(instance.id)
        return nil, bot_error
    end
    bots.points_to_win = configured_points
    bots.return_area_id = source_area_id
    local ref_x = tonumber(object.x)
    local ref_y = tonumber(object.y)
    local ref_z = as_number(object.z, 0)
    local ref_direction = as_string(props.Direction, "Down")
    if ref_x and ref_y then
        local return_x, return_z = ref_x, ref_z
        if ref_direction == "Up" then return_z = ref_z - 1
        elseif ref_direction == "Down" then return_z = ref_z + 1
        elseif ref_direction == "Left" then return_x = ref_x - 1
        elseif ref_direction == "Right" then return_x = ref_x + 1
        end
        bots.return_position = { x = return_x + 1, y = ref_y + 1, z = return_z }
        bots.return_npc_position = { x = ref_x, y = ref_y, z = ref_z }
        bots.return_npc_direction = ref_direction
    else
        log("MATCH_FLOW: Ref-Prog return position unavailable; object coordinates missing area="
            .. tostring(source_area_id) .. " object=" .. tostring(object.id))
    end
    bots.match_point_active = false
    bots.match_point_challenger_slot = nil
    bots.match_complete = false
    log("MATCH_RULES: configured points_to_win=" .. tostring(configured_points)
        .. " return_area_id=" .. tostring(source_area_id)
        .. " instance=" .. tostring(instance.id))
    return instance, spawn_points
end

local function move_player_off_map(player_id, area_id)
    if type(Net.move_player) == "function" then
        local ok, result = pcall(
            Net.move_player, player_id,
            Config.UI.OFF_MAP_POSITION.x, Config.UI.OFF_MAP_POSITION.y, Config.UI.OFF_MAP_POSITION.z
        )
        if ok and result ~= false then return true end
    end
    if type(Net.transfer_player) == "function" then
        local ok, result = pcall(
            Net.transfer_player, player_id, area_id, false,
            Config.UI.OFF_MAP_POSITION.x, Config.UI.OFF_MAP_POSITION.y, Config.UI.OFF_MAP_POSITION.z
        )
        if ok and result ~= false then return true end
    end
    log("Could not move real player actor off-map for " .. tostring(player_id))
    return false
end

-- ---------------------------------------------------------------------------
-- Selector UI
-- ---------------------------------------------------------------------------

local function hide_bomb_selector_ui(player_id, rep)
    rep = rep or State.player_representations[player_id]
    if not rep then return end
    if rep.cursor_left then pcall(games.remove_ui_element, rep.cursor_left, player_id) end
    if rep.cursor_right then pcall(games.remove_ui_element, rep.cursor_right, player_id) end
    if rep.bomb_preview then pcall(UISafe.erase, player_id, rep.bomb_preview) end
    if rep.bomb_confirm_prompt_text_id then
        pcall(games.remove_text, rep.bomb_confirm_prompt_text_id, player_id)
    end
end

local DIRECTION_CURSOR_DIRECTIONS = { "Left", "Up", "Right" }

local function direction_cursor_id(rep, direction)
    if direction == "Left" then return rep.direction_cursor_left end
    if direction == "Up" then return rep.direction_cursor_up end
    if direction == "Right" then return rep.direction_cursor_right end
    return nil
end

local function draw_direction_cursor(player_id, rep, direction, y)
    local cursor_id = direction_cursor_id(rep, direction)
    local x_index = direction == "Left" and 1 or (direction == "Up" and 2 or 3)
    if not cursor_id then return end
    local role_check = State.player_representations[player_id]["bot_record"]["role"]
    local arrow_state = "CURSOR_UP"
    local red = { a = 255, r = 255, g = 0, b = 0, color_mode = 1 }
    local blue = { a = 255, r = 0, g = 0, b = 255, color_mode = 1 }
    local arrow_color = red
    if role_check == "Kicker" then
        arrow_state = "CURSOR_UP"; arrow_color = red
    elseif role_check == "Defender" then
        arrow_state = "CURSOR_DOWN"; arrow_color = blue
    else
        print("ROLE IS UNKNOWN")
    end
    pcall(games.remove_ui_element, cursor_id, player_id)
    pcall(
        games.add_ui_element,
        cursor_id, player_id,
        Config.ASSETS.VIBRANT_CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        arrow_state, Config.UI.DIRECTION_CURSOR_X[x_index], y, 100,
        Config.UI.DIRECTION_CURSOR_SCALE, Config.UI.DIRECTION_CURSOR_SCALE
    )
    pcall(games.update_ui_element, cursor_id, player_id, arrow_color)
end

local function show_direction_selector_ui(player_id, rep)
    if not rep or State.player_representations[player_id] ~= rep then return end
    rep.direction_cursor_bob_tick = 0
    rep.direction_cursor_bob_offset = 0
    for _, direction in ipairs(DIRECTION_CURSOR_DIRECTIONS) do
        draw_direction_cursor(player_id, rep, direction, Config.UI.DIRECTION_CURSOR_Y)
    end
    rep.direction_cursor_ui_visible = true
end

local function hide_direction_selector_ui(player_id, rep)
    rep = rep or State.player_representations[player_id]
    if not rep then return end
    for _, direction in ipairs(DIRECTION_CURSOR_DIRECTIONS) do
        local cursor_id = direction_cursor_id(rep, direction)
        if cursor_id then pcall(games.remove_ui_element, cursor_id, player_id) end
    end
    rep.direction_cursor_ui_visible = false
    rep.direction_cursor_bob_tick = 0
    rep.direction_cursor_bob_offset = 0
end

local function update_direction_selector_bob(player_id, rep)
    if not rep.direction_cursor_ui_visible or not rep.direction_selection_active
        or rep.confirming or rep.direction_selection_confirmed then return end
    local selected = rep.selected_direction
    if selected ~= "Left" and selected ~= "Up" and selected ~= "Right" then return end
    rep.direction_cursor_bob_tick = (rep.direction_cursor_bob_tick or 0) + 1
    if rep.direction_cursor_bob_tick < Config.UI.DIRECTION_CURSOR_BOB_TICKS then return end
    rep.direction_cursor_bob_tick = 0
    rep.direction_cursor_bob_offset = (rep.direction_cursor_bob_offset or 0) == 0
        and -Config.UI.DIRECTION_CURSOR_BOB_OFFSET or 0
    draw_direction_cursor(
        player_id, rep, selected,
        Config.UI.DIRECTION_CURSOR_Y + rep.direction_cursor_bob_offset
    )
end

local function hide_selector_ui(player_id, rep)
    rep = rep or State.player_representations[player_id]
    if not rep then return end
    if rep.cursor_top then pcall(games.remove_ui_element, rep.cursor_top, player_id) end
    if rep.cursor_bottom then pcall(games.remove_ui_element, rep.cursor_bottom, player_id) end
    if rep.skin_text_id then pcall(games.remove_text, rep.skin_text_id, player_id) end
    if rep.confirm_prompt_text_id then
        pcall(games.remove_text, rep.confirm_prompt_text_id, player_id)
    end
    hide_bomb_selector_ui(player_id, rep)
    hide_direction_selector_ui(player_id, rep)
    rep.selector_ui_visible = false
end

local function show_bomb_selector_ui(player_id, rep)
    if not rep or State.player_representations[player_id] ~= rep then return end
    if rep.confirming or rep.bomb_selection_confirmed
        or rep.selection_confirmed or rep.match_started then return end
    if Net.get_player_area(player_id) ~= rep.area_id then return end
    local option = BOMB_OPTIONS[rep.bomb_skin_index]
    if not option then return end
    local texture_path = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".png"
    local animation_path = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".animation"
    pcall(
        games.add_ui_element,
        rep.cursor_left, player_id, Config.ASSETS.CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        "CURSOR_LEFT", Config.UI.BOMB_CURSOR_LEFT_X, Config.UI.BOMB_CURSOR_Y, 100,
        Config.UI.BOMB_SELECTOR_SCALE, Config.UI.BOMB_SELECTOR_SCALE
    )
    pcall(
        games.add_ui_element,
        rep.cursor_right, player_id, Config.ASSETS.CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        "CURSOR_RIGHT", Config.UI.BOMB_CURSOR_RIGHT_X, Config.UI.BOMB_CURSOR_Y, 100,
        Config.UI.BOMB_SELECTOR_SCALE, Config.UI.BOMB_SELECTOR_SCALE
    )
    local drawn = UISafe.draw(
        player_id, rep.bomb_preview, texture_path,
        {
            anim_path = animation_path,
            anim_state = BOMB_PREVIEW_ANIMATION,
            x = Config.UI.BOMB_PREVIEW_X, y = Config.UI.BOMB_PREVIEW_Y, z = 100,
            sx = Config.UI.BOMB_SELECTOR_SCALE, sy = Config.UI.BOMB_SELECTOR_SCALE
        }
    )
    if not drawn then
        log("Could not draw bomb skin preview for player "
            .. tostring(player_id) .. ": " .. option.name)
    end
    draw_confirm_prompt(player_id, rep.bomb_confirm_prompt_text_id)
end

local function show_selector_ui(player_id, rep)
    if not rep or State.player_representations[player_id] ~= rep then return end
    if rep.confirming or rep.selection_confirmed or rep.match_started then return end
    if Net.get_player_area(player_id) ~= rep.area_id then return end
    if rep.selector_ui_visible then return end
    if not rep.bomb_selection_confirmed then
        show_bomb_selector_ui(player_id, rep)
        rep.selector_ui_visible = true
        return
    end
    local bot_x = math.floor(Config.UI.SCREEN_WIDTH / 2)
    local bot_y = math.floor(Config.UI.SCREEN_HEIGHT / 2)
    pcall(
        games.add_ui_element,
        rep.cursor_top, player_id, Config.ASSETS.CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        "CURSOR_UP", bot_x, bot_y - 40, 100, 2.0, 2.0
    )
    pcall(
        games.add_ui_element,
        rep.cursor_bottom, player_id, Config.ASSETS.CURSOR_TEXTURE, Config.ASSETS.CURSOR_ANIMATION,
        "CURSOR_DOWN", bot_x, bot_y + 20, 100, 2.0, 2.0
    )
    draw_navi_name(player_id, rep, NAVI_OPTIONS[rep.skin_index].name)
    draw_confirm_prompt(player_id, rep.confirm_prompt_text_id)
    rep.selector_ui_visible = true
end

-- ---------------------------------------------------------------------------
-- Player representation lifecycle
-- ---------------------------------------------------------------------------

local function remove_representation(player_id)
    local rep = State.player_representations[player_id]
    if not rep then return end
    hide_selector_ui(player_id, rep)
    if rep.scoreboard_ui_id then pcall(games.remove_ui_element, rep.scoreboard_ui_id, player_id) end
    if rep.score_player_one_mug_ui_id then pcall(games.remove_ui_element, rep.score_player_one_mug_ui_id, player_id) end
    if rep.score_player_two_mug_ui_id then pcall(games.remove_ui_element, rep.score_player_two_mug_ui_id, player_id) end
    if rep.score_player_one_text_id then pcall(games.remove_text, rep.score_player_one_text_id, player_id) end
    if rep.score_player_two_text_id then pcall(games.remove_text, rep.score_player_two_text_id, player_id) end
    if rep.role_text_id then pcall(games.remove_text, rep.role_text_id, player_id) end
    if rep.role_panel_id then pcall(Displayer.SlicedPanel.remove, player_id, rep.role_panel_id) end
    if rep.hud_hidden and type(Net.toggle_player_hud) == "function" then
        pcall(Net.toggle_player_hud, player_id)
        rep.hud_hidden = false
    end
    local input = rep.input or InputAPI.get_controller(player_id)
    if input and rep.input_owner then
        pcall(input.release_input, input, rep.input_owner)
    end
    if type(Net.unlock_player_camera) == "function" then
        pcall(Net.unlock_player_camera, player_id)
    end
    if type(Net.track_with_player_camera) == "function" then
        pcall(Net.track_with_player_camera, player_id)
    end
    if type(Net.unlock_player_input) == "function" then
        local ok, err = pcall(Net.unlock_player_input, player_id)
        if not ok then
            log("Could not unlock player input during FootBomb cleanup: "
                .. tostring(err))
        end
    end
    State.player_representations[player_id] = nil
end

local fade_player_to_black
local fade_player_in

local function setup_player_representation(player_id, instance, bot_record)
    if not instance or not bot_record
        or Net.get_player_area(player_id) ~= instance.area_id then
        return
    end
    local existing = State.player_representations[player_id]
    if existing
        and existing.instance_id == instance.id
        and existing.slot == bot_record.slot then
        existing.bot_id = bot_record.id
        existing.bot_record = bot_record
        return
    end
    remove_representation(player_id)
    local rep = {
        instance_id = instance.id,
        area_id = instance.area_id,
        slot = bot_record.slot,
        bot_id = bot_record.id,
        actor_id = bot_record.actor_id,
        bot_record = bot_record,
        cursor_top = "footbomb_cursor_top_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        cursor_bottom = "footbomb_cursor_bottom_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        direction_cursor_left = "footbomb_direction_cursor_left_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        direction_cursor_up = "footbomb_direction_cursor_up_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        direction_cursor_right = "footbomb_direction_cursor_right_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        skin_text_id = "footbomb_navi_name_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        confirm_prompt_text_id = "footbomb_navi_confirm_prompt_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        cursor_left = "footbomb_bomb_cursor_left_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        cursor_right = "footbomb_bomb_cursor_right_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        bomb_preview = "footbomb_bomb_preview_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        bomb_confirm_prompt_text_id = "footbomb_bomb_confirm_prompt_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        scoreboard_ui_id = "footbomb_scoreboard_"
            .. tostring(instance.id):gsub("[^%w_%-]", "_") .. "_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_one_mug_ui_id = "footbomb_scoreboard_mug_p1_"
            .. tostring(instance.id):gsub("[^%w_%-]", "_") .. "_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_two_mug_ui_id = "footbomb_scoreboard_mug_p2_"
            .. tostring(instance.id):gsub("[^%w_%-]", "_") .. "_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_one_text_id = "footbomb_score_p1_"
            .. tostring(instance.id):gsub("[^%w_%-]", "_") .. "_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_two_text_id = "footbomb_score_p2_"
            .. tostring(instance.id):gsub("[^%w_%-]", "_") .. "_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        role_text_id = "footbomb_role_text_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        role_panel_id = "footbomb_role_panel_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        role_panel_role = nil,
        role_text_enabled = false,
        role_text_suppressed = false,
        role_text_suppression_count = 0,
        skin_index = bot_record.skin_index or 1,
        bomb_skin_index = 1,
        bomb_selection_confirmed = false,
        selection_confirmed = false,
        confirming = false,
        match_started = false,
        selector_ui_visible = false,
        direction_selection_active = false,
        direction_selection_confirmed = false,
        selected_direction = nil,
        direction_cursor_ui_visible = false,
        direction_cursor_bob_tick = 0,
        direction_cursor_bob_offset = 0,
        input = InputAPI.get_controller(player_id)
            or InputAPI.create_controller(player_id),
        input_owner = "footbomb:" .. tostring(instance.id) .. ":"
            .. tostring(player_id)
    }
    State.player_representations[player_id] = rep
    fade_player_to_black(player_id)
    if type(Net.toggle_player_hud) == "function" then
        local ok, err = pcall(Net.toggle_player_hud, player_id)
        if ok then rep.hud_hidden = true
        else
            log("Could not hide player HUD for "
                .. tostring(player_id) .. ": " .. tostring(err))
        end
    end
    if type(Net.lock_player_input) == "function" then
        local ok, err = pcall(Net.lock_player_input, player_id)
        if ok then
            log("selector locked player input for virtual_input player="
                .. tostring(player_id))
        else
            log("Could not lock player input for selector player="
                .. tostring(player_id) .. ": " .. tostring(err))
        end
    end
    if rep.input then
        local claimed = rep.input:claim_input(rep.input_owner, true)
        if claimed then
            rep.input:consume(rep.input_owner)
            rep.input:require_release(
                { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                rep.input_owner
            )
        else
            log("Could not claim input for player " .. tostring(player_id))
        end
    end
    move_player_off_map(player_id, instance.area_id)
    if type(Net.unlock_player_camera) == "function" then
        pcall(Net.unlock_player_camera, player_id)
    end
    local position = bot_record.position
    if type(Net.get_bot_position) == "function" then
        local ok, current = pcall(Net.get_bot_position, bot_record.id)
        if ok and type(current) == "table"
            and type(current.x) == "number"
            and type(current.y) == "number" then
            position = {
                x = current.x, y = current.y,
                z = as_number(current.z, position and position.z or 0)
            }
        end
    end
    if position and type(Net.move_player_camera) == "function" then
        pcall(
            Net.move_player_camera, player_id,
            position.x, position.y, position.z or 0, 0
        )
    end
    show_selector_ui(player_id, rep)
    async(function()
        await(Async.sleep(0.85))
        if State.player_representations[player_id] == rep then
            fade_player_in(player_id)
        end
    end)
end

local function setup_representations_for_match(instance, player_ids, bots)
    for slot, player_id in ipairs(player_ids) do
        setup_player_representation(player_id, instance, bots[slot])
    end
end

-- ---------------------------------------------------------------------------
-- Match creation
-- ---------------------------------------------------------------------------

local function launch_npc_match(player_id, source_area_id, object, npc)
    if not player_is_available(player_id) then return end
    local instance, spawn_or_error = make_instance(
        player_id, source_area_id, object, "npc"
    )
    if not instance then
        await_player_message(
            player_id,
            "I couldn't open the FootBomb field right now: "
            .. tostring(spawn_or_error)
        )
        log("NPC match setup failed: " .. tostring(spawn_or_error))
        return
    end
    local spawn_points = spawn_or_error
    local transferred = transfer_match_players(instance, { player_id }, spawn_points)
    if #transferred ~= 1 then
        remove_instance_bots(instance.id)
        EzMapInstance.remove(instance.id)
        await_player_message(
            player_id,
            "I couldn't transfer you to the FootBomb field. Please try again."
        )
        return
    end
    setup_player_representation(
        player_id, instance, State.instance_bots[instance.id][1]
    )
    log("Started private VS NPC match " .. tostring(instance.id))
end

local function launch_player_match(waiting, second_player)
    local first_player = waiting.player_id
    if not player_is_available(first_player)
        or not player_is_available(second_player) then
        return false, "One of the players is no longer available."
    end
    local instance, spawn_or_error = make_instance(
        first_player, waiting.source_area_id, waiting.object, "player"
    )
    if not instance then return false, tostring(spawn_or_error) end
    local spawn_points = spawn_or_error
    EzMapInstance.set_host(instance.id, first_player)
    instance.metadata.party.members = { first_player, second_player }
    local transferred = transfer_match_players(
        instance, { first_player, second_player }, spawn_points
    )
    if #transferred ~= 2 then
        remove_instance_bots(instance.id)
        for _, player_id in ipairs(transferred) do
            pcall(Net.transfer_player, player_id, waiting.source_area_id, false)
        end
        EzMapInstance.remove(instance.id)
        return false, "I couldn't transfer both players to the FootBomb field."
    end
    setup_representations_for_match(
        instance, { first_player, second_player },
        State.instance_bots[instance.id]
    )
    log("Started VS Player match " .. tostring(instance.id))
    return true
end

-- ---------------------------------------------------------------------------
-- Skin selection
-- ---------------------------------------------------------------------------

local function cycle_player_skin(player_id, direction)
    local rep = State.player_representations[player_id]
    if not rep or rep.confirming or rep.selection_confirmed
        or not rep.bot_record or rep.bot_record.fixed_skin then return end
    local next_index = ((rep.skin_index - 1 + direction) % #NAVI_OPTIONS) + 1
    if next_index == rep.skin_index then return end
    local option = NAVI_OPTIONS[next_index]
    local position = rep.bot_record.position
    local old_id = rep.bot_record.id
    pcall(Net.provide_asset_for_player, player_id, option.texture)
    pcall(Net.provide_asset_for_player, player_id, option.animation)
    safe_remove_bot(old_id)
    local ok, new_id = pcall(Net.create_bot, rep.actor_id, {
        name = rep.slot == 1 and "FootBomb Player 1" or "FootBomb Player 2",
        area_id = rep.area_id,
        texture_path = option.texture,
        animation_path = option.animation,
        animation = option.animation_state or AnimationStates.IDLE_D,
        x = position.x, y = position.y, z = position.z,
        direction = "Down",
        solid = false, size = 0.2, warp_in = false, dont_face_player = true
    })
    if not ok or not new_id then
        log("Could not change Navi skin for "
            .. tostring(player_id) .. ": " .. tostring(new_id))
        local old_option = NAVI_OPTIONS[rep.skin_index]
        local restore_ok, restored_id = pcall(Net.create_bot, rep.actor_id, {
            name = rep.slot == 1 and "FootBomb Player 1" or "FootBomb Player 2",
            area_id = rep.area_id,
            texture_path = old_option.texture,
            animation_path = old_option.animation,
            animation = old_option.animation_state or AnimationStates.IDLE_D,
            x = position.x, y = position.y, z = position.z,
            direction = "Down",
            solid = false, size = 0.2, warp_in = false, dont_face_player = true
        })
        if restore_ok and restored_id then
            rep.bot_record.id = restored_id
            rep.bot_record.skin_index = rep.skin_index
            rep.bot_record.navi_name = old_option.name
            rep.bot_record.texture_path = old_option.texture
            rep.bot_record.animation_path = old_option.animation
            rep.bot_record.current_direction = "Down"
            rep.bot_record._hold_token = nil
            rep.bot_id = restored_id
            local slots = State.instance_bots[rep.instance_id]
            if slots and slots[rep.slot] then
                slots[rep.slot].id = restored_id
                slots[rep.slot].skin_index = rep.skin_index
                slots[rep.slot].navi_name = old_option.name
                slots[rep.slot].texture_path = old_option.texture
                slots[rep.slot].animation_path = old_option.animation
                slots[rep.slot].mug_texture_path = old_option.texture:gsub("%.png$", "-mug.png")
                slots[rep.slot].mug_animation_path = Config.ASSETS.DEFAULT_MUG_ANIMATION
                slots[rep.slot].current_direction = "Down"
                slots[rep.slot]._hold_token = nil
            end
        end
        return
    end
    rep.skin_index = next_index
    rep.bot_record.skin_index = next_index
    rep.bot_record.navi_name = option.name
    rep.bot_record.texture_path = option.texture
    rep.bot_record.animation_path = option.animation
    rep.bot_record.mug_texture_path = option.texture:gsub("%.png$", "-mug.png")
    rep.bot_record.mug_animation_path = Config.ASSETS.DEFAULT_MUG_ANIMATION
    rep.bot_record.id = new_id
    rep.bot_record.current_direction = "Down"
    rep.bot_record._hold_token = nil
    rep.bot_id = new_id
    if rep.selector_ui_visible then
        draw_navi_name(player_id, rep, option.name)
    end
    local slots = State.instance_bots[rep.instance_id]
    if slots and slots[rep.slot] then
        slots[rep.slot].id = new_id
        slots[rep.slot].skin_index = next_index
        slots[rep.slot].navi_name = option.name
        slots[rep.slot].texture_path = option.texture
        slots[rep.slot].animation_path = option.animation
        slots[rep.slot].mug_texture_path = option.texture:gsub("%.png$", "-mug.png")
        slots[rep.slot].mug_animation_path = Config.ASSETS.DEFAULT_MUG_ANIMATION
        slots[rep.slot].current_direction = "Down"
        slots[rep.slot]._hold_token = nil
    end
    log("Player " .. tostring(player_id) .. " selected " .. option.name
        .. " skin_index=" .. tostring(next_index))
end

local function cycle_bomb_skin(player_id, direction)
    local rep = State.player_representations[player_id]
    if not rep or rep.confirming or rep.bomb_selection_confirmed
        or rep.selection_confirmed or rep.match_started then return end
    local next_index = ((rep.bomb_skin_index - 1 + direction) % #BOMB_OPTIONS) + 1
    if next_index == rep.bomb_skin_index then return end
    local option = BOMB_OPTIONS[next_index]
    rep.bomb_skin_index = next_index
    hide_bomb_selector_ui(player_id, rep)
    show_bomb_selector_ui(player_id, rep)
    pcall(Net.play_sound_for_player, player_id, Config.ASSETS.CURSOR_SFX)
    log("Player " .. tostring(player_id) .. " previewing ball skin " .. option.name)
end

fade_player_to_black = function(player_id)
    local ok, err = pcall(
        Net.fade_player_camera, player_id,
        { r = 0, g = 0, b = 0, a = 255 }, 0.8
    )
    if not ok then
        log("Camera fade-to-black failed for "
            .. tostring(player_id) .. ": " .. tostring(err))
        return false
    end
    return true
end

local function fade_player_to_white(player_id)
    local ok, err = pcall(
        Net.fade_player_camera, player_id,
        { r = 255, g = 255, b = 255, a = 255 }, 0.8
    )
    if not ok then
        log("Camera fade-to-white failed for "
            .. tostring(player_id) .. ": " .. tostring(err))
        return false
    end
    return true
end

fade_player_in = function(player_id)
    local ok, err = pcall(
        Net.fade_player_camera, player_id,
        { r = 0, g = 0, b = 0, a = 0 }, 0.8
    )
    if not ok then
        log("Camera fade-in failed for "
            .. tostring(player_id) .. ": " .. tostring(err))
        return false
    end
    return true
end

local function focus_player_camera_for_round(player_id, instance_id)
    local points = State.instance_spawn_points[instance_id]
    local focus = points and points.CameraFocus
    if not focus then
        log("CAMERA_FLOW: missing Camera Focus point for instance="
            .. tostring(instance_id))
        return false
    end
    if type(Net.move_player_camera) ~= "function" then
        log("CAMERA_FLOW: Net.move_player_camera unavailable for player="
            .. tostring(player_id))
        return false
    end
    local ok, result = pcall(
        Net.move_player_camera, player_id,
        focus.x, focus.y, focus.z or 0, 0
    )
    log("CAMERA_FLOW: positioned player camera at Camera Focus player="
        .. tostring(player_id) .. " instance=" .. tostring(instance_id)
        .. " x=" .. tostring(focus.x) .. " y=" .. tostring(focus.y)
        .. " z=" .. tostring(focus.z or 0)
        .. " pcall_ok=" .. tostring(ok)
        .. " return=" .. tostring(result))
    return ok and result ~= false
end

local function position_bots_for_round(instance_id)
    local bots = State.instance_bots[instance_id]
    local points = State.instance_spawn_points[instance_id]
    if not bots or #bots < 2 or not points then
        log("Cannot position FootBomb round bots; match data is missing for "
            .. tostring(instance_id))
        return false
    end
    local all_ok = true
    for _, bot in ipairs(bots) do
        local is_kicker = bot.role == "Kicker"
        local target = is_kicker and points.Kicker or points["Defender 2"]
        if type(target) ~= "table" then
            log("RESULT_FLOW: invalid role position target type=" .. type(target)
                .. " role=" .. tostring(bot.role)
                .. " instance=" .. tostring(instance_id))
            all_ok = false
        else
            local move_ok, move_result = pcall(
                Net.move_bot, bot.id, target.x, target.y, target.z or 0
            )
            if not move_ok or move_result == false then
                log("Could not move FootBomb bot " .. tostring(bot.id)
                    .. " to role position " .. tostring(bot.role)
                    .. ": " .. tostring(move_result))
                all_ok = false
            else
                bot.position = { x = target.x, y = target.y, z = target.z or 0 }
            end
        end
    end
    return all_ok
end

local function spawn_bomb_bot_for_round(instance_id, human_reps)
    local bots = State.instance_bots[instance_id]
    local points = State.instance_spawn_points[instance_id]
    if not bots or not points or not points.Bomb then
        log("BOMB_FLOW: cannot spawn bomb; match data or Tiled Bomb point is missing for "
            .. tostring(instance_id))
        return false
    end
    local kicker
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then kicker = bot; break end
    end
    if not kicker then
        log("BOMB_FLOW: cannot spawn bomb; no Kicker role for "
            .. tostring(instance_id))
        return false
    end
    -- Prefer the kicker's own bomb-skin choice. If the kicker is an NPC
    -- (VS NPC rounds where the bot slot has no human rep), fall back to the
    -- (single) human player's choice so the selected skin stays consistent
    -- across rounds instead of snapping back to BOMB_OPTIONS[1].
    local bomb_skin_index = 1
    local kicker_is_human = false
    for _, entry in ipairs(human_reps or {}) do
        local rep = entry.rep
        if rep and rep.slot == kicker.slot then
            bomb_skin_index = tonumber(rep.bomb_skin_index) or 1
            kicker_is_human = true
            break
        end
    end
    if not kicker_is_human then
        for _, entry in ipairs(human_reps or {}) do
            local rep = entry.rep
            if rep then
                bomb_skin_index = tonumber(rep.bomb_skin_index) or 1
                break
            end
        end
    end
    if bomb_skin_index < 1 or bomb_skin_index > #BOMB_OPTIONS then
        bomb_skin_index = 1
    end
    local option = BOMB_OPTIONS[bomb_skin_index] or BOMB_OPTIONS[1]
    local texture_path = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".png"
    local animation_path = Config.ASSETS.BOMB_FOLDER .. option.asset_name .. ".animation"
    local actor_id = "footbomb-match-"
        .. tostring(instance_id):gsub("[^%w_%-]", "_") .. "-bomb"
    if bots.bomb_bot then
        bots.bomb_bot._removed = true
        bots.bomb_bot._hold_token = nil
        safe_remove_bot(bots.bomb_bot.id)
        bots.bomb_bot = nil
    end
    local point = points.Bomb
    log("BOMB_FLOW: spawning bomb instance=" .. tostring(instance_id)
        .. " kicker_slot=" .. tostring(kicker.slot)
        .. " skin=" .. tostring(option.name)
        .. " position={x=" .. tostring(point.x)
        .. ",y=" .. tostring(point.y) .. ",z=" .. tostring(point.z or 0) .. "}")
    local create_ok, bomb_id = pcall(Net.create_bot, actor_id, {
        name = "FootBomb Bomb",
        area_id = kicker.area_id,
        texture_path = texture_path,
        animation_path = animation_path,
        animation = AnimationStates.SMALL_BOMB,
        x = point.x, y = point.y, z = point.z or 0,
        direction = "Down",
        solid = false, size = 0.2, warp_in = false, dont_face_player = true
    })
    if not create_ok or not bomb_id then
        log("BOMB_FLOW: bomb bot creation failed instance="
            .. tostring(instance_id) .. " pcall_ok=" .. tostring(create_ok)
            .. " result=" .. tostring(bomb_id))
        return false
    end
    bots.bomb_bot = {
        id = bomb_id,
        actor_id = actor_id,
        area_id = kicker.area_id,
        current_direction = "Down",
        _round_instance_id = instance_id,
        skin_index = bomb_skin_index,
        skin_name = option.name,
        texture_path = texture_path,
        animation_path = animation_path,
        animation_state = AnimationStates.SMALL_BOMB,
        position = { x = point.x, y = point.y, z = point.z or 0 }
    }
    if type(Net.set_bot_avatar) == "function" then
        local avatar_ok, avatar_result = pcall(
            Net.set_bot_avatar, bomb_id, texture_path, animation_path
        )
        log("BOMB_FLOW: avatar refresh returned bot=" .. tostring(bomb_id)
            .. " pcall_ok=" .. tostring(avatar_ok)
            .. " return=" .. tostring(avatar_result))
    end
    local animation_ok, animation_result = set_bot_animation_state(
        bomb_id, AnimationStates.SMALL_BOMB, true
    )
    log("BOMB_FLOW: Small-Bomb animation request returned bot="
        .. tostring(bomb_id) .. " success=" .. tostring(animation_ok)
        .. " detail=" .. tostring(animation_result))
    return animation_ok
end

local function set_defender_animation_for_round(instance_id, animation_state, phase)
    local bots = State.instance_bots[instance_id]
    if not bots then return false end
    local defender
    for _, bot in ipairs(bots) do
        if bot.role == "Defender" then defender = bot; break end
    end
    if not defender then
        log("ANIM_FLOW: cannot set defender animation; no Defender bot for "
            .. tostring(instance_id) .. " phase=" .. tostring(phase))
        return false
    end
    -- Apply the pose directly instead of emitting assert_idle through the role
    -- bus. During role swaps, queued defender events can otherwise race the
    -- round transition and leave the bot displaying a stale state.
    cancel_hold(defender, "defender-round-idle-" .. tostring(phase))
    -- Normalize facing explicitly: the defender bot inherits its direction
    -- from whichever role/state it ended the previous round in. Round 1
    -- starts at "Down" (creation default), but after round 1 the bot is left
    -- at "Up" by the previous Kicker's assert_idle_u. That made the first-
    -- round IDLE_DEFENSE render with a different facing than subsequent
    -- rounds.
    ensure_bot_direction(defender, "Up")
    local state = animation_state or AnimationStates.FOOTBOMB_IDLE_DEFENSE
    local ok, result = set_bot_animation_state(defender.id, state, true)
    -- Keep the bot record's bookkeeping in sync with the last accepted state
    -- so downstream code that reads bot.animation_state (e.g. hold_pose_for,
    -- assert_looping) never acts on a stale value.
    if ok and result ~= false then
        defender.animation_state = state
    end
    log("ANIM_FLOW: defender round idle applied bot=" .. tostring(defender.id)
        .. " phase=" .. tostring(phase)
        .. " state=" .. tostring(state)
        .. " success=" .. tostring(ok)
        .. " detail=" .. tostring(result))
    return ok and result ~= false
end

local function set_kicker_pose_for_round(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots then return false end
    local kicker
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then kicker = bot; break end
    end
    if not kicker then
        log("Cannot set FootBomb kicker pose; no Kicker bot for "
            .. tostring(instance_id))
        return false
    end
    -- Set the actual bot state directly at round setup. Routing this through
    -- the role event bus allowed other queued role actions to briefly leave
    -- the kicker in a previous state during the round-start reveal.
    cancel_hold(kicker, "kicker-round-start-idle-ur")
    ensure_bot_direction(kicker, "Up Right")
    local animation_ok, animation_result =
        set_bot_animation_state(kicker.id, AnimationStates.IDLE_UR, true)
    -- Keep bot.animation_state in sync with the applied state so reassertions
    -- and post-fade repeats use the correct value.
    if animation_ok and animation_result ~= false then
        kicker.animation_state = AnimationStates.IDLE_UR
    end
    log("KICKER_FLOW: round-start IDLE_UR bot=" .. tostring(kicker.id)
        .. " instance=" .. tostring(instance_id)
        .. " success=" .. tostring(animation_ok)
        .. " detail=" .. tostring(animation_result))
    return animation_ok and animation_result ~= false
end

local function apply_round_role_poses(instance_id, phase)
    -- This is the single pose checkpoint for both first-round setup and every
    -- role swap. Call it only while participant cameras are fully black.
    local defender_ok = set_defender_animation_for_round(
        instance_id, AnimationStates.FOOTBOMB_IDLE_DEFENSE,
        tostring(phase) .. "-defender")
    local kicker_ok, kicker_result = pcall(set_kicker_pose_for_round, instance_id)
    local kicker_success = kicker_ok and kicker_result ~= false
    log("ROUND_SETUP: role poses checked/applied instance=" .. tostring(instance_id)
        .. " phase=" .. tostring(phase)
        .. " defender_success=" .. tostring(defender_ok)
        .. " kicker_success=" .. tostring(kicker_success)
        .. " kicker_detail=" .. tostring(kicker_result))
    return defender_ok and kicker_success
end

-- Re-apply the round-start poses after fade-in has completed. Some clients
-- drop animation writes that arrive during the black-screen transition, so
-- the Kicker occasionally keeps its previous state (typically
-- FOOTBOMB_IDLE_DEFENSE from the skin-selection bot creation) even though
-- the server accepted IDLE_UR. Re-issuing the same write while the bot is
-- visible resolves it without touching gameplay logic.
local function reassert_round_start_poses(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots then return end
    for _, bot in ipairs(bots) do
        if bot._removed then
            -- skip
        elseif bot._hold_token then
            -- an in-progress hold owns this bot; do not fight it
        elseif bot.role == "Kicker" then
            ensure_bot_direction(bot, "Up Right")
            local ok, detail = set_bot_animation_state(
                bot.id, AnimationStates.IDLE_UR, true
            )
            if ok and detail ~= false then
                bot.animation_state = AnimationStates.IDLE_UR
            end
            log("KICKER_FLOW: post-fade reassertion bot=" .. tostring(bot.id)
                .. " state=IDLE_UR success=" .. tostring(ok)
                .. " detail=" .. tostring(detail))
        elseif bot.role == "Defender" then
            ensure_bot_direction(bot, "Up")
            local ok, detail = set_bot_animation_state(
                bot.id, AnimationStates.FOOTBOMB_IDLE_DEFENSE, true
            )
            if ok and detail ~= false then
                bot.animation_state = AnimationStates.FOOTBOMB_IDLE_DEFENSE
            end
            log("DEFENDER_FLOW: post-fade reassertion bot=" .. tostring(bot.id)
                .. " state=FOOTBOMB_IDLE_DEFENSE success=" .. tostring(ok)
                .. " detail=" .. tostring(detail))
        end
    end
end

local function prime_round_bot_animations(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots then
        log("ROUND_SETUP: cannot validate animations; bots missing instance="
            .. tostring(instance_id))
        return false
    end
    -- Patch 2: END states are now required during round priming.
    local required_states = {
        AnimationStates.IDLE_D,
        AnimationStates.IDLE_UR,
        AnimationStates.IDLE_U,
        AnimationStates.WALK_U,
        AnimationStates.WALK_UR,
        AnimationStates.FOOTBOMB_IDLE_DEFENSE,
        AnimationStates.FOOTBOMB_READY_DEFENSE,
        AnimationStates.FOOTBOMB_JUMP_RIGHT,
        AnimationStates.FOOTBOMB_JUMP_LEFT,
        AnimationStates.FOOTBOMB_JUMP_RIGHT_END,
        AnimationStates.FOOTBOMB_JUMP_LEFT_END,
    }
    local checked = 0
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" or bot.role == "Defender" then
            local valid, detail = validate_animation_states(
                bot.animation_path, required_states,
                "selected Navi " .. tostring(bot.navi_name or bot.id),
                bot.texture_path
            )
            if not valid then
                log("ROUND_SETUP: selected Navi animation validation failed bot="
                    .. tostring(bot.id) .. " error=" .. tostring(detail))
                return false
            end
            -- Prewarm the parsed-animation cache so the result-planning block
            -- never has to do a cold Boom.load during a live round. This keeps
            -- the BOMB_LAUNCHED THUD in the same server tick as the bomb's
            -- first movement keyframe.
            get_footbomb_animation(bot.animation_path)
            checked = checked + 1
        end
    end
    if checked ~= 2 then
        log("ROUND_SETUP: expected two selected Navi bots; validated="
            .. tostring(checked) .. " instance=" .. tostring(instance_id))
        return false
    end
    log("ROUND_SETUP: selected Navi animation assets/states validated instance="
        .. tostring(instance_id) .. " bots=" .. tostring(checked))
    return true
end

-- ---------------------------------------------------------------------------
-- Scoreboard
-- ---------------------------------------------------------------------------


local function draw_scoreboard_mug(player_id, rep, bot, ui_id, x)
    if not bot or not bot.mug_texture_path or not bot.mug_animation_path or not ui_id then
        return
    end
    pcall(games.remove_ui_element, ui_id, player_id)
    pcall(Net.provide_asset_for_player, player_id, bot.mug_texture_path)
    pcall(Net.provide_asset_for_player, player_id, bot.mug_animation_path)
    log("SCORE_FLOW: drawing current bot mugshot player="
        .. tostring(player_id) .. " slot=" .. tostring(bot.slot)
        .. " navi=" .. tostring(bot.navi_name))
    local ok, err = pcall(
        games.add_ui_element,
        ui_id, player_id, bot.mug_texture_path, bot.mug_animation_path,
        "IDLE", x, Config.UI.SCORE_MUG_Y, 102, Config.UI.SCORE_MUG_SCALE, Config.UI.SCORE_MUG_SCALE
    )
    if not ok then
        log("SCORE_FLOW: scoreboard mug draw failed player="
            .. tostring(player_id) .. " error=" .. tostring(err))
    end
end

local function draw_scoreboard_for_player(player_id, rep, bots)
    if not rep or not bots or State.player_representations[player_id] ~= rep then
        return
    end
    hide_role_text(player_id, rep)
    pcall(Net.provide_asset_for_player, player_id, Config.ASSETS.SCOREBOARD_TEXTURE)
    pcall(Net.provide_asset_for_player, player_id, Config.ASSETS.SCOREBOARD_ANIMATION)
    local ok, err = pcall(
        games.add_ui_element,
        rep.scoreboard_ui_id, player_id,
        Config.ASSETS.SCOREBOARD_TEXTURE, Config.ASSETS.SCOREBOARD_ANIMATION,
        "DEFAULT", Config.UI.SCOREBOARD_X, Config.UI.SCOREBOARD_Y, 100,
        Config.UI.SCOREBOARD_SCALE, Config.UI.SCOREBOARD_SCALE
    )
    if not ok then
        log("SCORE_FLOW: scoreboard image draw failed player="
            .. tostring(player_id) .. " error=" .. tostring(err))
    end
    draw_scoreboard_mug(
        player_id, rep, bots[1], rep.score_player_one_mug_ui_id,
        Config.UI.SCORE_PLAYER_ONE_MUG_X
    )
    draw_scoreboard_mug(
        player_id, rep, bots[2], rep.score_player_two_mug_ui_id,
        Config.UI.SCORE_PLAYER_TWO_MUG_X
    )
    local score_text_one = tostring(bots.player_one_score or 0)
    local score_text_two = tostring(bots.player_two_score or 0)
    local score_text_options = { font = "THICK", scale = Config.UI.SCORE_TEXT_SCALE }
    local function measure_score(text)
        local measured_width, measured_height = TextLayout.measure(text, score_text_options)
        if type(measured_width) == "table" then
            local size = measured_width
            measured_width = size.width or size.w or size[1]
            measured_height = size.height or size.h or size[2]
        end
        measured_width = tonumber(measured_width)
            or TextLayout.measureLine(text, score_text_options)
        measured_height = tonumber(measured_height)
        if not measured_height or measured_height <= 0 then
            measured_height = 16 * Config.UI.SCORE_TEXT_SCALE
        end
        return measured_width, measured_height
    end
    local score_width_one, score_height_one = measure_score(score_text_one)
    local score_width_two, score_height_two = measure_score(score_text_two)
    local score_one_x = Config.UI.SCORE_BOX_PLAYER_ONE_X
        + (Config.UI.SCORE_BOX_WIDTH - score_width_one) / 2
    local score_one_y = Config.UI.SCORE_BOX_Y
        + (Config.UI.SCORE_BOX_HEIGHT - score_height_one) / 2
    local score_two_x = Config.UI.SCORE_BOX_PLAYER_TWO_X
        + (Config.UI.SCORE_BOX_WIDTH - score_width_two) / 2
    local score_two_y = Config.UI.SCORE_BOX_Y
        + (Config.UI.SCORE_BOX_HEIGHT - score_height_two) / 2
    local function draw_score_number(text_id, score_text, x, y, slot)
        local r, g, b = 255, 255, 255
        if bots.match_complete and bots.final_winner_slot and bots.final_score_pulse then
            local pulse = math.max(0, math.min(1, bots.final_score_pulse))
            if slot == bots.final_winner_slot then
                r = math.floor(10 + 55 * pulse + 0.5)
                g = math.floor(105 + 150 * pulse + 0.5)
                b = math.floor(10 + 55 * pulse + 0.5)
            else
                r = math.floor(105 + 150 * pulse + 0.5)
                g = math.floor(8 + 45 * pulse + 0.5)
                b = math.floor(8 + 45 * pulse + 0.5)
            end
        end
        pcall(games.draw_advanced_text, player_id, score_text, {
            text_id = text_id,
            x = math.floor(x + 0.5), y = math.floor(y + 0.5),
            z = 101, font = "THICK", scale = Config.UI.SCORE_TEXT_SCALE,
            r = r, g = g, b = b,
            opacity = 255, a = 255, color_mode = 0,
        })
    end
    draw_score_number(rep.score_player_one_text_id, score_text_one,
        score_one_x, score_one_y, 1)
    draw_score_number(rep.score_player_two_text_id, score_text_two,
        score_two_x, score_two_y, 2)
end

local function update_scoreboard(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots then return end
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            draw_scoreboard_for_player(player_id, rep, bots)
        end
    end
end

local function hide_scoreboard_for_player(player_id, rep)
    if not rep then return end
    if rep.scoreboard_ui_id then pcall(games.remove_ui_element, rep.scoreboard_ui_id, player_id) end
    if rep.score_player_one_mug_ui_id then pcall(games.remove_ui_element, rep.score_player_one_mug_ui_id, player_id) end
    if rep.score_player_two_mug_ui_id then pcall(games.remove_ui_element, rep.score_player_two_mug_ui_id, player_id) end
    if rep.score_player_one_text_id then pcall(games.remove_text, rep.score_player_one_text_id, player_id) end
    if rep.score_player_two_text_id then pcall(games.remove_text, rep.score_player_two_text_id, player_id) end
end

local function hide_scoreboard_for_instance(instance_id)
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            hide_scoreboard_for_player(player_id, rep)
        end
    end
end

local function play_sound_for_instance(instance_id, sound_path, reason)
    if type(Net.play_sound_for_player) ~= "function"
        or type(sound_path) ~= "string" or sound_path == "" then
        return 0
    end
    local played = 0
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id and player_is_available(player_id) then
            local ok, result = pcall(Net.play_sound_for_player, player_id, sound_path)
            if ok and result ~= false then
                played = played + 1
            else
                log("SFX_FLOW: sound failed player=" .. tostring(player_id)
                    .. " path=" .. tostring(sound_path)
                    .. " reason=" .. tostring(reason)
                    .. " error=" .. tostring(result))
            end
        end
    end
    log("SFX_FLOW: played path=" .. tostring(sound_path)
        .. " instance=" .. tostring(instance_id)
        .. " reason=" .. tostring(reason)
        .. " recipients=" .. tostring(played))
    return played
end

local function move_bot_smoothly(bot, target, speed, phase, animation_state, duration_override)
    if not bot or not bot.id then
        log("RESULT_FLOW: cannot move bot; missing bot phase=" .. tostring(phase))
        return false
    end
    if type(target) ~= "table" then
        log("RESULT_FLOW: cannot move bot; invalid target type=" .. type(target)
            .. " phase=" .. tostring(phase) .. " bot=" .. tostring(bot.id))
        return false
    end
    if type(Net.animate_bot_properties) ~= "function" then
        log("RESULT_FLOW: Net.animate_bot_properties unavailable phase="
            .. tostring(phase))
        return false
    end
    bot._movement_generation = (tonumber(bot._movement_generation) or 0) + 1
    local movement_generation = bot._movement_generation
    local start = bot.position
    if not start and type(Net.get_bot_position) == "function" then
        local position_ok, position = pcall(Net.get_bot_position, bot.id)
        if position_ok and type(position) == "table" then
            start = {
                x = tonumber(position.x) or 0,
                y = tonumber(position.y) or 0,
                z = tonumber(position.z) or 0
            }
        end
    end
    if type(start) ~= "table" then
        log("RESULT_FLOW: cannot move bot; start position unavailable bot="
            .. tostring(bot.id) .. " phase=" .. tostring(phase))
        return false
    end
    animation_state = animation_state or bot.animation_state
    local sx, sy, sz = tonumber(start.x) or 0, tonumber(start.y) or 0, tonumber(start.z) or 0
    local tx, ty, tz = tonumber(target.x) or sx, tonumber(target.y) or sy, tonumber(target.z) or sz
    local dx, dy = tx - sx, ty - sy
    local distance = math.sqrt(dx * dx + dy * dy)
    local move_speed = math.max(1, tonumber(speed) or Config.GAMEPLAY.RESULT_KICKER_WALK_U_SPEED or 150)
    local duration = math.max(0.12, tonumber(duration_override) or (distance / move_speed))
    local keyframes = {
        {
            properties = {
                { property = "X", value = sx },
                { property = "Y", value = sy },
                { property = "Z", value = sz }
            },
            duration = 0
        },
        {
            properties = {
                { property = "X", ease = "Linear", value = tx },
                { property = "Y", ease = "Linear", value = ty },
                { property = "Z", ease = "InOut",  value = tz }
            },
            duration = duration
        }
    }
    if animation_state then
        local pre_animation_ok, pre_animation_result =
            set_bot_animation_state(bot.id, animation_state)
        if pre_animation_ok then
            bot.animation_state = animation_state
        end
        log("RESULT_FLOW: pre-movement animation bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase)
            .. " state=" .. tostring(animation_state)
            .. " success=" .. tostring(pre_animation_ok)
            .. " detail=" .. tostring(pre_animation_result))
    end
    log("RESULT_FLOW: interpolated movement started bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase)
        .. " distance=" .. tostring(distance)
        .. " duration=" .. tostring(duration)
        .. " animation=" .. tostring(animation_state or "unchanged"))
    local animation_ok, animation_result = pcall(
        Net.animate_bot_properties, bot.id, keyframes
    )
    if not animation_ok or animation_result == false then
        log("RESULT_FLOW: interpolated movement failed bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase)
            .. " error=" .. tostring(animation_result))
        return false
    end
    await(Async.sleep(duration))
    if bot._movement_generation ~= movement_generation then
        log("RESULT_FLOW: ignored stale movement completion bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase)
            .. " generation=" .. tostring(movement_generation)
            .. " current_generation=" .. tostring(bot._movement_generation))
        return false
    end
    bot.position = { x = tx, y = ty, z = tz }
    log("RESULT_FLOW: interpolated movement complete bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase) .. " x=" .. tostring(tx)
        .. " y=" .. tostring(ty) .. " z=" .. tostring(tz))
    return true
end

local function set_result_animation(bot, animation_state, direction, phase, should_loop)
    if not bot then return false end
    if direction then ensure_bot_direction(bot, direction) end
    local animation_ok, animation_result = set_bot_animation_state(
        bot.id, animation_state, should_loop
    )
    if animation_ok then bot.animation_state = animation_state end
    log("RESULT_FLOW: animation bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase) .. " state=" .. tostring(animation_state)
        .. " success=" .. tostring(animation_ok)
        .. " detail=" .. tostring(animation_result))
    return animation_ok
end

local function hold_pose_for(bot, state, direction, hold_seconds, phase, should_loop)
    if not bot or not bot.id or bot._removed then return false end
    if type(state) ~= "string" or state == "" then return false end
    hold_seconds = math.max(0.5, tonumber(hold_seconds) or 2.5)
    if should_loop == nil then should_loop = true end
    if direction then ensure_bot_direction(bot, direction) end

    -- Match ezcutscenes' pose-hold strategy: apply the state immediately, then
    -- reassert it at a modest interval while this hold owns the bot. The jump
    -- animation is non-looping and its last frame is only 0.1-0.2s, so the END
    -- state can race the animation boundary on some clients. Reasserting every
    -- 0.2s for this short hold repairs a missed transition without coupling
    -- movement timing to animation timing. END states are single-frame poses.
    local token = {}
    bot._hold_token = token
    local animation_ok, animation_result = set_bot_animation_state(
        bot.id, state, should_loop
    )
    if not animation_ok then
        if bot._hold_token == token then bot._hold_token = nil end
        log("DEFENDER_FLOW: hold_pose_for failed bot=" .. tostring(bot.id)
            .. " state=" .. tostring(state) .. " phase=" .. tostring(phase)
            .. " detail=" .. tostring(animation_result))
        return false
    end
    bot.animation_state = state

    local interval = 0.2
    local reassert_count = math.max(1, math.floor(hold_seconds / interval))
    async(function()
        for _ = 1, reassert_count do
            await(Async.sleep(interval))
            if bot._removed or bot._hold_token ~= token then return end
            local reassert_ok, reassert_result = set_bot_animation_state(
                bot.id, state, should_loop
            )
            if reassert_ok then
                bot.animation_state = state
            else
                log("DEFENDER_FLOW: hold_pose_for reassert failed bot="
                    .. tostring(bot.id) .. " state=" .. tostring(state)
                    .. " phase=" .. tostring(phase)
                    .. " detail=" .. tostring(reassert_result))
            end
        end
    end)
    log("DEFENDER_FLOW: hold_pose_for started bot=" .. tostring(bot.id)
        .. " state=" .. tostring(state)
        .. " phase=" .. tostring(phase)
        .. " duration=" .. tostring(hold_seconds)
        .. " should_loop=" .. tostring(should_loop)
        .. " reassert_interval=" .. tostring(interval)
        .. " reasserts=" .. tostring(reassert_count))
    return true
end

local function award_round_point(instance_id, kicker, defender, winner)
    local bots = State.instance_bots[instance_id]
    if not bots or bots.round_winner or bots.match_complete then return end
    if winner.slot == 1 then
        bots.player_one_score = (bots.player_one_score or 0) + 1
    else
        bots.player_two_score = (bots.player_two_score or 0) + 1
    end
    bots.round_winner = winner.role
    log("SCORE_FLOW: round point recorded; scoreboard waits for black transition instance="
        .. tostring(instance_id)
        .. " kicker_direction=" .. tostring(kicker.direction_choice)
        .. " defender_direction=" .. tostring(defender.direction_choice)
        .. " winner=" .. tostring(winner.role)
        .. " winner_slot=" .. tostring(winner.slot)
        .. " player_one_score=" .. tostring(bots.player_one_score)
        .. " player_two_score=" .. tostring(bots.player_two_score))
end

local function evaluate_match_point(bots, instance_id)
    local score_one = bots.player_one_score or 0
    local score_two = bots.player_two_score or 0
    local target = bots.points_to_win or Config.DEFAULTS.POINTS_TO_WIN
    if score_one == score_two then
        if bots.match_point_active then
            bots.match_point_challenger_slot = nil
            log("MATCH_FLOW: scores tied at match point; continue instance="
                .. tostring(instance_id) .. " score=" .. tostring(score_one))
        end
        return false
    end
    local leader_slot = score_one > score_two and 1 or 2
    local trailing_slot = leader_slot == 1 and 2 or 1
    local leader_score = math.max(score_one, score_two)
    if not bots.match_point_active then
        if leader_score >= target then
            bots.match_point_active = true
            bots.match_point_challenger_slot = trailing_slot
            log("MATCH_FLOW: target reached; trailing player gets final chance instance="
                .. tostring(instance_id)
                .. " target=" .. tostring(target)
                .. " leader_slot=" .. tostring(leader_slot)
                .. " challenger_slot=" .. tostring(trailing_slot)
                .. " score=" .. tostring(score_one) .. "-" .. tostring(score_two))
        end
        return false
    end
    local challenger_slot = bots.match_point_challenger_slot
    if not challenger_slot then
        bots.match_point_challenger_slot = trailing_slot
        log("MATCH_FLOW: tie broken; trailing player gets final chance instance="
            .. tostring(instance_id) .. " challenger_slot=" .. tostring(trailing_slot)
            .. " score=" .. tostring(score_one) .. "-" .. tostring(score_two))
        return false
    end
    local challenger_score = challenger_slot == 1 and score_one or score_two
    local other_score = challenger_slot == 1 and score_two or score_one
    if challenger_score > other_score then
        bots.match_point_challenger_slot = challenger_slot == 1 and 2 or 1
        log("MATCH_FLOW: challenger took the lead; final chance switches sides instance="
            .. tostring(instance_id)
            .. " next_challenger_slot=" .. tostring(bots.match_point_challenger_slot)
            .. " score=" .. tostring(score_one) .. "-" .. tostring(score_two))
        return false
    end
    bots.match_complete = true
    bots.final_winner_slot = leader_slot
    do
        local record = EzMapInstance.get(instance_id)
        if record then
            EzMapInstance.events:emit("match_completed", instance_id, {
                instance_id = instance_id,
                winner_slot = leader_slot,
                player_one_score = score_one,
                player_two_score = score_two,
                target = target,
            })
        end
    end
    log("MATCH_FLOW: match complete instance=" .. tostring(instance_id)
        .. " winner_slot=" .. tostring(leader_slot)
        .. " final_score=" .. tostring(score_one) .. "-" .. tostring(score_two)
        .. " target=" .. tostring(target))
    return true
end

local function complete_match_and_return(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots or bots.returning_players then return end
    bots.returning_players = true
    local return_area_id = bots.return_area_id or Config.DEFAULTS.SOURCE_AREA
    local return_position = bots.return_position
    local players = {}
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            players[#players + 1] = player_id
        end
    end
    log("MATCH_FLOW: final score display started instance=" .. tostring(instance_id)
        .. " score=" .. tostring(bots.player_one_score or 0) .. "-"
        .. tostring(bots.player_two_score or 0) .. " seconds=3")
    for _, player_id in ipairs(players) do
        if player_is_available(player_id) then
            local sound_ok, sound_result = pcall(
                Net.play_sound_for_player, player_id, Config.ASSETS.FINAL_SCORE_SFX
            )
            if not sound_ok or sound_result == false then
                log("MATCH_FLOW: final score cheer failed player="
                    .. tostring(player_id) .. " error=" .. tostring(sound_result))
            end
        end
    end
    local pulse_steps = 20
    for pulse_step = 1, pulse_steps do
        bots.final_score_pulse = (math.sin((pulse_step - 1) * math.pi / 5) + 1) / 2
        update_scoreboard(instance_id)
        await(Async.sleep(0.15))
    end
    bots.final_score_pulse = nil
    local connected_players = {}
    for _, player_id in ipairs(players) do
        connected_players[player_id] = player_is_available(player_id)
        remove_representation(player_id)
    end
    for _, player_id in ipairs(players) do
        if not connected_players[player_id] then
            log("MATCH_FLOW: skipping return for disconnected player="
                .. tostring(player_id) .. " instance=" .. tostring(instance_id))
        elseif type(Net.transfer_player) == "function" then
            local ok, result
            if return_position then
                ok, result = pcall(
                    Net.transfer_player, player_id, return_area_id, false,
                    return_position.x, return_position.y, return_position.z
                )
            else
                ok, result = pcall(Net.transfer_player, player_id, return_area_id, false)
            end
            log("MATCH_FLOW: returning player=" .. tostring(player_id)
                .. " area=" .. tostring(return_area_id)
                .. " success=" .. tostring(ok and result ~= false)
                .. " detail=" .. tostring(result))
        else
            log("MATCH_FLOW: Net.transfer_player unavailable for player="
                .. tostring(player_id))
        end
    end
    if State.instance_bots[instance_id] then
        remove_instance_bots(instance_id)
        local removed, remove_error = EzMapInstance.remove(instance_id)
        if not removed then
            log("MATCH_FLOW: instance cleanup returned false instance="
                .. tostring(instance_id) .. " detail=" .. tostring(remove_error))
        end
    end
end

local begin_next_round

local function get_animation_state_duration(bot, state_name)
    local animation, animation_error = get_footbomb_animation(bot and bot.animation_path)
    if not animation then return nil, animation_error end
    local state = animation.states and animation.states[state_name]
    local frames = state and state.framelist
    if type(frames) ~= "table" or #frames == 0 then
        return nil, "state has no frames: " .. tostring(state_name)
    end
    local duration = 0
    for _, frame in ipairs(frames) do
        duration = duration + math.max(0, tonumber(frame.duration) or 0)
    end
    if duration <= 0 then
        return nil, "state has no positive frame duration: " .. tostring(state_name)
    end
    return duration
end

local function get_animation_movement_end(bot, state_name)
    local animation, animation_error = get_footbomb_animation(bot and bot.animation_path)
    if not animation then return nil, animation_error end
    local state = animation.states and animation.states[state_name]
    local timing, timing_error = ResultTimeline.state_timing(state)
    if not timing then
        return nil, tostring(state_name) .. ": " .. tostring(timing_error)
    end
    -- Patch 6: emit the movement-end timing plan so it can be correlated
    -- against jump animation JSON and the resulting wall-clock behaviour.
    log("ANIM_DIAG: get_animation_movement_end bot=" .. tostring(bot and bot.id)
        .. " navi=" .. tostring(bot and bot.navi_name)
        .. " state=" .. tostring(state_name)
        .. " frames=" .. tostring(timing.frame_count)
        .. " total_duration=" .. tostring(timing.total_duration)
        .. " movement_duration=" .. tostring(timing.movement_duration)
        .. " final_frame_start=" .. tostring(timing.final_frame_start)
        .. " final_frame_duration=" .. tostring(timing.final_frame_duration))
    return timing.movement_duration
end

local function world_xy_distance(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then return nil end
    local dx = (tonumber(b.x) or 0) - (tonumber(a.x) or 0)
    local dy = (tonumber(b.y) or 0) - (tonumber(a.y) or 0)
    return math.sqrt(dx * dx + dy * dy)
end

local read_bot_position

local function defender_jump_position_at(start_position, target_position, ratio, movement_speed)
    ratio = math.max(0, math.min(1, tonumber(ratio) or 0))
    -- Speed shapes how progress is distributed across the fixed animation
    -- movement window; it never changes the window duration or endpoint.
    -- 5 is the neutral profile (linear progress), higher values front-load
    -- travel, and lower values ease into the movement more gradually.
    local speed = math.max(0.1, tonumber(movement_speed)
        or tonumber(Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED) or 5)
    local profile = math.max(0.5, math.min(2.0, speed / 5))
    ratio = 1 - ((1 - ratio) ^ profile)
    local sx, sy = tonumber(start_position and start_position.x) or 0,
        tonumber(start_position and start_position.y) or 0
    local tx, ty = tonumber(target_position and target_position.x) or sx,
        tonumber(target_position and target_position.y) or sy
    local sz, tz = tonumber(start_position and start_position.z) or 0,
        tonumber(target_position and target_position.z) or 0
    local dx, dy = tx - sx, ty - sy
    local distance = math.sqrt(dx * dx + dy * dy)
    local arc = math.min(0.15, distance * 0.08)
    local control_x, control_y = (sx + tx) / 2, (sy + ty) / 2
    if distance > 0.000001 then
        control_x = control_x - (dy / distance) * arc
        control_y = control_y + (dx / distance) * arc
    end
    local inverse = 1 - ratio
    return {
        x = inverse * inverse * sx + 2 * inverse * ratio * control_x + ratio * ratio * tx,
        y = inverse * inverse * sy + 2 * inverse * ratio * control_y + ratio * ratio * ty,
        z = sz + (tz - sz) * ratio,
    }
end

local function move_defender_jump_arc(bot, target, duration, phase)
    if not bot or not bot.id or type(target) ~= "table"
        or type(Net.animate_bot_properties) ~= "function" then
        log("RESULT_FLOW: jump arc keyframes unavailable bot="
            .. tostring(bot and bot.id) .. " phase=" .. tostring(phase))
        return false
    end
    bot._movement_generation = (tonumber(bot._movement_generation) or 0) + 1
    local movement_generation = bot._movement_generation
    local start = read_bot_position(bot) or bot.position
    if type(start) ~= "table" then
        log("RESULT_FLOW: jump arc start position unavailable bot="
            .. tostring(bot.id) .. " phase=" .. tostring(phase))
        return false
    end
    local sx, sy, sz = tonumber(start.x) or 0, tonumber(start.y) or 0, tonumber(start.z) or 0
    local start_position = { x = sx, y = sy, z = sz }
    local target_position = {
        x = tonumber(target.x) or sx,
        y = tonumber(target.y) or sy,
        z = tonumber(target.z) or sz,
    }
    duration = math.max(0.12, tonumber(duration) or 0.12)
    local keyframes = {
        {
            properties = {
                { property = "X", value = sx },
                { property = "Y", value = sy },
                { property = "Z", value = sz },
            },
            duration = 0
        },
    }
    local previous_ratio = 0
    for _, ratio in ipairs({ 0.2, 0.4, 0.6, 0.8, 1 }) do
        local position = defender_jump_position_at(
            start_position, target_position, ratio, Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED
        )
        keyframes[#keyframes + 1] = {
            properties = {
                { property = "X", ease = "Linear", value = position.x },
                { property = "Y", ease = "Linear", value = position.y },
                { property = "Z", ease = "Linear", value = position.z },
            },
            duration = duration * (ratio - previous_ratio),
        }
        previous_ratio = ratio
    end
    local ok, result = pcall(Net.animate_bot_properties, bot.id, keyframes)
    if not ok or result == false then
        log("RESULT_FLOW: jump arc keyframes failed bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase) .. " error=" .. tostring(result))
        return false
    end
    await(Async.sleep(duration))
    if bot._movement_generation ~= movement_generation then
        log("RESULT_FLOW: ignored stale jump-arc completion bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase)
            .. " generation=" .. tostring(movement_generation)
            .. " current_generation=" .. tostring(bot._movement_generation))
        return false
    end
    bot.position = target_position
    log("RESULT_FLOW: defender jump arc complete bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase) .. " keyframes=" .. tostring(#keyframes)
        .. " duration=" .. tostring(duration) .. " x=" .. tostring(target_position.x)
        .. " y=" .. tostring(target_position.y))
    return true
end

local function animation_frame_at_elapsed(animation, state_name, elapsed)
    local state = animation and animation.states and animation.states[state_name]
    local frames = state and state.framelist
    if type(frames) ~= "table" or #frames == 0 then return nil end
    elapsed = math.max(0, tonumber(elapsed) or 0)
    if state.loop then
        local total_duration = 0
        for _, frame in ipairs(frames) do
            total_duration = total_duration + math.max(0, tonumber(frame.duration) or 0)
        end
        if total_duration > 0 then elapsed = elapsed % total_duration end
    end
    local last = frames[#frames]
    for _, frame in ipairs(frames) do
        local duration = math.max(0, tonumber(frame.duration) or 0)
        if elapsed < duration then return frame end
        elapsed = elapsed - duration
    end
    return last
end

local function get_navi_ball_point_offset(bot, state_name, elapsed, child_z)
    local animation, animation_error = get_footbomb_animation(bot and bot.animation_path)
    if not animation then return nil, animation_error end
    local frame = animation_frame_at_elapsed(animation, state_name, elapsed)
    if not frame then return nil, "state has no frames: " .. tostring(state_name) end
    local point = frame.points and frame.points.Ball
    if type(point) ~= "table" then
        return nil, "state=" .. tostring(state_name) .. " frame has no Ball point"
    end
    local screen_offset, offset_error, meta =
        WorldAttachment.point_to_pixel_offset(frame, point)
    if not screen_offset then return nil, offset_error end
    local area_id = bot and bot.area_id
    if not area_id and bot and bot.id and type(Net.get_bot_area) == "function" then
        local area_ok, found_area = pcall(Net.get_bot_area, bot.id)
        if area_ok then area_id = found_area end
    end
    local tile_width, tile_height = 64, 32
    if area_id and type(Net.get_tile_width) == "function" then
        local ok, value = pcall(Net.get_tile_width, area_id)
        if ok and tonumber(value) and tonumber(value) > 0 then
            tile_width = tonumber(value)
        end
    end
    if area_id and type(Net.get_tile_height) == "function" then
        local ok, value = pcall(Net.get_tile_height, area_id)
        if ok and tonumber(value) and tonumber(value) > 0 then
            tile_height = tonumber(value)
        end
    end
    -- NOTE: child_z here is the LIFT (delta above the parent), not the
    -- parent's absolute z. The engine already renders the parent at its
    -- own z; we only compensate x/y for the lift we add on top.
    -- The scale is derived dynamically by world-attachment from
    -- tile_height / tile_width (0.5 for the standard 64x32 map).
    local map_offset, map_error, map_meta = WorldAttachment.pixel_offset_to_map(
        screen_offset,
        {
            projection = "isometric",
            tile_width = tile_width,
            tile_height = tile_height,
            z_correction = {
                enabled = true,
                child_z = tonumber(child_z) or 0,
            },
            anti_jitter = true,
        }
    )
    if not map_offset then return nil, map_error end
    meta = meta or {}
    meta.screen_offset_x, meta.screen_offset_y = screen_offset.x, screen_offset.y
    meta.tile_width, meta.tile_height = tile_width, tile_height
    meta.child_z_correction = map_meta and map_meta.child_z_correction
        or ((tonumber(child_z) or 0) * (tile_height / tile_width))
    meta.child_z_scale = map_meta and map_meta.scale
        or (tile_height / tile_width)
    return map_offset, nil, meta
end

read_bot_position = function(bot)
    if bot and bot.id and type(Net.get_bot_position) == "function" then
        local ok, position = pcall(Net.get_bot_position, bot.id)
        if ok and type(position) == "table" then
            return {
                x = tonumber(position.x) or 0,
                y = tonumber(position.y) or 0,
                z = tonumber(position.z) or 0,
            }
        end
    end
    local position = bot and bot.position
    if type(position) == "table" then
        return {
            x = tonumber(position.x) or 0,
            y = tonumber(position.y) or 0,
            z = tonumber(position.z) or 0,
        }
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Role-based animation events (concrete implementations)
-- ---------------------------------------------------------------------------

ensure_role_events = function(instance_id)
    local events = State.instance_role_events[instance_id]
    if not events then
        events = {
            kicker = EventEmitter.new(),
            defender = EventEmitter.new(),
            bomb = EventEmitter.new(),
            phase = EventEmitter.new(),
        }
        State.instance_role_events[instance_id] = events
    end
    return events
end

destroy_role_events = function(instance_id)
    local events = State.instance_role_events[instance_id]
    if not events then return end
    events.kicker:destroy()
    events.defender:destroy()
    events.bomb:destroy()
    events.phase:destroy()
    State.instance_role_events[instance_id] = nil
end

emit_async = function(instance_id, role, event, ...)
    local events = ensure_role_events(instance_id)
    local emitter = events[role]
    if not emitter then
        log("EMIT_FLOW: no emitter for role=" .. tostring(role)
            .. " event=" .. tostring(event)
            .. " instance=" .. tostring(instance_id))
        return Async.create_promise(function(r) r(false) end)
    end
    local arg_count = select('#', ...)
    local varargs = { n = arg_count, ... }
    local resolve
    local promise = Async.create_promise(function(r) resolve = r end)
    varargs[arg_count + 1] = resolve
    varargs.n = arg_count + 1
    local type_list = {}
    for i = 1, arg_count do
        type_list[i] = type(varargs[i])
    end
    log("EMIT_FLOW: instance=" .. tostring(instance_id)
        .. " role=" .. tostring(role)
        .. " event=" .. tostring(event)
        .. " data_args=" .. tostring(arg_count)
        .. " types=[" .. table.concat(type_list, ",") .. "]")
    emitter:emit(event, table.unpack(varargs, 1, varargs.n))
    return promise
end

local function subscribe_kicker_handlers(bot, emitter, on)
    on(emitter, "assert_ready", function()
        if bot._removed then return end
        cancel_hold(bot, "kicker-assert-ready")
        ensure_bot_direction(bot, "Up Right")
        local anim_ok, anim_err =
            set_bot_animation_state(bot.id, AnimationStates.IDLE_UR, true)
        if anim_ok then bot.animation_state = AnimationStates.IDLE_UR end
        log("KICKER_FLOW: assert_ready bot=" .. tostring(bot.id)
            .. " success=" .. tostring(anim_ok) .. " detail=" .. tostring(anim_err))
    end)
    on(emitter, "play_walk_sequence", function(move_forward, bomb_point, resolve)
        async(function()
            local function run()
                if bot._removed then return false end
                if type(move_forward) ~= "table" then
                    log("KICKER_FLOW: play_walk_sequence bad move_forward type="
                        .. type(move_forward) .. " bot=" .. tostring(bot.id))
                    return false
                end
                if type(bomb_point) ~= "table" then
                    log("KICKER_FLOW: play_walk_sequence bad bomb_point type="
                        .. type(bomb_point) .. " bot=" .. tostring(bot.id))
                    return false
                end
                local step_ok = set_result_animation(
                    bot, AnimationStates.WALK_UR, "Up Right",
                    "kicker-walk-to-move-forward"
                )
                if step_ok then
                    step_ok = move_bot_smoothly(
                        bot, move_forward, Config.GAMEPLAY.RESULT_KICKER_WALK_UR_SPEED,
                        "kicker-walk-to-move-forward", AnimationStates.WALK_UR
                    )
                end
                if step_ok then
                    step_ok = set_result_animation(
                        bot, AnimationStates.WALK_U, "Up", "kicker-walk-to-bomb"
                    )
                end
                if step_ok then
                    step_ok = move_bot_smoothly(
                        bot, bomb_point, Config.GAMEPLAY.RESULT_KICKER_WALK_U_SPEED,
                        "kicker-walk-to-bomb", AnimationStates.WALK_U
                    )
                end
                return step_ok
            end
            local ok, result = pcall(run)
            if not ok then
                log("KICKER_FLOW: walk_sequence error bot=" .. tostring(bot.id)
                    .. " err=" .. tostring(result))
            end
            if resolve then resolve(ok and result == true) end
        end)
    end)
    on(emitter, "assert_idle_u", function()
        if bot._removed then return end
        cancel_hold(bot, "kicker-assert-idle-u")
        set_result_animation(bot, AnimationStates.IDLE_U, "Up", "kicker-idle-u")
    end)
end

local function subscribe_defender_handlers(bot, emitter, on)
    on(emitter, "assert_idle", function(state_override)
        if bot._removed then return end
        cancel_hold(bot, "defender-assert-idle")
        local state = state_override or AnimationStates.FOOTBOMB_IDLE_DEFENSE
        set_result_animation(bot, state, nil, "defender-assert-idle")
    end)
    on(emitter, "assert_ready", function()
        if bot._removed then return end
        cancel_hold(bot, "defender-assert-ready")
        set_result_animation(
            bot, AnimationStates.FOOTBOMB_READY_DEFENSE, "Up",
            "defender-assert-ready"
        )
    end)
    on(emitter, "play_jump", function(direction, target, movement_duration, animation_duration, final_frame_start, resolve)
        async(function()
            local function run()
                if bot._removed then return false end
                if direction ~= "Left" and direction ~= "Right" then
                    log("DEFENDER_FLOW: play_jump requires Left/Right, got "
                        .. type(direction) .. "=" .. tostring(direction))
                    return false
                end
                if type(target) ~= "table" then
                    log("DEFENDER_FLOW: play_jump bad target type="
                        .. type(target) .. " bot=" .. tostring(bot.id))
                    return false
                end
                local jump_state = direction == "Left"
                    and AnimationStates.FOOTBOMB_JUMP_LEFT
                    or AnimationStates.FOOTBOMB_JUMP_RIGHT
                local round_events = get_round_events(bot._round_instance_id)
                -- Direction-conflation fix: pass nil so the player's Left/Right
                -- choice does NOT leak into Net.set_bot_direction. The jump
                -- states (JUMP_LEFT / JUMP_RIGHT) already carry the visual
                -- leap; the bot's sprite facing stays wherever assert_ready
                -- last set it ("Up").
                set_result_animation(
                    bot, jump_state, nil,
                    "defender-play-jump-launch", false
                )

                -- Switch to the matching single-frame END pose at the authored
                -- start of the jump state's final frame, not after the whole
                -- non-looping animation expires. The END frame matches that
                -- final jump frame, so this preserves the visual pose while
                -- preventing the engine's post-animation fallback from flashing.
                -- Transition exactly at the authored final-frame boundary.
                -- The END state's single frame matches the jump's final frame,
                -- so there is no visual pose change, only a persistent state.
                local end_state = direction == "Left"
                    and AnimationStates.FOOTBOMB_JUMP_LEFT_END
                    or AnimationStates.FOOTBOMB_JUMP_RIGHT_END
                local transition_at = math.max(0,
                    tonumber(final_frame_start) or movement_duration)
                async(function()
                    if transition_at > 0 then await(Async.sleep(transition_at)) end
                    if bot._removed then return end
                    hold_pose_for(
                        bot, end_state, nil, 2.5,
                        "defender-jump-final-frame-transition", true
                    )
                    log("DEFENDER_FLOW: jump-to-END transition bot=" .. tostring(bot.id)
                        .. " direction=" .. tostring(direction)
                        .. " jump_state=" .. tostring(jump_state)
                        .. " end_state=" .. tostring(end_state)
                        .. " final_frame_start=" .. tostring(final_frame_start)
                        .. " transition_at=" .. tostring(transition_at))
                end)
                if round_events then
                    round_events:emit(ROUND_EVENT.DEFENDER_JUMP_LAUNCHED, {
                        bot_id = bot.id,
                        direction = direction,
                        state = jump_state,
                    })
                end
                movement_duration = math.max(0.12, tonumber(movement_duration) or 0.12)
                animation_duration = math.max(movement_duration,
                    tonumber(animation_duration) or movement_duration)
                local arc_ok = move_defender_jump_arc(
                    bot, target, movement_duration, "defender-play-jump-arc"
                )
                -- Keep the authored animation running through its final frame.
                -- The bot reaches its destination at movement_duration, but the
                -- result actor does not complete until the animation boundary.
                if arc_ok and animation_duration > movement_duration then
                    await(Async.sleep(animation_duration - movement_duration))
                end
                if round_events and not bot._removed then
                    round_events:emit(ROUND_EVENT.DEFENDER_LANDING_FRAME, {
                        bot_id = bot.id,
                        direction = direction,
                        state = jump_state,
                    })
                end
                if round_events then
                    round_events:emit(ROUND_EVENT.DEFENDER_ARC_COMPLETE, {
                        bot_id = bot.id,
                        direction = direction,
                        success = arc_ok,
                    })
                end
                return arc_ok
            end
            local ok, result = pcall(run)
            if not ok then
                log("DEFENDER_FLOW: play_jump error bot=" .. tostring(bot.id)
                    .. " err=" .. tostring(result))
            end
            if resolve then resolve(ok and result == true) end
        end)
    end)
    -- Direction-conflation fix: Left/Right holds now target the authored
    -- END pose but pass nil for the direction parameter, so the player's
    -- Left/Right choice no longer triggers Net.set_bot_direction. The bot's
    -- sprite facing stays wherever assert_ready last left it. Unknown
    -- directions are rejected rather than silently falling through to
    -- READY_DEFENSE, so a typo surfaces in logs instead of rendering the
    -- wrong pose.
    on(emitter, "assert_hold", function(direction)
        if bot._removed then return end
        local hold_state
        if direction == "Left" then
            hold_state = AnimationStates.FOOTBOMB_JUMP_LEFT_END
        elseif direction == "Right" then
            hold_state = AnimationStates.FOOTBOMB_JUMP_RIGHT_END
        elseif direction == "Up" then
            hold_state = AnimationStates.FOOTBOMB_READY_DEFENSE
        else
            log("DEFENDER_FLOW: assert_hold rejected unknown direction="
                .. tostring(direction) .. " bot=" .. tostring(bot.id))
            return
        end
        hold_pose_for(
            bot, hold_state, nil,
            2.5, "defender-assert-hold-" .. tostring(direction), true
        )
    end)
end

local function subscribe_bomb_handlers(bot, emitter, on)
    on(emitter, "assert_looping", function()
        if bot._removed then return end
        set_bot_animation_state(
            bot.id,
            bot.animation_state or AnimationStates.SMALL_BOMB,
            true
        )
    end)
end

assign_bot_role = function(bot, new_role, instance_id)
    if bot._role_subscriptions then
        for _, sub in ipairs(bot._role_subscriptions) do
            sub.emitter:remove_listener(sub.event, sub.fn)
        end
    end
    bot._role_subscriptions = {}
    bot.role = new_role
    cancel_hold(bot, "role-change-to-" .. tostring(new_role))
    local events = ensure_role_events(instance_id)
    local subs = bot._role_subscriptions
    local function on(emitter, event, fn)
        emitter:on(event, fn)
        table.insert(subs, { emitter = emitter, event = event, fn = fn })
    end
    if new_role == "Kicker" then
        subscribe_kicker_handlers(bot, events.kicker, on)
    elseif new_role == "Defender" then
        subscribe_defender_handlers(bot, events.defender, on)
    end
    -- Do not change the visible pose while the selection/result screen is
    -- still visible. The round setup applies role poses after the camera has
    -- fully faded to black, then reveals them together on fade-in.
    log("ROLE_FLOW: assigned bot=" .. tostring(bot.id)
        .. " role=" .. tostring(new_role)
        .. " instance=" .. tostring(instance_id)
        .. " subscriptions=" .. tostring(#subs))
    return true
end

-- ---------------------------------------------------------------------------
-- Ball follower
-- ---------------------------------------------------------------------------

local function move_bot_follow_keyframe(bot, position, phase, duration)
    if not bot or not bot.id or type(position) ~= "table" then return false end
    duration = math.max(0.005, tonumber(duration) or 0.01)
    local start = bot.position or read_bot_position(bot) or position
    local sx, sy, sz = tonumber(start.x) or 0, tonumber(start.y) or 0, tonumber(start.z) or 0
    local tx = tonumber(position.x) or sx
    local ty = tonumber(position.y) or sy
    local tz = tonumber(position.z) or sz
    if type(Net.animate_bot_properties) ~= "function" then
        log("BALL_CATCH: keyframe follow unavailable; refusing immediate-move fallback phase="
            .. tostring(phase) .. " bot=" .. tostring(bot.id))
        return false
    end
    local start_duration = math.min(0.001, duration / 4)
    local target_duration = math.max(0.004, duration - start_duration)
    local keyframes = {
        {
            properties = {
                { property = "X", value = sx },
                { property = "Y", value = sy },
                { property = "Z", value = sz },
            },
            duration = start_duration,
        },
        {
            properties = {
                { property = "X", ease = "InOut",  value = tx },
                { property = "Y", ease = "InOut",  value = ty },
                { property = "Z", ease = "Linear", value = tz },
            },
            duration = target_duration,
        },
    }
    local ok, result = pcall(Net.animate_bot_properties, bot.id, keyframes)
    if not ok or result == false then
        log("BALL_CATCH: keyframe follow failed phase=" .. tostring(phase)
            .. " error=" .. tostring(result))
        return false
    end
    await(Async.sleep(duration))
    bot.position = { x = tx, y = ty, z = tz }
    return true
end

local function follow_defender_ball_point(instance_id, bots, ball_bot, defender,
                                          animation_state, initial_elapsed, movement_duration,
                                          animation_duration, start_position, target_position)
    if not bots.ball_follow_active or State.instance_bots[instance_id] ~= bots then
        return
    end
    if type(Net.animate_bot_properties) ~= "function" then
        log("BALL_CATCH: animation track unavailable; cannot attach ball instance="
            .. tostring(instance_id))
        bots.ball_follow_active = false
        return
    end
    local elapsed = math.max(0, tonumber(initial_elapsed) or 0)
    local finish = math.max(elapsed, tonumber(animation_duration)
        or tonumber(movement_duration) or elapsed)
    movement_duration = math.max(0.001, tonumber(movement_duration) or finish)
    local animation, animation_error =
        get_footbomb_animation(defender and defender.animation_path)
    local state = animation and animation.states and animation.states[animation_state]
    local frames = state and state.framelist
    if type(frames) ~= "table" or #frames == 0 then
        log("BALL_CATCH: cannot build Ball-point track instance=" .. tostring(instance_id)
            .. " state=" .. tostring(animation_state)
            .. " error=" .. tostring(animation_error or "state has no frames"))
        bots.ball_follow_active = false
        return
    end
    local function defender_position_at(t)
        if start_position and target_position and movement_duration > 0 then
            local ratio = math.max(0, math.min(1, t / movement_duration))
            return defender_jump_position_at(
                start_position, target_position, ratio, Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED
            )
        end
        return read_bot_position(defender) or defender.position
    end
    local times = { elapsed }
    local boundary = 0
    for _, frame in ipairs(frames) do
        boundary = boundary + math.max(0, tonumber(frame.duration) or 0)
        if boundary > elapsed + 0.000001 and boundary < finish - 0.000001 then
            times[#times + 1] = boundary
        end
    end
    if finish > elapsed + 0.000001 then times[#times + 1] = finish end
    local current = ball_bot.position or read_bot_position(ball_bot) or { x = 0, y = 0, z = 0 }
    local keyframes = {
        {
            properties = {
                { property = "X", value = tonumber(current.x) or 0 },
                { property = "Y", value = tonumber(current.y) or 0 },
                { property = "Z", value = tonumber(current.z) or 0 },
            },
            duration = 0,
        }
    }
    local previous_time = elapsed
    for i = 2, #times do
        local sample_time = times[i]
        local point_time = sample_time
        if math.abs(sample_time - finish) < 0.000001 and finish > elapsed then
            point_time = math.max(elapsed, finish - 0.000001)
        end
        local defender_position = defender_position_at(point_time)
        local lift = tonumber(Config.GAMEPLAY.RESULT_BALL_Z_LIFT) or 0.1
        -- Pass lift (delta) not defender.z + lift (absolute). Matches the
        -- catch phase so the ball does not snap at the catch→follow
        -- transition; the engine handles the defender's absolute z.
        local offset, point_error, point_meta = get_navi_ball_point_offset(
            defender, animation_state, point_time, lift
        )
        if not offset or not defender_position then
            log("BALL_CATCH: failed building Ball-point track instance="
                .. tostring(instance_id) .. " state=" .. tostring(animation_state)
                .. " elapsed=" .. tostring(point_time)
                .. " error=" .. tostring(point_error or "defender position unavailable"))
            bots.ball_follow_active = false
            return
        end
        local attached_position, attach_error = WorldAttachment.target_position(
            defender_position, offset, { z_offset = lift }
        )
        if not attached_position then
            log("BALL_CATCH: failed composing attachment position instance="
                .. tostring(instance_id) .. " error=" .. tostring(attach_error))
            bots.ball_follow_active = false
            return
        end
        log("BALL_FOLLOW: phase=sample instance=" .. tostring(instance_id)
            .. " state=" .. tostring(animation_state)
            .. " defender_z=" .. tostring(defender_position.z)
            .. " lift=" .. tostring(lift)
            .. " child_z_correction=" .. tostring(point_meta and point_meta.child_z_correction)
            .. " child_z_scale=" .. tostring(point_meta and point_meta.child_z_scale)
            .. " attached_z=" .. tostring(attached_position.z)
            .. " t=" .. tostring(point_time))
        keyframes[#keyframes + 1] = {
            properties = {
                { property = "X", ease = "Linear", value = attached_position.x },
                { property = "Y", ease = "Linear", value = attached_position.y },
                { property = "Z", ease = "Linear", value = attached_position.z },
            },
            duration = math.max(0.001, sample_time - previous_time),
        }
        previous_time = sample_time
    end
    local ok, result = pcall(Net.animate_bot_properties, ball_bot.id, keyframes)
    if not ok or result == false then
        log("BALL_CATCH: Ball-point track failed instance=" .. tostring(instance_id)
            .. " error=" .. tostring(result))
        bots.ball_follow_active = false
        return
    end
    log("BALL_CATCH: synchronized Ball-point track started instance="
        .. tostring(instance_id) .. " state=" .. tostring(animation_state)
        .. " keyframes=" .. tostring(#keyframes)
        .. " from_elapsed=" .. tostring(elapsed)
        .. " to_elapsed=" .. tostring(finish))
    if finish > elapsed then await(Async.sleep(finish - elapsed)) end
    log("BALL_CATCH: synchronized Ball-point track reached jump end instance="
        .. tostring(instance_id))
end

local function resolve_round_winner(instance_id)
    local bots = State.instance_bots[instance_id]
    local points = State.instance_spawn_points[instance_id]
    if not bots or bots.round_winner or bots.result_animation_active then return end
    local kicker, defender
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then kicker = bot end
        if bot.role == "Defender" then defender = bot end
    end
    if not kicker or not defender then
        log("RESULT_FLOW: cannot animate result; Kicker or Defender missing instance="
            .. tostring(instance_id))
        return
    end
    if not kicker.direction_choice or not defender.direction_choice then
        log("RESULT_FLOW: cannot animate result; direction missing instance="
            .. tostring(instance_id))
        return
    end
    if not points or not points.MoveForward or not points.Bomb
        or not points["Defender 1"] or not points["Defender 2"] or not points["Defender 3"]
        or not points["Bomb 1"] or not points["Bomb 2"] or not points["Bomb 3"] then
        log("RESULT_FLOW: cannot animate result; required Tiled points missing instance="
            .. tostring(instance_id))
        return
    end
    if not bots.bomb_bot or not bots.bomb_bot.id then
        log("RESULT_FLOW: cannot animate result; bomb bot missing instance="
            .. tostring(instance_id))
        return
    end
    local winner = kicker.direction_choice == defender.direction_choice
        and defender or kicker
    local target_name = RESULT_TARGET_BY_DIRECTION[kicker.direction_choice]
    local bomb_target = target_name and points[target_name]
    if not bomb_target then
        log("RESULT_FLOW: invalid kicker direction/target instance="
            .. tostring(instance_id) .. " direction=" .. tostring(kicker.direction_choice))
        return
    end
    bots.result_animation_active = true
    log("RESULT_FLOW: starting result animation instance=" .. tostring(instance_id)
        .. " kicker_direction=" .. tostring(kicker.direction_choice)
        .. " defender_direction=" .. tostring(defender.direction_choice)
        .. " predicted_winner=" .. tostring(winner.role)
        .. " bomb_target=" .. tostring(target_name))

    destroy_round_events(instance_id)
    local round_events = ensure_round_events(instance_id)
    if round_events then
        SfxDriver.attach(
            round_events, ROUND_EVENT, play_sound_for_instance,
            instance_id, server_asset_file_exists
        )
    end

    async(function()
        local role_events = ensure_role_events(instance_id)
        local bomb_position = bots.bomb_bot.position or points.Bomb

        round_events:emit(ROUND_EVENT.KICKER_STEP_STARTED, { step = "walk_to_forward" })
        local kicker_ok = await(emit_async(
            instance_id, "kicker", "play_walk_sequence",
            points.MoveForward, bomb_position
        ))
        round_events:emit(ROUND_EVENT.KICKER_STEP_COMPLETE, {
            step = "walk_to_forward", success = kicker_ok,
        })

        if kicker_ok then
            -- The kicker's walk-to-bomb just finished. All of the response
            -- planning below reads only static geometry (points), the current
            -- defender position (unchanged during the kicker walk), and the
            -- parsed animation data (prewarmed in prime_round_bot_animations).
            -- We defer the BOMB_LAUNCHED emit until after planning so the
            -- THUD and the bomb's first movement keyframe are dispatched in
            -- the same server tick — previously the THUD fired before the
            -- planning block and the bomb launched tens to hundreds of ms
            -- later, which made the SFX feel out of sync with the animation.

            -- Hoisted so catch planning, catch execution, and follow all use
            -- the same lift, keeping the ball visually attached without a
            -- snap at the catch→follow boundary.
            local ball_lift = tonumber(Config.GAMEPLAY.RESULT_BALL_Z_LIFT) or 0.1

            local defender_target_name = ({
                Left = "Defender 1", Up = "Defender 2", Right = "Defender 3",
            })[defender.direction_choice]
            local defender_target = points[defender_target_name]
            local defender_direction = defender.direction_choice == "Left" and "Left"
                or (defender.direction_choice == "Right" and "Right" or "Up")

            if not defender_target then
                log("RESULT_FLOW: defender target missing name="
                    .. tostring(defender_target_name) .. " instance=" .. tostring(instance_id))
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, { success = false, phase = "defender_target_missing" })
                bots.result_animation_active = false
                return
            end
            local defender_start = read_bot_position(defender) or defender.position
            if not defender_start then
                log("RESULT_FLOW: defender start position unavailable instance="
                    .. tostring(instance_id))
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, { success = false, phase = "defender_start_missing" })
                bots.result_animation_active = false
                return
            end

            -- Determine jump animation and measure its MOVEMENT duration.
            local jump_state = (defender.direction_choice == "Left"
                and AnimationStates.FOOTBOMB_JUMP_LEFT)
                or (defender.direction_choice == "Right"
                    and AnimationStates.FOOTBOMB_JUMP_RIGHT)
                or nil
            local jump_movement_duration = 0
            local jump_animation_duration = 0
            local jump_final_frame_start = 0
            if jump_state then
                local animation = get_footbomb_animation(defender.animation_path)
                local state = animation and animation.states and animation.states[jump_state]
                local timing = ResultTimeline.state_timing(state)
                if timing then
                    jump_movement_duration = timing.movement_duration
                    jump_animation_duration = timing.total_duration
                    jump_final_frame_start = timing.final_frame_start
                    log("ANIM_DIAG: jump clocks bot=" .. tostring(defender.id)
                        .. " state=" .. tostring(jump_state)
                        .. " movement_duration=" .. tostring(jump_movement_duration)
                        .. " animation_duration=" .. tostring(jump_animation_duration)
                        .. " final_frame_start=" .. tostring(jump_final_frame_start)
                        .. " speed_profile=" .. tostring(Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED))
                else
                    jump_movement_duration = get_animation_movement_end(defender, jump_state) or 0
                    jump_animation_duration = get_animation_state_duration(defender, jump_state)
                        or jump_movement_duration
                    local animation = get_footbomb_animation(defender.animation_path)
                    local state = animation and animation.states and animation.states[jump_state]
                    local timing = ResultTimeline.state_timing(state)
                    jump_final_frame_start = timing and timing.final_frame_start
                        or jump_movement_duration
                end
            end

            local base_bomb_speed = math.max(1, tonumber(Config.GAMEPLAY.RESULT_BOMB_MOVE_SPEED)
                or tonumber(Config.GAMEPLAY.RESULT_KICKER_WALK_U_SPEED) or 150)
            local response_bomb_speed = base_bomb_speed * 3.0
            local bomb_speed = response_bomb_speed
            local bomb_start = read_bot_position(bots.bomb_bot)
                or bots.bomb_bot.position or points.Bomb
            local bomb_target_distance = world_xy_distance(bomb_start, bomb_target) or 0
            local is_matching_jump = winner.role == "Defender"
                and (defender.direction_choice == "Left" or defender.direction_choice == "Right")
            local is_center_catch = winner.role == "Defender"
                and kicker.direction_choice == "Up" and defender.direction_choice == "Up"
            local bomb_target_travel_duration = bomb_target_distance / bomb_speed

            local shared_duration = ResultTimeline.shared_response_duration({
                jump_movement_duration = jump_movement_duration,
                jump_animation_duration = jump_animation_duration,
                defender_travel_duration = 0,
                bomb_travel_duration = bomb_target_travel_duration,
                matching_jump = is_matching_jump,
                center_catch = is_center_catch,
                minimum_duration = 0.12,
            })

            local defender_move_duration = jump_movement_duration > 0
                and jump_movement_duration or shared_duration
            local catch_duration = jump_movement_duration > 0
                and (jump_movement_duration / 2) or (shared_duration / 2)

            if is_matching_jump then
                local target_position = {
                    x = tonumber(defender_target.x) or tonumber(defender_start.x) or 0,
                    y = tonumber(defender_target.y) or tonumber(defender_start.y) or 0,
                    z = tonumber(defender_target.z) or tonumber(defender_start.z) or 0,
                }
                local start_position = {
                    x = tonumber(defender_start.x) or 0,
                    y = tonumber(defender_start.y) or 0,
                    z = tonumber(defender_start.z) or 0,
                }
                for _ = 1, 8 do
                    local contact_elapsed = catch_duration
                    local ratio = math.max(0, math.min(1,
                        contact_elapsed / (jump_movement_duration > 0
                            and jump_movement_duration or shared_duration)))
                    local midpoint = defender_jump_position_at(
                        start_position, target_position, ratio,
                        Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED
                    )
                    -- Lift is the DELTA above the defender, not midpoint.z
                    -- (which is an absolute z). This matches the follow
                    -- phase so the ball does not snap when follow starts.
                    local offset = get_navi_ball_point_offset(
                        defender, jump_state, contact_elapsed, ball_lift
                    )
                    if type(offset) == "table" then
                        local catch_position = WorldAttachment.target_position(
                            midpoint, offset, { z_offset = ball_lift }
                        )
                        if catch_position then
                            local ball_distance = world_xy_distance(bomb_start, catch_position) or 0
                            local required_speed = ball_distance / math.max(0.001, catch_duration)
                            if required_speed > response_bomb_speed then
                                response_bomb_speed = required_speed
                                bomb_speed = response_bomb_speed
                            end
                            break
                        else
                            break
                        end
                    else
                        break
                    end
                end
            elseif is_center_catch then
                -- Same delta-based child_z as the matching jump catch so the
                -- x/y correction is consistent between center and side
                -- catches. `ball_lift` is already hoisted above.
                local ready_offset = get_navi_ball_point_offset(
                    defender, AnimationStates.FOOTBOMB_READY_DEFENSE, 0,
                    ball_lift
                )
                if type(ready_offset) == "table" then
                    local ready_catch = WorldAttachment.target_position(
                        defender_target, ready_offset, { z_offset = ball_lift }
                    )
                    if ready_catch then
                        local ball_distance = world_xy_distance(bomb_start, ready_catch) or 0
                        local required_speed = ball_distance / math.max(0.001, shared_duration / 2)
                        if required_speed > response_bomb_speed then
                            response_bomb_speed = required_speed
                            bomb_speed = response_bomb_speed
                        end
                    end
                end
            end

            log("RESULT_FLOW: planned shared response timing instance=" .. tostring(instance_id)
                .. " direction=" .. tostring(defender.direction_choice)
                .. " jump_movement_duration=" .. tostring(jump_movement_duration)
                .. " jump_animation_duration=" .. tostring(jump_animation_duration)
                .. " defender_move_duration=" .. tostring(defender_move_duration)
                .. " catch_duration=" .. tostring(catch_duration)
                .. " bomb_target_distance=" .. tostring(bomb_target_distance)
                .. " bomb_target_travel_duration=" .. tostring(bomb_target_travel_duration)
                .. " response_bomb_speed=" .. tostring(response_bomb_speed)
                .. " shared_duration=" .. tostring(shared_duration)
                .. " matching_jump=" .. tostring(is_matching_jump)
                .. " center_catch=" .. tostring(is_center_catch)
                .. " ball_lift=" .. tostring(ball_lift))

            -- Planning is complete and all inputs for the launch are frozen.
            -- Dispatch the THUD in the same tick as the movement keyframes
            -- below so the SFX lines up with the bomb leaving its start
            -- position, not with the kicker's arrival (which can be followed
            -- by a variable planning delay on slower servers).
            round_events:emit(ROUND_EVENT.BOMB_LAUNCHED, {
                kicker_direction = kicker.direction_choice,
                defender_direction = defender.direction_choice,
            })

            log("RESULT_FLOW: launching bomb and defender response together instance="
                .. tostring(instance_id) .. " bomb_target=" .. tostring(target_name)
                .. " defender_target=" .. tostring(defender_target_name)
                .. " shared_duration=" .. tostring(shared_duration))

            local bomb_done, bomb_ok = false, false
            local defender_done, defender_ok = false, false

            local response_events = EzBus.new()
            local response_actor_seen = {}
            local response_results = {}
            local response_complete = false
            response_events:on("actor_done", function(actor, success)
                if response_actor_seen[actor] then return end
                response_actor_seen[actor] = true
                response_results[actor] = success
                log("RESULT_FLOW: response actor completed instance=" .. tostring(instance_id)
                    .. " actor=" .. tostring(actor) .. " success=" .. tostring(success))
                if response_actor_seen.bomb and response_actor_seen.defender then
                    response_complete = true
                    response_events:emit("response_complete", response_results)
                end
            end)
            local resolve_response
            local response_promise = Async.create_promise(function(resolve)
                resolve_response = resolve
            end)
            response_events:once("response_complete", function(results)
                resolve_response(results)
            end)
            local function mark_response_actor_done(actor, success)
                if actor == "bomb" then
                    bomb_done, bomb_ok = true, success
                elseif actor == "defender" then
                    defender_done, defender_ok = true, success
                end
                response_events:emit("actor_done", actor, success)
            end

            if is_matching_jump and defender_start then
                local start_position = {
                    x = tonumber(defender_start.x) or 0,
                    y = tonumber(defender_start.y) or 0,
                    z = tonumber(defender_start.z) or 0,
                }
                local target_position = {
                    x = tonumber(defender_target.x) or start_position.x,
                    y = tonumber(defender_target.y) or start_position.y,
                    z = tonumber(defender_target.z) or start_position.z,
                }
                local ratio = jump_movement_duration > 0
                    and (catch_duration / jump_movement_duration) or 0.5
                ratio = math.max(0, math.min(1, ratio))
                local midpoint = defender_jump_position_at(
                    start_position, target_position, ratio, Config.GAMEPLAY.RESULT_DEFENDER_JUMP_SPEED
                )
                -- Same delta-based values as the planning block above.
                local catch_offset, catch_point_error = get_navi_ball_point_offset(
                    defender, jump_state, catch_duration, ball_lift
                )
                local catch_position
                if catch_offset then
                    local catch_position_error
                    catch_position, catch_position_error = WorldAttachment.target_position(
                        midpoint, catch_offset, { z_offset = ball_lift }
                    )
                    if not catch_position then
                        log("BALL_CATCH: failed composing catch position instance="
                            .. tostring(instance_id) .. " error=" .. tostring(catch_position_error))
                        catch_offset = nil
                    end
                end
                if catch_offset then
                    log("BALL_CATCH: matching jump catch scheduled instance="
                        .. tostring(instance_id)
                        .. " direction=" .. tostring(defender.direction_choice)
                        .. " state=" .. tostring(jump_state)
                        .. " catch_elapsed=" .. tostring(catch_duration)
                        .. " jump_movement_duration=" .. tostring(jump_movement_duration)
                        .. " ball_lift=" .. tostring(ball_lift)
                        .. " catch_x=" .. tostring(catch_position.x)
                        .. " catch_y=" .. tostring(catch_position.y)
                        .. " catch_z=" .. tostring(catch_position.z))
                    async(function()
                        bomb_ok = move_bot_smoothly(
                            bots.bomb_bot, catch_position, response_bomb_speed,
                            "bomb-to-defender-ball-point", nil, catch_duration
                        )
                        if bomb_ok then
                            round_events:emit(ROUND_EVENT.BOMB_CATCH_CONTACT, {
                                match = true, center = false,
                                catch_x = catch_position.x, catch_y = catch_position.y,
                            })
                            role_events.bomb:emit("assert_looping")
                            bots.ball_follow_active = true
                            async(function()
                                follow_defender_ball_point(
                                    instance_id, bots, bots.bomb_bot, defender,
                                    jump_state, catch_duration, jump_movement_duration,
                                    jump_animation_duration, start_position, target_position
                                )
                            end)
                        end
                        mark_response_actor_done("bomb", bomb_ok)
                    end)
                else
                    log("BALL_CATCH: matching jump has no usable Ball point; using normal bomb path instance="
                        .. tostring(instance_id) .. " state=" .. tostring(jump_state)
                        .. " error=" .. tostring(catch_point_error))
                    async(function()
                        bomb_ok = move_bot_smoothly(
                            bots.bomb_bot, bomb_target, response_bomb_speed,
                            "bomb-to-" .. tostring(target_name), nil, bomb_target_travel_duration
                        )
                        if bomb_ok then
                            round_events:emit(ROUND_EVENT.BOMB_TARGET_REACHED, {})
                        end
                        mark_response_actor_done("bomb", bomb_ok)
                    end)
                end
            else
                async(function()
                    local center_catch_position
                    local bomb_move_duration  -- nil for non-center cases → natural bomb speed
                    if is_center_catch then
                        local defender_position = read_bot_position(defender)
                            or defender.position or defender_target
                        -- Delta-based; matches ball_lift and target z_offset.
                        local attach_offset, attach_error = get_navi_ball_point_offset(
                            defender, AnimationStates.FOOTBOMB_READY_DEFENSE, 0,
                            ball_lift
                        )
                        if attach_offset then
                            local attach_position_error
                            center_catch_position, attach_position_error =
                                WorldAttachment.target_position(
                                    defender_position, attach_offset,
                                    { z_offset = ball_lift }
                                )
                            if not center_catch_position then
                                log("BALL_CATCH: failed composing center catch target instance="
                                    .. tostring(instance_id) .. " error="
                                    .. tostring(attach_position_error))
                            end
                        else
                            log("BALL_CATCH: center/center Ball point unavailable instance="
                                .. tostring(instance_id) .. " error=" .. tostring(attach_error))
                        end
                        if center_catch_position then
                            bomb_move_duration = shared_duration / 2
                        end
                    end
                    local bomb_destination = center_catch_position or bomb_target
                    if defender.direction_choice == "Up" then
                        role_events.defender:emit("assert_ready")
                    end
                    -- IMPORTANT: for non-center catches, pass nil so the bomb
                    -- moves at its natural speed. Forcing shared_duration here
                    -- made the bomb move 3-4x slower than its configured
                    -- speed on non-matching rounds.
                    bomb_ok = move_bot_smoothly(
                        bots.bomb_bot, bomb_destination, response_bomb_speed,
                        is_center_catch and "bomb-to-center-ball-point"
                        or ("bomb-to-" .. tostring(target_name)),
                        nil, bomb_move_duration
                    )
                    if bomb_ok and is_center_catch and center_catch_position then
                        local defender_position = read_bot_position(defender)
                            or defender.position or defender_target
                        round_events:emit(ROUND_EVENT.BOMB_CATCH_CONTACT, {
                            match = false, center = true,
                        })
                        role_events.bomb:emit("assert_looping")
                        bots.ball_follow_active = true
                        async(function()
                            follow_defender_ball_point(
                                instance_id, bots, bots.bomb_bot, defender,
                                AnimationStates.FOOTBOMB_READY_DEFENSE, 0,
                                shared_duration / 2, shared_duration / 2,
                                defender_position, defender_position
                            )
                        end)
                        await(Async.sleep(math.max(0, shared_duration - bomb_move_duration)))
                    elseif bomb_ok then
                        round_events:emit(ROUND_EVENT.BOMB_TARGET_REACHED, {})
                    end
                    mark_response_actor_done("bomb", bomb_ok)
                end)
            end

            if defender.direction_choice == "Left" or defender.direction_choice == "Right" then
                async(function()
                    defender_ok = await(emit_async(
                        instance_id, "defender", "play_jump",
                        defender_direction, defender_target, defender_move_duration,
                        jump_animation_duration > 0 and jump_animation_duration
                            or defender_move_duration,
                        jump_final_frame_start > 0 and jump_final_frame_start
                            or defender_move_duration
                    ))
                    mark_response_actor_done("defender", defender_ok)
                end)
            else
                defender.position = {
                    x = defender_target.x, y = defender_target.y, z = defender_target.z
                }
                mark_response_actor_done("defender", true)
            end

            local completed_response = await(response_promise)
            bomb_ok = completed_response.bomb == true
            defender_ok = completed_response.defender == true
            response_events:destroy()
            log("RESULT_FLOW: event barrier released instance=" .. tostring(instance_id)
                .. " bomb_ok=" .. tostring(bomb_ok)
                .. " defender_ok=" .. tostring(defender_ok))
            round_events:emit(ROUND_EVENT.ROUND_RESPONSE_COMPLETE, {
                bomb_ok = bomb_ok, defender_ok = defender_ok,
            })
            if not bomb_ok or not defender_ok then
                log("RESULT_FLOW: synchronized bomb/defender movement failed; point not awarded instance="
                    .. tostring(instance_id) .. " bomb_ok=" .. tostring(bomb_ok)
                    .. " defender_ok=" .. tostring(defender_ok))
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, {
                    success = false, phase = "response_barrier",
                })
                bots.result_animation_active = false
                return
            end

            -- With the END states now authored, Left/Right jump conclusions
            -- hold the authored landing pose; Up still holds READY_DEFENSE.
            role_events.defender:emit("assert_hold", defender.direction_choice)
            role_events.kicker:emit("assert_idle_u")
            round_events:emit(ROUND_EVENT.DEFENDER_HOLD_STARTED, {})

            -- Diagnostic: confirm the ball's catch/follow z values match so
            -- the ball stays glued to the ball point through the END pose.
            if bots.bomb_bot and bots.bomb_bot.position then
                local bp = bots.bomb_bot.position
                local dp = defender.position or read_bot_position(defender)
                log("BALL_FLOW: catch→follow transition instance=" .. tostring(instance_id)
                    .. " bomb_z=" .. tostring(bp.z)
                    .. " defender_z=" .. tostring(dp and dp.z)
                    .. " ball_lift=" .. tostring(ball_lift)
                    .. " expected_bomb_z=" .. tostring(dp and (dp.z + ball_lift)))
            end

            award_round_point(instance_id, kicker, defender, winner)

            log("ROUND_FLOW: result hold started instance=" .. tostring(instance_id)
                .. " seconds=1.5")
            await(Async.sleep(1.5))
            bots.ball_follow_active = false
            round_events:emit(ROUND_EVENT.ROUND_HOLD_COMPLETE, {})

            role_events.defender:emit("assert_hold", defender.direction_choice)
            role_events.kicker:emit("assert_idle_u")

            if winner.role == "Kicker" then
                local bomb_bot = bots.bomb_bot
                if bomb_bot and bomb_bot.id then
                    local bomb_area_id = bomb_bot.area_id or kicker.area_id
                    round_events:emit(ROUND_EVENT.BOMB_EXPLODING, {
                        bomb_id = bomb_bot.id, area_id = bomb_area_id,
                    })
                    local explosion_ok, explosion_result = pcall(
                        EzExplosions.explode, bomb_bot.id, bomb_area_id, 5
                    )
                    log("GOAL_FX: explosion burst requested instance=" .. tostring(instance_id)
                        .. " bomb=" .. tostring(bomb_bot.id)
                        .. " area=" .. tostring(bomb_area_id)
                        .. " success=" .. tostring(explosion_ok)
                        .. " detail=" .. tostring(explosion_result)
                        .. " bomb_animation_restore=skipped")
                else
                    log("GOAL_FX: skipping explosion burst; bomb bot unavailable instance="
                        .. tostring(instance_id))
                end
            end

            local humans = {}
            for player_id, rep in pairs(State.player_representations) do
                if rep.instance_id == instance_id then
                    humans[#humans + 1] = { player_id = player_id, rep = rep }
                    if State.player_representations[player_id] == rep then
                        if winner.role == "Kicker" then
                            fade_player_to_white(player_id)
                        else
                            fade_player_to_black(player_id)
                        end
                    end
                end
            end
            round_events:emit(ROUND_EVENT.ROUND_CAMERA_FADE_STARTED, {
                participant_count = #humans,
            })
            log("ROUND_FLOW: result camera fade started instance="
                .. tostring(instance_id) .. " participant_count=" .. tostring(#humans))
            await(Async.sleep(0.85))
            round_events:emit(ROUND_EVENT.ROUND_CAMERA_FADED, {})

            update_scoreboard(instance_id)
            log("SCORE_FLOW: scoreboard updated during black transition instance="
                .. tostring(instance_id)
                .. " player_one_score=" .. tostring(bots.player_one_score or 0)
                .. " player_two_score=" .. tostring(bots.player_two_score or 0))

            bots.result_animation_active = false
            if evaluate_match_point(bots, instance_id) then
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, {
                    success = true, match_over = true,
                })
                complete_match_and_return(instance_id)
            elseif begin_next_round then
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, {
                    success = true, match_over = false,
                })
                begin_next_round(instance_id)
            else
                round_events:emit(ROUND_EVENT.ROUND_COMPLETE, {
                    success = true, match_over = false, next_round_missing = true,
                })
                log("ROUND_FLOW: next-round handler unavailable instance="
                    .. tostring(instance_id))
            end
        else
            log("RESULT_FLOW: kicker movement failed; point not awarded instance="
                .. tostring(instance_id))
            round_events:emit(ROUND_EVENT.ROUND_COMPLETE, {
                success = false, phase = "kicker",
            })
            bots.result_animation_active = false
        end
    end)
end

-- ---------------------------------------------------------------------------
-- NPC direction variety (Fisher-Yates shuffle bag)
-- ---------------------------------------------------------------------------
-- Each fill of the bag contains all three directions exactly once, in random
-- order. Picking pops from the bag; when the bag empties it refills with a
-- fresh shuffle. Consequences:
--   * No fixed cycle. The order changes every three picks.
--   * No streaks. "Left, Left, Left" is impossible within any 3-pick window.
--   * Still random-feeling. Nothing about the next pick is predictable from
--     the previous ones within a bag fill.
--
-- The bag lives on the bot record (`bot._direction_bag`) rather than on
-- `State`, so it survives the Kicker/Defender role swap each round. The
-- NPC's variety is a property of the NPC, not of the role they're in.

local function refill_npc_direction_bag(bot)
    local bag = {}
    for i, direction in ipairs(Config.DIRECTIONS.CHOICES) do
        bag[i] = direction
    end
    for i = #bag, 2, -1 do
        local j = math.random(1, i)
        bag[i], bag[j] = bag[j], bag[i]
    end
    bot._direction_bag = bag
    log("DIRECTION_FLOW: NPC direction bag refilled bot=" .. tostring(bot.id)
        .. " order=" .. table.concat(bag, ","))
    return bag
end

local function draw_npc_direction(bot)
    local bag = bot._direction_bag
    if type(bag) ~= "table" or #bag == 0 then
        bag = refill_npc_direction_bag(bot)
    end
    return table.remove(bag, 1)
end

local function finish_direction_selection_if_ready(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots or bots.directions_resolved then return end
    local humans = {}
    local human_slots = {}
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            humans[#humans + 1] = { player_id = player_id, rep = rep }
            human_slots[rep.slot] = true
            if not rep.direction_selection_confirmed then return end
        end
    end
    if #humans == 0 then return end
    for slot, bot in ipairs(bots) do
        if not human_slots[slot] then
            bot.direction_choice = draw_npc_direction(bot)
            log("DIRECTION_FLOW: server chose NPC direction instance="
                .. tostring(instance_id) .. " slot=" .. tostring(slot)
                .. " role=" .. tostring(bot.role)
                .. " direction=" .. tostring(bot.direction_choice)
                .. " bag_remaining=" .. tostring(#(bot._direction_bag or {})))
        end
    end
    bots.directions_resolved = true
    for _, entry in ipairs(humans) do
        local rep = entry.rep
        rep.direction_selection_active = false
        hide_direction_selector_ui(entry.player_id, rep)
        local bot = bots[rep.slot]
        if bot then
            if rep.selected_direction == "Left" or rep.selected_direction == "Up"
                or rep.selected_direction == "Right" then
                bot.direction_choice = rep.selected_direction
            else
                log("DIRECTION_FLOW: refusing invalid/missing human direction instance="
                    .. tostring(instance_id) .. " player=" .. tostring(entry.player_id))
            end
        end
        log("DIRECTION_FLOW: confirmed human direction instance="
            .. tostring(instance_id) .. " player=" .. tostring(entry.player_id)
            .. " role=" .. tostring(bot and bot.role)
            .. " direction=" .. tostring(rep.selected_direction))
    end
    log("DIRECTION_FLOW: all directions resolved instance=" .. tostring(instance_id))
    resolve_round_winner(instance_id)
end

local function start_direction_selection(instance_id, human_reps)
    local bots = State.instance_bots[instance_id]
    if not bots then return end
    bots.directions_resolved = false
    for _, entry in ipairs(human_reps) do
        local player_id, rep = entry.player_id, entry.rep
        rep.direction_selection_active = false
        rep.direction_selection_confirmed = false
        rep.selected_direction = nil
        rep.confirming = false
        if rep.input and rep.input_owner
            and rep.input:has_input_control(rep.input_owner) then
            rep.input:consume(rep.input_owner)
            rep.input:require_release(
                { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                rep.input_owner
            )
        end
        async(function()
            if State.player_representations[player_id] ~= rep then return end
            await(Async.sleep(Config.INPUT.DIRECTION_SETTLE_SECONDS))
            if State.player_representations[player_id] == rep then
                if rep.input and rep.input_owner
                    and rep.input:has_input_control(rep.input_owner) then
                    rep.input:consume(rep.input_owner)
                    rep.input:require_release(
                        { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                        rep.input_owner
                    )
                end
                rep.direction_selection_active = true
                rep.direction_prompt_shown = true
                show_direction_selector_ui(player_id, rep)
                log("DIRECTION_FLOW: selection prompt ready player="
                    .. tostring(player_id) .. " role=" .. tostring(bots[rep.slot].role)
                    .. " selected=none")
            end
        end)
    end
    log("DIRECTION_FLOW: started direction selection instance=" .. tostring(instance_id)
        .. " human_count=" .. tostring(#human_reps))
end

begin_next_round = function(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots or bots.round_transition_active then
        log("ROUND_FLOW: refusing duplicate next-round setup instance="
            .. tostring(instance_id))
        return
    end
    local humans = {}
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            humans[#humans + 1] = { player_id = player_id, rep = rep }
        end
    end
    if #humans == 0 then
        log("ROUND_FLOW: no participants remain; next round cancelled instance="
            .. tostring(instance_id))
        return
    end
    bots.round_transition_active = true
    bots.round_number = (tonumber(bots.round_number) or 1) + 1
    -- Hide the role swap and repositioning. Fade-out duration is 0.8s, so
    -- wait slightly longer before touching the bots' round-start poses.
    for _, entry in ipairs(humans) do
        if State.player_representations[entry.player_id] == entry.rep then
            fade_player_to_black(entry.player_id)
        end
    end
    await(Async.sleep(0.9))
    for _, bot in ipairs(bots) do
        local new_role = (bot.role == "Kicker") and "Defender" or "Kicker"
        assign_bot_role(bot, new_role, instance_id)
        bot.direction_choice = nil
    end
    bots.round_winner = nil
    bots.directions_resolved = false
    for _, entry in ipairs(humans) do
        local rep = entry.rep
        rep.direction_selection_active = false
        rep.direction_selection_confirmed = false
        rep.direction_prompt_shown = false
        rep.selected_direction = nil
        rep.confirming = false
    end
    log("ROUND_SETUP: next-round fade-out complete; applying positions and poses under black screen instance="
        .. tostring(instance_id))
    log("ROUND_FLOW: preparing next round instance=" .. tostring(instance_id)
        .. " round=" .. tostring(bots.round_number)
        .. " player_one_role=" .. tostring(bots[1] and bots[1].role)
        .. " player_two_role=" .. tostring(bots[2] and bots[2].role))
    local positioned = position_bots_for_round(instance_id)
    log("ROUND_SETUP: next-round bot positioning instance="
        .. tostring(instance_id) .. " success=" .. tostring(positioned))
    local bomb_spawned = spawn_bomb_bot_for_round(instance_id, humans)
    log("ROUND_SETUP: next-round bomb spawn instance="
        .. tostring(instance_id) .. " success=" .. tostring(bomb_spawned))
    await(Async.sleep(0.25))
    local poses_applied = apply_round_role_poses(instance_id, "next-round")
    if not poses_applied then
        -- Retry once while the cameras are still black; never reveal the bots
        -- after a failed role-pose request without checking both roles again.
        await(Async.sleep(0.15))
        poses_applied = apply_round_role_poses(instance_id, "next-round-retry")
    end
    hide_scoreboard_for_instance(instance_id)
    for _, entry in ipairs(humans) do
        local role_bot = bots[entry.rep.slot]
        if role_bot and State.player_representations[entry.player_id] == entry.rep then
            draw_role_text(entry.player_id, entry.rep, role_bot.role)
        end
    end
    for _, entry in ipairs(humans) do
        local player_id, rep = entry.player_id, entry.rep
        if State.player_representations[player_id] == rep then
            rep.camera_focus_active = true
            focus_player_camera_for_round(player_id, instance_id)
            fade_player_in(player_id)
        end
    end
    log("ROUND_FLOW: next-round fade-in started instance=" .. tostring(instance_id))
    await(Async.sleep(0.85))
    bots.round_transition_active = false
    -- The client may have dropped the round-setup animation writes that
    -- arrived during the black-screen transition, leaving the Kicker stuck
    -- on its pre-round state (typically FOOTBOMB_IDLE_DEFENSE from the
    -- skin-selection bot creation). Re-issue the pose now that the bot is
    -- visible so the client applies it. See reassert_round_start_poses.
    reassert_round_start_poses(instance_id)
    start_direction_selection(instance_id, humans)
    log("ROUND_FLOW: next round ready for direction selection instance="
        .. tostring(instance_id) .. " round=" .. tostring(bots.round_number))
end

local function confirm_direction_selection(player_id, rep)
    if not rep or rep.confirming or not rep.direction_selection_active
        or rep.direction_selection_confirmed then
        return
    end
    rep.confirming = true
    local selected = rep.selected_direction
    if selected ~= "Left" and selected ~= "Up" and selected ~= "Right" then
        rep.confirming = false
        log("DIRECTION_FLOW: ignored Confirm before direction selected player="
            .. tostring(player_id))
        if rep.input and rep.input_owner
            and rep.input:has_input_control(rep.input_owner) then
            rep.input:consume(rep.input_owner)
            rep.input:require_release(
                { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                rep.input_owner
            )
        end
        return
    end
    hide_direction_selector_ui(player_id, rep)
    local bot = State.instance_bots[rep.instance_id]
        and State.instance_bots[rep.instance_id][rep.slot]
    local role = bot and bot.role or "player"
    if rep.input and rep.input_owner
        and rep.input:has_input_control(rep.input_owner) then
        rep.input:consume(rep.input_owner)
        rep.input:require_release(
            { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
            rep.input_owner
        )
    end
    async(function()
        if State.player_representations[player_id] ~= rep then return end
        rep.direction_selection_active = false
        await_player_message(
            player_id,
            "You chose " .. string.upper(selected) .. " for your "
            .. (role == "Kicker" and "kick direction" or "defense direction")
            .. ". Would you like to confirm this selection?"
        )
        if State.player_representations[player_id] ~= rep then return end
        await(Async.sleep(Config.INPUT.DIRECTION_SETTLE_SECONDS))
        if State.player_representations[player_id] ~= rep then return end
        local choice = await_player_quiz(player_id, "Yes", "No")
        log("DIRECTION_FLOW: confirmation answer player=" .. tostring(player_id)
            .. " direction=" .. tostring(selected) .. " choice=" .. tostring(choice))
        if State.player_representations[player_id] ~= rep then return end
        await(Async.sleep(Config.INPUT.DIRECTION_SETTLE_SECONDS))
        if State.player_representations[player_id] ~= rep then return end
        if rep.input and rep.input_owner
            and rep.input:has_input_control(rep.input_owner) then
            rep.input:consume(rep.input_owner)
            rep.input:require_release(
                { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                rep.input_owner
            )
        end
        if choice == 0 then
            rep.direction_selection_confirmed = true
            rep.direction_selection_active = false
            await_player_message(
                player_id,
                "Confirmed " .. string.upper(selected)
                .. ". Waiting for the other player..."
            )
            await(Async.sleep(Config.INPUT.DIRECTION_SETTLE_SECONDS))
            if State.player_representations[player_id] == rep then
                finish_direction_selection_if_ready(rep.instance_id)
            end
        else
            rep.direction_selection_active = false
            rep.direction_prompt_shown = false
            if rep.input and rep.input_owner
                and rep.input:has_input_control(rep.input_owner) then
                rep.input:consume(rep.input_owner)
                rep.input:require_release(
                    { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                    rep.input_owner
                )
            end
            await(Async.sleep(Config.INPUT.DIRECTION_SETTLE_SECONDS))
            if State.player_representations[player_id] == rep
                and not rep.direction_selection_confirmed then
                if rep.input and rep.input_owner
                    and rep.input:has_input_control(rep.input_owner) then
                    rep.input:consume(rep.input_owner)
                    rep.input:require_release(
                        { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                        rep.input_owner
                    )
                end
                rep.direction_selection_active = true
                show_direction_selector_ui(player_id, rep)
            end
        end
        if State.player_representations[player_id] == rep then
            rep.confirming = false
        end
    end)
end

local function try_begin_match(instance_id)
    local bots = State.instance_bots[instance_id]
    if not bots or #bots < 2 then return end
    local human_reps = {}
    for player_id, rep in pairs(State.player_representations) do
        if rep.instance_id == instance_id then
            human_reps[#human_reps + 1] = { player_id = player_id, rep = rep }
            if not rep.selection_confirmed then return end
        end
    end
    if #human_reps == 0 then return end
    if bots.match_started then return end
    bots.match_started = true
    local kicker_slot = math.random(1, 2)
    local role_1 = kicker_slot == 1 and "Kicker" or "Defender"
    local role_2 = kicker_slot == 2 and "Kicker" or "Defender"
    assign_bot_role(bots[1], role_1, instance_id)
    assign_bot_role(bots[2], role_2, instance_id)
    do
        local record = EzMapInstance.get(instance_id)
        if record then
            EzMapInstance.events:emit("match_started", instance_id, {
                instance_id = instance_id,
                mode = record.metadata and record.metadata.mode,
                host_id = record.host_id,
                player_ids = record.player_ids,
                points_to_win = bots.points_to_win,
                player_one_role = bots[1].role,
                player_two_role = bots[2].role,
            })
        end
    end
    bots.player_one_score = bots.player_one_score or 0
    bots.player_two_score = bots.player_two_score or 0
    bots.round_winner = nil
    for _, entry in ipairs(human_reps) do
        local rep = entry.rep
        rep.match_started = true
        hide_selector_ui(entry.player_id, rep)
    end
    local fade_ready_count = 0
    local transition_started = false
    for _, entry in ipairs(human_reps) do
        local player_id = entry.player_id
        local rep = entry.rep
        async(function()
            await(Async.sleep(0.25))
            if State.player_representations[player_id] == rep then
                fade_player_to_black(player_id)
            end
            fade_ready_count = fade_ready_count + 1
            if fade_ready_count == #human_reps and not transition_started then
                transition_started = true
                await(Async.sleep(0.9))
                log("ROUND_SETUP: moving both bots to their assigned positions instance="
                    .. tostring(instance_id))
                local positioned = position_bots_for_round(instance_id)
                log("ROUND_SETUP: bot positioning calls complete instance="
                    .. tostring(instance_id) .. " success=" .. tostring(positioned))
                local bomb_spawned = spawn_bomb_bot_for_round(instance_id, human_reps)
                log("ROUND_SETUP: bomb bot spawn complete instance="
                    .. tostring(instance_id) .. " success=" .. tostring(bomb_spawned))
                await(Async.sleep(0.35))
                local animations_primed = prime_round_bot_animations(instance_id)
                log("ROUND_SETUP: bot animation priming returned instance="
                    .. tostring(instance_id) .. " success="
                    .. tostring(animations_primed))
                -- Always check and apply both role poses together after the
                -- screen is black, including the very first round.
                local poses_applied = apply_round_role_poses(instance_id, "first-round")
                if not poses_applied then
                    await(Async.sleep(0.15))
                    poses_applied = apply_round_role_poses(instance_id, "first-round-retry")
                end
                log("ROUND_SETUP: fading cameras in instance="
                    .. tostring(instance_id))
                for _, participant in ipairs(human_reps) do
                    local player_id = participant.player_id
                    local rep = participant.rep
                    if State.player_representations[player_id] == rep then
                        rep.camera_focus_active = true
                        focus_player_camera_for_round(player_id, instance_id)
                        fade_player_in(player_id)
                    end
                end
                log("CAMERA_FLOW: keeping Camera Focus locked after fade-in instance="
                    .. tostring(instance_id))
                hide_scoreboard_for_instance(instance_id)
                for _, participant in ipairs(human_reps) do
                    local player_id, rep = participant.player_id, participant.rep
                    local role_bot = State.instance_bots[instance_id]
                        and State.instance_bots[instance_id][rep.slot]
                    if State.player_representations[player_id] == rep and role_bot then
                        draw_role_text(player_id, rep, role_bot.role)
                    end
                end
                -- Match the next-round path: reassert after fade-in so clients
                -- that dropped the black-screen writes still show the correct
                -- round-start pose. See reassert_round_start_poses.
                await(Async.sleep(0.85))
                reassert_round_start_poses(instance_id)
                start_direction_selection(instance_id, human_reps)
            end
        end)
    end
    log("Assigned FootBomb roles for " .. tostring(instance_id)
        .. ": Player 1=" .. bots[1].role
        .. ", Player 2=" .. bots[2].role)
end

local function confirm_bomb_selection(player_id, rep)
    if not rep or rep.confirming or rep.bomb_selection_confirmed
        or rep.selection_confirmed then
        return
    end
    if State.player_representations[player_id] ~= rep then return end
    rep.bomb_selection_confirmed = true
    local option = BOMB_OPTIONS[rep.bomb_skin_index]
    hide_selector_ui(player_id, rep)
    if rep.input and rep.input_owner
        and rep.input:has_input_control(rep.input_owner) then
        rep.input:consume(rep.input_owner)
        rep.input:require_release(
            { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
            rep.input_owner
        )
    end
    log("Player " .. tostring(player_id) .. " confirmed ball skin " .. option.name)
    show_selector_ui(player_id, rep)
end

local function confirm_navi_selection(player_id, rep)
    if not rep or rep.confirming or rep.selection_confirmed then return end
    local option = NAVI_OPTIONS[rep.skin_index]
    if not option then return end
    rep.confirming = true
    hide_selector_ui(player_id, rep)
    if rep.input and rep.input_owner
        and rep.input:has_input_control(rep.input_owner) then
        rep.input:consume(rep.input_owner)
        rep.input:require_release(
            { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
            rep.input_owner
        )
    end
    async(function()
        local function representation_is_current()
            return State.player_representations[player_id] == rep
                and Net.get_player_area(player_id) == rep.area_id
        end
        if not representation_is_current() then return end
        await_player_message(
            player_id,
            "You selected " .. option.name
            .. ". Would you like to use " .. option.name .. "?"
        )
        if not representation_is_current() then return end
        local choice = await_player_quiz(player_id, "Yes", "No")
        if not representation_is_current() then return end
        await(Async.sleep(0.25))
        if choice == 0 then
            rep.selection_confirmed = true
            rep.confirmed_skin_index = rep.skin_index
            rep.confirming = false
            await_player_message(player_id, "You selected " .. option.name .. "!")
            await(Async.sleep(0.25))
            if State.player_representations[player_id] == rep then
                try_begin_match(rep.instance_id)
            end
        end
        if State.player_representations[player_id] == rep
            and not rep.selection_confirmed then
            if rep.input and rep.input_owner
                and rep.input:has_input_control(rep.input_owner) then
                rep.input:consume(rep.input_owner)
                rep.input:require_release(
                    { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                    rep.input_owner
                )
            end
            rep.confirming = false
            show_selector_ui(player_id, rep)
        end
    end)
end

-- ---------------------------------------------------------------------------
-- Ref interaction and matchmaking
-- ---------------------------------------------------------------------------

local function join_waiting_match(player_id, source_area_id, reference)
    local waiting = State.waiting_matches[source_area_id]
    if not waiting then return false end
    if State.pending_interactions[player_id] then return true end
    State.pending_interactions[player_id] = true
    async(function()
        local npc = reference.npc
        if waiting.player_id == player_id then
            await_player_message(
                player_id,
                "You're already waiting for an opponent. The next player to talk to me can join.",
                npc.mug_texture_path, npc.mug_animation_path
            )
            State.pending_interactions[player_id] = nil
            return
        end
        await_player_message(
            player_id,
            "Someone is looking for a FootBomb opponent. Would you like to join?",
            npc.mug_texture_path, npc.mug_animation_path
        )
        if Net.get_player_area(player_id) ~= source_area_id
            or State.waiting_matches[source_area_id] ~= waiting then
            State.pending_interactions[player_id] = nil
            return
        end
        local choice = await_player_quiz(
            player_id, "Join Match", "No", "Cancel",
            npc.mug_texture_path, npc.mug_animation_path
        )
        if choice == 0 and State.waiting_matches[source_area_id] == waiting then
            State.waiting_matches[source_area_id] = nil
            local ok, err = launch_player_match(waiting, player_id)
            if not ok then
                await_player_message(
                    player_id, "We couldn't start the match: " .. tostring(err),
                    npc.mug_texture_path, npc.mug_animation_path
                )
                if player_is_available(waiting.player_id) then
                    State.waiting_matches[source_area_id] = waiting
                end
            end
        else
            await_player_message(
                player_id,
                "No problem. The match is still waiting for an opponent.",
                npc.mug_texture_path, npc.mug_animation_path
            )
        end
        State.pending_interactions[player_id] = nil
    end)
    return true
end

local function begin_interaction(player_id, area_id, reference)
    if State.pending_interactions[player_id] then return end
    log("ASSET_FLOW: source-area interaction observed player=" .. tostring(player_id)
        .. " area=" .. tostring(area_id)
        .. " expected_source_area=" .. tostring(Config.DEFAULTS.SOURCE_AREA))
    if area_id == Config.DEFAULTS.SOURCE_AREA then
        provide_source_area_assets(area_id, "begin_interaction")
    end
    if join_waiting_match(player_id, area_id, reference) then return end
    State.pending_interactions[player_id] = true
    async(function()
        local npc = reference.npc
        local object = reference.object
        await_player_message(
            player_id, "Hey! Would you like to play FootBomb?",
            npc.mug_texture_path, npc.mug_animation_path
        )
        if Net.get_player_area(player_id) ~= area_id then
            State.pending_interactions[player_id] = nil
            return
        end
        local choice = await_player_quiz(
            player_id, "VS [NPC]", "VS Player", "No",
            npc.mug_texture_path, npc.mug_animation_path
        )
        if Net.get_player_area(player_id) ~= area_id then
            State.pending_interactions[player_id] = nil
            return
        end
        if choice == 0 then
            await_player_message(
                player_id, "Let's do it! I'll prepare a private field.",
                npc.mug_texture_path, npc.mug_animation_path
            )
            if Net.get_player_area(player_id) == area_id then
                launch_npc_match(player_id, area_id, object, npc)
            end
        elseif choice == 1 then
            if State.waiting_matches[area_id] then
                await_player_message(
                    player_id,
                    "Another player is already waiting for an opponent. Please let them finish matchmaking first.",
                    npc.mug_texture_path, npc.mug_animation_path
                )
            else
                State.waiting_matches[area_id] = {
                    player_id = player_id,
                    source_area_id = area_id,
                    object = object,
                    npc = npc,
                    created_at = os.time()
                }
                await_player_message(
                    player_id,
                    "All right! Stay here. The next player who talks to me can join your match.",
                    npc.mug_texture_path, npc.mug_animation_path
                )
            end
        else
            await_player_message(
                player_id, "No problem. Come back when you're ready.",
                npc.mug_texture_path, npc.mug_animation_path
            )
        end
        State.pending_interactions[player_id] = nil
    end)
end

function FootBomb.handle_player_join(player_id)
    local area_id = Net.get_player_area(player_id)
    log("ASSET_FLOW: player_join observed player=" .. tostring(player_id)
        .. " area=" .. tostring(area_id)
        .. " expected_source_area=" .. tostring(Config.DEFAULTS.SOURCE_AREA))
    if area_id == Config.DEFAULTS.SOURCE_AREA then
        provide_source_area_assets(area_id, "player_join")
    end
end

function FootBomb.handle_actor_interaction(player_id, actor_id, button)
    if button ~= nil and button ~= 0 then return end
    if State.pending_interactions[player_id] then return end
    local area_id = Net.get_player_area(player_id)
    if not area_id then return end
    local reference = State.npc_refs[area_id]
        and State.npc_refs[area_id][tostring(actor_id)]
    if reference then
        begin_interaction(player_id, area_id, reference)
    end
end

function FootBomb.handle_player_transfer(player_id)
    local area_id = Net.get_player_area(player_id)
    log("ASSET_FLOW: player_transfer observed player=" .. tostring(player_id)
        .. " area=" .. tostring(area_id)
        .. " expected_source_area=" .. tostring(Config.DEFAULTS.SOURCE_AREA))
    if area_id == Config.DEFAULTS.SOURCE_AREA then
        provide_source_area_assets(area_id, "player_transfer")
    end
    local record = EzMapInstance.get_for_player(player_id)
    if record and Net.get_player_area(player_id) ~= record.area_id then
        remove_representation(player_id)
        EzMapInstance.unregister_player(record.id, player_id)
        if record.metadata and record.metadata.party then
            record.metadata.party.members = record.player_ids
        end
        cleanup_empty_instance(record)
        return
    end
    if record and record.metadata and record.metadata.game == "footbomb" then
        local bots = State.instance_bots[record.id] or {}
        for slot, member_id in ipairs(record.player_ids or {}) do
            if member_id == player_id then
                setup_player_representation(player_id, record, bots[slot])
                break
            end
        end
    end
end

function FootBomb.handle_player_disconnect(player_id)
    State.pending_interactions[player_id] = nil
    for area_id, waiting in pairs(State.waiting_matches) do
        if waiting.player_id == player_id then
            State.waiting_matches[area_id] = nil
        end
    end
    remove_representation(player_id)
    local record = EzMapInstance.get_for_player(player_id)
    if record then
        EzMapInstance.unregister_player(record.id, player_id)
        if record.metadata and record.metadata.party then
            record.metadata.party.members = record.player_ids
        end
        cleanup_empty_instance(record)
    end
end

-- ---------------------------------------------------------------------------
-- Input and camera update
-- ---------------------------------------------------------------------------

Net:on("tick", function(event)
    for player_id, rep in pairs(State.player_representations) do
        if Net.get_player_area(player_id) == rep.area_id then
            update_direction_selector_bob(player_id, rep)
            local input = rep.input or InputAPI.get_controller(player_id)
            if input and rep.input_owner
                and input:has_input_control(rep.input_owner)
                and rep.direction_selection_active
                and not rep.confirming
                and not rep.direction_selection_confirmed then
                local chosen_direction = nil
                if input:is_action_pressed("Left", rep.input_owner) then
                    chosen_direction = "Left"
                elseif input:is_action_pressed("Up", rep.input_owner) then
                    chosen_direction = "Up"
                elseif input:is_action_pressed("Right", rep.input_owner) then
                    chosen_direction = "Right"
                elseif input:is_action_pressed("Confirm", rep.input_owner) then
                    input:consume(rep.input_owner)
                    input:require_release(
                        { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                        rep.input_owner
                    )
                    confirm_direction_selection(player_id, rep)
                end
                if chosen_direction then
                    local previous_direction = rep.selected_direction
                    local direction_changed = previous_direction ~= chosen_direction
                    rep.selected_direction = chosen_direction
                    if rep.direction_cursor_ui_visible and direction_changed then
                        rep.direction_cursor_bob_tick = 0
                        rep.direction_cursor_bob_offset = 0
                        show_direction_selector_ui(player_id, rep)
                    end
                    if direction_changed then
                        pcall(Net.play_sound_for_player, player_id, Config.ASSETS.CURSOR_SFX)
                        log("DIRECTION_FLOW: player changed direction player="
                            .. tostring(player_id) .. " direction=" .. chosen_direction)
                    else
                        log("DIRECTION_FLOW: player re-selected same direction (no change) player="
                            .. tostring(player_id) .. " direction=" .. chosen_direction)
                    end
                    input:consume(rep.input_owner)
                    input:require_release(
                        { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                        rep.input_owner
                    )
                end
            elseif input and rep.input_owner
                and input:has_input_control(rep.input_owner)
                and not rep.confirming
                and not rep.selection_confirmed
                and not rep.match_started then
                if not rep.bomb_selection_confirmed then
                    if input:is_action_pressed("Left", rep.input_owner) then
                        cycle_bomb_skin(player_id, -1)
                    elseif input:is_action_pressed("Right", rep.input_owner) then
                        cycle_bomb_skin(player_id, 1)
                    elseif input:is_action_pressed("Confirm", rep.input_owner) then
                        confirm_bomb_selection(player_id, rep)
                    end
                else
                    if input:is_action_pressed("Up", rep.input_owner) then
                        pcall(Net.play_sound_for_player, player_id, Config.ASSETS.CURSOR_SFX)
                        cycle_player_skin(player_id, -1)
                    elseif input:is_action_pressed("Down", rep.input_owner) then
                        pcall(Net.play_sound_for_player, player_id, Config.ASSETS.CURSOR_SFX)
                        cycle_player_skin(player_id, 1)
                    elseif input:is_action_pressed("Confirm", rep.input_owner) then
                        confirm_navi_selection(player_id, rep)
                    end
                end
            end
            if not rep.camera_focus_active
                and type(Net.get_bot_position) == "function"
                and type(Net.move_player_camera) == "function" then
                local ok, pos = pcall(Net.get_bot_position, rep.bot_id)
                if ok and type(pos) == "table"
                    and type(pos.x) == "number"
                    and type(pos.y) == "number" then
                    pcall(
                        Net.move_player_camera, player_id,
                        pos.x, pos.y, as_number(pos.z, 0), 0
                    )
                elseif rep.bot_record and rep.bot_record.position then
                    local fallback = rep.bot_record.position
                    pcall(
                        Net.move_player_camera, player_id,
                        fallback.x, fallback.y, fallback.z, 0
                    )
                end
            end
        end
    end
end)

return FootBomb