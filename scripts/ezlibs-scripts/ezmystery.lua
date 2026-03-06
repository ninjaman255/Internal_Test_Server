local ezmystery = {}
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local ezcache = require('scripts/ezlibs-scripts/ezcache')
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezlocks = require('scripts/ezlibs-scripts/ezlocks')
local math = require('math')

local AvatarCache = require('scripts/avatar_utils/main')
local AvatarUtils = require('scripts/avatar_utils/avatar_utils')

local object_cache = {}
local revealed_mysteries_for_players = {}

local sfx = {
    item_get = '/server/assets/ezlibs-assets/sfx/item_get.ogg',
}

local player_avatars = {}
local player_animations = {}
--Type Mystery Data (or Mystery Datum) have these custom_properties
--Locked (bool) do you need an unlocker to open this?
--Password Locked (string) if set, requires this password to open
--Once (bool) should this never respawn for this player?
--Type (string) one of: 'keyitem', 'item', 'money', 'random', 'quiz'
--(for keyitem/item/money types)
--    Name (string) name of item
--    Description (string) description of key item
--    Amount (number) amount of money or item count
--(for random type)
--    Next 1..N (object IDs) possible mystery data to randomly pick
--(for quiz type)
--    Quiz List (object ID) reference to a Quiz List object

local function object_is_mystery_data(object)
    if object.type == "Mystery Data" or object.type == "Mystery Datum" then
        return true
    end
end

local function fetch_player_avatar_and_details(player_id)
    local player_secret = Net.get_player_secret(player_id)
    local player_avatar = AvatarCache.get_player_avatar_paths(player_secret)
    print(player_avatar)

    local texture_path = ""
    local anim_path = ""
    if player_avatar ~= nil then
        if player_avatar.sheet ~= nil and player_avatar.sheet.texture ~= nil then
            texture_path = player_avatar.sheet.texture
        end
        if player_avatar.sheet ~= nil and player_avatar.sheet.animation ~= nil then
            anim_path = player_avatar.sheet.animation
        end
    end
    player_avatars[player_secret] = { texture_path = texture_path, anim_path = anim_path }
    local parsed = AvatarUtils.parse_animation_file(anim_path)
    player_animations[player_secret] = parsed
    print(player_animations)
end

Net:on("player_join", function(event)
    local player_id = event.player_id
    fetch_player_avatar_and_details(player_id)
end)

Net:on("avatar_change", function(event)
    local player_id = event.player_id
    fetch_player_avatar_and_details(player_id)
end)

Net:on("object_interaction", function(event)
    -- { player_id: string, object_id: number, button: number }
    local area_id = Net.get_player_area(event.player_id)
    local object = Net.get_object_by_id(area_id, event.object_id)
    if object_is_mystery_data(object) then
        try_collect_datum(event.player_id, area_id, object)
    end
end)

function ezmystery.handle_player_disconnect(player_id)
    revealed_mysteries_for_players[player_id] = nil
end

function ezmystery.hide_random_data(player_id)
    local area_id = Net.get_player_area(player_id)
    local objects = Net.list_objects(area_id)
    --New map properties. Default to making maximum smaller than minimum so that if this isn't setup, it won't be used.
    local area_min_mystery_count = tonumber(Net.get_area_custom_property(area_id, "Mystery Data Minimum")) or 1
    local area_max_mystery_count = tonumber(Net.get_area_custom_property(area_id, "Mystery Data Maximum")) or 0
    --As mentioned, don't do anything if the min is smaller than the max. Safety!
    if area_min_mystery_count > area_max_mystery_count then return end
    --If we don't have a record of this player upon transfer (due to reasons like joining in an area without randomized data), then process this player
    if revealed_mysteries_for_players[player_id] == nil then revealed_mysteries_for_players[player_id] = {} end
    --If we've already processed this area for this player, don't process. We don't want to process the same area twice.
    --That way, we don't rearrange existing mystery data, or data that's already been hidden.
    if revealed_mysteries_for_players[player_id] and revealed_mysteries_for_players[player_id][area_id] then
        return
    end
    --Mystery count used in the loop.
    local mystery_count = 0
    --Amount of mystery data to be found in the area.
    local desired_mystery_count = math.random(area_min_mystery_count, area_max_mystery_count)
    --Add the area to a dict of player memory. Since we've started processing this area, we don't want to process it again.
    revealed_mysteries_for_players[player_id][area_id] = {}
    local datum_list = {}
    for i, object_id in next, objects do
        local object = Net.get_object_by_id(area_id, object_id)
        --Only allow in to the list if it's a mystery datum that is not set to one-time and it's not locked.
        if object_is_mystery_data(object) and object.custom_properties["Once"] ~= "true" and object.custom_properties["Locked"] ~= "true" then
            --Add to the list.
            table.insert(datum_list, object.id)
            --Increment count since we found a datum.
            mystery_count = mystery_count + 1
        end
    end
    while mystery_count > desired_mystery_count do
        --Get random mystery index.
        local index = math.random(#datum_list)
        --Get random mystery ID.
        local mystery = datum_list[index]
        --If it's not already removed, then...
        if mystery ~= nil then
            --Hide it.
            ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, mystery)
            --Remove it.
            table.remove(datum_list, helpers.indexOf(datum_list, mystery))
            --Reassign the mystery count.
            mystery_count = #datum_list
        end
    end
    revealed_mysteries_for_players[player_id][area_id] = datum_list
end

function ezmystery.handle_player_transfer(player_id)
    ezmystery.hide_random_data(player_id)
