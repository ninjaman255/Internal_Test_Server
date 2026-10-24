local logger = require('scripts/ezlibs-scripts/ezlogger').get('eznpcs')
local Direction = require("scripts/ezlibs-scripts/direction")
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local ezcache = require('scripts/ezlibs-scripts/ezcache')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local math = require('math')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezquests = require('scripts/ezlibs-scripts/ezquests')   -- added for quest checks
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

-- Optional schema-driven validation. If the generated schema file is not
-- present yet (user hasn't run generate-ezlibs-tiled.lua), validation is
-- skipped silently so the module continues to load.
local tiled_schema = nil
do
    local ok, mod = pcall(require, "scripts/ezlibs-scripts/ezlibs-tiled-schema")
    if ok and type(mod) == "table" and mod.classes then
        tiled_schema = mod
    end
end

local eznpcs = {}

-- Battle-exit notifications are retained per player so a dialogue coroutine
-- can wait for the actual exit event even if it arrives just before waiting.
local battle_exit_generation = {}
local battle_exit_waiting = {}
local placeholder_to_botid = {}          -- area_id -> placeholder_id -> global bot ID (for non-exclusive NPCs)
local exclusive_npcs = {}                -- player_id -> { placeholder_id = bot_id }
local exclusive_placeholders = {}        -- list of { area_id, object_id } for all exclusive NPC placeholders

-- Quest‑exclusive NPC data
local quest_exclusive_placeholders = {}  -- list of { area_id, object_id, quest_name, required_state }
local quest_exclusive_npcs = {}           -- player_id -> { placeholder_id = bot_id }

-- NPC Spawner state:
--   npc_spawners[area_id][object_id] = spawner_state (see register_npc_spawner)
local npc_spawners = {}

local npcs = {}                           -- global bot ID -> npc data (for all bots, including exclusive)
local current_player_conversation = {}

local npc_asset_folder = '/server/assets/ezlibs-assets/eznpcs/'
local custom_events_script_path = 'scripts/events/eznpcs_events'
local custom_events_script_loaded = false
local generic_npc_mug_animation_path = npc_asset_folder..'mug/mug.animation'
local events = require('scripts/ezlibs-scripts/eznpcs/dialogue_types')
local npc_required_properties = {"Direction","Asset Name"}

-- Backwards-compatible local alias. Semantics unchanged: nil -> false,
-- true/"true"/non-zero-number -> true. The single canonical implementation
-- now lives in tiled_utils.
local is_property_true = tu.is_true

-- ---------------------------------------------------------------------------
-- NPC animation state tracking
--
-- Waypoints and cutscene pose holds both need to drive bot animation state.
-- Tracking the "current" animation + who owns it lets waypoint movement skip
-- redundant Net.animate_bot calls every tick, and lets a cutscene pose hold
-- block waypoint ticks from clobbering it (see move_npc's pose bail-out).
--
-- Ownership values:
--   nil       - no explicit animation tracked (engine picks).
--   "move"    - waypoint travel animation, applied by move_npc and by
--               start_scripted_waypoint_move for keyframe-driven movement.
--   "wait"    - waypoint Wait Animation, applied by on_npc_reached_waypoint
--               and waypoint_follow_behaviour.initialize.
--   "pose"    - cutscene / API pose hold, applied by move_bot_to_spot /
--               set_bot_pose. move_npc bails out while this owns the state.
-- ---------------------------------------------------------------------------
local function set_npc_animation(npc, animation, loop, source)
    if not npc or not npc.bot_id then return false end
    if not animation or animation == "" then return false end
    if loop == nil then loop = true end
    if npc.current_animation == animation
        and npc._animation_source == source then
        return true
    end
    local ok, result = pcall(Net.animate_bot, npc.bot_id, animation, loop)
    if ok and result ~= false then
        npc.current_animation = animation
        npc._animation_source = source
        return true
    end
    return false
end

local function printd(...)
    local arg={...}
    logger:info('[eznpcs]',table.unpack(arg))
end

-- Log-only schema validation. Turning this into a hard reject is a one-line
-- change (replace the `logger:warn` block with `return nil`).
local function validate_npc_object(area_id, object)
    if not tiled_schema then return end
    local class_name = object.type or "NPC"
    local class_def = tiled_schema.classes[class_name]
    if not class_def then return end
    local ok, report = tu.validate_properties(object, class_def.members, tiled_schema.enums)
    if ok then return end
    for _, e in ipairs(report.errors) do
        logger:warn(string.format(
            "[eznpcs] %s %s in %s: %s (expected %s, got %s)",
            class_name, tostring(object.id), tostring(area_id),
            e.issue, tostring(e.expected), tostring(e.got)))
    end
end

-- Helper: get all players currently in the server (across all areas)
local function get_all_players()
    local players = {}
    local areas = Net.list_areas()
    for _, area_id in ipairs(areas) do
        local area_players = Net.list_players(area_id) or {}
        for _, pid in ipairs(area_players) do
            table.insert(players, pid)
        end
    end
    return players
end

-- Helper: exclude a bot from everyone except the owner
local function exclude_except_for(owner_id, bot_id)
    local all_players = get_all_players()
    for _, pid in ipairs(all_players) do
        if pid ~= owner_id then
            Net.exclude_actor_for_player(pid, bot_id)
        end
    end
    printd("Excluded bot", bot_id, "from all except", owner_id)
end

-- Helper: include a bot for all players (used when creating a non-exclusive bot)
local function include_for_all(bot_id)
    local all_players = get_all_players()
    for _, pid in ipairs(all_players) do
        Net.include_actor_for_player(pid, bot_id)
    end
end

-- Notify other modules when a bot lifecycle event occurs. Consumers such as
-- ezpress (area-wide scaling) and ezbottriggers (bot enter/depart detection)
-- subscribe to these on ezbus, so no Net polling is required elsewhere.
local function emit_bot_created(bot_id, area_id, extra)
    if bot_id == nil then return end
    local payload = { bot_id = bot_id, area_id = area_id }
    if type(extra) == "table" then
        for k, v in pairs(extra) do payload[k] = v end
    end
    ezbus:emit("bot_created", payload)
end

local function emit_bot_removed(bot_id)
    if bot_id == nil then return end
    ezbus:emit("bot_removed", { bot_id = bot_id })
end

local function emit_bot_moved(bot_id, area_id, x, y, z)
    if bot_id == nil then return end
    ezbus:emit("bot_moved", {
        bot_id = bot_id,
        area_id = area_id,
        x = x,
        y = y,
        z = z
    })
end


function eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
    local mugshot_asset_name = npc.asset_name
    local custom_mugshot = dialogue.custom_properties["Mugshot"]
    local mug = {}
    if custom_mugshot then
        mugshot_asset_name = custom_mugshot
    end
    mug.texture_path = npc_asset_folder.."mug/"..mugshot_asset_name..".png"
    mug.animation_path = npc.mug_animation_path
    if mugshot_asset_name == "player" then
        local player_mugshot = Net.get_player_mugshot(player_id)
        mug.texture_path = player_mugshot.texture_path
        mug.animation_path = player_mugshot.animation_path
    end
    return mug
end

function do_dialogue(npc,player_id,dialogue,relay_object)
    return async(function ()
        local dialogue_promise = nil

        local area_id = Net.get_player_area(player_id)
        local dialogue_type = dialogue.custom_properties["Dialogue Type"]
        local event_name = dialogue.custom_properties["Event Name"]
        if event_name then
            --legacy override for people still using Event Name
            dialogue_type = event_name
        end
        if dialogue_type == nil then
            printd("dialogue "..dialogue.id.." has no Dialogue Type specified.")
            return
        end

        if events[dialogue_type] then
            dialogue_promise = events[dialogue_type].action(npc,player_id,dialogue,relay_object)
        end

        local next_dialogue_id = await(dialogue_promise)
        if not next_dialogue_id then
            return
        end

        local dialogue = ezcache.get_object_by_id_cached(area_id,next_dialogue_id)
        if not dialogue then
            return
        end
        return await(do_dialogue(npc,player_id,dialogue,relay_object))
    end)
end

-- Creates a bot (global or per-player) and returns its npc_data.
--
-- options (all optional):
--   skip_placeholder_registration  (bool)  When true, does NOT register the
--                                          bot in placeholder_to_botid. Used
--                                          by spawners so multiple instances
--                                          of the same template don't collide.
--   on_path_complete               (func)  Passed to waypoint_follow_behaviour;
--                                          fires when the NPC reaches a
--                                          waypoint with no next waypoint.
function create_bot_from_object(area_id, object, player_id, options)
    if not object then return end
    options = options or {}
    local x = object.x
    local y = object.y
    local z = object.z

    for i, prop_name in pairs(npc_required_properties) do
        if not object.custom_properties[prop_name] then
            printd('NPC objects require the custom property '..prop_name)
            return false
        end
    end

    local npc_asset_name = object.custom_properties["Asset Name"]
    local npc_animation_name = object.custom_properties["Animation Name"] or false
    local npc_mug_animation_name = object.custom_properties["Mug Animation Name"] or false
    local npc_turns_to_talk = is_property_true(object.custom_properties["Dont Face Player"])
    local direction = object.custom_properties.Direction

    -- Debug: print asset paths
    printd("Creating NPC with asset:", npc_asset_name, "texture:", npc_asset_folder.."sheet/"..npc_asset_name..".png")

    -- Create the bot (initially visible to all)
    local npc = create_npc(area_id, npc_asset_name, x, y, z, direction,
                           object.name, npc_animation_name, npc_mug_animation_name, npc_turns_to_talk)

    if not npc then
        printd("Failed to create bot for", npc_asset_name)
        return
    end

    -- If this is an exclusive NPC for a specific player, hide it from everyone else
    if player_id then
        if not exclusive_npcs[player_id] then exclusive_npcs[player_id] = {} end
        exclusive_npcs[player_id][tostring(object.id)] = npc.bot_id
        exclude_except_for(player_id, npc.bot_id)
        printd("Exclusive bot", npc.bot_id, "created for player", player_id)
    elseif not options.skip_placeholder_registration then
        -- Global NPC: store in placeholder_to_botid and ensure visible to all
        if not placeholder_to_botid[area_id] then placeholder_to_botid[area_id] = {} end
        placeholder_to_botid[area_id][tostring(object.id)] = npc.bot_id
        printd("Global bot", npc.bot_id, "created for placeholder", object.id)
    else
        printd("Spawned bot", npc.bot_id, "created without placeholder registration")
    end

    -- New Tiled format: NPCs reference a separate Dialogue object.
    -- Keep the NPC placeholder ID/properties separate from the dialogue data:
    -- Player Exclusive and placeholder hiding belong to the NPC object.
    npc.placeholder_id = object.id
    npc.placeholder_custom_properties = object.custom_properties or {}

    local first_dialogue_id = object.custom_properties["First Dialogue"]
    if first_dialogue_id ~= nil and tostring(first_dialogue_id) ~= "" then
        local first_dialogue = ezcache.get_object_by_id_cached(area_id, first_dialogue_id)
        if first_dialogue and (first_dialogue.type == "Dialogue" or first_dialogue.class == "Dialogue") then
            npc.first_dialogue = first_dialogue
        else
            printd("NPC " .. tostring(object.id)
                .. " has an invalid First Dialogue reference: "
                .. tostring(first_dialogue_id)
                .. " (expected a Dialogue object in area " .. tostring(area_id) .. ")")
        end
    end

    -- Install the interaction handler whenever the NPC has either a
    -- First Dialogue or a Cutscene property. Cutscene-only NPCs use the
    -- same handler so the Once-consumed path has somewhere to fall through.
    local cutscene_name = object.custom_properties["Cutscene"]
    local has_cutscene = cutscene_name ~= nil and tostring(cutscene_name) ~= ""
    if npc.first_dialogue or has_cutscene then
        add_behaviour(npc, chat_behaviour())
    end

    if object.custom_properties["Next Waypoint 1"] then
        local waypoint_follow = waypoint_follow_behaviour(
            object.custom_properties["Next Waypoint 1"], options)
        add_behaviour(npc, waypoint_follow)
    end

    -- Lets composed behavior objects attach to ordinary, player-exclusive,
    -- and quest-exclusive instances after the base NPC record is complete.
    ezbus:emit("npc_created_from_object", {
        area_id = area_id,
        object_id = object.id,
        object_type = object.type,
        bot_id = npc.bot_id,
        player_id = player_id,
        x = npc.x, y = npc.y, z = npc.z or 0,
        name = object.name,
        custom_properties = object.custom_properties or {},
    })

    return npc
end

function create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,npc_turns_to_talk)
    local texture_path = npc_asset_folder.."sheet/"..asset_name..".png"
    local animation_path = npc_asset_folder.."sheet/"..asset_name..".animation"
    local mug_animation_path = generic_npc_mug_animation_path
    local name = bot_name or nil
    --Override animations if they were provided as custom properties
    if animation_name then
        animation_path = npc_asset_folder..'sheet/'..animation_name..".animation"
    end
    if mug_animation_name then
        mug_animation_path = npc_asset_folder..'mug/'..mug_animation_name..".animation"
    end
    if npc_turns_to_talk == nil then
        npc_turns_to_talk = true
    end
    --Create bot
    local npc_data = {
        asset_name=asset_name,
        bot_id=nil,
        name=name,
        area_id=area_id,
        texture_path=texture_path,
        animation_path=animation_path,
        mug_animation_path=mug_animation_path,
        x=x,
        y=y,
        z=z,
        direction=direction,
        solid=true,
        size=0.2,
        speed=1,
        dont_face_player=npc_turns_to_talk,
        warp_in = true,  -- Explicitly set warp_in to ensure visibility
        -- Animation ownership tracking (see set_npc_animation above).
        current_animation = nil,
        _animation_source = nil,
        _hold_generation = 0,
        -- Scripted movement ownership. When a scripted waypoint move is in
        -- flight (Move Duration > 0), _scripted_move_generation is bumped so
        -- any stale async completion can detect it lost ownership. See
        -- start_scripted_waypoint_move.
        _scripted_move_generation = 0,
        _scripted_move_active = false,
    }
    printd("Creating bot with texture:", texture_path, "animation:", animation_path)
    local lastBotId = Net.create_bot(npc_data)
    if not lastBotId then
        printd("Net.create_bot returned nil for", asset_name)
        return nil
    end
    npc_data.bot_id = lastBotId
    npcs[lastBotId] = npc_data
    printd('created npc '..(name or "unnamed")..' id:'..lastBotId..' at ('..x..','..y..','..z..')')
    -- Include position so ezbottriggers can immediately register an overlap
    -- for bots spawned inside a trigger area (static NPCs included).
    emit_bot_created(lastBotId, area_id, {
        asset_name = asset_name,
        name = name,
        x = x,
        y = y,
        z = z
    })
    return npc_data
end

function add_behaviour(npc,behaviour)
    if behaviour.type and behaviour.action then
        npc[behaviour.type] = behaviour
        if behaviour.initialize then
            behaviour.initialize(npc)
        end
    end
end

function clear_player_conversation(player_id)
    Net.unlock_player_input(player_id)
    local bot_id = current_player_conversation[player_id]
    if bot_id then
        local npc = npcs[bot_id]
        if npc and not npc.dont_face_player then
            Net.set_bot_direction(npc.bot_id, npc.direction)
        end
        current_player_conversation[player_id] = nil
        ezbus:emit("dialogue_ended", {
            player_id = player_id,
            npc_id = bot_id
        })
    end
end

--Behaviour factories
function chat_behaviour()
    behaviour = {
        type='on_interact',
        action=function(npc,player_id,relay_object)
            return async(function ()
                -- Optional cutscene prefix. If the NPC has a `Cutscene`
                -- property set and the referenced cutscene has not already
                -- been consumed (Once semantics), play it and skip the
                -- dialogue for this interaction. Subsequent interactions
                -- fall through to the normal dialogue flow.
                local cutscene_name = npc.placeholder_custom_properties
                    and npc.placeholder_custom_properties["Cutscene"]
                if cutscene_name and cutscene_name ~= "" then
                    local ezcutscenes = require('scripts/ezlibs-scripts/ezcutscenes/ezcutscenes')
                    local cutscene_promise = ezcutscenes.start(
                        player_id,
                        npc.area_id,
                        cutscene_name,
                        {
                            trigger_object_id = npc.placeholder_id,
                            trigger_bot_id = npc.bot_id,
                        })
                    if cutscene_promise then
                        await(cutscene_promise)
                        return
                    end
                    -- Cutscene already played (Once consumed); continue below.
                end

                if current_player_conversation[player_id] == npc.bot_id then
                    return
                end
                current_player_conversation[player_id] = npc.bot_id

                if not npc.dont_face_player then
                    local player_pos = Net.get_player_position(player_id)
                    local dir = player_pos and Direction.from_points(npc, player_pos) or nil
                    if dir then
                        Net.set_bot_direction(npc.bot_id, dir)
                    end
                end

                local dialogue = npc.first_dialogue
                if not dialogue then
                    -- Cutscene-only NPC whose Once was already consumed.
                    current_player_conversation[player_id] = nil
                    return
                end
                Net.lock_player_input(player_id)
                await(do_dialogue(npc,player_id,dialogue,relay_object))
                clear_player_conversation(player_id)
            end)
        end
    }
    return behaviour
end

-- waypoint_follow_behaviour(first_waypoint_id, options)
--   options.on_path_complete  (func, optional)  Fires when the NPC reaches a
--                                                 waypoint whose Next Waypoint
--                                                 is nil (end of path). Used
--                                                 by NPC Spawners to trigger
--                                                 warp-out or cleanup.
function waypoint_follow_behaviour(first_waypoint_id, options)
    options = options or {}
    behaviour = {
        type='on_tick',
        initialize=function(npc)
            npc._waypoint_path_complete_cb = options.on_path_complete
            local first_waypoint = ezcache.get_object_by_id_cached(npc.area_id, first_waypoint_id)
            if first_waypoint then
                npc.next_waypoint = first_waypoint
                -- Seed the initial pose from the first waypoint's Wait
                -- Animation, so the NPC spawns in the correct state instead
                -- of whatever Net.create_bot defaulted to.
                local props = first_waypoint.custom_properties or {}
                local wait_anim = props["Wait Animation"]
                if wait_anim and wait_anim ~= "" then
                    local wait_loop_prop = props["Wait Loop"]
                    local wait_loop = (wait_loop_prop == nil) and true
                        or is_property_true(wait_loop_prop)
                    set_npc_animation(npc, wait_anim, wait_loop, "wait")
                end
            else
                printd('invalid Next Waypoint '..first_waypoint_id)
            end
        end,
        action=function(npc,delta_time)
            move_npc(npc,delta_time)
        end
    }
    return behaviour
end

function do_actor_interaction(player_id,actor_id,relay_object)
    local npc = npcs[actor_id]
    if npc and npc.on_interact then
        npc.on_interact.action(npc,player_id,relay_object)
    end
end

function is_anyone_talking_to_npc(npc_id)
    for player_id, chatty_npc_id in pairs(current_player_conversation) do
        if npc_id == chatty_npc_id then return true end
    end
    return false
end

-- =========================================================================
-- Scripted waypoint movement
--
-- Footbomb-style jumps are multi-frame animations where the position must
-- track the animation's intrinsic timing (a 0.5s jump arc, for example).
-- Per-tick Net.move_bot can't express that: the animation and position drift
-- apart. When a waypoint sets Move Duration > 0, we switch into scripted mode:
--
--   1. Apply the Move Animation once (respecting Move Loop).
--   2. Queue keyframes with Net.animate_bot_properties from the current
--      position to the waypoint position over exactly Move Duration seconds.
--   3. On completion, call on_npc_reached_waypoint — which applies the Wait
--      Animation (the END hold pose) and advances npc.next_waypoint.
--
-- A generation counter invalidates in-flight scripted moves when a cutscene
-- pose claims the animation state, or when a new scripted move starts.
-- =========================================================================
local function start_scripted_waypoint_move(npc, waypoint, move_anim, move_loop, move_duration)
    if not npc or not npc.bot_id then return false end
    if type(move_duration) ~= "number" or move_duration <= 0 then return false end

    local sx = tonumber(npc.x) or 0
    local sy = tonumber(npc.y) or 0
    local sz = tonumber(npc.z) or 0
    local tx = tonumber(waypoint.x) or sx
    local ty = tonumber(waypoint.y) or sy
    local tz = tonumber(waypoint.z) or sz

    -- Claim ownership: bump generation, mark in flight. Any older scripted
    -- completion will see a generation mismatch and bail out cleanly.
    npc._scripted_move_generation = (npc._scripted_move_generation or 0) + 1
    local my_generation = npc._scripted_move_generation
    npc._scripted_move_active = true

    -- Apply the Move Animation once (non-looping for jumps, looping for
    -- cycles). set_npc_animation short-circuits if already current so
    -- replays inside the same source never double-fire.
    if move_anim and move_anim ~= "" then
        set_npc_animation(npc, move_anim, move_loop, "move")
    end

    -- Queue position keyframes matching the animation timing.
    local keyframes = {
        {
            properties = {
                { property = "X", value = sx },
                { property = "Y", value = sy },
                { property = "Z", value = sz },
            },
            duration = 0,
        },
        {
            properties = {
                { property = "X", ease = "Linear", value = tx },
                { property = "Y", ease = "Linear", value = ty },
                { property = "Z", ease = "InOut",  value = tz },
            },
            duration = move_duration,
        },
    }
    local ok, result = pcall(Net.animate_bot_properties, npc.bot_id, keyframes)
    if not ok or result == false then
        npc._scripted_move_active = false
        printd("scripted waypoint move failed bot=" .. tostring(npc.bot_id)
            .. " error=" .. tostring(result))
        return false
    end

    -- Local cache of the final position so subsequent ticks (and
    -- on_npc_reached_waypoint) see the correct endpoint even before the
    -- engine has finished interpolating.
    npc.x, npc.y, npc.z = tx, ty, tz

    async(function()
        await(Async.sleep(move_duration))
        -- Lost ownership? A cutscene pose or another scripted move took over.
        if npc._scripted_move_generation ~= my_generation then return end
        if not npc._scripted_move_active then return end
        if npc._removed then return end
        -- Pose holds override everything, including waypoint arrival.
        if npc._animation_source == "pose" then return end
        -- The next_waypoint may have changed if someone intervened.
        if npc.next_waypoint ~= waypoint then
            npc._scripted_move_active = false
            return
        end
        npc._scripted_move_active = false
        -- Broadcast the arrival so ezbottriggers reconciles overlaps at the
        -- exact waypoint position.
        local area_id = npc.area_id
        if type(Net.get_bot_area) == "function" then
            local ok_area, found = pcall(Net.get_bot_area, npc.bot_id)
            if ok_area and found then area_id = found end
        end
        if area_id then
            emit_bot_moved(npc.bot_id, area_id, tx, ty, tz)
        end
        on_npc_reached_waypoint(npc, waypoint)
    end)

    printd("scripted waypoint move started bot=" .. tostring(npc.bot_id)
        .. " waypoint=" .. tostring(waypoint.id)
        .. " animation=" .. tostring(move_anim or "")
        .. " loop=" .. tostring(move_loop)
        .. " duration=" .. tostring(move_duration)
        .. " generation=" .. tostring(my_generation)
        .. " target=(" .. tostring(tx) .. "," .. tostring(ty) .. "," .. tostring(tz) .. ")")
    return true
end

function move_npc(npc,delta_time)
    if is_anyone_talking_to_npc(npc.bot_id) then return end
    -- A cutscene / API pose hold owns the animation state. Bail out so
    -- waypoint ticks don't fight the pose and don't re-enable movement
    -- while the pose is being held.
    if npc._animation_source == "pose" then return end
    -- A scripted waypoint move is in flight. Its async completion owns the
    -- transition to on_npc_reached_waypoint, so per-tick movement must not
    -- interleave with the keyframes.
    if npc._scripted_move_active then return end
    if npc.wait_time and npc.wait_time > 0 then
        npc.wait_time = npc.wait_time - delta_time
        return
    end

    local area_id = Net.get_bot_area(npc.bot_id)
    local waypoint = npc.next_waypoint
    if not waypoint then return end

    local distance = math.sqrt((waypoint.x - npc.x) ^ 2 + (waypoint.y - npc.y) ^ 2)
    if distance < npc.size then
        on_npc_reached_waypoint(npc,waypoint)
        return
    end

    local wp_props = waypoint.custom_properties or {}
    local move_anim = wp_props["Move Animation"]
    local move_loop_prop = wp_props["Move Loop"]
    local move_loop = (move_loop_prop == nil) and true or is_property_true(move_loop_prop)
    local move_duration = tonumber(wp_props["Move Duration"]) or 0

    -- Scripted mode: Move Duration > 0 means the author authored a
    -- time-synced animation (like a jump arc). Switch to keyframe movement
    -- so position and animation stay glued together.
    if move_anim and move_anim ~= "" and move_duration > 0 then
        start_scripted_waypoint_move(npc, waypoint, move_anim, move_loop, move_duration)
        return
    end

    -- Walk mode: apply travel animation/direction, advance per-tick.
    if move_anim and move_anim ~= "" then
        set_npc_animation(npc, move_anim, move_loop, "move")
    else
        local move_dir = wp_props["Move Direction"]
        if move_dir and move_dir ~= "" and npc.direction ~= move_dir then
            Net.set_bot_direction(npc.bot_id, move_dir)
            npc.direction = move_dir
        end
    end

    local angle = math.atan(waypoint.y - npc.y, waypoint.x - npc.x)
    local vel_x = math.cos(angle) * npc.speed
    local vel_y = math.sin(angle) * npc.speed

    local new_pos = {x=0,y=0,z=npc.z,size=npc.size}

    new_pos.x = npc.x + vel_x * delta_time
    new_pos.y = npc.y + vel_y * delta_time

    if helpers.position_overlaps_something(new_pos,area_id) then return end

    Net.move_bot(npc.bot_id, new_pos.x, new_pos.y, new_pos.z)
    npc.x = new_pos.x
    npc.y = new_pos.y
    -- Broadcast the new position so ezbottriggers can reconcile overlaps.
    emit_bot_moved(npc.bot_id, area_id, new_pos.x, new_pos.y, new_pos.z)
end

function on_npc_reached_waypoint(npc,waypoint)
    local should_be_cached = ezcache.object_is_of_type(waypoint,{"Waypoint"})
    if not should_be_cached then
        printd("WARNING Waypoint "..waypoint.id.." at "..waypoint.x..","..waypoint.y.." in "..npc.area_id.." has incorrect type and wont be cached")
    end
    if waypoint.custom_properties['Wait Time'] ~= nil then
        npc.wait_time = tonumber(waypoint.custom_properties['Wait Time'])
        if waypoint.custom_properties['Direction'] ~= nil then
            npc.direction = waypoint.custom_properties['Direction']
            Net.set_bot_direction(npc.bot_id, waypoint.custom_properties['Direction'])
        end
        -- Apply the arrival pose inside the same Wait Time guard, so we
        -- only overwrite travel animation when there's a wait to hold it.
        -- Wait Animation is typically an END / hold state (e.g.
        -- FOOTBOMB_JUMP_LEFT_END); Wait Loop defaults to true so the
        -- engine keeps showing it rather than reverting to idle.
        local wait_anim = waypoint.custom_properties['Wait Animation']
        if wait_anim and wait_anim ~= "" then
            local wait_loop_prop = waypoint.custom_properties['Wait Loop']
            local wait_loop = (wait_loop_prop == nil) and true
                or is_property_true(wait_loop_prop)
            set_npc_animation(npc, wait_anim, wait_loop, "wait")
        end
    end
    local waypoint_type = "first"
    if waypoint.custom_properties["Waypoint Type"] then
        waypoint_type = waypoint.custom_properties["Waypoint Type"]
    end
    local next_waypoints = helpers.extract_numbered_properties(waypoint,"Next Waypoint ")
    local next_waypoint_id = nil
    if waypoint_type == "first" then
        next_waypoint_id = first_value_from_table(next_waypoints)
    end
    if waypoint_type == "random" then
        local next_waypoint_index = math.random(#next_waypoints)
        next_waypoint_id = next_waypoints[next_waypoint_index]
    end
    local date_b = waypoint.custom_properties['Date']
    if waypoint_type == "before" then
        if date_b then
            next_waypoint_id = next_waypoints[2]
            if helpers.is_now_before_date(date_b) then
                next_waypoint_id = next_waypoints[1]
            end
        end
    end
    if waypoint_type == "after" then
        if date_b then
            next_waypoint_id = next_waypoints[2]
            if not helpers.is_now_before_date(date_b) then
                next_waypoint_id = next_waypoints[1]
            end
        end
    end

    if next_waypoint_id then
        npc.next_waypoint = ezcache.get_object_by_id_cached(npc.area_id,next_waypoint_id)
    else
        -- End of path: next_waypoint becomes nil, and the path-complete
        -- callback (if any) fires exactly once. Spawners use this hook to
        -- decide whether to warp out, warp out after a delay, or simply
        -- leave the NPC parked at the last waypoint.
        npc.next_waypoint = nil
        if npc._waypoint_path_complete_cb then
            local ok, err = pcall(npc._waypoint_path_complete_cb, npc)
            if not ok then
                printd("waypoint path-complete callback failed bot="
                    .. tostring(npc.bot_id) .. " err=" .. tostring(err))
            end
        end
    end
end

-- =========================================================================
-- NPC Spawners
--
-- Two independent axes control spawning:
--   * Spawn Mode (Once / Interval)
--   * Trigger Radius (0 = immediate on load; > 0 = player presence gated)
--
-- State lives in npc_spawners[area_id][object_id]:
--   live_bots             set of bot_ids currently alive from this spawner
--   spawn_mode            "once" | "interval"
--   spawn_interval        seconds between spawns (Interval mode)
--   max_alive             0 = unlimited; else concurrent-bot cap
--   once                  Once-mode per-session cap flag
--   once_spawned          whether Once mode has already fired this session
--   trigger_armed         Once mode: re-arm after player leaves radius
--   was_player_inside     Interval mode: detect entry transitions
--   time_since_last_spawn Interval mode: interval timer
--
-- Templates may be NPC or Pushback NPC. Pushback NPC templates produce a
-- bot whose collision zone follows it; ezpushback subscribes to the
-- npc_spawned_from_spawner event emitted below to attach the moving
-- rectangle to each spawned bot.
-- =========================================================================

-- Clean up dead entries and return the live count.
local function count_and_prune_live_bots(spawner)
    local live_count = 0
    local dead = nil
    for bot_id in pairs(spawner.live_bots) do
        if npcs[bot_id] then
            live_count = live_count + 1
        else
            dead = dead or {}
            dead[#dead + 1] = bot_id
        end
    end
    if dead then
        for _, bot_id in ipairs(dead) do
            spawner.live_bots[bot_id] = nil
        end
    end
    return live_count
end

-- Warp out a spawner-owned NPC. Called by the on_path_complete callback.
local function warp_out_spawner_npc(spawner, npc)
    if not spawner or not npc or not npc.bot_id then return end
    local props = spawner.object.custom_properties or {}
    local delay = tonumber(props["Warp Out Delay"]) or 0
    local animation = props["Warp Out Animation"]
    local duration = tonumber(props["Warp Out Animation Duration"]) or 0.5
    if duration < 0 then duration = 0 end
    local bot_id = npc.bot_id

    async(function()
        if delay > 0 then
            await(Async.sleep(delay))
        end
        if not npcs[bot_id] then
            spawner.live_bots[bot_id] = nil
            return
        end
        if animation and animation ~= "" then
            pcall(Net.animate_bot, bot_id, animation, false)
            await(Async.sleep(duration))
        end
        if not npcs[bot_id] then
            spawner.live_bots[bot_id] = nil
            return
        end
        spawner.live_bots[bot_id] = nil
        emit_bot_removed(bot_id)
        pcall(Net.remove_bot, bot_id)
        npcs[bot_id] = nil
        printd("spawner warped out bot=" .. tostring(bot_id)
            .. " spawner=" .. tostring(spawner.object.id)
            .. " area=" .. tostring(spawner.area_id))
    end)

    printd("spawner warp-out scheduled bot=" .. tostring(bot_id)
        .. " spawner=" .. tostring(spawner.object.id)
        .. " delay=" .. tostring(delay)
        .. " animation=" .. tostring(animation or "")
        .. " duration=" .. tostring(duration))
end

-- Callback factory. Each spawner gets a closure that captures its own state.
local function make_spawner_path_complete_cb(spawner)
    return function(npc)
        local props = spawner.object.custom_properties or {}
        local warp_out = is_property_true(props["Warp Out At End"])
        printd("spawner path complete bot=" .. tostring(npc.bot_id)
            .. " spawner=" .. tostring(spawner.object.id)
            .. " warp_out=" .. tostring(warp_out))
        if not warp_out then
            -- NPC stays at the last waypoint; spawner keeps the bot in
            -- live_bots so Interval mode counts it toward Max Alive.
            return
        end
        warp_out_spawner_npc(spawner, npc)
    end
end

-- Spawn one NPC from this spawner. Returns true on success. Enforces:
--   * Once mode: no live bot AND not once_spawned
--   * Interval mode: live count under Max Alive (or unlimited)
--
-- After a successful spawn, emits npc_spawned_from_spawner so consumers
-- (notably ezpushback for Pushback NPC templates) can attach per-bot
-- behaviours that need the template's properties but a bot_id-scoped key.
local function spawn_from_spawner(spawner)
    if not spawner then return false end
    local live_count = count_and_prune_live_bots(spawner)

    if spawner.spawn_mode == "once" then
        if spawner.once_spawned then return false end
        if live_count > 0 then return false end
    end
    if spawner.max_alive > 0 and live_count >= spawner.max_alive then
        return false
    end

    local npc = create_bot_from_object(spawner.area_id, spawner.template_object, nil, {
        skip_placeholder_registration = true,
        on_path_complete = make_spawner_path_complete_cb(spawner),
    })
    if not npc then
        return false
    end
    spawner.live_bots[npc.bot_id] = true
    if spawner.spawn_mode == "once" then
        spawner.once_spawned = true
    end
    printd("spawner spawned bot=" .. tostring(npc.bot_id)
        .. " spawner=" .. tostring(spawner.object.id)
        .. " area=" .. tostring(spawner.area_id)
        .. " mode=" .. tostring(spawner.spawn_mode)
        .. " live_count=" .. tostring(live_count + 1))

    -- Notify downstream modules. Payload carries everything needed to
    -- build a bot-scoped entry: template properties (for e.g. Pushback NPC
    -- collision dims), template type (for routing), and the spawn position
    -- (so an attached collision zone starts at the bot rather than the
    -- template's authored location).
    ezbus:emit("npc_spawned_from_spawner", {
        bot_id = npc.bot_id,
        area_id = spawner.area_id,
        spawner_id = spawner.object.id,
        template_object_id = spawner.template_object.id,
        template_type = spawner.template_object.type,
        template_name = spawner.template_object.name,
        template_custom_properties = spawner.template_object.custom_properties or {},
        spawn_x = npc.x,
        spawn_y = npc.y,
        spawn_z = npc.z or 0,
    })
    return true
end

local function register_npc_spawner(area_id, object)
    validate_npc_object(area_id, object)

    local props = object.custom_properties or {}
    local template_ref = props["NPC Template"]
    if not template_ref or tostring(template_ref) == "" then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner missing NPC Template reference:",
            tostring(object.id))
        return
    end

    local template = ezcache.get_object_by_id_cached(area_id, tostring(template_ref))
    if not template then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner template not found:",
            tostring(object.id), "->", tostring(template_ref))
        return
    end
    if template.type ~= "NPC" and template.type ~= "Pushback NPC" then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner NPC Template must reference an NPC or Pushback NPC object; got type:",
            tostring(template.type))
        return
    end
    if not is_property_true((template.custom_properties or {})["Template Only"]) then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner template is not marked 'Template Only'; a duplicate NPC may spawn.",
            "spawner=", tostring(object.id),
            "template=", tostring(template_ref))
    end

    local trigger_radius = tonumber(props["Trigger Radius"]) or 0
    if trigger_radius < 0 then trigger_radius = 0 end
    local once = is_property_true(props["Once"])

    -- Spawn mode. Interval requires a trigger radius; with radius = 0 there
    -- is nothing to gate on, so we fall back to Once and warn.
    local spawn_mode_raw = props["Spawn Mode"]
    local spawn_mode = "once"
    if spawn_mode_raw and string.lower(tostring(spawn_mode_raw)) == "interval" then
        spawn_mode = "interval"
    end
    if spawn_mode == "interval" and trigger_radius <= 0 then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner '", tostring(object.id),
            "' has Spawn Mode = Interval but Trigger Radius = 0; ",
            "falling back to Once (no trigger to gate spawning).")
        spawn_mode = "once"
    end
    if spawn_mode == "interval" and once then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner '", tostring(object.id),
            "' has Spawn Mode = Interval and Once = true; ",
            "Once is ignored in Interval mode.")
    end

    local spawn_interval = tonumber(props["Spawn Interval"]) or 3
    if spawn_interval <= 0 then spawn_interval = 0.1 end
    local max_alive = tonumber(props["Max Alive"]) or 0
    if max_alive < 0 then max_alive = 0 end

    if spawn_mode == "interval"
        and not is_property_true(props["Warp Out At End"])
        and max_alive == 0 then
        logger:for_area(area_id):warn(
            "[eznpcs] NPC Spawner '", tostring(object.id),
            "' is in Interval mode with Warp Out At End = false and Max Alive = 0; ",
            "bots will accumulate indefinitely. Set Max Alive or enable Warp Out At End.")
    end

    local spawner = {
        area_id = area_id,
        object = object,
        template_object = template,
        live_bots = {},
        trigger_radius = trigger_radius,
        spawn_mode = spawn_mode,
        spawn_interval = spawn_interval,
        max_alive = max_alive,
        once = once,
        once_spawned = false,
        trigger_armed = true,
        was_player_inside = false,
        time_since_last_spawn = 0,
    }

    npc_spawners[area_id] = npc_spawners[area_id] or {}
    npc_spawners[area_id][tostring(object.id)] = spawner

    logger:for_area(area_id):info(
        "[eznpcs] Registered NPC Spawner:", tostring(object.id),
        "template=", tostring(template_ref),
        "template_type=", tostring(template.type),
        "radius=", tostring(trigger_radius),
        "mode=", spawn_mode,
        "interval=", tostring(spawn_interval),
        "max_alive=", tostring(max_alive),
        "once=", tostring(once),
        "warp_out_at_end=", tostring(is_property_true(props["Warp Out At End"])))

    if trigger_radius <= 0 then
        -- Immediate mode: spawn once on area load. Always one-shot per
        -- session, regardless of the Once flag (there's no trigger to
        -- re-arm).
        if spawn_from_spawner(spawner) then
            spawner.once_spawned = true
        else
            logger:for_area(area_id):warn(
                "[eznpcs] NPC Spawner immediate spawn failed:",
                tostring(object.id), "(will not retry)")
            spawner.once_spawned = true
        end
    end
