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

local FootBomb = {}
local npc_refs = {}                 -- area_id -> actor_id -> reference
local pending_interactions = {}    -- player_id -> true
local waiting_matches = {}         -- source area -> waiting VS Player match
local player_representations = {}  -- player_id -> bot/cursor/camera data
local instance_bots = {}           -- instance_id -> slot records
local instance_spawn_points = {}   -- instance_id -> named Player 1/2 positions

local DEFAULT_SOURCE_AREA = "footbomb"
local MUG_FOLDER = "/server/assets/net-game-footbomb/bots/"
local DEFAULT_ASSET_NAME = "ref-prog"
local DEFAULT_MUG_ANIMATION = MUG_FOLDER .. "mug.animation"
local DEFAULT_MUGSHOT_NAME = "ref-prog-mug"

local BOT_ASSET_FOLDER = "/server/assets/net-game-footbomb/bots/"
local BOMB_ASSET_FOLDER = "/server/assets/net-game-footbomb/bombs/"

local NAVI_OPTIONS = {
    {
        name = "MegaMan",
        texture = BOT_ASSET_FOLDER .. "megaman.png",
        animation = BOT_ASSET_FOLDER .. "megaman.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "Roll",
        texture = BOT_ASSET_FOLDER .. "roll.png",
        animation = BOT_ASSET_FOLDER .. "roll.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "Normal Navi",
        texture = BOT_ASSET_FOLDER .. "normal-navi-green.png",
        animation = BOT_ASSET_FOLDER .. "normal-navi-green.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "ProtoMan",
        texture = BOT_ASSET_FOLDER .. "protoman-bn5.png",
        animation = BOT_ASSET_FOLDER .. "protoman-bn5.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "Glyde",
        texture = BOT_ASSET_FOLDER .. "glyde.png",
        animation = BOT_ASSET_FOLDER .. "glyde.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "GutsMan",
        texture = BOT_ASSET_FOLDER .. "gutsman.png",
        animation = BOT_ASSET_FOLDER .. "gutsman.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    },
    {
        name = "Prog",
        texture = BOT_ASSET_FOLDER .. "prog.png",
        animation = BOT_ASSET_FOLDER .. "prog.animation",
        animation_state = "FOOTBOMB_IDLE_DEFENSE"
    }
}

-- Ball skins used by the selection UI.
-- Gameplay does not use this selection yet.
local BOMB_OPTIONS = {
    {
        name = "Classic-MM",
        asset_name = "classic-mm"
    },
    {
        name = "Default-Skin",
        asset_name = "default-skin"
    },
    {
        name = "Pokemon",
        asset_name = "pokemon"
    }
}

local BOMB_PREVIEW_ANIMATION = "Preview"

local MEGAMAN_TEXTURE = NAVI_OPTIONS[1].texture
local MEGAMAN_ANIMATION = NAVI_OPTIONS[1].animation

local CURSOR_TEXTURE = "/server/assets/net-games/cursors/text_cursor.png"
local CURSOR_ANIMATION = "/server/assets/net-games/cursors/text_cursor.animation"
local CURSOR_SFX = "/server/assets/net-games/sfx/cursor_move.ogg"

local OFF_MAP_POSITION = { x = -1000, y = -1000, z = 0 }

-- Both selection stages use the same confirmation prompt and rendering path.
local CONFIRM_PROMPT = "Press A To Confirm"
local CONFIRM_PROMPT_SCALE = 2.0
local CONFIRM_PROMPT_Y = 5
local NAVI_NAME_SCALE = 1.5

local SCREEN_WIDTH = 240
local SCREEN_HEIGHT = 160
local SCREEN_CENTER = {x = 120, y = 80}

-- Ball selector coordinates use the same 240x160 virtual screen as the
-- existing Navi selector.
local BOMB_CURSOR_LEFT_X = SCREEN_CENTER.x - 28
local BOMB_CURSOR_RIGHT_X = SCREEN_CENTER.x + 34
local BOMB_CURSOR_Y = SCREEN_CENTER.y + 12

local BOMB_PREVIEW_X = SCREEN_CENTER.x - 17
local BOMB_PREVIEW_Y = SCREEN_CENTER.y + 4
local BOMB_SELECTOR_SCALE = 2.0

local function log(message)
    logger:info("[footbomb] " .. tostring(message))
end

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
        animation = "IDLE_DR",

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
        ["Defender 2"] = true
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
        "Defender 2"
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
        ["Defender 2"] = found["Defender 2"]
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
            animation = "IDLE_D",

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

local function transfer_match_players(instance, player_ids, spawn_points)
    local transferred = {}

    for slot, player_id in ipairs(player_ids) do
        for _, option in ipairs(NAVI_OPTIONS) do
            pcall(
                Net.provide_asset_for_player,
                player_id,
                option.texture
            )

            pcall(
                Net.provide_asset_for_player,
                player_id,
                option.animation
            )
        end

        pcall(Net.provide_asset_for_player, player_id, CURSOR_SFX)
        pcall(Net.provide_asset_for_player, player_id, CURSOR_TEXTURE)
        pcall(Net.provide_asset_for_player, player_id, CURSOR_ANIMATION)

        -- Make the bomb preview assets available to the player.
        for _, option in ipairs(BOMB_OPTIONS) do
            local texture_path = BOMB_ASSET_FOLDER
                .. option.asset_name .. ".png"

            local animation_path = BOMB_ASSET_FOLDER
                .. option.asset_name .. ".animation"

            pcall(
                Net.provide_asset_for_player,
                player_id,
                texture_path
            )

            pcall(
                Net.provide_asset_for_player,
                player_id,
                animation_path
            )
        end

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
        else
            log("Transfer failed for " .. tostring(player_id)
                .. ": " .. tostring(result))
        end
    end

    return transferred
end

local function remove_instance_bots(instance_id)
    for _, bot in ipairs(instance_bots[instance_id] or {}) do
        safe_remove_bot(bot.id)
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

        -- Selection state.
        skin_index = bot_record.skin_index or 1,
        bomb_skin_index = 1,

        bomb_selection_confirmed = false,
        selection_confirmed = false,
        confirming = false,
        match_started = false,
        selector_ui_visible = false,

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
        animation = option.animation_state or "IDLE_D",

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
                animation = old_option.animation_state or "IDLE_D",

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
            rep.bot_id = restored_id
        end

        return
    end

    rep.skin_index = next_index
    rep.bot_record.skin_index = next_index
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
    end

    log("Player " .. tostring(player_id)
        .. " selected " .. option.name)
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
        set_bot_animation_state(kicker.id, "IDLE_UR")
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
                        { property = "Animation", value = "IDLE_UR" },
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

---------------------------------------------------------------------------
-- Match confirmation
---------------------------------------------------------------------------

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

                -- Allow movement to settle before changing the kicker's pose.
                await(Async.sleep(0.35))
                log("ROUND_SETUP: applying kicker direction/animation instance="
                    .. tostring(instance_id))
                local kicker_pose_set = set_kicker_pose_for_round(instance_id)
                log("ROUND_SETUP: kicker pose calls complete instance="
                    .. tostring(instance_id) .. " success=" .. tostring(kicker_pose_set))
                if not kicker_pose_set then
                    log("Initial FootBomb kicker pose setup failed for "
                        .. tostring(instance_id))
                end

                -- Keep the camera black briefly so the pose can take effect
                -- before the field is revealed.
                await(Async.sleep(0.35))

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
                        Net.animate_bot, kicker.id, "IDLE_UR", true
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
                        fade_player_in(player_id)

                    end
                end
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

            -- Keep the camera centered on the current Navi bot.
            if type(Net.get_bot_position) == "function"
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