end

function ezmystery.handle_player_join(player_id)
    ezmystery.hide_random_data(player_id)
end

-- Quiz handling using a Quiz List object
local function run_quiz_from_list(player_id, area_id, quiz_list_id, failure_message)
    local quiz_list = ezcache.get_object_by_id_cached(area_id, quiz_list_id)
    if not quiz_list then
        warn("[ezmystery] Quiz List object not found: " .. tostring(quiz_list_id))
        return false
    end

    -- Extract numbered Next properties (pointing to quiz question objects)
    local question_ids = helpers.extract_numbered_properties(quiz_list, "Next ")
    if #question_ids == 0 then
        warn("[ezmystery] Quiz List has no Next properties")
        return false
    end

    for _, qid in ipairs(question_ids) do
        local qobj = ezcache.get_object_by_id_cached(area_id, qid)
        if not qobj then
            warn("[ezmystery] Quiz question object not found: " .. tostring(qid))
            return false
        end

        local question = qobj.custom_properties["Question"]
        local opt1 = qobj.custom_properties["Option 1"]
        local opt2 = qobj.custom_properties["Option 2"]
        local opt3 = qobj.custom_properties["Option 3"]
        local correct_answer = tonumber(qobj.custom_properties["Correct Answer"]) or 1

        -- Build options table, ignoring empty strings
        local options = {}
        if opt1 and #opt1 > 0 then table.insert(options, opt1) end
        if opt2 and #opt2 > 0 then table.insert(options, opt2) end
        if opt3 and #opt3 > 0 then table.insert(options, opt3) end

        if #options == 0 then
            warn("[ezmystery] Quiz question " .. tostring(qid) .. " has no options")
            return false
        end

        -- Validate correct answer index
        if correct_answer < 1 or correct_answer > #options then
            correct_answer = 1
        end

        -- Show question
        await(Async.message_player(player_id, question))

        -- Present options (quiz_player returns 0-based index)
        local choice = await(Async.quiz_player(player_id, options[1], options[2], options[3]))
        if choice == nil or choice < 0 or choice+1 ~= correct_answer then
            if failure_message and #failure_message > 0 then
                await(Async.message_player(player_id, failure_message))
            end
            return false
        end
    end
    return true
end

function try_collect_datum(player_id, area_id, object)
    return async(function()
        if ezmemory.object_is_hidden_from_player(player_id, area_id, object.id) then
            --Anti spam protection
            return
        end
        --anti spam lock
        local lock_id = player_id .. "_" .. area_id .. "_" .. object.id
        local lock = helpers.get_lock(player_id, lock_id)
        if not lock then
            return
        end

        -- Check for password lock first
        local password = object.custom_properties["Password Locked"]
        if password and #password > 0 then
            local unlocked = await(ezlocks.check_password(player_id, "Enter password:", password))
            if not unlocked then
                lock.release()
                return
            end
        else
            -- Fallback to old item-based lock
            if object.custom_properties["Locked"] == "true" then
                await(Async.message_player(player_id, "The Mystery Data is locked."))
                local unlocked = await(ezlocks.check_item(player_id, "Use an Unlocker to open it?", "Unlocker", 1, true))
                if not unlocked then
                    lock.release()
                    return
                end
            end
        end

        -- Now check type-specific collection conditions
        local datum_type = object.custom_properties["Type"]
        local can_collect = true
        if datum_type == "quiz" then
            local quiz_list_id = object.custom_properties["Quiz List"]
            if not quiz_list_id or #quiz_list_id == 0 then
                warn("[ezmystery] Quiz type missing Quiz List property")
                can_collect = false
            else
                local failure_message = object.custom_properties["Failure Message"] or "Incorrect answer."
                can_collect = await(run_quiz_from_list(player_id, area_id, quiz_list_id, failure_message))
            end
        end

        if can_collect then
            await(Async.message_player(player_id, "Accessing the mystery data\x01...\x01"))
            await(collect_datum(player_id, object, object.id))
        end
        lock.release()
    end)
end

function read_datum_information(area_id, object)
    local item_info = helpers.read_item_information(area_id, object.id)
    if not item_info then
        return false
    end
    if item_info.type == "random" then
        local random_options = helpers.extract_numbered_properties(object, "Next ")
        if #random_options == 0 then
            warn('[ezmystery] ' .. object.id .. ' is type=random, but has no Next #')
            return false
        end
    end
    return item_info
end

function collect_datum(player_id, object, datum_id_override)
    return async(function()
        local area_id = Net.get_player_area(player_id)
        local item_info = read_datum_information(area_id, object)
        local original_direction = Net.get_player_direction(player_id)
        if item_info == false then
            return
        end

        if item_info.type == "random" then
            local random_options = helpers.extract_numbered_properties(object, "Next ")
            local random_selection_id = random_options[math.random(#random_options)]
            if random_selection_id then
                randomly_selected_datum = ezcache.get_object_by_id_cached(area_id, random_selection_id)
                await(collect_datum(player_id, randomly_selected_datum, datum_id_override))
                return
            end
        else
            ezmemory.play_anim_get(player_id)
            await(ezmemory.give_item_with_optional_notify(player_id, area_id, object.id, item_info))
            ezmemory.set_direction_anim(player_id, original_direction)
        end

        if object.custom_properties["Once"] == "true" then
            --If this mystery data should only be available once (not respawning)
            ezmemory.hide_object_from_player(player_id, area_id, datum_id_override)
        end

        --Now remove the mystery data
        ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, datum_id_override)
    end)
end

return ezmystery