end

object_registry.register_handler("NPC Spawner", register_npc_spawner)

-- Prune dead bot_ids from spawner live_bots whenever any bot is removed.
-- This catches removals triggered from external modules (or from
-- disconnect cleanup) that would otherwise leave stale entries in the
-- set until the next spawn attempt iterated it.
ezbus:on("bot_removed", function(event)
    if type(event) ~= "table" or not event.bot_id then return end
    local bot_id = event.bot_id
    for _, area_spawners in pairs(npc_spawners) do
        for _, spawner in pairs(area_spawners) do
            if spawner.live_bots[bot_id] then
                spawner.live_bots[bot_id] = nil
            end
        end
    end
end)

-- Called from eznpcs.on_tick. Handles both Once and Interval modes; only
-- iterates spawners in radius mode (immediate mode is handled at registration).
local function update_spawner_triggers(delta_time)
    for area_id, area_spawners in pairs(npc_spawners) do
        for _, spawner in pairs(area_spawners) do
            if spawner.trigger_radius > 0 then
                -- Player presence test.
                local sx = tonumber(spawner.object.x) or 0
                local sy = tonumber(spawner.object.y) or 0
                local radius_sq = spawner.trigger_radius * spawner.trigger_radius
                local any_in_radius = false
                local players = Net.list_players(area_id) or {}
                for _, pid in ipairs(players) do
                    local ok, pos = pcall(Net.get_player_position, pid)
                    if ok and type(pos) == "table" then
                        local dx = (tonumber(pos.x) or 0) - sx
                        local dy = (tonumber(pos.y) or 0) - sy
                        if dx * dx + dy * dy <= radius_sq then
                            any_in_radius = true
                            break
                        end
                    end
                end

                if spawner.spawn_mode == "interval" then
                    if any_in_radius then
                        -- On entry, force an immediate spawn by setting the
                        -- timer at the interval threshold. Subsequent ticks
                        -- increment normally.
                        if not spawner.was_player_inside then
                            spawner.was_player_inside = true
                            spawner.time_since_last_spawn = spawner.spawn_interval
                        else
                            spawner.time_since_last_spawn =
                                spawner.time_since_last_spawn + delta_time
                        end
                        if spawner.time_since_last_spawn >= spawner.spawn_interval then
                            local live_count = count_and_prune_live_bots(spawner)
                            local at_cap = spawner.max_alive > 0
                                and live_count >= spawner.max_alive
                            if not at_cap then
                                if spawn_from_spawner(spawner) then
                                    spawner.time_since_last_spawn = 0
                                    logger:for_area(area_id):info(
                                        "[eznpcs] Interval spawner fired:",
                                        tostring(spawner.object.id),
                                        "live=", tostring(live_count + 1))
                                else
                                    -- Unexpected failure; back off to the next
                                    -- interval so we don't spam every tick.
                                    spawner.time_since_last_spawn = 0
                                end
                            end
                            -- At cap: leave the timer past the threshold so
                            -- the moment a slot frees we spawn immediately.
                        end
                    else
                        spawner.was_player_inside = false
                        spawner.time_since_last_spawn = 0
                    end
                else
                    -- Once mode.
                    if not spawner.once_spawned and spawner.trigger_armed then
                        if any_in_radius then
                            if spawn_from_spawner(spawner) then
                                spawner.trigger_armed = false
                                spawner.once_spawned = spawner.once
                                logger:for_area(area_id):info(
                                    "[eznpcs] Once spawner triggered:",
                                    tostring(spawner.object.id))
                            end
                        end
                    end
                    if not any_in_radius then
                        spawner.trigger_armed = true
                    end
                end
            end
        end
    end
