-- FootBomb Ref NPC and match-instance entry point.
-- Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

local logger = require("scripts/ezlibs-scripts/ezlogger").get("footbomb")
local object_registry = require("scripts/ezlibs-scripts/object_registry")
local EzMapInstance = require("scripts/ezlibs-scripts/ezmapinstance")
local games = require("scripts/net-games/main")
local InputAPI = require("scripts/input-controller/main")

local FootBomb = {}
local npc_refs = {}                 -- area_id -> actor_id -> reference
local pending_interactions = {}    -- player_id -> true
local waiting_matches = {}         -- source area -> waiting VS Player match
local player_representations = {}   -- player_id -> bot/cursor/camera data
local instance_bots = {}            -- instance_id -> slot records
local instance_spawn_points = {}     -- instance_id -> named Player 1/2 positions

local DEFAULT_SOURCE_AREA = "footbomb"
local NPC_FOLDER = "/server/assets/ezlibs-assets/eznpcs/"
local NPC_SHEET_FOLDER = NPC_FOLDER .. "sheet/"
local MUG_FOLDER = NPC_FOLDER .. "mug/"
local DEFAULT_ASSET_NAME = "male-navi-exe6_teal"
local DEFAULT_MUG_ANIMATION = MUG_FOLDER .. "mug.animation"
local BOT_ASSET_FOLDER = "/server/assets/net-game-footbomb/bots/"
local NAVI_OPTIONS = {
    { name = "MegaMan", texture = BOT_ASSET_FOLDER .. "megaman.png", animation = BOT_ASSET_FOLDER .. "megaman.animation" },
    { name = "Roll", texture = BOT_ASSET_FOLDER .. "roll.png", animation = BOT_ASSET_FOLDER .. "roll.animation" },
    { name = "ProtoMan", texture = BOT_ASSET_FOLDER .. "protoman-bn5.png", animation = BOT_ASSET_FOLDER .. "protoman-bn5.animation" }
}
local MEGAMAN_TEXTURE = NAVI_OPTIONS[1].texture
local MEGAMAN_ANIMATION = NAVI_OPTIONS[1].animation
local CURSOR_TOP_TEXTURE = "/server/assets/net-games/cursors/green_cursor.png"
local CURSOR_BOTTOM_TEXTURE = "/server/assets/net-games/cursors/orange_cursor.png"
local OFF_MAP_POSITION = { x = -1000, y = -1000, z = 0 }

local function log(message)
    logger:info("[footbomb] " .. tostring(message))
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
    npc_refs[area_id] = npc_refs[area_id] or {}
    return npc_refs[area_id]
end

local function create_ref_npc(area_id, object)
    if not object then return nil end
    local properties = object.custom_properties or {}
    local asset_name = as_string(properties["Asset Name"], DEFAULT_ASSET_NAME)
    local animation_name = as_string(properties["Animation Name"], asset_name)
    local mugshot_name = as_string(properties.Mugshot, asset_name)
    local mug_animation_name = as_string(properties["Mug Animation Name"], nil)
    local actor_id = "footbomb-ref-" .. tostring(area_id) .. "-" .. tostring(object.id)
    local animation_path = NPC_SHEET_FOLDER .. animation_name .. ".animation"
    local mug_animation_path = mug_animation_name and (MUG_FOLDER .. mug_animation_name .. ".animation") or DEFAULT_MUG_ANIMATION
    local bot_id = Net.create_bot(actor_id, {
        name = as_string(object.name, "FootBomb Ref"), area_id = area_id,
        texture_path = NPC_SHEET_FOLDER .. asset_name .. ".png",
        animation_path = animation_path, animation = "IDLE_DR",
        x = as_number(object.x, 0), y = as_number(object.y, 0), z = as_number(object.z, 0),
        direction = as_string(properties.Direction, "Down"), solid = true, size = 0.2,
        warp_in = false, dont_face_player = properties["Dont Face Player"] == true
    })
    if not bot_id then
        log("Net.create_bot failed for FootBomb Ref object " .. tostring(object.id))
        return nil
    end
    local reference = {
        object = object,
        npc = {
            bot_id = bot_id, actor_id = actor_id,
            mug_texture_path = MUG_FOLDER .. mugshot_name .. ".png",
            mug_animation_path = mug_animation_path
        }
    }
    ensure_area_refs(area_id)[tostring(actor_id)] = reference
    ensure_area_refs(area_id)[tostring(bot_id)] = reference
    log("Created FootBomb Ref " .. tostring(bot_id) .. " in " .. tostring(area_id))
    return reference.npc
