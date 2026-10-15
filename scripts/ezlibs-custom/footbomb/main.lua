-- FootBomb Ref NPC and match-instance entry point.
-- Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

local logger = require("scripts/ezlibs-scripts/ezlogger").get("footbomb")
local object_registry = require("scripts/ezlibs-scripts/object_registry")
local EzMapInstance = require("scripts/ezlibs-scripts/ezmapinstance")
local games = require("scripts/net-games/main")
local UISafe = require("scripts/net-games/ui-safe")
local TextLayout = require("scripts/displayer/text-layout")
local InputAPI = require("scripts/input-controller/main")
local CameraManager = require("scripts/camera/camera-manager")

-- Shared configuration/rosters live in dedicated modules so tuning and asset
-- changes do not need edits in the match lifecycle code.
local Config = require("scripts/ezlibs-custom/footbomb/constants")
local AnimationStates = require("scripts/ezlibs-custom/footbomb/animation_states")
local NAVI_OPTIONS = require("scripts/ezlibs-custom/footbomb/navi_options")
local BOMB_OPTIONS = require("scripts/ezlibs-custom/footbomb/bomb_options")

local FootBomb = {}
local npc_refs = {}                 -- area_id -> actor_id -> reference
local pending_interactions = {}    -- player_id -> true
local waiting_matches = {}         -- source area -> waiting VS Player match
local player_representations = {}  -- player_id -> bot/cursor/camera data
local instance_bots = {}           -- instance_id -> slot records
local instance_spawn_points = {}   -- instance_id -> named Player 1/2 positions

-- NPC direction choices rotate deterministically across rounds.
local npc_direction_sequence_index = 0

local DEFAULT_SOURCE_AREA = Config.DEFAULT_SOURCE_AREA
local MUG_FOLDER = Config.MUG_FOLDER
local DEFAULT_ASSET_NAME = Config.DEFAULT_ASSET_NAME
local DEFAULT_MUG_ANIMATION = Config.DEFAULT_MUG_ANIMATION
local DEFAULT_MUGSHOT_NAME = Config.DEFAULT_MUGSHOT_NAME

local BOT_ASSET_FOLDER = Config.BOT_ASSET_FOLDER
local BOMB_ASSET_FOLDER = Config.BOMB_ASSET_FOLDER

local BOMB_PREVIEW_ANIMATION = AnimationStates.BOMB_PREVIEW

local MEGAMAN_TEXTURE = NAVI_OPTIONS[1].texture
local MEGAMAN_ANIMATION = NAVI_OPTIONS[1].animation

local CURSOR_TEXTURE = Config.CURSOR_TEXTURE
local CURSOR_ANIMATION = Config.CURSOR_ANIMATION
local CURSOR_SFX = Config.CURSOR_SFX

local OFF_MAP_POSITION = Config.OFF_MAP_POSITION

-- Both selection stages use the same confirmation prompt and rendering path.
local CONFIRM_PROMPT = Config.CONFIRM_PROMPT
local CONFIRM_PROMPT_SCALE = Config.CONFIRM_PROMPT_SCALE
local CONFIRM_PROMPT_Y = Config.CONFIRM_PROMPT_Y
local NAVI_NAME_SCALE = Config.NAVI_NAME_SCALE

local SCREEN_WIDTH = Config.SCREEN_WIDTH
local SCREEN_HEIGHT = Config.SCREEN_HEIGHT
local SCREEN_CENTER = Config.SCREEN_CENTER
local SCOREBOARD_TEXTURE = Config.SCOREBOARD_TEXTURE
local SCOREBOARD_ANIMATION = Config.SCOREBOARD_ANIMATION
local SCOREBOARD_X = Config.SCOREBOARD_X
local SCOREBOARD_Y = Config.SCOREBOARD_Y
local SCOREBOARD_SCALE = Config.SCOREBOARD_SCALE
local SCORE_PLAYER_ONE_X = Config.SCORE_PLAYER_ONE_X
local SCORE_PLAYER_TWO_X = Config.SCORE_PLAYER_TWO_X
local SCORE_TEXT_Y = Config.SCORE_TEXT_Y
local SCORE_TEXT_SCALE = Config.SCORE_TEXT_SCALE

local BOMB_CURSOR_LEFT_X = Config.BOMB_CURSOR_LEFT_X
local BOMB_CURSOR_RIGHT_X = Config.BOMB_CURSOR_RIGHT_X
local BOMB_CURSOR_Y = Config.BOMB_CURSOR_Y
local BOMB_PREVIEW_X = Config.BOMB_PREVIEW_X
local BOMB_PREVIEW_Y = Config.BOMB_PREVIEW_Y
local BOMB_SELECTOR_SCALE = Config.BOMB_SELECTOR_SCALE

local function log(message)
    logger:info("[footbomb] " .. tostring(message))
end

-- Keep the target mapping shared by the live round resolver and the startup
-- diagnostic below so the printed test verifies the same mapping used in-game.
local RESULT_TARGET_BY_DIRECTION = {
    Left = "Bomb 1",
    Up = "Bomb 2",
    Right = "Bomb 3",
}

-- Diagnostic-only test: print all nine Kicker/Defender direction combinations
-- when the FootBomb module loads. This does not move bots, alter a match, or
-- award points. Remove/disable this call after verifying the logs if desired.
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

run_direction_mapping_test()

-- The camera is kept centered on the selected bot, while displayer text uses
-- virtual screen coordinates. Center the label using the measured width and
-- place it below the bot's usual screen-centered sprite position.
local function draw_confirm_prompt(player_id, text_id)
    local prompt_width = TextLayout.measureLine(
        CONFIRM_PROMPT,
        {
            font = "THICK",
            scale = CONFIRM_PROMPT_SCALE
        }
    )

    local prompt_x = math.max(
        0,
        math.floor((SCREEN_WIDTH - prompt_width) / 2)
    )

    pcall(
        games.draw_text,
        text_id,
        player_id,
        CONFIRM_PROMPT,
        prompt_x,
        CONFIRM_PROMPT_Y,
        100,
        "THICK",
        CONFIRM_PROMPT_SCALE
    )
end

local function draw_navi_name(player_id, rep, name)
    local width = TextLayout.measureLine(name, {
        font = "THICK",
        scale = NAVI_NAME_SCALE
    })

    local x = math.max(0, math.floor((SCREEN_WIDTH - width) / 2))

    pcall(
        games.draw_text,
        rep.skin_text_id,
        player_id,
        name,
        x,
        ((SCREEN_HEIGHT / 2) + 4),
        100,
        "THICK",
        NAVI_NAME_SCALE
    )
end

local function as_string(value, fallback)
    if value == nil or value == "" then
        return fallback
    end

    return tostring(value)
end

local function as_number(value, fallback)
    local parsed = tonumber(value)

    if parsed == nil then
        return fallback
    end

    return parsed
end

local function ensure_area_refs(area_id)
    npc_refs[area_id] = npc_refs[area_id] or {}
    return npc_refs[area_id]
end

local function create_ref_npc(area_id, object)
    if not object then
        return nil
    end

    local properties = object.custom_properties or {}

    local asset_name = as_string(
        properties["Asset Name"],
        DEFAULT_ASSET_NAME
    )

    local animation_name = as_string(
        properties["Animation Name"],
        asset_name
    )

    local mugshot_name = as_string(
        properties.Mugshot,
        DEFAULT_MUGSHOT_NAME
    )

    local mug_animation_name = as_string(
        properties["Mug Animation Name"],
        nil
    )

    local actor_id = "footbomb-ref-" .. tostring(area_id)
        .. "-" .. tostring(object.id)

    -- FootBomb Ref NPCs use the same dedicated asset directory as match bots.
    local animation_path = BOT_ASSET_FOLDER
        .. animation_name .. ".animation"

    local mug_animation_path =
        mug_animation_name
        and (MUG_FOLDER .. mug_animation_name .. ".animation")
        or DEFAULT_MUG_ANIMATION

    local bot_id = Net.create_bot(actor_id, {
        name = as_string(object.name, "FootBomb Ref"),
        area_id = area_id,

        texture_path = BOT_ASSET_FOLDER .. asset_name .. ".png",
        animation_path = animation_path,
        animation = AnimationStates.IDLE_DR,

        x = as_number(object.x, 0),
        y = as_number(object.y, 0),
        z = as_number(object.z, 0),

        direction = as_string(properties.Direction, "Down"),
        solid = true,
        size = 0.2,
        warp_in = false,
        dont_face_player = properties["Dont Face Player"] == true
    })

    if not bot_id then
        log("Net.create_bot failed for FootBomb Ref object "
            .. tostring(object.id))
        return nil
    end

    local reference = {
        object = object,

        npc = {
            bot_id = bot_id,
            actor_id = actor_id,
            mug_texture_path = MUG_FOLDER .. mugshot_name .. ".png",
            mug_animation_path = mug_animation_path
        }
    }

    ensure_area_refs(area_id)[tostring(actor_id)] = reference
    ensure_area_refs(area_id)[tostring(bot_id)] = reference

    log("Created FootBomb Ref " .. tostring(bot_id)
        .. " in " .. tostring(area_id))

    return reference.npc
end

object_registry.register_handler("FootBomb Ref", function(area_id, object)
    create_ref_npc(area_id, object)
end)

local function player_is_available(player_id)
    if player_id == nil then
        return false
    end

    if type(Net.is_player) == "function" then
        local ok, result = pcall(Net.is_player, player_id)

        if ok then
            return result == true
        end
    end

    if type(Net.get_player_area) == "function" then
        local ok, area = pcall(Net.get_player_area, player_id)
        return ok and area ~= nil
    end

    return false
end