end

-- Helper to update quest‑exclusive NPCs for a given player
local function update_quest_exclusive_for_player(player_id)
    -- Remove any existing quest exclusive NPCs for this player
    if quest_exclusive_npcs[player_id] then
        for placeholder_id, bot_id in pairs(quest_exclusive_npcs[player_id]) do
            emit_bot_removed(bot_id)
            Net.remove_bot(bot_id)
            npcs[bot_id] = nil
        end
        quest_exclusive_npcs[player_id] = nil
    end

    -- For each quest exclusive placeholder, check if the player's quest state matches
    for _, entry in ipairs(quest_exclusive_placeholders) do
        local state = ezquests.get_player_quest_state(player_id, entry.quest_name)
        if state and state == entry.required_state then
            local object = ezcache.get_object_by_id_cached(entry.area_id, entry.object_id)
            if object then
                local npc = create_bot_from_object(entry.area_id, object, player_id)
                if npc then
                    if not quest_exclusive_npcs[player_id] then
                        quest_exclusive_npcs[player_id] = {}
                    end
                    quest_exclusive_npcs[player_id][tostring(entry.object_id)] = npc.bot_id
                    printd("Quest‑exclusive bot", npc.bot_id, "created for player", player_id, "quest", entry.quest_name)
                end
            end
        end
    end