end

object_registry.register_handler("FootBomb Ref", function(area_id, object)
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
    if type(Net.list_objects) ~= "function" or type(Net.get_object_by_id) ~= "function" then
        return nil, "Net object lookup is unavailable"
    end

    local ok, object_ids = pcall(Net.list_objects, area_id)
    if not ok or type(object_ids) ~= "table" then
        return nil, "could not list objects in instance area " .. tostring(area_id)
    end

    local found = {}
    for _, object_id in pairs(object_ids) do
        local got, object = pcall(Net.get_object_by_id, area_id, object_id)
        if got and type(object) == "table" then
            local name = object.name
            if (name == "Player 1 Spawn" or name == "Player 2 Spawn") and not found[name] then
                local x, y = tonumber(object.x), tonumber(object.y)
                if x and y then
                    found[name] = { x = x, y = y, z = as_number(object.z, 0) }
                end
            end
        end
    end

    if not found["Player 1 Spawn"] or not found["Player 2 Spawn"] then
        local missing = {}
        if not found["Player 1 Spawn"] then missing[#missing + 1] = '"Player 1 Spawn"' end
        if not found["Player 2 Spawn"] then missing[#missing + 1] = '"Player 2 Spawn"' end
        return nil, "FootBomb map is missing point object(s): " .. table.concat(missing, " and ")
    end

    return { found["Player 1 Spawn"], found["Player 2 Spawn"] }
end

local function safe_remove_bot(bot_id)
    if bot_id then pcall(Net.remove_bot, bot_id, false) end
end

local function create_match_bots(instance, spawn_points, vs_npc)
    local prefix = "footbomb-match-" .. tostring(instance.id):gsub("[^%w_%-]", "_")
    local actor_ids = { prefix .. "-player1", prefix .. "-player2" }
    local labels = { "FootBomb Player 1", vs_npc and "FootBomb Opponent" or "FootBomb Player 2" }
    local created = {}

    for _, option in ipairs(NAVI_OPTIONS) do
        pcall(Net.provide_asset_for_player, instance.host_id, option.texture)
        pcall(Net.provide_asset_for_player, instance.host_id, option.animation)
    end

    for slot = 1, 2 do
        local position = spawn_points[slot]
        local ok, bot_id = pcall(Net.create_bot, actor_ids[slot], {
            name = labels[slot], area_id = instance.area_id,
            texture_path = MEGAMAN_TEXTURE, animation_path = MEGAMAN_ANIMATION,
            animation = "IDLE_DL",
            x = position.x, y = position.y, z = position.z,
            direction = "Down", solid = false, size = 0.2, warp_in = false,
            dont_face_player = true
        })
        if not ok or not bot_id then
            for _, previous in ipairs(created) do safe_remove_bot(previous.id) end
            return nil, "could not create both match bots (slot " .. tostring(slot) .. "): " .. tostring(bot_id)
        end
        created[#created + 1] = {
            id = bot_id, actor_id = actor_ids[slot], slot = slot,
            position = { x = position.x, y = position.y, z = position.z },
            skin_index = 1, fixed_skin = vs_npc and slot == 2
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
            pcall(Net.provide_asset_for_player, player_id, option.texture)
            pcall(Net.provide_asset_for_player, player_id, option.animation)
        end
        pcall(Net.provide_asset_for_player, player_id, CURSOR_TOP_TEXTURE)
        pcall(Net.provide_asset_for_player, player_id, CURSOR_BOTTOM_TEXTURE)

        local spawn = spawn_points[slot]
        local ok, result = pcall(EzMapInstance.transfer_player, instance.id, player_id,
            spawn.x, spawn.y, spawn.z)
        if ok and result ~= false then
            transferred[#transferred + 1] = player_id
        else
            log("Transfer failed for " .. tostring(player_id) .. ": " .. tostring(result))
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
    if not instance or type(instance.player_ids) ~= "table" or #instance.player_ids > 0 then return end
    remove_instance_bots(instance.id)
    local ok, err = EzMapInstance.remove(instance.id)
    if not ok then log("Could not remove empty instance " .. tostring(instance.id) .. ": " .. tostring(err)) end
end

local function make_instance(player_id, source_area_id, object, mode)
    local props = object.custom_properties or {}
    local instance_id = "footbomb_" .. tostring(player_id):gsub("[^%w_%-]", "_") .. "_" .. tostring(os.time())
    local instance, err = EzMapInstance.create(
        as_string(props["Instance Map"], DEFAULT_SOURCE_AREA), instance_id,
        {
            host_id = player_id, player_ids = {}, party_id = "footbomb_" .. tostring(player_id),
            metadata = { game = "footbomb", mode = mode, party = { host_id = player_id, members = {} } }
        }
    )
    if not instance then return nil, err end

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
    return instance, spawn_points
end

local function move_player_off_map(player_id, area_id)
    if type(Net.move_player) == "function" then
        local ok, result = pcall(Net.move_player, player_id, OFF_MAP_POSITION.x, OFF_MAP_POSITION.y, OFF_MAP_POSITION.z)
        if ok and result ~= false then return true end
    end
    if type(Net.transfer_player) == "function" then
        local ok, result = pcall(Net.transfer_player, player_id, area_id, false,
            OFF_MAP_POSITION.x, OFF_MAP_POSITION.y, OFF_MAP_POSITION.z)
        if ok and result ~= false then return true end
    end
    log("Could not move real player actor off-map for " .. tostring(player_id))
    return false
end

local function remove_representation(player_id)
    local rep = player_representations[player_id]
    if not rep then return end
    if rep.cursor_top then pcall(games.remove_ui_element, rep.cursor_top, player_id) end
    if rep.cursor_bottom then pcall(games.remove_ui_element, rep.cursor_bottom, player_id) end
    if rep.skin_text_id then pcall(games.remove_text, rep.skin_text_id, player_id) end
    if type(Net.unlock_player_camera) == "function" then pcall(Net.unlock_player_camera, player_id) end
    player_representations[player_id] = nil
end

local function setup_player_representation(player_id, instance, bot_record)
    if not instance or not bot_record or Net.get_player_area(player_id) ~= instance.area_id then return end

    local existing = player_representations[player_id]
    if existing and existing.instance_id == instance.id and existing.slot == bot_record.slot then
        -- Transfer events can fire more than once. Preserve the existing UI and assignment.
        existing.bot_id = bot_record.id
        existing.bot_record = bot_record
        return
    end

    remove_representation(player_id)
    local rep = {
        instance_id = instance.id, area_id = instance.area_id,
        slot = bot_record.slot, bot_id = bot_record.id,
        actor_id = bot_record.actor_id, bot_record = bot_record,
        cursor_top = "footbomb_cursor_top_" .. tostring(player_id):gsub("[^%w_%-]", "_"),
        cursor_bottom = "footbomb_cursor_bottom_" .. tostring(player_id):gsub("[^%w_%-]", "_"),
        skin_text_id = "footbomb_navi_name_" .. tostring(player_id):gsub("[^%w_%-]", "_"),
        skin_index = bot_record.skin_index or 1
    }
    player_representations[player_id] = rep

    pcall(games.add_ui_element, rep.cursor_top, player_id, CURSOR_TOP_TEXTURE, nil, nil, 112, 43, 100, 1, 1)
    pcall(games.add_ui_element, rep.cursor_bottom, player_id, CURSOR_BOTTOM_TEXTURE, nil, nil, 112, 104, 100, 1, 1)
    -- Draw the selected Navi name between the two visual cursor markers.
    pcall(games.draw_text, rep.skin_text_id, player_id, NAVI_OPTIONS[rep.skin_index].name, 86, 72, 100, "THICK", 1.5)
    if type(Net.lock_player_camera) == "function" then pcall(Net.lock_player_camera, player_id) end
    move_player_off_map(player_id, instance.area_id)
end

local function setup_representations_for_match(instance, player_ids, bots)
    for slot, player_id in ipairs(player_ids) do
        setup_player_representation(player_id, instance, bots[slot])
    end
end

local function launch_npc_match(player_id, source_area_id, object, npc)
    if not player_is_available(player_id) then return end
    local instance, spawn_or_error = make_instance(player_id, source_area_id, object, "npc")
    if not instance then
        await(Async.message_player(player_id, "I couldn't open the FootBomb field right now: " .. tostring(spawn_or_error)))
        log("NPC match setup failed: " .. tostring(spawn_or_error))
        return
    end

    local spawn_points = spawn_or_error
    local transferred = transfer_match_players(instance, { player_id }, spawn_points)
    if #transferred ~= 1 then
        remove_instance_bots(instance.id)
        EzMapInstance.remove(instance.id)
        await(Async.message_player(player_id, "I couldn't transfer you to the FootBomb field. Please try again."))
        return
    end

    -- Human owns Player 1. Player 2 remains a fixed MegaMan NPC opponent.
    setup_player_representation(player_id, instance, instance_bots[instance.id][1])
    log("Started private VS NPC match " .. tostring(instance.id))
end

local function launch_player_match(waiting, second_player)
    local first_player = waiting.player_id
    if not player_is_available(first_player) or not player_is_available(second_player) then
        return false, "One of the players is no longer available."
    end
    local instance, spawn_or_error = make_instance(first_player, waiting.source_area_id, waiting.object, "player")
    if not instance then return false, tostring(spawn_or_error) end

    local spawn_points = spawn_or_error
    instance.host_id = first_player
    instance.metadata.party.members = { first_player, second_player }

    -- Matchmaking order is server-owned: the waiting player is Player 1, joiner is Player 2.
    local transferred = transfer_match_players(instance, { first_player, second_player }, spawn_points)
    if #transferred ~= 2 then
        remove_instance_bots(instance.id)
        for _, player_id in ipairs(transferred) do
            pcall(Net.transfer_player, player_id, waiting.source_area_id)
        end
        EzMapInstance.remove(instance.id)
        return false, "I couldn't transfer both players to the FootBomb field."
    end

    setup_representations_for_match(instance, { first_player, second_player }, instance_bots[instance.id])
    log("Started VS Player match " .. tostring(instance.id))
    return true
end

local function cycle_player_skin(player_id, direction)
    local rep = player_representations[player_id]
    if not rep or not rep.bot_record or rep.bot_record.fixed_skin then return end

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
        area_id = rep.area_id, texture_path = option.texture, animation_path = option.animation,
        animation = "IDLE_DL", x = position.x, y = position.y, z = position.z,
        direction = "Down", solid = false, size = 0.2, warp_in = false, dont_face_player = true
    })

    if not ok or not new_id then
        log("Could not change Navi skin for " .. tostring(player_id) .. ": " .. tostring(new_id))
        local old_option = NAVI_OPTIONS[rep.skin_index]
        local restore_ok, restored_id = pcall(Net.create_bot, rep.actor_id, {
            name = rep.slot == 1 and "FootBomb Player 1" or "FootBomb Player 2",
            area_id = rep.area_id, texture_path = old_option.texture, animation_path = old_option.animation,
            animation = "IDLE_DL", x = position.x, y = position.y, z = position.z,
            direction = "Down", solid = false, size = 0.2, warp_in = false, dont_face_player = true
        })
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
    pcall(games.update_text, rep.skin_text_id, player_id, option.name)
    local slots = instance_bots[rep.instance_id]
    if slots and slots[rep.slot] then
        slots[rep.slot].id = new_id
        slots[rep.slot].skin_index = next_index
    end
    log("Player " .. tostring(player_id) .. " selected " .. option.name)
end

local function join_waiting_match(player_id, source_area_id, reference)
    local waiting = waiting_matches[source_area_id]
    if not waiting then return false end
    if pending_interactions[player_id] then return true end
    pending_interactions[player_id] = true
    async(function()
        local npc = reference.npc
        if waiting.player_id == player_id then
            await(Async.message_player(player_id, "You're already waiting for an opponent. The next player to talk to me can join.", npc.mug_texture_path, npc.mug_animation_path))
            pending_interactions[player_id] = nil
            return
        end
        await(Async.message_player(player_id, "Someone is looking for a FootBomb opponent. Would you like to join?", npc.mug_texture_path, npc.mug_animation_path))
        if Net.get_player_area(player_id) ~= source_area_id or waiting_matches[source_area_id] ~= waiting then
            pending_interactions[player_id] = nil
            return
        end
        local choice = await(Async.quiz_player(player_id, "Join Match", "No", "Cancel", npc.mug_texture_path, npc.mug_animation_path))
        if choice == 0 and waiting_matches[source_area_id] == waiting then
            waiting_matches[source_area_id] = nil
            local ok, err = launch_player_match(waiting, player_id)
            if not ok then
                await(Async.message_player(player_id, "We couldn't start the match: " .. tostring(err), npc.mug_texture_path, npc.mug_animation_path))
                if player_is_available(waiting.player_id) then
                    waiting_matches[source_area_id] = waiting
                end
            end
        else
            await(Async.message_player(player_id, "No problem. The match is still waiting for an opponent.", npc.mug_texture_path, npc.mug_animation_path))
        end
        pending_interactions[player_id] = nil
    end)
    return true
end

local function begin_interaction(player_id, area_id, reference)
    if pending_interactions[player_id] then return end
    if join_waiting_match(player_id, area_id, reference) then return end
    pending_interactions[player_id] = true
    async(function()
        local npc = reference.npc
        local object = reference.object
        await(Async.message_player(player_id, "Hey! Would you like to play FootBomb?", npc.mug_texture_path, npc.mug_animation_path))
        if Net.get_player_area(player_id) ~= area_id then pending_interactions[player_id] = nil; return end
        local choice = await(Async.quiz_player(player_id,
            "VS [NPC]", "VS Player", "No",
            npc.mug_texture_path, npc.mug_animation_path))
        if Net.get_player_area(player_id) ~= area_id then pending_interactions[player_id] = nil; return end
        if choice == 0 then
            await(Async.message_player(player_id, "Let's do it! I'll prepare a private field.", npc.mug_texture_path, npc.mug_animation_path))
            if Net.get_player_area(player_id) == area_id then launch_npc_match(player_id, area_id, object, npc) end
        elseif choice == 1 then
            if waiting_matches[area_id] then
                await(Async.message_player(player_id, "Another player is already waiting for an opponent. Please let them finish matchmaking first.", npc.mug_texture_path, npc.mug_animation_path))
            else
                waiting_matches[area_id] = { player_id = player_id, source_area_id = area_id, object = object, npc = npc, created_at = os.time() }
                await(Async.message_player(player_id, "All right! Stay here. The next player who talks to me can join your match.", npc.mug_texture_path, npc.mug_animation_path))
            end
        else
            await(Async.message_player(player_id, "No problem. Come back when you're ready.", npc.mug_texture_path, npc.mug_animation_path))
        end
        pending_interactions[player_id] = nil
    end)
end

function FootBomb.handle_actor_interaction(player_id, actor_id, button)
    if button ~= nil and button ~= 0 then return end
    if pending_interactions[player_id] then return end
    local area_id = Net.get_player_area(player_id)
    if not area_id then return end
    local reference = npc_refs[area_id] and npc_refs[area_id][tostring(actor_id)]
    if reference then begin_interaction(player_id, area_id, reference) end
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
    if record and record.metadata and record.metadata.game == "footbomb" then
        local bots = instance_bots[record.id] or {}
        for slot, member_id in ipairs(record.player_ids or {}) do
            if member_id == player_id then
                setup_player_representation(player_id, record, bots[slot])
                break
            end
        end
    end
end

function FootBomb.handle_player_disconnect(player_id)
    pending_interactions[player_id] = nil
    for area_id, waiting in pairs(waiting_matches) do
        if waiting.player_id == player_id then waiting_matches[area_id] = nil end
    end
    remove_representation(player_id)
    local record = EzMapInstance.get_for_player(player_id)
    if record then
        EzMapInstance.unregister_player(record.id, player_id)
        if record.metadata and record.metadata.party then record.metadata.party.members = record.player_ids end
        cleanup_empty_instance(record)
    end
end

-- Camera follow and Navi selection use the shared InputController. Up/Down are
-- edge-triggered actions, so holding a direction does not cycle skins every tick.
Net:on("tick", function(event)
    for player_id, rep in pairs(player_representations) do
        if Net.get_player_area(player_id) == rep.area_id then
            local input = InputAPI.get_controller(player_id)
            if input then
                if input:is_action_pressed("Up") then
                    cycle_player_skin(player_id, -1)
                elseif input:is_action_pressed("Down") then
                    cycle_player_skin(player_id, 1)
                end
            end

            if type(Net.get_bot_position) == "function" and type(Net.move_player_camera) == "function" then
                local ok, pos = pcall(Net.get_bot_position, rep.bot_id)
                if ok and type(pos) == "table" and type(pos.x) == "number" and type(pos.y) == "number" then
                    pcall(Net.move_player_camera, player_id, pos.x, pos.y, as_number(pos.z, 0), 0)
                elseif rep.bot_record and rep.bot_record.position then
                    local fallback = rep.bot_record.position
                    pcall(Net.move_player_camera, player_id, fallback.x, fallback.y, fallback.z, 0)
                end
            end
        end
    end
end)

return FootBomb