local function find_named_spawn_points(area_id)
    if type(Net.list_objects) ~= "function"
        or type(Net.get_object_by_id) ~= "function"
    then
        return nil, "Net object lookup is unavailable"
    end

    local ok, object_ids = pcall(Net.list_objects, area_id)

    if not ok or type(object_ids) ~= "table" then
        return nil, "could not list objects in instance area "
            .. tostring(area_id)
    end

    local found = {}
    local required_names = {
        ["Player 1 Spawn"] = true,
        ["Player 2 Spawn"] = true,
        ["Kicker"] = true,
        ["Move Forward"] = true,
        ["Defender 1"] = true,
        ["Defender 2"] = true,
        ["Defender 3"] = true,
        ["Bomb"] = true,
        ["Bomb 1"] = true,
        ["Bomb 2"] = true,
        ["Bomb 3"] = true,
        ["Camera Focus"] = true
    }

    for _, object_id in pairs(object_ids) do
        local got, object = pcall(
            Net.get_object_by_id,
            area_id,
            object_id
        )

        if got and type(object) == "table" then
            local name = object.name

            if required_names[name] and not found[name] then
                local x, y = tonumber(object.x), tonumber(object.y)

                if x and y then
                    found[name] = {
                        x = x,
                        y = y,
                        z = as_number(object.z, 0)
                    }
                end
            end
        end
    end

    local missing = {}

    for _, name in ipairs({
        "Player 1 Spawn",
        "Player 2 Spawn",
        "Kicker",
        "Move Forward",
        "Defender 1",
        "Defender 2",
        "Defender 3",
        "Bomb",
        "Bomb 1",
        "Bomb 2",
        "Bomb 3",
        "Camera Focus"
    }) do
        if not found[name] then
            missing[#missing + 1] = '"' .. name .. '"'
        end
    end

    if #missing > 0 then
        return nil, "FootBomb map is missing point object(s): "
            .. table.concat(missing, ", ")
    end

    -- Numeric entries are the initial instance/selector positions. Named
    -- entries are the gameplay positions used at the start of every round.
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
    if bot_id then
        pcall(Net.remove_bot, bot_id, false)
    end
end

local function set_bot_animation_state(bot_id, animation_state)
    -- Support the animation setter exposed by the server runtime.
    local setter = Net.animate_bot

    if type(setter) ~= "function" then
        return false, "bot animation setter is unavailable"
    end

    local ok, result = pcall(setter, bot_id, animation_state, true)

    if not ok or result == false then
        return false, result
    end

    return true
end

local function create_match_bots(instance, spawn_points, vs_npc)
    local prefix = "footbomb-match-"
        .. tostring(instance.id):gsub("[^%w_%-]", "_")

    local actor_ids = {
        prefix .. "-player1",
        prefix .. "-player2"
    }

    local labels = {
        "FootBomb Player 1",
        vs_npc and "FootBomb Opponent" or "FootBomb Player 2"
    }

    local created = {}

    for _, option in ipairs(NAVI_OPTIONS) do
        pcall(
            Net.provide_asset_for_player,
            instance.host_id,
            option.texture
        )

        pcall(
            Net.provide_asset_for_player,
            instance.host_id,
            option.animation
        )
    end

    for slot = 1, 2 do
        local position = spawn_points[slot]

        local skin_index =
            (vs_npc and slot == 2)
            and math.random(1, #NAVI_OPTIONS)
            or 1

        local skin = NAVI_OPTIONS[skin_index]

        local ok, bot_id = pcall(Net.create_bot, actor_ids[slot], {
            name = labels[slot],
            area_id = instance.area_id,

            texture_path = skin.texture,
            animation_path = skin.animation,
            -- Keep both Navi previews/round entrants in the defensive idle.
            animation = AnimationStates.IDLE_D,

            x = position.x,
            y = position.y,
            z = position.z,

            direction = "Down",
            solid = false,
            size = 0.2,
            warp_in = false,
            dont_face_player = true
        })

        if not ok or not bot_id then
            for _, previous in ipairs(created) do
                safe_remove_bot(previous.id)
            end

            return nil, "could not create both match bots (slot "
                .. tostring(slot) .. "): " .. tostring(bot_id)
        end

        created[#created + 1] = {
            id = bot_id,
            actor_id = actor_ids[slot],
            area_id = instance.area_id,
            slot = slot,

            position = {
                x = position.x,
                y = position.y,
                z = position.z
            },

            skin_index = skin_index,
            fixed_skin = vs_npc and slot == 2,
            navi_name = skin.name,
            texture_path = skin.texture,
            animation_path = skin.animation
        }
    end

    instance_bots[instance.id] = created
    instance_spawn_points[instance.id] = spawn_points

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

        local ok, result = pcall(
            Net.provide_asset_for_player,
            player_id,
            path
        )

        if ok and result ~= false then
            provided = provided + 1
        else
            failed = failed + 1
            log("Could not provide match asset to " .. tostring(player_id)
                .. " path=" .. path .. " error=" .. tostring(result))
        end
    end

    -- Every selectable bot skin must be ready, not just the currently
    -- equipped skin: the client may see either bot and later skin changes.
    for _, option in ipairs(NAVI_OPTIONS) do
        provide(option.texture)
        provide(option.animation)
    end

    -- Bombs use paired texture/animation files, including the skins shown by
    -- the selector and the bomb used during the result sequence.
    for _, option in ipairs(BOMB_OPTIONS) do
        provide(BOMB_ASSET_FOLDER .. option.asset_name .. ".png")
        provide(BOMB_ASSET_FOLDER .. option.asset_name .. ".animation")
    end

    -- Include the cursor assets used by the instance selection UI.
    provide(CURSOR_SFX)
    provide(CURSOR_TEXTURE)
    provide(CURSOR_ANIMATION)

    log("Match assets provided for " .. tostring(player_id)
        .. ": success=" .. tostring(provided)
        .. " failed=" .. tostring(failed))

    return failed == 0
end

local function transfer_match_players(instance, player_ids, spawn_points)
    local transferred = {}

    for slot, player_id in ipairs(player_ids) do
        -- Prime the client cache before transferring so the instance's bots
        -- have their assets ready as soon as they appear.
        provide_match_assets(player_id)

        local spawn = spawn_points[slot]

        local ok, result = pcall(
            EzMapInstance.transfer_player,
            instance.id,
            player_id,
            spawn.x,
            spawn.y,
            spawn.z,
            false
        )

        if ok and result ~= false then
            transferred[#transferred + 1] = player_id

            -- Re-provide after transfer as well. Some runtimes scope asset
            -- delivery to the player's current area/instance, and the bots
            -- already exist by the time the client enters the match.
            provide_match_assets(player_id)
        else
            log("Transfer failed for " .. tostring(player_id)
                .. ": " .. tostring(result))
        end
    end

    return transferred
end

local function remove_instance_bots(instance_id)
    local bots = instance_bots[instance_id] or {}
    for _, bot in ipairs(bots) do
        safe_remove_bot(bot.id)
    end
    if bots.bomb_bot then
        safe_remove_bot(bots.bomb_bot.id)
    end

    instance_bots[instance_id] = nil
    instance_spawn_points[instance_id] = nil
end

local function cleanup_empty_instance(instance)
    if not instance
        or type(instance.player_ids) ~= "table"
        or #instance.player_ids > 0
    then
        return
    end

    remove_instance_bots(instance.id)

    local ok, err = EzMapInstance.remove(instance.id)

    if not ok then
        log("Could not remove empty instance "
            .. tostring(instance.id) .. ": " .. tostring(err))
    end
end

local function make_instance(player_id, source_area_id, object, mode)
    local props = object.custom_properties or {}

    local instance_id = "footbomb_"
        .. tostring(player_id):gsub("[^%w_%-]", "_")
        .. "_" .. tostring(os.time())

    local instance, err = EzMapInstance.create(
        as_string(props["Instance Map"], DEFAULT_SOURCE_AREA),
        instance_id,
        {
            host_id = player_id,
            player_ids = {},
            party_id = "footbomb_" .. tostring(player_id),

            metadata = {
                game = "footbomb",
                mode = mode,

                party = {
                    host_id = player_id,
                    members = {}
                }
            }
        }
    )

    if not instance then
        return nil, err
    end

    local spawn_points, spawn_error =
        find_named_spawn_points(instance.area_id)

    if not spawn_points then
        EzMapInstance.remove(instance.id)
        return nil, spawn_error
    end

    local bots, bot_error =
        create_match_bots(instance, spawn_points, mode == "npc")

    if not bots then
        EzMapInstance.remove(instance.id)
        return nil, bot_error
    end

    return instance, spawn_points
end

local function move_player_off_map(player_id, area_id)
    if type(Net.move_player) == "function" then
        local ok, result = pcall(
            Net.move_player,
            player_id,
            OFF_MAP_POSITION.x,
            OFF_MAP_POSITION.y,
            OFF_MAP_POSITION.z
        )

        if ok and result ~= false then
            return true
        end
    end

    if type(Net.transfer_player) == "function" then
        local ok, result = pcall(
            Net.transfer_player,
            player_id,
            area_id,
            false,
            OFF_MAP_POSITION.x,
            OFF_MAP_POSITION.y,
            OFF_MAP_POSITION.z
        )

        if ok and result ~= false then
            return true
        end
    end

    log("Could not move real player actor off-map for "
        .. tostring(player_id))

    return false
end

---------------------------------------------------------------------------
-- Selector UI
---------------------------------------------------------------------------

local function hide_bomb_selector_ui(player_id, rep)
    rep = rep or player_representations[player_id]
    if not rep then return end

    if rep.cursor_left then
        pcall(
            games.remove_ui_element,
            rep.cursor_left,
            player_id
        )
    end

    if rep.cursor_right then
        pcall(
            games.remove_ui_element,
            rep.cursor_right,
            player_id
        )
    end

    if rep.bomb_preview then
        -- UISafe owns both the draw instance and its physical sprite
        -- allocation. Erasing through it also deallocates the active skin,
        -- preventing stale texture reuse as the player cycles skins.
        pcall(UISafe.erase, player_id, rep.bomb_preview)
    end

    if rep.bomb_confirm_prompt_text_id then
        pcall(
            games.remove_text,
            rep.bomb_confirm_prompt_text_id,
            player_id
        )
    end
end

local function hide_selector_ui(player_id, rep)
    rep = rep or player_representations[player_id]
    if not rep then return end

    if rep.cursor_top then
        pcall(games.remove_ui_element, rep.cursor_top, player_id)
    end

    if rep.cursor_bottom then
        pcall(games.remove_ui_element, rep.cursor_bottom, player_id)
    end

    if rep.skin_text_id then
        pcall(games.remove_text, rep.skin_text_id, player_id)
    end

    if rep.confirm_prompt_text_id then
        pcall(games.remove_text, rep.confirm_prompt_text_id, player_id)
    end

    hide_bomb_selector_ui(player_id, rep)

    rep.selector_ui_visible = false
end

local function show_bomb_selector_ui(player_id, rep)
    if not rep or player_representations[player_id] ~= rep then
        return
    end

    if rep.confirming
        or rep.bomb_selection_confirmed
        or rep.selection_confirmed
        or rep.match_started
    then
        return
    end

    if Net.get_player_area(player_id) ~= rep.area_id then
        return
    end

    local option = BOMB_OPTIONS[rep.bomb_skin_index]
    if not option then return end

    local texture_path = BOMB_ASSET_FOLDER
        .. option.asset_name .. ".png"

    local animation_path = BOMB_ASSET_FOLDER
        .. option.asset_name .. ".animation"

    -- UISafe provisions the assets and creates a fresh physical allocation
    -- whenever this logical preview changes skin. That matters because some
    -- clients retain the original texture when an allocation ID is reused.

    -- Left cursor.
    pcall(
        games.add_ui_element,
        rep.cursor_left,
        player_id,
        CURSOR_TEXTURE,
        CURSOR_ANIMATION,
        "CURSOR_LEFT",
        BOMB_CURSOR_LEFT_X,
        BOMB_CURSOR_Y,
        100,
        BOMB_SELECTOR_SCALE,
        BOMB_SELECTOR_SCALE
    )

    -- Right cursor.
    pcall(
        games.add_ui_element,
        rep.cursor_right,
        player_id,
        CURSOR_TEXTURE,
        CURSOR_ANIMATION,
        "CURSOR_RIGHT",
        BOMB_CURSOR_RIGHT_X,
        BOMB_CURSOR_Y,
        100,
        BOMB_SELECTOR_SCALE,
        BOMB_SELECTOR_SCALE
    )

    -- The preview animation is centered between the two cursors. Use the
    -- shared safe sprite system rather than games.add_ui_element here: the
    -- selected skin swaps both texture and animation assets under one logical
    -- preview ID, and UISafe replaces/deallocates the physical sprite safely.
    local drawn = UISafe.draw(
        player_id,
        rep.bomb_preview,
        texture_path,
        {
            anim_path = animation_path,
            anim_state = BOMB_PREVIEW_ANIMATION,
            x = BOMB_PREVIEW_X,
            y = BOMB_PREVIEW_Y,
            z = 100,
            sx = BOMB_SELECTOR_SCALE,
            sy = BOMB_SELECTOR_SCALE
        }
    )

    if not drawn then
        log("Could not draw bomb skin preview for player "
            .. tostring(player_id) .. ": " .. option.name)
    end

    -- Use exactly the same confirmation text, styling, centering, and draw
    -- path as the Navi selector.
    draw_confirm_prompt(player_id, rep.bomb_confirm_prompt_text_id)
end

local function show_selector_ui(player_id, rep)
    if not rep or player_representations[player_id] ~= rep then
        return
    end

    if rep.confirming or rep.selection_confirmed or rep.match_started then
        return
    end

    if Net.get_player_area(player_id) ~= rep.area_id then
        return
    end

    if rep.selector_ui_visible then
        return
    end

    -- Stage 1: select and confirm the ball skin before choosing a Navi.
    if not rep.bomb_selection_confirmed then
        show_bomb_selector_ui(player_id, rep)
        rep.selector_ui_visible = true
        return
    end

    -- Stage 2: the existing Navi selector.
    local bot_x = math.floor(SCREEN_WIDTH / 2)
    local bot_y = math.floor(SCREEN_HEIGHT / 2)

    pcall(
        games.add_ui_element,
        rep.cursor_top,
        player_id,
        CURSOR_TEXTURE,
        CURSOR_ANIMATION,
        "CURSOR_UP",
        bot_x,
        bot_y - 40,
        100,
        2.0,
        2.0
    )

    pcall(
        games.add_ui_element,
        rep.cursor_bottom,
        player_id,
        CURSOR_TEXTURE,
        CURSOR_ANIMATION,
        "CURSOR_DOWN",
        bot_x,
        bot_y + 20,
        100,
        2.0,
        2.0
    )

    draw_navi_name(
        player_id,
        rep,
        NAVI_OPTIONS[rep.skin_index].name
    )

    draw_confirm_prompt(player_id, rep.confirm_prompt_text_id)

    rep.selector_ui_visible = true
end

---------------------------------------------------------------------------
-- Player representation lifecycle
---------------------------------------------------------------------------

local function remove_representation(player_id)
    local rep = player_representations[player_id]
    if not rep then return end

    hide_selector_ui(player_id, rep)
    if rep.scoreboard_ui_id then
        pcall(games.remove_ui_element, rep.scoreboard_ui_id, player_id)
    end
    if rep.score_player_one_text_id then
        pcall(games.remove_text, rep.score_player_one_text_id, player_id)
    end
    if rep.score_player_two_text_id then
        pcall(games.remove_text, rep.score_player_two_text_id, player_id)
    end

    -- Net.toggle_player_hud is the engine API used by Simon Says to hide and
    -- restore the player's HUD around a minigame. Only undo the toggle when
    -- this representation successfully applied it.
    if rep.hud_hidden and type(Net.toggle_player_hud) == "function" then
        pcall(Net.toggle_player_hud, player_id)
        rep.hud_hidden = false
    end

    -- Return the shared controller to the unclaimed state only if this
    -- representation still owns it. Never release a newer system's lease.
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

    -- Simon Says explicitly locks player input while its minigame is active.
    -- This engine emits virtual_input events while input is locked; FootBomb's
    -- shared InputController depends on those events for directional selection.
    -- Release the lock when the FootBomb representation is removed.
    if type(Net.unlock_player_input) == "function" then
        local ok, err = pcall(Net.unlock_player_input, player_id)

        if not ok then
            log("Could not unlock player input during FootBomb cleanup: "
                .. tostring(err))
        end
    end

    player_representations[player_id] = nil
end

local function setup_player_representation(player_id, instance, bot_record)
    if not instance
        or not bot_record
        or Net.get_player_area(player_id) ~= instance.area_id
    then
        return
    end

    local existing = player_representations[player_id]

    if existing
        and existing.instance_id == instance.id
        and existing.slot == bot_record.slot
    then
        -- Transfer events can fire more than once. Preserve the existing UI
        -- and assignment.
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

        -- Navi selector UI.
        cursor_top = "footbomb_cursor_top_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        cursor_bottom = "footbomb_cursor_bottom_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        skin_text_id = "footbomb_navi_name_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        confirm_prompt_text_id = "footbomb_navi_confirm_prompt_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        -- Ball selector UI.
        cursor_left = "footbomb_bomb_cursor_left_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        cursor_right = "footbomb_bomb_cursor_right_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        bomb_preview = "footbomb_bomb_preview_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        bomb_confirm_prompt_text_id = "footbomb_bomb_confirm_prompt_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        scoreboard_ui_id = "footbomb_scoreboard_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_one_text_id = "footbomb_score_p1_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),
        score_player_two_text_id = "footbomb_score_p2_"
            .. tostring(player_id):gsub("[^%w_%-]", "_"),

        -- Selection state.
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

        input = InputAPI.get_controller(player_id)
            or InputAPI.create_controller(player_id),

        input_owner = "footbomb:"
            .. tostring(instance.id)
            .. ":"
            .. tostring(player_id)
    }

    player_representations[player_id] = rep

    -- Hide the standard HUD while FootBomb's dedicated selector/game view is
    -- active. Restore it in remove_representation during match exit/disconnect.
    if type(Net.toggle_player_hud) == "function" then
        local ok, err = pcall(Net.toggle_player_hud, player_id)

        if ok then
            rep.hud_hidden = true
        else
            log("Could not hide player HUD for "
                .. tostring(player_id) .. ": " .. tostring(err))
        end
    else
        log("Net.toggle_player_hud is unavailable; standard HUD will remain visible")
    end

    -- Match Simon Says' input lifecycle: lock normal player movement while
    -- FootBomb is active so the engine emits virtual_input events to the shared
    -- InputController. The player actor is off-map, so ordinary movement is
    -- not useful here; the selector needs the virtual input stream instead.
    if type(Net.lock_player_input) == "function" then
        local ok, err = pcall(Net.lock_player_input, player_id)

        if ok then
            log("selector locked player input for virtual_input player="
                .. tostring(player_id))
        else
            log("Could not lock player input for selector player="
                .. tostring(player_id) .. ": " .. tostring(err))
        end
    else
        log("Net.lock_player_input is unavailable; selector virtual_input may not be emitted")
    end

    -- Entering FootBomb is an explicit context handoff: take exclusive input
    -- ownership from the camera controller (or another previous UI owner).
    if rep.input then
        local claimed = rep.input:claim_input(rep.input_owner, true)

        if claimed then
            -- Clear any edge left over from the previous UI/context, then
            -- require every selector action to be released before accepting
            -- a fresh press.
            rep.input:consume(rep.input_owner)

            rep.input:require_release(
                { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                rep.input_owner
            )
        else
            log("Could not claim input for player " .. tostring(player_id))
        end
    else
        log("No input controller available for player " .. tostring(player_id))
    end

    show_selector_ui(player_id, rep)

    -- The real player actor is intentionally moved off-map. Do NOT lock the
    -- camera to that actor: doing so pins the view at roughly (-1000, -1000)
    -- and makes the player activate the free-camera controller to see the bot.
    move_player_off_map(player_id, instance.area_id)

    if type(Net.unlock_player_camera) == "function" then
        pcall(Net.unlock_player_camera, player_id)
    end

    -- Set an immediate initial focus; the tick handler keeps tracking the bot.
    local position = bot_record.position

    if type(Net.get_bot_position) == "function" then
        local ok, current = pcall(
            Net.get_bot_position,
            bot_record.id
        )

        if ok
            and type(current) == "table"
            and type(current.x) == "number"
            and type(current.y) == "number"
        then
            position = {
                x = current.x,
                y = current.y,
                z = as_number(
                    current.z,
                    position and position.z or 0
                )
            }
        end
    end

    if position and type(Net.move_player_camera) == "function" then
        pcall(
            Net.move_player_camera,
            player_id,
            position.x,
            position.y,
            position.z or 0,
            0
        )
    end
end

local function setup_representations_for_match(instance, player_ids, bots)
    for slot, player_id in ipairs(player_ids) do
        setup_player_representation(
            player_id,
            instance,
            bots[slot]
        )
    end
end

---------------------------------------------------------------------------
-- Match creation
---------------------------------------------------------------------------

local function launch_npc_match(player_id, source_area_id, object, npc)
    if not player_is_available(player_id) then
        return
    end

    local instance, spawn_or_error = make_instance(
        player_id,
        source_area_id,
        object,
        "npc"
    )

    if not instance then
        await(Async.message_player(
            player_id,
            "I couldn't open the FootBomb field right now: "
                .. tostring(spawn_or_error)
        ))

        log("NPC match setup failed: " .. tostring(spawn_or_error))
        return
    end

    local spawn_points = spawn_or_error

    local transferred = transfer_match_players(
        instance,
        { player_id },
        spawn_points
    )

    if #transferred ~= 1 then
        remove_instance_bots(instance.id)
        EzMapInstance.remove(instance.id)

        await(Async.message_player(
            player_id,
            "I couldn't transfer you to the FootBomb field. Please try again."
        ))

        return
    end

    -- Human owns Player 1. Player 2 remains a fixed MegaMan NPC opponent.
    setup_player_representation(
        player_id,
        instance,
        instance_bots[instance.id][1]
    )

    log("Started private VS NPC match " .. tostring(instance.id))
end

local function launch_player_match(waiting, second_player)
    local first_player = waiting.player_id

    if not player_is_available(first_player)
        or not player_is_available(second_player)
    then
        return false, "One of the players is no longer available."
    end

    local instance, spawn_or_error = make_instance(
        first_player,
        waiting.source_area_id,
        waiting.object,
        "player"
    )

    if not instance then
        return false, tostring(spawn_or_error)
    end

    local spawn_points = spawn_or_error

    instance.host_id = first_player
    instance.metadata.party.members = {
        first_player,
        second_player
    }

    -- Matchmaking order is server-owned: waiting player is Player 1,
    -- joiner is Player 2.
    local transferred = transfer_match_players(
        instance,
        { first_player, second_player },
        spawn_points
    )

    if #transferred ~= 2 then
        remove_instance_bots(instance.id)

        for _, player_id in ipairs(transferred) do
            pcall(
                Net.transfer_player,
                player_id,
                waiting.source_area_id,
                false
            )
        end

        EzMapInstance.remove(instance.id)

        return false, "I couldn't transfer both players to the FootBomb field."
    end

    setup_representations_for_match(
        instance,
        { first_player, second_player },
        instance_bots[instance.id]
    )

    log("Started VS Player match " .. tostring(instance.id))
    return true
end

---------------------------------------------------------------------------
-- Skin selection
---------------------------------------------------------------------------

local function cycle_player_skin(player_id, direction)
    local rep = player_representations[player_id]

    if not rep
        or rep.confirming
        or rep.selection_confirmed
        or not rep.bot_record
        or rep.bot_record.fixed_skin
    then
        return
    end

    local next_index =
        ((rep.skin_index - 1 + direction) % #NAVI_OPTIONS) + 1

    if next_index == rep.skin_index then
        return
    end

    local option = NAVI_OPTIONS[next_index]
    local position = rep.bot_record.position
    local old_id = rep.bot_record.id

    pcall(Net.provide_asset_for_player, player_id, option.texture)
    pcall(Net.provide_asset_for_player, player_id, option.animation)

    safe_remove_bot(old_id)

    local ok, new_id = pcall(Net.create_bot, rep.actor_id, {
        name = rep.slot == 1
            and "FootBomb Player 1"
            or "FootBomb Player 2",

        area_id = rep.area_id,

        texture_path = option.texture,
        animation_path = option.animation,
        animation = option.animation_state or AnimationStates.IDLE_D,

        x = position.x,
        y = position.y,
        z = position.z,

        direction = "Down",
        solid = false,
        size = 0.2,
        warp_in = false,
        dont_face_player = true
    })

    if not ok or not new_id then
        log("Could not change Navi skin for "
            .. tostring(player_id) .. ": " .. tostring(new_id))

        local old_option = NAVI_OPTIONS[rep.skin_index]

        local restore_ok, restored_id = pcall(
            Net.create_bot,
            rep.actor_id,
            {
                name = rep.slot == 1
                    and "FootBomb Player 1"
                    or "FootBomb Player 2",

                area_id = rep.area_id,

                texture_path = old_option.texture,
                animation_path = old_option.animation,
                animation = old_option.animation_state or AnimationStates.IDLE_D,

                x = position.x,
                y = position.y,
                z = position.z,

                direction = "Down",
                solid = false,
                size = 0.2,
                warp_in = false,
                dont_face_player = true
            }
        )

        if restore_ok and restored_id then
            rep.bot_record.id = restored_id
            rep.bot_record.skin_index = rep.skin_index
            rep.bot_record.navi_name = old_option.name
            rep.bot_record.texture_path = old_option.texture
            rep.bot_record.animation_path = old_option.animation
            rep.bot_id = restored_id

            local slots = instance_bots[rep.instance_id]
            if slots and slots[rep.slot] then
                slots[rep.slot].id = restored_id
                slots[rep.slot].skin_index = rep.skin_index
                slots[rep.slot].navi_name = old_option.name
                slots[rep.slot].texture_path = old_option.texture
                slots[rep.slot].animation_path = old_option.animation
            end
        end

        return
    end

    -- Keep the bot record's complete skin identity in sync with the newly
    -- created bot. Round-start avatar refreshes use these paths; leaving the
    -- old paths here can silently replace a selected Navi with MegaMan.
    rep.skin_index = next_index
    rep.bot_record.skin_index = next_index
    rep.bot_record.navi_name = option.name
    rep.bot_record.texture_path = option.texture
    rep.bot_record.animation_path = option.animation
    rep.bot_record.id = new_id
    rep.bot_id = new_id

    -- Re-draw so the x position is re-centered for names of different widths.
    if rep.selector_ui_visible then
        draw_navi_name(player_id, rep, option.name)
    end

    local slots = instance_bots[rep.instance_id]

    if slots and slots[rep.slot] then
        slots[rep.slot].id = new_id
        slots[rep.slot].skin_index = next_index
        slots[rep.slot].navi_name = option.name
        slots[rep.slot].texture_path = option.texture
        slots[rep.slot].animation_path = option.animation
    end

    log("Player " .. tostring(player_id)
        .. " selected " .. option.name
        .. " skin_index=" .. tostring(next_index)
        .. " texture_path=" .. tostring(option.texture)
        .. " animation_path=" .. tostring(option.animation))
end

local function cycle_bomb_skin(player_id, direction)
    local rep = player_representations[player_id]

    if not rep
        or rep.confirming
        or rep.bomb_selection_confirmed
        or rep.selection_confirmed
        or rep.match_started
    then
        return
    end

    local next_index =
        ((rep.bomb_skin_index - 1 + direction) % #BOMB_OPTIONS) + 1

    if next_index == rep.bomb_skin_index then
        return
    end

    local option = BOMB_OPTIONS[next_index]

    rep.bomb_skin_index = next_index

    -- Remove the previous preview element before recreating it with the
    -- selected skin's texture and animation.
    hide_bomb_selector_ui(player_id, rep)
    show_bomb_selector_ui(player_id, rep)

    pcall(Net.play_sound_for_player, player_id, CURSOR_SFX)

    log("Player " .. tostring(player_id)
        .. " previewing ball skin " .. option.name)
end

local function fade_player_to_black(player_id)
    local ok, err = pcall(
        Net.fade_player_camera,
        player_id,
        { r = 0, g = 0, b = 0, a = 255 },
        0.8
    )

    if not ok then
        log("Camera fade-to-black failed for "
            .. tostring(player_id) .. ": " .. tostring(err))
        return false
    end

    return true
end

local function fade_player_in(player_id)
    local ok, err = pcall(
        Net.fade_player_camera,
        player_id,
        { r = 0, g = 0, b = 0, a = 0 },
        0.8
    )

    if not ok then
        log("Camera fade-in failed for "
            .. tostring(player_id) .. ": " .. tostring(err))
        return false
    end

    return true
end

-- Place a participant's camera at the map's named intro framing point.
-- This is a one-time camera placement for the reveal; the normal Navi camera
-- follow loop resumes afterward.
local function focus_player_camera_for_round(player_id, instance_id)
    local points = instance_spawn_points[instance_id]
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
        Net.move_player_camera,
        player_id,
        focus.x,
        focus.y,
        focus.z or 0,
        0
    )

    log("CAMERA_FLOW: positioned player camera at Camera Focus player="
        .. tostring(player_id) .. " instance=" .. tostring(instance_id)
        .. " x=" .. tostring(focus.x) .. " y=" .. tostring(focus.y)
        .. " z=" .. tostring(focus.z or 0)
        .. " pcall_ok=" .. tostring(ok)
        .. " return=" .. tostring(result))

    return ok and result ~= false
end

-- This positioning helper is deliberately independent from Navi and bomb
-- skin selection. The same helper can be called again when a new round starts.
local function position_bots_for_round(instance_id)
    local bots = instance_bots[instance_id]
    local points = instance_spawn_points[instance_id]

    if not bots or #bots < 2 or not points then
        log("Cannot position FootBomb round bots; match data is missing for "
            .. tostring(instance_id))
        return false
    end

    local all_ok = true

    -- First move both bots. Do not change pose/facing until all movement
    -- calls have completed, so the kicker setup is applied after positioning.
    for _, bot in ipairs(bots) do
        local is_kicker = bot.role == "Kicker"
        local target = is_kicker and points.Kicker or points["Defender 2"]

        if not target then
            log("Missing round position for role " .. tostring(bot.role))
            all_ok = false
        else
            local move_ok, move_result = pcall(
                Net.move_bot,
                bot.id,
                target.x,
                target.y,
                target.z or 0
            )

            if not move_ok or move_result == false then
                log("Could not move FootBomb bot " .. tostring(bot.id)
                    .. " to role position " .. tostring(bot.role)
                    .. ": " .. tostring(move_result))
                all_ok = false
            else
                bot.position = {
                    x = target.x,
                    y = target.y,
                    z = target.z or 0
                }
            end
        end
    end

    return all_ok
end

-- Spawn the ball as a non-solid bot at the Tiled point object named "Bomb".
-- The Kicker's confirmed ball selection determines which bomb assets are used.
local function spawn_bomb_bot_for_round(instance_id, human_reps)
    local bots = instance_bots[instance_id]
    local points = instance_spawn_points[instance_id]
    if not bots or not points or not points.Bomb then
        log("BOMB_FLOW: cannot spawn bomb; match data or Tiled Bomb point is missing for "
            .. tostring(instance_id))
        return false
    end

    local kicker
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then
            kicker = bot
            break
        end
    end
    if not kicker then
        log("BOMB_FLOW: cannot spawn bomb; no Kicker role for " .. tostring(instance_id))
        return false
    end

    -- Default to the first skin when the Kicker is an NPC. For a human Kicker,
    -- use that player's confirmed bomb selector choice.
    local bomb_skin_index = 1
    for _, entry in ipairs(human_reps or {}) do
        local rep = entry.rep
        if rep and rep.slot == kicker.slot then
            bomb_skin_index = tonumber(rep.bomb_skin_index) or 1
            break
        end
    end
    if bomb_skin_index < 1 or bomb_skin_index > #BOMB_OPTIONS then
        bomb_skin_index = 1
    end

    local option = BOMB_OPTIONS[bomb_skin_index] or BOMB_OPTIONS[1]
    local texture_path = BOMB_ASSET_FOLDER .. option.asset_name .. ".png"
    local animation_path = BOMB_ASSET_FOLDER .. option.asset_name .. ".animation"
    local actor_id = "footbomb-match-"
        .. tostring(instance_id):gsub("[^%w_%-]", "_") .. "-bomb"

    if bots.bomb_bot then
        safe_remove_bot(bots.bomb_bot.id)
        bots.bomb_bot = nil
    end

    local point = points.Bomb
    log("BOMB_FLOW: spawning bomb instance=" .. tostring(instance_id)
        .. " kicker_slot=" .. tostring(kicker.slot)
        .. " skin=" .. tostring(option.name)
        .. " texture_path=" .. tostring(texture_path)
        .. " animation_path=" .. tostring(animation_path)
        .. " position={x=" .. tostring(point.x)
        .. ",y=" .. tostring(point.y) .. ",z=" .. tostring(point.z or 0) .. "}")

    local create_ok, bomb_id = pcall(Net.create_bot, actor_id, {
        name = "FootBomb Bomb",
        area_id = kicker.area_id,
        texture_path = texture_path,
        animation_path = animation_path,
        animation = AnimationStates.SMALL_BOMB,
        x = point.x,
        y = point.y,
        z = point.z or 0,
        direction = "Down",
        solid = false,
        size = 0.2,
        warp_in = false,
        dont_face_player = true
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
        skin_index = bomb_skin_index,
        skin_name = option.name,
        texture_path = texture_path,
        animation_path = animation_path,
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

    local animation_ok, animation_result = pcall(
        Net.animate_bot, bomb_id, AnimationStates.SMALL_BOMB, true
    )
    log("BOMB_FLOW: Small-Bomb animation request returned bot="
        .. tostring(bomb_id) .. " pcall_ok=" .. tostring(animation_ok)
        .. " return=" .. tostring(animation_result))

    return animation_ok and animation_result ~= false
end

-- Apply a custom defensive animation state after the bot has reached its
-- round position. Refreshing the avatar assets first is important for clients
-- that have not bound the bot's animation file yet.
local function set_defender_animation_for_round(instance_id, animation_state, phase)
    local bots = instance_bots[instance_id]
    if not bots then
        return false
    end

    local defender
    for _, bot in ipairs(bots) do
        if bot.role == "Defender" then
            defender = bot
            break
        end
    end

    if not defender then
        log("ANIM_FLOW: cannot set defender animation; no Defender bot for "
            .. tostring(instance_id) .. " phase=" .. tostring(phase))
        return false
    end

    log("ANIM_FLOW: applying defender animation bot=" .. tostring(defender.id)
        .. " phase=" .. tostring(phase)
        .. " state=" .. tostring(animation_state)
        .. " navi=" .. tostring(defender.navi_name))

    if defender.texture_path and defender.animation_path
        and type(Net.set_bot_avatar) == "function" then
        local avatar_ok, avatar_result = pcall(
            Net.set_bot_avatar,
            defender.id,
            defender.texture_path,
            defender.animation_path
        )
        log("ANIM_FLOW: defender avatar refresh returned bot="
            .. tostring(defender.id) .. " phase=" .. tostring(phase)
            .. " pcall_ok=" .. tostring(avatar_ok)
            .. " return=" .. tostring(avatar_result))
    end

    local animation_ok, animation_result = pcall(
        Net.animate_bot, defender.id, animation_state, true
    )
    log("ANIM_FLOW: defender animation call returned bot="
        .. tostring(defender.id) .. " phase=" .. tostring(phase)
        .. " state=" .. tostring(animation_state)
        .. " pcall_ok=" .. tostring(animation_ok)
        .. " return=" .. tostring(animation_result))

    if not animation_ok or animation_result == false then
        log("Could not set FootBomb defender animation bot="
            .. tostring(defender.id) .. " phase=" .. tostring(phase)
            .. " state=" .. tostring(animation_state) .. ": "
            .. tostring(animation_result))
        return false
    end

    return true
end

-- Apply the kicker's pose only after the round-position moves have been sent.
-- OpenNetBattle direction values use spaces ("Up Right"), not underscores.
local function set_kicker_pose_for_round(instance_id)
    local bots = instance_bots[instance_id]
    if not bots then
        return false
    end

    local kicker
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then
            kicker = bot
            break
        end
    end

    if not kicker then
        log("Cannot set FootBomb kicker pose; no Kicker bot for "
            .. tostring(instance_id))
        return false
    end

    -- Confirm the bot is still registered before changing its pose.
    local is_bot_ok, is_bot_result = pcall(Net.is_bot, kicker.id)
    local area_ok, area_result = pcall(Net.get_bot_area, kicker.id)
    local position_ok, position_result = pcall(Net.get_bot_position, kicker.id)
    local direction_before_ok, direction_before =
        pcall(Net.get_bot_direction, kicker.id)
    log("ANIM_FLOW: kicker preflight bot=" .. tostring(kicker.id)
        .. " is_bot_ok=" .. tostring(is_bot_ok)
        .. " is_bot=" .. tostring(is_bot_result)
        .. " area_ok=" .. tostring(area_ok)
        .. " area=" .. tostring(area_result)
        .. " position_ok=" .. tostring(position_ok)
        .. " position=" .. tostring(position_result)
        .. " direction_ok=" .. tostring(direction_before_ok)
        .. " direction=" .. tostring(direction_before))

    -- Re-apply the same avatar assets before requesting the state. This is a
    -- targeted test for clients that have not bound the bot's animation file
    -- yet; it does not change the selected Navi skin.
    if kicker.texture_path and kicker.animation_path
        and type(Net.set_bot_avatar) == "function" then
        log("ANIM_FLOW: refreshing kicker avatar assets bot="
            .. tostring(kicker.id)
            .. " animation_path=" .. tostring(kicker.animation_path))
        local avatar_ok, avatar_result = pcall(
            Net.set_bot_avatar,
            kicker.id,
            kicker.texture_path,
            kicker.animation_path
        )
        log("ANIM_FLOW: kicker avatar refresh returned bot="
            .. tostring(kicker.id)
            .. " pcall_ok=" .. tostring(avatar_ok)
            .. " return=" .. tostring(avatar_result))
    end

    log("ANIM_FLOW: applying kicker direction bot="
        .. tostring(kicker.id) .. " direction=Up Right")
    local direction_ok, direction_result = pcall(
        Net.set_bot_direction, kicker.id, "Up Right"
    )
    log("ANIM_FLOW: kicker direction call returned bot="
        .. tostring(kicker.id) .. " pcall_ok=" .. tostring(direction_ok)
        .. " return=" .. tostring(direction_result))

    local direction_after_ok, direction_after =
        pcall(Net.get_bot_direction, kicker.id)
    log("ANIM_FLOW: kicker direction readback bot=" .. tostring(kicker.id)
        .. " read_ok=" .. tostring(direction_after_ok)
        .. " direction=" .. tostring(direction_after))

    log("ANIM_FLOW: applying kicker animation bot="
        .. tostring(kicker.id) .. " state=IDLE_UR via Net.animate_bot")
    local animation_ok, animation_result =
        set_bot_animation_state(kicker.id, AnimationStates.IDLE_UR)
    log("ANIM_FLOW: kicker animation call returned bot="
        .. tostring(kicker.id) .. " success=" .. tostring(animation_ok)
        .. " detail=" .. tostring(animation_result))

    -- The direct animation API returns nil on success, so it cannot confirm
    -- that the renderer accepted the state. Try the documented keyframe API
    -- as a fallback path, and log its outcome for diagnosis.
    local property_setter = Net.animate_bot_properties
    local property_ok, property_result = false, "setter unavailable"
    if type(property_setter) == "function" then
        log("ANIM_FLOW: fallback animation properties bot="
            .. tostring(kicker.id) .. " state=IDLE_UR direction=Up Right")
        property_ok, property_result = pcall(
            property_setter,
            kicker.id,
            {
                {
                    properties = {
                        { property = "Animation", value = AnimationStates.IDLE_UR },
                        { property = "Direction", value = "Up Right" }
                    },
                    duration = 0.05
                }
            }
        )
    end
    log("ANIM_FLOW: fallback animation properties returned bot="
        .. tostring(kicker.id) .. " pcall_ok=" .. tostring(property_ok)
        .. " return=" .. tostring(property_result))

    local final_direction_ok, final_direction =
        pcall(Net.get_bot_direction, kicker.id)
    log("ANIM_FLOW: final kicker direction readback bot="
        .. tostring(kicker.id) .. " read_ok=" .. tostring(final_direction_ok)
        .. " direction=" .. tostring(final_direction))

    if not direction_ok or direction_result == false then
        log("Could not set kicker direction for FootBomb bot "
            .. tostring(kicker.id) .. " to Up Right: "
            .. tostring(direction_result))
    end
    if not animation_ok then
        log("Could not set kicker animation for FootBomb bot "
            .. tostring(kicker.id) .. " to IDLE_UR: "
            .. tostring(animation_result))
    end

    return direction_ok and direction_result ~= false
        and (animation_ok or property_ok)
end

-- Briefly request every Navi animation while the cameras are black. This
-- primes each selected avatar's animation assets before players can see the
-- bots, avoiding first-use "missing asset" flashes during gameplay.
local function prime_round_bot_animations(instance_id)
    local bots = instance_bots[instance_id]
    if not bots then
        log("ROUND_SETUP: cannot prime animations; bots missing instance="
            .. tostring(instance_id))
        return false
    end

    local kicker, defender
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then
            kicker = bot
        elseif bot.role == "Defender" then
            defender = bot
        end
    end

    if not kicker or not defender then
        log("ROUND_SETUP: cannot prime animations; role bot missing instance="
            .. tostring(instance_id)
            .. " kicker=" .. tostring(kicker ~= nil)
            .. " defender=" .. tostring(defender ~= nil))
        return false
    end

    -- Keep this explicit and deterministic. Bomb-only states are excluded
    -- because these two bots use Navi animation files, not bomb animation files.
    local states = {
        AnimationStates.IDLE_D,
        AnimationStates.IDLE_DR,
        AnimationStates.IDLE_UR,
        AnimationStates.IDLE_U,
        AnimationStates.WALK_U,
        AnimationStates.WALK_UR,
        AnimationStates.FOOTBOMB_IDLE_DEFENSE,
        AnimationStates.FOOTBOMB_READY_DEFENSE,
        AnimationStates.FOOTBOMB_JUMP_RIGHT,
        AnimationStates.FOOTBOMB_JUMP_LEFT,
    }

    log("ROUND_SETUP: priming Navi animation states while cameras are black"
        .. " instance=" .. tostring(instance_id)
        .. " state_count=" .. tostring(#states))

    local failed = 0
    for _, state in ipairs(states) do
        for _, bot in ipairs({ kicker, defender }) do
            local ok, result = pcall(Net.animate_bot, bot.id, state, true)
            if not ok or result == false then
                failed = failed + 1
                log("ROUND_SETUP: animation prime failed bot="
                    .. tostring(bot.id) .. " state=" .. tostring(state)
                    .. " pcall_ok=" .. tostring(ok)
                    .. " return=" .. tostring(result))
            end
        end
        -- 100 ms per state: fast enough to keep the intro snappy, while
        -- giving the client a brief opportunity to initialize each state.
        await(Async.sleep(0.1))
    end

    -- Restore the actual starting poses after the warm-up sequence.
    local defender_ok = set_defender_animation_for_round(
        instance_id, AnimationStates.FOOTBOMB_READY_DEFENSE,
        "post-animation-prime-ready")
    local kicker_ok, kicker_result = pcall(
        Net.animate_bot, kicker.id, AnimationStates.IDLE_UR, true)

    log("ROUND_SETUP: animation priming complete instance="
        .. tostring(instance_id)
        .. " failures=" .. tostring(failed)
        .. " defender_ready=" .. tostring(defender_ok)
        .. " kicker_idle_pcall_ok=" .. tostring(kicker_ok)
        .. " kicker_idle_return=" .. tostring(kicker_result))

    return failed == 0 and defender_ok and kicker_ok
        and kicker_result ~= false
end

---------------------------------------------------------------------------
-- Round direction selection
---------------------------------------------------------------------------

local DIRECTION_CHOICES = Config.DIRECTION_CHOICES
local DIRECTION_INPUT_SETTLE_SECONDS = Config.DIRECTION_INPUT_SETTLE_SECONDS

local function direction_selection_prompt(rep)
    return "Choose a direction for your " .. tostring(
        (rep.bot_record and rep.bot_record.role) or "turn"
    ) .. ": Left, Up, or Right. Press Confirm when ready. Current: "
        .. tostring(rep.selected_direction or "none") .. "."
end

local function draw_scoreboard_for_player(player_id, rep, bots)
    if not rep or not bots or player_representations[player_id] ~= rep then
        return
    end

    pcall(Net.provide_asset_for_player, player_id, SCOREBOARD_TEXTURE)
    pcall(Net.provide_asset_for_player, player_id, SCOREBOARD_ANIMATION)

    local ok, err = pcall(
        games.add_ui_element,
        rep.scoreboard_ui_id,
        player_id,
        SCOREBOARD_TEXTURE,
        SCOREBOARD_ANIMATION,
        "DEFAULT",
        SCOREBOARD_X,
        SCOREBOARD_Y,
        100,
        SCOREBOARD_SCALE,
        SCOREBOARD_SCALE
    )
    if not ok then
        log("SCORE_FLOW: scoreboard image draw failed player="
            .. tostring(player_id) .. " error=" .. tostring(err))
    end

    pcall(games.draw_text, rep.score_player_one_text_id, player_id,
        tostring(bots.player_one_score or 0), SCORE_PLAYER_ONE_X,
        SCORE_TEXT_Y, 101, "THICK", SCORE_TEXT_SCALE)
    pcall(games.draw_text, rep.score_player_two_text_id, player_id,
        tostring(bots.player_two_score or 0), SCORE_PLAYER_TWO_X,
        SCORE_TEXT_Y, 101, "THICK", SCORE_TEXT_SCALE)
end

local function update_scoreboard(instance_id)
    local bots = instance_bots[instance_id]
    if not bots then return end
    for player_id, rep in pairs(player_representations) do
        if rep.instance_id == instance_id then
            draw_scoreboard_for_player(player_id, rep, bots)
        end
    end
end

-- The scoreboard is an intermission display: show it while the cameras are
-- black between rounds, then remove it before revealing active gameplay.
local function hide_scoreboard_for_player(player_id, rep)
    if not rep then return end
    if rep.scoreboard_ui_id then
        pcall(games.remove_ui_element, rep.scoreboard_ui_id, player_id)
    end
    if rep.score_player_one_text_id then
        pcall(games.remove_text, rep.score_player_one_text_id, player_id)
    end
    if rep.score_player_two_text_id then
        pcall(games.remove_text, rep.score_player_two_text_id, player_id)
    end
end

local function hide_scoreboard_for_instance(instance_id)
    for player_id, rep in pairs(player_representations) do
        if rep.instance_id == instance_id then
            hide_scoreboard_for_player(player_id, rep)
        end
    end
end

local function move_bot_smoothly(bot, target, speed, phase, animation_state, duration_override)
    if not bot or not bot.id or not target then
        log("RESULT_FLOW: cannot move bot; missing bot/target phase=" .. tostring(phase))
        return false
    end
    if type(Net.animate_bot_properties) ~= "function" then
        log("RESULT_FLOW: Net.animate_bot_properties unavailable; refusing instant movement phase="
            .. tostring(phase))
        return false
    end

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
    if not start then
        log("RESULT_FLOW: cannot move bot; start position unavailable bot="
            .. tostring(bot.id) .. " phase=" .. tostring(phase))
        return false
    end

    local sx, sy, sz = tonumber(start.x) or 0, tonumber(start.y) or 0, tonumber(start.z) or 0
    local tx, ty, tz = tonumber(target.x) or sx, tonumber(target.y) or sy, tonumber(target.z) or sz
    local dx, dy, dz = tx - sx, ty - sy, tz - sz
    local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
    local move_speed = math.max(1, tonumber(speed) or Config.RESULT_KICKER_WALK_U_SPEED or 150)
    local duration = math.max(0.12, tonumber(duration_override) or (distance / move_speed))

    -- Keep the current position as a zero-duration starting keyframe, then let
    -- the engine interpolate X/Y/Z over the duration of the second keyframe.
    -- This follows the Net.animate_bot_properties patterns used by ezlibs.
    local start_properties = {
        { property = "X", value = sx },
        { property = "Y", value = sy },
        { property = "Z", value = sz }
    }
    local target_properties = {
        { property = "X", ease = "InOut", value = tx },
        { property = "Y", ease = "InOut", value = ty },
        { property = "Z", ease = "InOut", value = tz }
    }
    if animation_state then
        start_properties[#start_properties + 1] = {
            property = "Animation", value = animation_state
        }
        target_properties[#target_properties + 1] = {
            property = "Animation", value = animation_state
        }
    end

    local keyframes = {
        { properties = start_properties, duration = 0 },
        { properties = target_properties, duration = duration }
    }

    -- Set the intended animation through Net.animate_bot before starting the
    -- property interpolation. The Animation property on keyframes can be
    -- transient or arrive out of order on clients, so prime the bot's state
    -- first and still include it in both keyframes as a secondary safeguard.
    if animation_state then
        local pre_animation_ok, pre_animation_result =
            set_bot_animation_state(bot.id, animation_state)
        log("RESULT_FLOW: pre-movement animation bot=" .. tostring(bot.id)
            .. " phase=" .. tostring(phase)
            .. " state=" .. tostring(animation_state)
            .. " success=" .. tostring(pre_animation_ok)
            .. " detail=" .. tostring(pre_animation_result))
        if not pre_animation_ok then
            log("RESULT_FLOW: pre-movement animation failed; continuing with property animation bot="
                .. tostring(bot.id) .. " phase=" .. tostring(phase))
        end
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

    -- The animation runs on the server. Resume at the exact interpolation
    -- duration so the arrival animation override can run immediately, without
    -- leaving a small post-interpolation gap where the client may show a
    -- missing/default animation asset.
    await(Async.sleep(duration))
    bot.position = { x = tx, y = ty, z = tz }

    log("RESULT_FLOW: interpolated movement complete bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase) .. " x=" .. tostring(tx)
        .. " y=" .. tostring(ty) .. " z=" .. tostring(tz))
    return true
end

local function set_result_animation(bot, animation_state, direction, phase)
    if not bot then return false end
    if bot.texture_path and bot.animation_path
        and type(Net.set_bot_avatar) == "function" then
        pcall(Net.set_bot_avatar, bot.id, bot.texture_path, bot.animation_path)
    end
    if direction and type(Net.set_bot_direction) == "function" then
        local direction_ok, direction_result = pcall(Net.set_bot_direction, bot.id, direction)
        if not direction_ok or direction_result == false then
            log("RESULT_FLOW: direction set failed bot=" .. tostring(bot.id)
                .. " phase=" .. tostring(phase) .. " direction=" .. tostring(direction))
        end
    end
    local animation_ok, animation_result = set_bot_animation_state(bot.id, animation_state)
    log("RESULT_FLOW: animation bot=" .. tostring(bot.id)
        .. " phase=" .. tostring(phase) .. " state=" .. tostring(animation_state)
        .. " success=" .. tostring(animation_ok)
        .. " detail=" .. tostring(animation_result))
    return animation_ok
end

local function award_round_point(instance_id, kicker, defender, winner)
    local bots = instance_bots[instance_id]
    if not bots or bots.round_winner then return end
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

-- Assigned below the direction-selection helpers so the next-round transition
-- can reuse the same prompt flow without duplicating its implementation.
local begin_next_round

local function resolve_round_winner(instance_id)
    local bots = instance_bots[instance_id]
    local points = instance_spawn_points[instance_id]
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

    local winner = kicker.direction_choice == defender.direction_choice and defender or kicker
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

    async(function()
        local kicker_ok = set_result_animation(
            kicker, AnimationStates.WALK_UR, "Up Right", "kicker-to-move-forward"
        )
        if kicker_ok then
            kicker_ok = move_bot_smoothly(
                kicker, points.MoveForward, Config.RESULT_KICKER_WALK_UR_SPEED,
                "kicker-to-move-forward", AnimationStates.WALK_UR
            )
        end
        if kicker_ok then
            kicker_ok = set_result_animation(
                kicker, AnimationStates.WALK_U, "Up", "kicker-to-bomb"
            )
        end
        local bomb_position = bots.bomb_bot.position or points.Bomb
        if kicker_ok then
            kicker_ok = move_bot_smoothly(
                kicker, bomb_position, Config.RESULT_KICKER_WALK_U_SPEED, "kicker-to-bomb",
                AnimationStates.WALK_U
            )
        end

        if kicker_ok then
            -- Launch the bomb and Defender response together. For Left/Right,
            -- the Defender's configured speed (60) determines the shared travel
            -- duration; the bomb uses that exact duration so both arrive together.
            local defender_target_name = ({
                Left = "Defender 1",
                Up = "Defender 2",
                Right = "Defender 3",
            })[defender.direction_choice]
            local defender_target = points[defender_target_name]
            local defender_animation = defender.direction_choice == "Left"
                and AnimationStates.FOOTBOMB_JUMP_LEFT
                or (defender.direction_choice == "Right"
                    and AnimationStates.FOOTBOMB_JUMP_RIGHT
                    or AnimationStates.FOOTBOMB_READY_DEFENSE)
            local defender_direction = defender.direction_choice == "Left" and "Left"
                or (defender.direction_choice == "Right" and "Right" or "Up")

            if not defender_target then
                log("RESULT_FLOW: defender target missing name="
                    .. tostring(defender_target_name) .. " instance=" .. tostring(instance_id))
                bots.result_animation_active = false
                return
            end

            local shared_duration
            if defender.direction_choice == "Left" or defender.direction_choice == "Right" then
                local start = defender.position
                if not start and type(Net.get_bot_position) == "function" then
                    local pos_ok, pos = pcall(Net.get_bot_position, defender.id)
                    if pos_ok and type(pos) == "table" then start = pos end
                end
                if not start then
                    log("RESULT_FLOW: defender start position unavailable instance="
                        .. tostring(instance_id))
                    bots.result_animation_active = false
                    return
                end
                local dx = (tonumber(defender_target.x) or 0) - (tonumber(start.x) or 0)
                local dy = (tonumber(defender_target.y) or 0) - (tonumber(start.y) or 0)
                local dz = (tonumber(defender_target.z) or 0) - (tonumber(start.z) or 0)
                local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
                shared_duration = math.max(0.12, distance / math.max(1,
                    tonumber(Config.RESULT_DEFENDER_JUMP_SPEED) or 60))
            end

            log("RESULT_FLOW: launching bomb and defender response together instance="
                .. tostring(instance_id) .. " bomb_target=" .. tostring(target_name)
                .. " defender_target=" .. tostring(defender_target_name)
                .. " shared_duration=" .. tostring(shared_duration or "bomb-only"))

            -- Apply the pose/direction at launch; the interpolated keyframes also
            -- carry the jump animation throughout the Defender's movement.
            set_result_animation(defender, defender_animation, defender_direction,
                "defender-response-launch")

            local bomb_done, bomb_ok = false, false
            local defender_done, defender_ok = false, false
            async(function()
                bomb_ok = move_bot_smoothly(
                    bots.bomb_bot, bomb_target, Config.RESULT_BOMB_MOVE_SPEED,
                    "bomb-to-" .. tostring(target_name), nil, shared_duration
                )
                bomb_done = true
            end)
            if defender.direction_choice == "Left" or defender.direction_choice == "Right" then
                async(function()
                    defender_ok = move_bot_smoothly(
                        defender, defender_target,
                        Config.RESULT_DEFENDER_JUMP_SPEED or 60,
                        "defender-to-" .. tostring(defender_target_name),
                        defender_animation, shared_duration
                    )
                    defender_done = true
                end)
            else
                -- Up is a stationary defense pose; it has no travel to synchronize.
                defender.position = {
                    x = defender_target.x, y = defender_target.y, z = defender_target.z
                }
                defender_done, defender_ok = true, true
            end

            while not bomb_done or not defender_done do
                await(Async.sleep(0.02))
            end
            if not bomb_ok or not defender_ok then
                log("RESULT_FLOW: synchronized bomb/defender movement failed; point not awarded instance="
                    .. tostring(instance_id) .. " bomb_ok=" .. tostring(bomb_ok)
                    .. " defender_ok=" .. tostring(defender_ok))
                bots.result_animation_active = false
                return
            end
            -- animate_bot_properties drives the interpolation, but its Animation
            -- property does not reliably persist after the keyframes finish. Reapply
            -- the Defender's intended pose through the Net.animate_bot wrapper only
            -- after both the bomb and Defender have arrived at their destinations.
            if defender.direction_choice == "Left" or defender.direction_choice == "Right" then
                local arrival_animation_ok = set_result_animation(
                    defender,
                    defender_animation,
                    defender_direction,
                    "defender-arrival-animation-override"
                )
                log("RESULT_FLOW: defender arrival animation override bot="
                    .. tostring(defender.id)
                    .. " state=" .. tostring(defender_animation)
                    .. " success=" .. tostring(arrival_animation_ok))

                -- Some server/client animation controllers re-apply the bot's
                -- directional idle shortly after a property interpolation ends.
                -- The jump is already started with looping enabled above; reassert
                -- it briefly after arrival to win any late completion/idle update.
                -- This is intentionally after the synchronized movement and does
                -- not alter either travel duration or the scoring decision.
                async(function()
                    for _, delay in ipairs({ 0.15, 0.35, 0.75, 1.25 }) do
                        await(Async.sleep(delay))
                        local current_bots = instance_bots[instance_id]
                        local same_defender = false
                        for _, current_bot in ipairs(current_bots or {}) do
                            if current_bot.id == defender.id
                                and current_bot.role == "Defender" then
                                same_defender = true
                                break
                            end
                        end
                        if not same_defender then
                            log("ANIM_FLOW: stopping defender animation reassertion; bot no longer belongs to match instance="
                                .. tostring(instance_id) .. " bot=" .. tostring(defender.id))
                            return
                        end

                        local retry_ok = set_result_animation(
                            defender,
                            defender_animation,
                            defender_direction,
                            "defender-loop-reassert-" .. tostring(delay)
                        )
                        log("ANIM_FLOW: defender jump animation reasserted bot="
                            .. tostring(defender.id)
                            .. " state=" .. tostring(defender_animation)
                            .. " delay=" .. tostring(delay)
                            .. " success=" .. tostring(retry_ok))
                    end
                end)
            else
                set_result_animation(
                    defender,
                    AnimationStates.FOOTBOMB_READY_DEFENSE,
                    defender_direction,
                    "defender-arrival-ready-defense-override"
                )
            end

            set_result_animation(kicker, AnimationStates.IDLE_U, "Up", "kicker-after-kick")
            award_round_point(instance_id, kicker, defender, winner)

            -- Keep the result visible for a beat after the ball and Defender
            -- arrive, then hide the transition before updating the score or
            -- changing roles/positions.
            log("ROUND_FLOW: result hold started instance=" .. tostring(instance_id)
                .. " seconds=1.0")
            await(Async.sleep(1.0))

            local humans = {}
            for player_id, rep in pairs(player_representations) do
                if rep.instance_id == instance_id then
                    humans[#humans + 1] = { player_id = player_id, rep = rep }
                    if player_representations[player_id] == rep then
                        fade_player_to_black(player_id)
                    end
                end
            end
            log("ROUND_FLOW: result fade-to-black started instance="
                .. tostring(instance_id) .. " participant_count=" .. tostring(#humans))
            await(Async.sleep(0.85))

            -- The scoreboard is already on the HUD; refresh its values only
            -- after the field has been hidden, before preparing the next round.
            update_scoreboard(instance_id)
            log("SCORE_FLOW: scoreboard updated during black transition instance="
                .. tostring(instance_id)
                .. " player_one_score=" .. tostring(bots.player_one_score or 0)
                .. " player_two_score=" .. tostring(bots.player_two_score or 0))

            bots.result_animation_active = false
            if begin_next_round then
                begin_next_round(instance_id)
            else
                log("ROUND_FLOW: next-round handler unavailable instance="
                    .. tostring(instance_id))
            end
        else
            log("RESULT_FLOW: kicker movement failed; point not awarded instance="
                .. tostring(instance_id))
            bots.result_animation_active = false
        end
    end)
end

local function finish_direction_selection_if_ready(instance_id)
    local bots = instance_bots[instance_id]
    if not bots or bots.directions_resolved then
        return
    end

    local humans = {}
    local human_slots = {}
    for player_id, rep in pairs(player_representations) do
        if rep.instance_id == instance_id then
            humans[#humans + 1] = { player_id = player_id, rep = rep }
            human_slots[rep.slot] = true
            if not rep.direction_selection_confirmed then
                return
            end
        end
    end
    if #humans == 0 then
        return
    end

    -- NPCs do not receive player input. Their choice is deterministic but
    -- rotates Left -> Up -> Right across NPC turns, avoiding a fixed answer.
    for slot, bot in ipairs(bots) do
        if not human_slots[slot] then
            npc_direction_sequence_index = (npc_direction_sequence_index % #DIRECTION_CHOICES) + 1
            bot.direction_choice = DIRECTION_CHOICES[npc_direction_sequence_index]
            log("DIRECTION_FLOW: server chose NPC direction instance="
                .. tostring(instance_id) .. " slot=" .. tostring(slot)
                .. " role=" .. tostring(bot.role)
                .. " direction=" .. tostring(bot.direction_choice)
                .. " sequence_index=" .. tostring(npc_direction_sequence_index))
        end
    end

    bots.directions_resolved = true
    for _, entry in ipairs(humans) do
        local rep = entry.rep
        rep.direction_selection_active = false
        local bot = bots[rep.slot]
        if bot then
            -- Never invent a direction if confirmation was somehow reached
            -- without a valid human selection.
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
    local bots = instance_bots[instance_id]
    if not bots then
        return
    end

    bots.directions_resolved = false
    for _, entry in ipairs(human_reps) do
        local player_id, rep = entry.player_id, entry.rep
        -- Enable input only after the role-specific prompt has closed.
        rep.direction_selection_active = false
        rep.direction_selection_confirmed = false
        -- No direction is preselected; require a fresh directional press.
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
            if player_representations[player_id] ~= rep then
                return
            end
            await(Async.message_player(
                player_id,
                "Your role is " .. tostring(bots[rep.slot].role)
                    .. ". Choose Left, Up, or Right for your "
                    .. (bots[rep.slot].role == "Kicker" and "kick direction" or "defense direction")
                    .. ". Press Confirm to select."
            ))
            -- Keep all direction input disabled until the textbox is closed
            -- and the same settling buffer used by Navi selection has elapsed.
            await(Async.sleep(DIRECTION_INPUT_SETTLE_SECONDS))
            if player_representations[player_id] == rep then
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
    local bots = instance_bots[instance_id]
    if not bots or bots.round_transition_active then
        log("ROUND_FLOW: refusing duplicate next-round setup instance="
            .. tostring(instance_id))
        return
    end

    local humans = {}
    for player_id, rep in pairs(player_representations) do
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

    -- Swap roles by bot/slot so each player alternates between Kicker and
    -- Defender. Clear all per-round choices before the next prompt opens.
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then
            bot.role = "Defender"
        else
            bot.role = "Kicker"
        end
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

    -- Give position changes a short settle window before applying the poses.
    await(Async.sleep(0.25))
    local defender_idle_set = set_defender_animation_for_round(
        instance_id, AnimationStates.FOOTBOMB_IDLE_DEFENSE, "next-round-idle")
    local kicker_pose_set, kicker_pose_result = pcall(
        set_kicker_pose_for_round, instance_id)
    log("ROUND_SETUP: next-round initial poses instance=" .. tostring(instance_id)
        .. " defender_idle=" .. tostring(defender_idle_set)
        .. " kicker_pcall_ok=" .. tostring(kicker_pose_set)
        .. " kicker_result=" .. tostring(kicker_pose_result))

    await(Async.sleep(0.8))
    local defender_ready_set = set_defender_animation_for_round(
        instance_id, AnimationStates.FOOTBOMB_READY_DEFENSE, "next-round-ready")
    log("ROUND_SETUP: next-round defender ready instance="
        .. tostring(instance_id) .. " success=" .. tostring(defender_ready_set))

    local animations_primed = prime_round_bot_animations(instance_id)
    log("ROUND_SETUP: next-round animation priming instance="
        .. tostring(instance_id) .. " success=" .. tostring(animations_primed))
    await(Async.sleep(0.15))

    local kicker
    for _, bot in ipairs(bots) do
        if bot.role == "Kicker" then
            kicker = bot
            break
        end
    end
    if kicker then
        local retry_ok, retry_result = pcall(
            Net.animate_bot, kicker.id, AnimationStates.IDLE_UR, true)
        log("ROUND_SETUP: next-round kicker idle reassert bot="
            .. tostring(kicker.id) .. " pcall_ok=" .. tostring(retry_ok)
            .. " return=" .. tostring(retry_result))
    end

    -- The score has been visible during the black intermission. Remove it
    -- before revealing the next active round so it does not cover gameplay.
    hide_scoreboard_for_instance(instance_id)

    -- Reveal only after both bots are ready. Camera focus remains on the same
    -- field framing used for the opening round.
    for _, entry in ipairs(humans) do
        local player_id, rep = entry.player_id, entry.rep
        if player_representations[player_id] == rep then
            rep.camera_focus_active = true
            focus_player_camera_for_round(player_id, instance_id)
            fade_player_in(player_id)
        end
    end
    log("ROUND_FLOW: next-round fade-in started instance=" .. tostring(instance_id))
    await(Async.sleep(0.85))

    bots.round_transition_active = false
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
    local bot = instance_bots[rep.instance_id] and instance_bots[rep.instance_id][rep.slot]
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
        if player_representations[player_id] ~= rep then
            return
        end

        -- Disable direction input for the entire message/quiz sequence.
        rep.direction_selection_active = false
        await(Async.message_player(
            player_id,
            "You chose " .. string.upper(selected) .. " for your "
                .. (role == "Kicker" and "kick direction" or "defense direction")
                .. ". Would you like to confirm this selection?"
        ))
        if player_representations[player_id] ~= rep then
            return
        end
        await(Async.sleep(DIRECTION_INPUT_SETTLE_SECONDS))
        if player_representations[player_id] ~= rep then
            return
        end

        local choice = await(Async.quiz_player(player_id, "Yes", "No"))
        log("DIRECTION_FLOW: confirmation answer player=" .. tostring(player_id)
            .. " direction=" .. tostring(selected) .. " choice=" .. tostring(choice))
        if player_representations[player_id] ~= rep then
            return
        end

        -- Let the quiz close cleanly before showing the result/retry message.
        await(Async.sleep(DIRECTION_INPUT_SETTLE_SECONDS))
        if player_representations[player_id] ~= rep then
            return
        end
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
            await(Async.message_player(
                player_id,
                "Confirmed " .. string.upper(selected) .. ". Waiting for the other player..."
            ))
            await(Async.sleep(DIRECTION_INPUT_SETTLE_SECONDS))
            if player_representations[player_id] == rep then
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
            await(Async.message_player(
                player_id,
                "Selection not confirmed. Choose Left, Up, or Right, then press Confirm."
            ))
            await(Async.sleep(DIRECTION_INPUT_SETTLE_SECONDS))
            if player_representations[player_id] == rep
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
            end
        end

        if player_representations[player_id] == rep then
            rep.confirming = false
        end
    end)
end

local function try_begin_match(instance_id)
    local bots = instance_bots[instance_id]

    if not bots or #bots < 2 then
        return
    end

    local human_reps = {}

    for player_id, rep in pairs(player_representations) do
        if rep.instance_id == instance_id then
            human_reps[#human_reps + 1] = {
                player_id = player_id,
                rep = rep
            }

            if not rep.selection_confirmed then
                return
            end
        end
    end

    if #human_reps == 0 then
        return
    end

    if bots.match_started then
        return
    end

    bots.match_started = true

    local kicker_slot = math.random(1, 2)

    bots[1].role = kicker_slot == 1 and "Kicker" or "Defender"
    bots[2].role = kicker_slot == 2 and "Kicker" or "Defender"
    bots.player_one_score = bots.player_one_score or 0
    bots.player_two_score = bots.player_two_score or 0
    bots.round_winner = nil

    for _, entry in ipairs(human_reps) do
        local rep = entry.rep
        rep.match_started = true
        hide_selector_ui(entry.player_id, rep)
    end

    -- Each human can acknowledge their role message independently. Only after
    -- all participating cameras have started fading to black do we reposition
    -- both bots and reveal the field. In VS NPC mode the server-owned opponent
    -- follows the same role/position path.
    local fade_ready_count = 0
    local transition_started = false

    for _, entry in ipairs(human_reps) do
        local player_id = entry.player_id
        local rep = entry.rep

        async(function()
            log("MATCH_FLOW: opening role message player="
                .. tostring(player_id) .. " role="
                .. tostring(bots[rep.slot].role))
            await(Async.message_player(
                player_id,
                "FootBomb will begin shortly! You are the "
                    .. tostring(bots[rep.slot].role) .. "."
            ))
            log("MATCH_FLOW: role message await returned player="
                .. tostring(player_id))

            -- Ensure the role textbox has had time to disappear before fading
            -- the camera and changing the bots' poses.
            await(Async.sleep(0.25))
            log("MATCH_FLOW: role textbox settle wait complete player="
                .. tostring(player_id))

            if player_representations[player_id] == rep then
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
                if not positioned then
                    log("Initial FootBomb round positioning failed for "
                        .. tostring(instance_id))
                end

                local bomb_spawned = spawn_bomb_bot_for_round(instance_id, human_reps)
                log("ROUND_SETUP: bomb bot spawn complete instance="
                    .. tostring(instance_id) .. " success=" .. tostring(bomb_spawned))

                -- Allow movement to settle before changing the kicker's pose.
                await(Async.sleep(0.35))

                -- The Defender has a two-stage defensive pose: settle into the
                -- idle state first, then switch to the ready state after a pause.
                log("ROUND_SETUP: applying defender idle animation instance="
                    .. tostring(instance_id))
                local defender_idle_set = set_defender_animation_for_round(
                    instance_id, AnimationStates.FOOTBOMB_IDLE_DEFENSE, "idle"
                )
                log("ROUND_SETUP: defender idle animation call complete instance="
                    .. tostring(instance_id) .. " success="
                    .. tostring(defender_idle_set))

                log("ROUND_SETUP: applying kicker direction/animation instance="
                    .. tostring(instance_id))
                local kicker_pose_set = set_kicker_pose_for_round(instance_id)
                log("ROUND_SETUP: kicker pose calls complete instance="
                    .. tostring(instance_id) .. " success=" .. tostring(kicker_pose_set))
                if not kicker_pose_set then
                    log("Initial FootBomb kicker pose setup failed for "
                        .. tostring(instance_id))
                end

                -- Give the Defender's idle animation time to be visible before
                -- transitioning into the ready stance, while cameras are black.
                await(Async.sleep(0.8))
                log("ROUND_SETUP: switching defender to ready animation instance="
                    .. tostring(instance_id))
                local defender_ready_set = set_defender_animation_for_round(
                    instance_id, AnimationStates.FOOTBOMB_READY_DEFENSE, "ready"
                )
                log("ROUND_SETUP: defender ready animation call complete instance="
                    .. tostring(instance_id) .. " success="
                    .. tostring(defender_ready_set))

                -- Prime every animation on both Navi bots while the cameras
                -- are still black. The helper restores each bot's starting
                -- pose before the reveal.
                local animations_primed = prime_round_bot_animations(instance_id)
                log("ROUND_SETUP: bot animation priming returned instance="
                    .. tostring(instance_id) .. " success="
                    .. tostring(animations_primed))

                -- Allow the restored starting poses to reach clients before
                -- fading the cameras in.
                await(Async.sleep(0.15))

                -- Re-issue the animation after the client has had a little
                -- time to receive the avatar/state updates while still black.
                local kicker = nil
                for _, bot in ipairs(instance_bots[instance_id] or {}) do
                    if bot.role == "Kicker" then
                        kicker = bot
                        break
                    end
                end
                if kicker then
                    log("ROUND_SETUP: reapplying kicker animation before fade-in bot="
                        .. tostring(kicker.id) .. " state=IDLE_UR")
                    local retry_ok, retry_result = pcall(
                        Net.animate_bot, kicker.id, AnimationStates.IDLE_UR, true
                    )
                    log("ROUND_SETUP: kicker animation retry returned bot="
                        .. tostring(kicker.id)
                        .. " pcall_ok=" .. tostring(retry_ok)
                        .. " return=" .. tostring(retry_result))
                end

                log("ROUND_SETUP: fading cameras in instance="
                    .. tostring(instance_id))

                for _, participant in ipairs(human_reps) do
                    local player_id = participant.player_id
                    local rep = participant.rep

                    if player_representations[player_id] == rep then
                        -- Temporarily suspend the normal Navi-follow update so
                        -- it cannot overwrite Camera Focus while the reveal is
                        -- happening.
                        rep.camera_focus_active = true

                        -- Center each human player's camera on the Tiled
                        -- "Camera Focus" point before revealing the round.
                        focus_player_camera_for_round(player_id, instance_id)
                        fade_player_in(player_id)
                    end
                end

                -- Keep the camera locked to Camera Focus after the reveal.
                -- The normal Navi-follow loop must not reclaim the camera
                -- immediately after the fade-in and cause a visible jump.
                log("CAMERA_FLOW: keeping Camera Focus locked after fade-in instance="
                    .. tostring(instance_id))
                -- The scoreboard is reserved for the black intermission after
                -- the first result; keep the active field clear during gameplay.
                hide_scoreboard_for_instance(instance_id)

                -- Once the field is revealed, collect each human's role-based
                -- direction choice. NPC directions are assigned server-side
                -- after every human has confirmed.
                start_direction_selection(instance_id, human_reps)
            end
        end)
    end

    log("Assigned FootBomb roles for " .. tostring(instance_id)
        .. ": Player 1=" .. bots[1].role
        .. ", Player 2=" .. bots[2].role)
end

-- The first Confirm press locks in the ball skin and advances to the Navi
-- selector. It does not open a message or quiz.
local function confirm_bomb_selection(player_id, rep)
    if not rep
        or rep.confirming
        or rep.bomb_selection_confirmed
        or rep.selection_confirmed
    then
        return
    end

    if player_representations[player_id] ~= rep then
        return
    end

    rep.bomb_selection_confirmed = true

    local option = BOMB_OPTIONS[rep.bomb_skin_index]

    hide_selector_ui(player_id, rep)

    -- Consume the Confirm edge that completed the ball selection and require
    -- a full release before accepting Confirm for Navi selection.
    if rep.input
        and rep.input_owner
        and rep.input:has_input_control(rep.input_owner)
    then
        rep.input:consume(rep.input_owner)

        rep.input:require_release(
            { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
            rep.input_owner
        )
    end

    log("Player " .. tostring(player_id)
        .. " confirmed ball skin " .. option.name)

    -- show_selector_ui now presents the Navi selector because the ball
    -- selection has been confirmed.
    show_selector_ui(player_id, rep)
end

local function confirm_navi_selection(player_id, rep)
    if not rep or rep.confirming or rep.selection_confirmed then
        return
    end

    local option = NAVI_OPTIONS[rep.skin_index]
    if not option then
        return
    end

    -- Suspend selector input before opening any textbox. Consume the Confirm
    -- edge that opened this flow and require release so the textbox's own
    -- confirm/dismiss input cannot also activate the selector.
    rep.confirming = true

    hide_selector_ui(player_id, rep)

    if rep.input
        and rep.input_owner
        and rep.input:has_input_control(rep.input_owner)
    then
        rep.input:consume(rep.input_owner)

        rep.input:require_release(
            { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
            rep.input_owner
        )
    end

    async(function()
        local function representation_is_current()
            return player_representations[player_id] == rep
                and Net.get_player_area(player_id) == rep.area_id
        end

        if not representation_is_current() then
            return
        end

        await(Async.message_player(
            player_id,
            "You selected " .. option.name
                .. ". Would you like to use " .. option.name .. "?"
        ))

        if not representation_is_current() then
            return
        end

        log("CONFIRM_FLOW: opening Yes/No quiz player="
            .. tostring(player_id))
        local choice = await(Async.quiz_player(
            player_id,
            "Yes",
            "No"
        ))
        log("CONFIRM_FLOW: Yes/No quiz await returned player="
            .. tostring(player_id) .. " choice=" .. tostring(choice))

        if not representation_is_current() then
            log("CONFIRM_FLOW: representation changed after quiz player="
                .. tostring(player_id))
            return
        end

        -- Async.quiz_player should resolve after the choice is made, but allow
        -- the textbox/UI transition to settle before opening the next message.
        await(Async.sleep(0.25))

        if choice == 0 then
            rep.selection_confirmed = true
            rep.confirmed_skin_index = rep.skin_index
            rep.confirming = false

            log("CONFIRM_FLOW: opening final selection message player="
                .. tostring(player_id))
            await(Async.message_player(
                player_id,
                "You selected " .. option.name .. "!"
            ))
            log("CONFIRM_FLOW: final selection message await returned player="
                .. tostring(player_id))

            -- Treat the await as the textbox dismissal signal, then give the
            -- client one short settling interval before match-start dialogue
            -- and bot animation/position changes begin.
            await(Async.sleep(0.25))
            log("CONFIRM_FLOW: textbox settle wait complete player="
                .. tostring(player_id))

            if player_representations[player_id] == rep then
                log("CONFIRM_FLOW: entering try_begin_match player="
                    .. tostring(player_id))
                try_begin_match(rep.instance_id)
            end
        end

        if player_representations[player_id] == rep
            and not rep.selection_confirmed
        then
            -- The quiz may have consumed Confirm to close the textbox.
            -- Clear any resulting edge and wait for a fresh release/press.
            if rep.input
                and rep.input_owner
                and rep.input:has_input_control(rep.input_owner)
            then
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

---------------------------------------------------------------------------
-- Ref interaction and matchmaking
---------------------------------------------------------------------------

local function join_waiting_match(player_id, source_area_id, reference)
    local waiting = waiting_matches[source_area_id]

    if not waiting then
        return false
    end

    if pending_interactions[player_id] then
        return true
    end

    pending_interactions[player_id] = true

    async(function()
        local npc = reference.npc

        if waiting.player_id == player_id then
            await(Async.message_player(
                player_id,
                "You're already waiting for an opponent. The next player to talk to me can join.",
                npc.mug_texture_path,
                npc.mug_animation_path
            ))

            pending_interactions[player_id] = nil
            return
        end

        await(Async.message_player(
            player_id,
            "Someone is looking for a FootBomb opponent. Would you like to join?",
            npc.mug_texture_path,
            npc.mug_animation_path
        ))

        if Net.get_player_area(player_id) ~= source_area_id
            or waiting_matches[source_area_id] ~= waiting
        then
            pending_interactions[player_id] = nil
            return
        end

        local choice = await(Async.quiz_player(
            player_id,
            "Join Match",
            "No",
            "Cancel",
            npc.mug_texture_path,
            npc.mug_animation_path
        ))

        if choice == 0 and waiting_matches[source_area_id] == waiting then
            waiting_matches[source_area_id] = nil

            local ok, err = launch_player_match(waiting, player_id)

            if not ok then
                await(Async.message_player(
                    player_id,
                    "We couldn't start the match: " .. tostring(err),
                    npc.mug_texture_path,
                    npc.mug_animation_path
                ))

                if player_is_available(waiting.player_id) then
                    waiting_matches[source_area_id] = waiting
                end
            end
        else
            await(Async.message_player(
                player_id,
                "No problem. The match is still waiting for an opponent.",
                npc.mug_texture_path,
                npc.mug_animation_path
            ))
        end

        pending_interactions[player_id] = nil
    end)

    return true
end

local function begin_interaction(player_id, area_id, reference)
    if pending_interactions[player_id] then
        return
    end

    if join_waiting_match(player_id, area_id, reference) then
        return
    end

    pending_interactions[player_id] = true

    async(function()
        local npc = reference.npc
        local object = reference.object

        await(Async.message_player(
            player_id,
            "Hey! Would you like to play FootBomb?",
            npc.mug_texture_path,
            npc.mug_animation_path
        ))

        if Net.get_player_area(player_id) ~= area_id then
            pending_interactions[player_id] = nil
            return
        end

        local choice = await(Async.quiz_player(
            player_id,
            "VS [NPC]",
            "VS Player",
            "No",
            npc.mug_texture_path,
            npc.mug_animation_path
        ))

        if Net.get_player_area(player_id) ~= area_id then
            pending_interactions[player_id] = nil
            return
        end

        if choice == 0 then
            await(Async.message_player(
                player_id,
                "Let's do it! I'll prepare a private field.",
                npc.mug_texture_path,
                npc.mug_animation_path
            ))

            if Net.get_player_area(player_id) == area_id then
                launch_npc_match(
                    player_id,
                    area_id,
                    object,
                    npc
                )
            end
        elseif choice == 1 then
            if waiting_matches[area_id] then
                await(Async.message_player(
                    player_id,
                    "Another player is already waiting for an opponent. Please let them finish matchmaking first.",
                    npc.mug_texture_path,
                    npc.mug_animation_path
                ))
            else
                waiting_matches[area_id] = {
                    player_id = player_id,
                    source_area_id = area_id,
                    object = object,
                    npc = npc,
                    created_at = os.time()
                }

                await(Async.message_player(
                    player_id,
                    "All right! Stay here. The next player who talks to me can join your match.",
                    npc.mug_texture_path,
                    npc.mug_animation_path
                ))
            end
        else
            await(Async.message_player(
                player_id,
                "No problem. Come back when you're ready.",
                npc.mug_texture_path,
                npc.mug_animation_path
            ))
        end

        pending_interactions[player_id] = nil
    end)
end

function FootBomb.handle_actor_interaction(player_id, actor_id, button)
    if button ~= nil and button ~= 0 then
        return
    end

    if pending_interactions[player_id] then
        return
    end

    local area_id = Net.get_player_area(player_id)
    if not area_id then
        return
    end

    local reference = npc_refs[area_id]
        and npc_refs[area_id][tostring(actor_id)]

    if reference then
        begin_interaction(player_id, area_id, reference)
    end
end

function FootBomb.handle_player_transfer(player_id)
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

    if record
        and record.metadata
        and record.metadata.game == "footbomb"
    then
        local bots = instance_bots[record.id] or {}

        for slot, member_id in ipairs(record.player_ids or {}) do
            if member_id == player_id then
                setup_player_representation(
                    player_id,
                    record,
                    bots[slot]
                )
                break
            end
        end
    end
end

function FootBomb.handle_player_disconnect(player_id)
    pending_interactions[player_id] = nil

    for area_id, waiting in pairs(waiting_matches) do
        if waiting.player_id == player_id then
            waiting_matches[area_id] = nil
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

---------------------------------------------------------------------------
-- Input and camera update
---------------------------------------------------------------------------

-- Camera follow and both selection stages use the shared InputController.
-- Up/Down cycle Navi skins; Left/Right cycle ball skins. Confirm first locks
-- the ball selection and then operates the existing Navi confirmation flow.
Net:on("tick", function(event)
    for player_id, rep in pairs(player_representations) do
        if Net.get_player_area(player_id) == rep.area_id then
            local input = rep.input or InputAPI.get_controller(player_id)

            if input
                and rep.input_owner
                and input:has_input_control(rep.input_owner)
                and rep.direction_selection_active
                and not rep.confirming
                and not rep.direction_selection_confirmed
            then
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
                    rep.selected_direction = chosen_direction
                    pcall(Net.play_sound_for_player, player_id, CURSOR_SFX)
                    log("DIRECTION_FLOW: player changed direction player="
                        .. tostring(player_id) .. " direction=" .. chosen_direction)
                    input:consume(rep.input_owner)
                    input:require_release(
                        { "Up", "Down", "Left", "Right", "Confirm", "Cancel" },
                        rep.input_owner
                    )
                end
            elseif input
                and rep.input_owner
                and input:has_input_control(rep.input_owner)
                and not rep.confirming
                and not rep.selection_confirmed
                and not rep.match_started
            then
                if not rep.bomb_selection_confirmed then
                    -- Ball skin selection stage.
                    if input:is_action_pressed("Left", rep.input_owner) then
                        cycle_bomb_skin(player_id, -1)
                    elseif input:is_action_pressed("Right", rep.input_owner) then
                        cycle_bomb_skin(player_id, 1)
                    elseif input:is_action_pressed("Confirm", rep.input_owner) then
                        confirm_bomb_selection(player_id, rep)
                    end
                else
                    -- Navi selection stage.
                    if input:is_action_pressed("Up", rep.input_owner) then
                        pcall(
                            Net.play_sound_for_player,
                            player_id,
                            CURSOR_SFX
                        )

                        cycle_player_skin(player_id, -1)
                    elseif input:is_action_pressed("Down", rep.input_owner) then
                        pcall(
                            Net.play_sound_for_player,
                            player_id,
                            CURSOR_SFX
                        )

                        cycle_player_skin(player_id, 1)
                    elseif input:is_action_pressed("Confirm", rep.input_owner) then
                        confirm_navi_selection(player_id, rep)
                    end
                end
            end

            -- Keep the camera centered on the current Navi bot, except
            -- while the round intro temporarily owns the camera framing.
            if not rep.camera_focus_active
                and type(Net.get_bot_position) == "function"
                and type(Net.move_player_camera) == "function"
            then
                local ok, pos = pcall(
                    Net.get_bot_position,
                    rep.bot_id
                )

                if ok
                    and type(pos) == "table"
                    and type(pos.x) == "number"
                    and type(pos.y) == "number"
                then
                    pcall(
                        Net.move_player_camera,
                        player_id,
                        pos.x,
                        pos.y,
                        as_number(pos.z, 0),
                        0
                    )
                elseif rep.bot_record and rep.bot_record.position then
                    local fallback = rep.bot_record.position

                    pcall(
                        Net.move_player_camera,
                        player_id,
                        fallback.x,
                        fallback.y,
                        fallback.z,
                        0
                    )
                end
            end
        end
    end
end)

return FootBomb