end

-- Register regular NPCs and the Pushback-enabled NPC subtype through the same
-- creation path, so dialogue, waypoints, quest rules, and exclusivity stay consistent.
local function register_npc_object(area_id, object)
    validate_npc_object(area_id, object)

    local props = object.custom_properties or {}

    if is_property_true(props["Template Only"]) then
        printd("Skipping template-only NPC placeholder id "..object.id.." in "..area_id)
        return
    end

    local is_quest = is_property_true(props["Quest NPC"])
    local is_exclusive = is_property_true(props["Player Exclusive"])
    local quest_exclusive = props["Quest Exclusive"]

    if quest_exclusive then
        local required_state = props["Quest State"] or "active"
        table.insert(quest_exclusive_placeholders, {
            area_id = area_id,
            object_id = object.id,
            quest_name = quest_exclusive,
            required_state = required_state
        })
        printd("Registered quest-exclusive NPC placeholder id "..object.id.." in "..area_id.." for quest "..quest_exclusive)
    elseif is_quest or is_exclusive then
        printd("Skipping quest/exclusive NPC placeholder id "..object.id.." in "..area_id)
        if is_exclusive then
            table.insert(exclusive_placeholders, {area_id = area_id, object_id = object.id})
        end
    else
        create_bot_from_object(area_id, object)
    end
end

object_registry.register_handler("NPC", register_npc_object)
object_registry.register_handler("Pushback NPC", register_npc_object)

-- Public lookup used by companion systems such as ezpushback.
function eznpcs.get_bot_for_placeholder(area_id, object_id)
    local by_area = placeholder_to_botid[area_id]
    return by_area and by_area[tostring(object_id)] or nil
end

-- Public API
function eznpcs.load_npcs()
    local areas = Net.list_areas()
    for i, area_id in next, areas do
        eznpcs.add_npcs_to_area(area_id)
    end
end

function eznpcs.add_npcs_to_area(area_id)
    -- Legacy: scan area for NPCs (already handled by registry, but keep for completeness)
    local objects = Net.list_objects(area_id)
    for i, object_id in next, objects do
        local object = ezcache.get_object_by_id_cached(area_id, object_id)
        if object and (object.type == "NPC" or object.type == "Pushback NPC") then
            local props = object.custom_properties or {}
            local is_template_only = is_property_true(props["Template Only"])
            local is_quest = is_property_true(props["Quest NPC"])
            local is_exclusive = is_property_true(props["Player Exclusive"])
            local quest_exclusive = props["Quest Exclusive"]
            if is_template_only then
                -- Skip; used only as a spawner template.
            elseif quest_exclusive then
                -- Already handled by registry, but ensure it's stored (registry runs first)
                -- (duplicate entries won't hurt)
                local required_state = props["Quest State"] or "active"
                table.insert(quest_exclusive_placeholders, {
                    area_id = area_id,
                    object_id = object.id,
                    quest_name = quest_exclusive,
                    required_state = required_state
                })
            elseif not is_quest and not is_exclusive then
                -- Registry handlers already created ordinary and Pushback NPC bots.
                -- Avoid creating a duplicate during the legacy second scan.
                if not eznpcs.get_bot_for_placeholder(area_id, object.id) then
                    create_bot_from_object(area_id, object)
                end
            elseif is_exclusive then
                -- Also store in exclusive_placeholders in case area was added after startup
                table.insert(exclusive_placeholders, {area_id = area_id, object_id = object.id})
            end
        end
    end
end

function eznpcs.add_event(event_object)
    if not (event_object.name and event_object.action) then
        printd('Cant add invalid event, events need a name and action {}')
        return
    end
    if events[event_object.name] then
        printd('WARNING event '..event_object.name..' already exists and will be replaced')
    end
    events[event_object.name] = event_object
    printd('added event '..event_object.name)
end

function eznpcs.create_npc_from_object(area_id,object_id)
    local object = ezcache.get_object_by_id_cached(area_id, object_id)
    return create_bot_from_object(area_id, object)
end

function eznpcs.handle_actor_interaction(player_id,actor_id)
    return do_actor_interaction(player_id,actor_id)
end

function eznpcs.on_tick(delta_time)
    if not custom_events_script_loaded then
        custom_events_script_loaded = true
        helpers.safe_require(custom_events_script_path)
    end
    update_spawner_triggers(delta_time)
    for bot_id, npc in pairs(npcs) do
        if npc.on_tick then
            npc.on_tick.action(npc,delta_time)
        end
    end
end

function eznpcs.create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player)
    -- Preserve the legacy default when callers omit the optional flag, while
    -- allowing custom typed NPC references to honor their Tiled property.
    if dont_face_player == nil then
        dont_face_player = true
    end
    return create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player)
end

function eznpcs.handle_player_transfer(player_id)
    clear_player_conversation(player_id)
end

function eznpcs.handle_player_join(player_id)
    -- Create player‑exclusive NPCs
    for _, entry in ipairs(exclusive_placeholders) do
        local object = ezcache.get_object_by_id_cached(entry.area_id, entry.object_id)
        if object then
            local hidden = ezmemory.object_is_hidden_from_player(player_id, entry.area_id, entry.object_id)
            if not hidden then
                if not exclusive_npcs[player_id] or not exclusive_npcs[player_id][tostring(entry.object_id)] then
                    create_bot_from_object(entry.area_id, object, player_id)
                end
            end
        end
    end

    -- Create quest‑exclusive NPCs based on current quest state
    update_quest_exclusive_for_player(player_id)

    -- Exclude other players' exclusive NPCs from this new player
    for owner_id, npcs_for_owner in pairs(exclusive_npcs) do
        for placeholder_id, bot_id in pairs(npcs_for_owner) do
            if owner_id ~= player_id then
                Net.exclude_actor_for_player(player_id, bot_id)
            end
        end
    end
    -- Also exclude other players' quest‑exclusive NPCs
    for owner_id, npcs_for_owner in pairs(quest_exclusive_npcs) do
        for placeholder_id, bot_id in pairs(npcs_for_owner) do
            if owner_id ~= player_id then
                Net.exclude_actor_for_player(player_id, bot_id)
            end
        end
    end
end

function eznpcs.handle_player_disconnect(player_id)
    clear_player_conversation(player_id)
    eznpcs.cancel_battle_exit_wait(player_id)

    -- Remove player‑exclusive NPCs
    if exclusive_npcs[player_id] then
        for placeholder_id, bot_id in pairs(exclusive_npcs[player_id]) do
            emit_bot_removed(bot_id)
            Net.remove_bot(bot_id)
            npcs[bot_id] = nil
        end
        exclusive_npcs[player_id] = nil
    end

    -- Remove quest‑exclusive NPCs
    if quest_exclusive_npcs[player_id] then
        for placeholder_id, bot_id in pairs(quest_exclusive_npcs[player_id]) do
            emit_bot_removed(bot_id)
            Net.remove_bot(bot_id)
            npcs[bot_id] = nil
        end
        quest_exclusive_npcs[player_id] = nil
    end
end

function eznpcs.handle_object_interaction(player_id, object_id)
    local area_id = Net.get_player_area(player_id)
    local object = ezcache.get_object_by_id_cached(area_id, object_id)
    if not object then
        printd("handle_object_interaction: object not found in cache", object_id)
        return
    end

    -- Check if it's an exclusive NPC placeholder
    if (object.type == "NPC" or object.type == "Pushback NPC") and object.custom_properties then
        if is_property_true(object.custom_properties["Player Exclusive"]) then
            printd("Exclusive NPC interaction for player", player_id, "placeholder", object.id)
            if not exclusive_npcs[player_id] or not exclusive_npcs[player_id][tostring(object.id)] then
                local npc = create_bot_from_object(area_id, object, player_id)
                if npc then
                    do_actor_interaction(player_id, npc.bot_id, object)
                end
            else
                local bot_id = exclusive_npcs[player_id][tostring(object.id)]
                do_actor_interaction(player_id, bot_id, object)
            end
            return
        end

        -- Check if it's a quest‑exclusive placeholder
        local quest_exclusive = object.custom_properties["Quest Exclusive"]
        if quest_exclusive then
            printd("Quest‑exclusive NPC interaction for player", player_id, "placeholder", object.id)
            if not quest_exclusive_npcs[player_id] or not quest_exclusive_npcs[player_id][tostring(object.id)] then
                local required_state = object.custom_properties["Quest State"] or "active"
                local state = ezquests.get_player_quest_state(player_id, quest_exclusive)
                if state and state == required_state then
                    local npc = create_bot_from_object(area_id, object, player_id)
                    if npc then
                        if not quest_exclusive_npcs[player_id] then
                            quest_exclusive_npcs[player_id] = {}
                        end
                        quest_exclusive_npcs[player_id][tostring(object.id)] = npc.bot_id
                        do_actor_interaction(player_id, npc.bot_id, object)
                    end
                else
                    printd("Player", player_id, "does not meet quest state for", quest_exclusive)
                end
            else
                local bot_id = quest_exclusive_npcs[player_id][tostring(object.id)]
                do_actor_interaction(player_id, bot_id, object)
            end
            return
        end
    end

    -- Existing relay logic for non-exclusive NPCs
    if object.custom_properties and object.custom_properties["Interact Relay"] then
        local placeholder_id = object.custom_properties["Interact Relay"]
        if placeholder_to_botid[area_id] and placeholder_to_botid[area_id][placeholder_id] then
            local bot_id = placeholder_to_botid[area_id][placeholder_id]
            do_actor_interaction(player_id, bot_id, object)
        end
    end
end

-- Helper to remove an exclusive NPC (called from dialogue_types on win)
function eznpcs.remove_exclusive_npc(player_id, placeholder_id)
    if exclusive_npcs[player_id] then
        local bot_id = exclusive_npcs[player_id][tostring(placeholder_id)]
        if bot_id then
            emit_bot_removed(bot_id)
            Net.remove_bot(bot_id)
            npcs[bot_id] = nil
            exclusive_npcs[player_id][tostring(placeholder_id)] = nil
            printd("Removed exclusive NPC bot", bot_id, "for player", player_id)
        end
    end
end

function eznpcs.prepare_battle_exit_wait(player_id)
    battle_exit_waiting[player_id] = true
    battle_exit_generation[player_id] = nil
end

function eznpcs.cancel_battle_exit_wait(player_id)
    battle_exit_waiting[player_id] = nil
    battle_exit_generation[player_id] = nil
end

-- Called by ezlibs main.lua when the engine emits battle_exit. The full
-- battle_results payload is supplied as the second argument when available.
function eznpcs.handle_battle_exit(player_id, battle_results, exit_event)
    if player_id == nil then
        return
    end

    battle_exit_generation[player_id] = {
        results = battle_results,
        event = exit_event
    }
    battle_exit_waiting[player_id] = nil
end

-- Await the actual battle_exit event before running post-battle world effects.
-- Returns the stored battle_results payload and battle_exit event, if present.
function eznpcs.wait_for_battle_exit(player_id)
    return async(function()
        while battle_exit_waiting[player_id] do
            await(Async.sleep(0.05))
        end

        local result = battle_exit_generation[player_id]
        battle_exit_generation[player_id] = nil
        if result then
            return result.results, result.event
        end
        return nil, nil
    end)
end

function eznpcs.handle_battle_results(player_id, stats)
    -- Kept as a plugin hook for consistency with the central battle event
    -- fan-out. The canonical full payload is stored by ezbattle_results.
end

-- Helper to remove a quest‑exclusive NPC (can be called when quest state changes)
function eznpcs.remove_quest_exclusive_npc(player_id, placeholder_id)
    if quest_exclusive_npcs[player_id] then
        local bot_id = quest_exclusive_npcs[player_id][tostring(placeholder_id)]
        if bot_id then
            emit_bot_removed(bot_id)
            Net.remove_bot(bot_id)
            npcs[bot_id] = nil
            quest_exclusive_npcs[player_id][tostring(placeholder_id)] = nil
            printd("Removed quest‑exclusive NPC bot", bot_id, "for player", player_id)
        end
    end
end

-- Helper to get bot ID for placeholder (used in ezmemory)
function eznpcs.get_bot_id_for_placeholder(area_id, placeholder_id)
    if placeholder_to_botid[area_id] then
        return placeholder_to_botid[area_id][tostring(placeholder_id)]
    end
    return nil
end

-- Listen for quest events to refresh quest‑exclusive NPCs
ezbus:on("quest_event", function(event)
    local player_id = event.player_id
    -- When a quest event occurs, update quest‑exclusive NPCs for that player
    -- (This covers state changes that happen through dialogue)
    update_quest_exclusive_for_player(player_id)
end)

-- =========================================================================
-- Cutscene support: bot movement, pose hold, and bot resolution
--
-- These helpers generalize the movement-and-hold pattern used by
-- net-game-footbomb so any module (ezcutscenes, custom map scripts) can
-- drive NPC bots through animated sequences without reimplementing the
-- animate_bot_properties keyframe plumbing.
-- =========================================================================

local function _resolve_bot_id(bot_or_npc)
    if bot_or_npc == nil then return nil end
    if type(bot_or_npc) == "string" or type(bot_or_npc) == "number" then
        return bot_or_npc
    end
    if type(bot_or_npc) == "table" then
        return bot_or_npc.bot_id or bot_or_npc.id
    end
    return nil
end

local function _apply_bot_animation(bot_id, state, loop)
    if not bot_id or not state then return false end
    if loop == nil then loop = true end
    local ok, result = pcall(Net.animate_bot, bot_id, state, loop)
    return ok and result ~= false
end

local function _apply_bot_direction(bot_id, direction)
    if not bot_id or not direction then return true end
    local ok, result = pcall(Net.set_bot_direction, bot_id, direction)
    return ok and result ~= false
end

-- Bump the hold generation on this bot. Any in-flight reassert loop compares
-- the current generation against its captured generation and exits on
-- mismatch, so bumping invalidates any stale loop.
local function _bump_hold_generation(bot_id)
    local npc = npcs[bot_id]
    if not npc then return nil end
    npc._hold_generation = (npc._hold_generation or 0) + 1
    return npc._hold_generation
end

-- Claim pose ownership: bump generation and mark the source as "pose".
-- Called at the very start of move_bot_to_spot / set_bot_pose so move_npc
-- bails out during the movement keyframes (before _apply_pose_with_reassert
-- would otherwise take ownership after the move).
--
-- Also invalidates any in-flight scripted waypoint move: a cutscene pose
-- always takes precedence over pending waypoint travel.
local function _claim_pose(bot_id)
    local npc = npcs[bot_id]
    if not npc then return end
    npc._hold_generation = (npc._hold_generation or 0) + 1
    npc._scripted_move_generation = (npc._scripted_move_generation or 0) + 1
    npc._scripted_move_active = false
    npc._animation_source = "pose"
end

-- Release pose ownership. Called from cancel_bot_hold (explicit release),
-- and from the pose functions when a hold naturally expires (hold_seconds
-- elapsed) or no hold was requested at all.
local function _release_pose(bot_id)
    local npc = npcs[bot_id]
    if npc and npc._animation_source == "pose" then
        npc._animation_source = nil
        npc.current_animation = nil
    end
end

-- Public: get the internal npc record for a bot. Useful for cutscene steps
-- that need mugshot info via get_dialogue_mugshot.
function eznpcs.get_bot_record(bot_id)
    if bot_id == nil then return nil end
    return npcs[bot_id]
end

-- Public: resolve a bot_id given an area + object_id + optional player context.
-- Tries per-player exclusive, quest-exclusive, then global bots.
function eznpcs.resolve_bot(area_id, object_id, player_id)
    if object_id == nil or area_id == nil then return nil end
    local key = tostring(object_id)
    if player_id then
        if exclusive_npcs[player_id] and exclusive_npcs[player_id][key] then
            return exclusive_npcs[player_id][key]
        end
        if quest_exclusive_npcs[player_id] and quest_exclusive_npcs[player_id][key] then
            return quest_exclusive_npcs[player_id][key]
        end
    end
    if placeholder_to_botid[area_id] and placeholder_to_botid[area_id][key] then
        return placeholder_to_botid[area_id][key]
    end
    return nil
end

-- Public: cancel any active pose hold on this bot. Reassert loops check a
-- monotonically increasing generation counter, so a cancelled hold exits
-- without an extra sleep-and-poll cycle. Also releases pose ownership so
-- waypoint movement can resume.
function eznpcs.cancel_bot_hold(bot_or_npc)
    local bot_id = _resolve_bot_id(bot_or_npc)
    if not bot_id then return end
    _bump_hold_generation(bot_id)
    _release_pose(bot_id)
end

-- Internal: set a pose and (optionally) reassert it every `reassert_interval`
-- seconds. Returns the generation this pose was assigned, for coordinated
-- cancellation by move_bot_to_spot / set_bot_pose.
local function _apply_pose_with_reassert(bot_id, animation, loop, reassert_interval)
    local npc = npcs[bot_id]
    local my_generation = nil
    if npc then
        npc._hold_generation = (npc._hold_generation or 0) + 1
        my_generation = npc._hold_generation
        npc._animation_source = "pose"
        npc.current_animation = animation
    end
    _apply_bot_animation(bot_id, animation, loop)
    if reassert_interval and reassert_interval > 0 and npc then
        async(function()
            while true do
                await(Async.sleep(reassert_interval))
                if not npc then return end
                if npc._hold_generation ~= my_generation then return end
                if npc._removed then return end
                _apply_bot_animation(bot_id, animation, loop)
            end
        end)
    end
    return my_generation
end

-- Move a bot to a target position with animation, then optionally hold a pose.
--
--   options.animation               (string)  animation during movement
--   options.direction               (string)  facing during movement
--   options.speed                   (number)  map units / second (default 3)
--   options.hold_animation          (string)  pose applied on arrival
--   options.hold_direction          (string)  facing applied on arrival
--   options.hold_seconds            (number)  hold duration; 0/nil = indefinite
--   options.hold_loop               (bool)    loop flag for hold (default true)
--   options.hold_reassert           (bool)    reassert hold (default false)
--   options.hold_reassert_interval  (number)  reassert period (default 0.2)
--
-- Returns an async promise resolving to `true` on success. If
-- `hold_seconds` > 0, the promise resolves after that wait; if 0/nil, it
-- resolves immediately after starting the hold. The hold persists until
-- another move/pose call, eznpcs.cancel_bot_hold, or (for reassert=false
-- with loop=false) the animation naturally ending.
function eznpcs.move_bot_to_spot(bot_or_npc, target, options)
    return async(function()
        local bot_id = _resolve_bot_id(bot_or_npc)
        if not bot_id or type(target) ~= "table" then return false end
        options = options or {}

        local start_ok, start = pcall(Net.get_bot_position, bot_id)
        if not start_ok or type(start) ~= "table" then return false end

        local sx = tonumber(start.x) or 0
        local sy = tonumber(start.y) or 0
        local sz = tonumber(start.z) or 0
        local tx = tonumber(target.x) or sx
        local ty = tonumber(target.y) or sy
        local tz = tonumber(target.z) or sz

        local dx, dy = tx - sx, ty - sy
        local distance = math.sqrt(dx * dx + dy * dy)
        local speed = math.max(0.1, tonumber(options.speed) or 3)
        local duration = math.max(0.05, distance / speed)

        -- Claim pose ownership immediately: waypoint ticks must not fight
        -- the movement keyframes we're about to send, and any in-flight
        -- reassert loop or scripted waypoint move must be invalidated.
        _claim_pose(bot_id)

        if options.direction then _apply_bot_direction(bot_id, options.direction) end
        if options.animation then _apply_bot_animation(bot_id, options.animation, true) end

        local keyframes = {
            {
                properties = {
                    { property = "X", value = sx },
                    { property = "Y", value = sy },
                    { property = "Z", value = sz },
                },
                duration = 0,
            },
            {
                properties = {
                    { property = "X", ease = "Linear", value = tx },
                    { property = "Y", ease = "Linear", value = ty },
                    { property = "Z", ease = "Linear", value = tz },
                },
                duration = duration,
            },
        }

        local ok_move, move_result = pcall(Net.animate_bot_properties, bot_id, keyframes)
        if not ok_move or move_result == false then
            _release_pose(bot_id)
            return false
        end

        await(Async.sleep(duration))

        if not options.hold_animation then
            -- No hold requested; release ownership so waypoint movement
            -- (or whatever was happening before) can resume.
            _release_pose(bot_id)
            return true
        end

        if options.hold_direction then
            _apply_bot_direction(bot_id, options.hold_direction)
        end
        local reassert_interval = nil
        if options.hold_reassert then
            reassert_interval = math.max(0.05,
                tonumber(options.hold_reassert_interval) or 0.2)
        end
        local hold_loop = options.hold_loop ~= false
        local my_generation = _apply_pose_with_reassert(
            bot_id, options.hold_animation, hold_loop, reassert_interval)

        local hold_seconds = tonumber(options.hold_seconds) or 0
        if hold_seconds > 0 then
            await(Async.sleep(hold_seconds))
            local npc = npcs[bot_id]
            if npc and npc._hold_generation == my_generation then
                _bump_hold_generation(bot_id)
                _release_pose(bot_id)
            end
        end
        return true
    end)
end

-- Set a pose on a bot without moving it.
--
--   options.animation     (string)  required
--   options.direction     (string)  facing
--   options.loop          (bool)    loop flag (default true)
--   options.hold          (bool)    reassert the pose (default true)
--   options.hold_seconds  (number)  0/nil = indefinite; >0 waits that long
function eznpcs.set_bot_pose(bot_or_npc, options)
    return async(function()
        local bot_id = _resolve_bot_id(bot_or_npc)
        if not bot_id or not options or not options.animation then return false end

        -- Default is to claim pose ownership; explicit hold = false means
        -- "apply once, don't block waypoints". In that case we still bump
        -- the generation to invalidate any in-flight reassert loop.
        local claims_pose = options.hold ~= false
        if claims_pose then
            _claim_pose(bot_id)
        else
            _bump_hold_generation(bot_id)
        end

        if options.direction then _apply_bot_direction(bot_id, options.direction) end

        local loop = options.loop ~= false
        local reassert_interval = nil
        if claims_pose then
            reassert_interval = math.max(0.05,
                tonumber(options.hold_reassert_interval) or 0.2)
        end
        local my_generation = _apply_pose_with_reassert(
            bot_id, options.animation, loop, reassert_interval)

        local hold_seconds = tonumber(options.hold_seconds) or 0
        if hold_seconds > 0 then
            await(Async.sleep(hold_seconds))
            local npc = npcs[bot_id]
            if npc and npc._hold_generation == my_generation then
                _bump_hold_generation(bot_id)
                _release_pose(bot_id)
            end
        elseif not claims_pose then
            -- hold = false with no hold_seconds: fire-and-forget pose.
            -- Release immediately so a subsequent waypoint tick can
            -- re-apply travel animation on the next frame.
            _release_pose(bot_id)
        end
        return true
    end)
end

return eznpcs