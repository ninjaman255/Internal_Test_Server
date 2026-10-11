-- FootBomb Ref NPC and private match-instance entry point.
-- Loaded as an ezlibs custom plugin; event dispatch is handled by
-- scripts/ezlibs-scripts/main.lua through custom.lua.

local logger = require("scripts/ezlibs-scripts/ezlogger").get("footbomb")
local object_registry = require("scripts/ezlibs-scripts/object_registry")
local EzMapInstance = require("scripts/ezlibs-scripts/ezmapinstance")
local Parties = require("scripts/ezlibs-custom/nebulous-liberations/utils/parties")

local FootBomb = {}
local npc_refs = {}             -- area_id -> actor_id -> { object, npc }
local pending_interactions = {} -- player_id -> true while the dialogue is active

local DEFAULT_SOURCE_AREA = "footbomb"
local DEFAULT_INTRO = "Hey! Want to play a round of FootBomb?"
local DEFAULT_QUESTION = "Would you like to join a FootBomb party and enter the field?"
local DEFAULT_DECLINED = "No problem. Come back when you're ready."
local DEFAULT_STARTED = "All right! I'll get your party onto the field."
local NPC_FOLDER = "/server/assets/ezlibs-assets/eznpcs/"
local NPC_SHEET_FOLDER = NPC_FOLDER .. "sheet/"
local MUG_FOLDER = NPC_FOLDER .. "mug/"
local DEFAULT_ASSET_NAME = "male-navi-exe6_teal"
local DEFAULT_MUG_ANIMATION = MUG_FOLDER .. "mug.animation"

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

local function as_boolean(value)
    if value == true then return true end
    if type(value) == "number" then return value ~= 0 end
    if type(value) == "string" then
        local normalized = value:lower()
        return normalized == "true" or normalized == "1" or normalized == "yes"
    end
    return false
end

local function ensure_area_refs(area_id)
    if not npc_refs[area_id] then
        npc_refs[area_id] = {}
    end
    return npc_refs[area_id]
end

local function create_ref_npc(area_id, object)
    if not object then return nil end

    local properties = object.custom_properties or {}
    -- Follow Simon Says: a Tiled reference object describes a bot, and the
    -- map object itself is cached by object_registry after this callback.
    local asset_name = as_string(properties["Asset Name"], DEFAULT_ASSET_NAME)
    local animation_name = as_string(properties["Animation Name"], nil)
    local mugshot_name = as_string(properties.Mugshot, asset_name)
    local mug_animation_name = as_string(properties["Mug Animation Name"], nil)
    local direction = as_string(properties.Direction, "Down")
    local actor_id = "footbomb-ref-" .. tostring(area_id) .. "-" .. tostring(object.id)

    local animation_path = NPC_SHEET_FOLDER .. asset_name .. ".animation"
    if animation_name then
        animation_path = NPC_SHEET_FOLDER .. animation_name .. ".animation"
    end

    local mug_animation_path = DEFAULT_MUG_ANIMATION
    if mug_animation_name then
        mug_animation_path = MUG_FOLDER .. mug_animation_name .. ".animation"
    end

    local bot_id = Net.create_bot(actor_id, {
        name = as_string(object.name, "FootBomb Ref"),
        area_id = area_id,
        texture_path = NPC_SHEET_FOLDER .. asset_name .. ".png",
        animation_path = animation_path,
        animation = "IDLE_DR",
        x = as_number(object.x, 0),
        y = as_number(object.y, 0),
        z = as_number(object.z, 0),
        direction = direction,
        solid = true,
        size = 0.2,
        warp_in = false,
        dont_face_player = as_boolean(properties["Dont Face Player"])
    })

    if not bot_id then
        log("Net.create_bot failed for FootBomb Ref " .. tostring(object.id) .. " in " .. tostring(area_id) .. ".")
        return nil
    end

    local npc = {
        bot_id = bot_id,
        actor_id = actor_id,
        asset_name = asset_name,
        mugshot_name = mugshot_name,
        texture_path = NPC_SHEET_FOLDER .. asset_name .. ".png",
        animation_path = animation_path,
        mug_texture_path = MUG_FOLDER .. mugshot_name .. ".png",
        mug_animation_path = mug_animation_path
    }

    local reference = {
        object = object,
        npc = npc,
        actor_id = tostring(actor_id)
    }
    -- Simon Says interacts by the ID passed into Net.create_bot. Also retain
    -- the returned ID as an alias in case the engine normalizes bot IDs.
    ensure_area_refs(area_id)[tostring(actor_id)] = reference
    ensure_area_refs(area_id)[tostring(bot_id)] = reference
    log("Created FootBomb Ref bot " .. tostring(bot_id) .. " for map object " .. tostring(object.id) .. " in " .. tostring(area_id) .. ".")
    return npc
end

-- Register the Tiled custom object type before object_registry.load_all().
-- The registry caches/removes the reference object from Net after this handler;
-- we keep the object data here so interactions can still be resolved.
object_registry.register_handler("FootBomb Ref", function(area_id, object)
    create_ref_npc(area_id, object)
end)

local function get_party_members(player_id)
    local existing_party = Parties.find(player_id)
    local members = {}
    local seen = {}

    if existing_party and type(existing_party.members) == "table" then
        for _, member_id in ipairs(existing_party.members) do
            if member_id ~= nil and not seen[member_id] then
                seen[member_id] = true
                members[#members + 1] = member_id
            end
        end
    end

    if #members == 0 then
        members[1] = player_id
    elseif not seen[player_id] then
        -- A party lookup should include its requesting member, but retain a
        -- defensive fallback if a stale party table is encountered.
        members[#members + 1] = player_id
    end

    return members, existing_party
end

local function player_is_available(player_id)
    if player_id == nil then return false end
    if Net and type(Net.is_player) == "function" then
        local ok, result = pcall(Net.is_player, player_id)
        if ok then return result == true end
    end
    if Net and type(Net.get_player_area) == "function" then
        local ok, area_id = pcall(Net.get_player_area, player_id)
        return ok and area_id ~= nil
    end
    return false
end

local function get_spawn_position(instance_id, source_area_id, fallback_object)
    if Net and type(Net.get_spawn_position) == "function" then
        local ok, spawn = pcall(Net.get_spawn_position, instance_id)
        if ok and spawn and type(spawn.x) == "number" and type(spawn.y) == "number" then
            return { x = spawn.x, y = spawn.y, z = as_number(spawn.z, 0) }
        end

        ok, spawn = pcall(Net.get_spawn_position, source_area_id)
        if ok and spawn and type(spawn.x) == "number" and type(spawn.y) == "number" then
            return { x = spawn.x, y = spawn.y, z = as_number(spawn.z, 0) }
        end
    end

    -- FootBomb currently has no dedicated spawn marker. The custom object
    -- exposes a configurable fallback in map/world coordinates; default values
    -- place the party near the middle of the field rather than beside the NPC.
    local properties = fallback_object and fallback_object.custom_properties or {}
    return {
        x = as_number(properties["Spawn X"], as_number(fallback_object and fallback_object.x, 0) + 1),
        y = as_number(properties["Spawn Y"], as_number(fallback_object and fallback_object.y, 0)),
        z = as_number(properties["Spawn Z"], as_number(fallback_object and fallback_object.z, 0))
    }
end

local function unregister_member(record, player_id)
    if not record then return end
    EzMapInstance.unregister_player(record.id, player_id)
    if record.metadata and record.metadata.party then
        record.metadata.party.host_id = record.host_id
        record.metadata.party.members = record.player_ids
    end
end

local function cleanup_if_empty(record)
    if not record or type(record.player_ids) ~= "table" or #record.player_ids > 0 then
        return
    end

    local ok, err = EzMapInstance.remove(record.id)
    if ok then
        log("Removed empty FootBomb instance " .. tostring(record.id) .. ".")
    else
        log("Could not remove empty FootBomb instance " .. tostring(record.id) .. ": " .. tostring(err))
    end
end

local function launch_party(player_id, source_area_id, ref_object)
    local members, existing_party = get_party_members(player_id)
    local available_members = {}
    local seen = {}

    for _, member_id in ipairs(members) do
        if not seen[member_id] and player_is_available(member_id) then
            seen[member_id] = true
            available_members[#available_members + 1] = member_id
        end
    end

    if #available_members == 0 then
        await(Async.message_player(player_id, "I couldn't find any available party members. Please try again."))
        return
    end

    local host_id = available_members[1]
    local preferred_id = "footbomb_" .. tostring(host_id):gsub("[^%w_%-]", "_") .. "_" .. tostring(os.time())
    local party_id = existing_party and (existing_party.id or ("party_" .. tostring(host_id))) or ("footbomb_party_" .. tostring(host_id) .. "_" .. tostring(os.time()))

    local instance, create_error = EzMapInstance.create(
        as_string((ref_object.custom_properties or {})["Instance Map"], DEFAULT_SOURCE_AREA),
        preferred_id,
        {
            host_id = host_id,
            player_ids = {},
            party_id = party_id,
            metadata = {
                game = "footbomb",
                party = {
                    id = party_id,
                    host_id = host_id,
                    members = {}
                }
            }
        }
    )

    if not instance then
        log("Failed to create FootBomb instance: " .. tostring(create_error))
        await(Async.message_player(player_id, "I couldn't open the FootBomb field right now. Please try again later."))
        return
    end

    local spawn = get_spawn_position(instance.area_id, instance.base_area_id, ref_object)
    local transferred = 0

    for index, member_id in ipairs(available_members) do
        local offset_x = ((index - 1) % 3) * 0.5
        local offset_y = math.floor((index - 1) / 3) * 0.5
        local ok, transfer_error = EzMapInstance.transfer_player(
            instance.id,
            member_id,
            spawn.x + offset_x,
            spawn.y + offset_y,
            spawn.z
        )

        if ok then
            transferred = transferred + 1
            instance.metadata.party.members[#instance.metadata.party.members + 1] = member_id
        else
            log("Failed to transfer party member " .. tostring(member_id) .. " to " .. tostring(instance.id) .. ": " .. tostring(transfer_error))
        end
    end

    if transferred == 0 then
        EzMapInstance.remove(instance.id)
        await(Async.message_player(player_id, "I couldn't transfer your party to the FootBomb field. Please try again."))
        return
    end

    log("Started FootBomb instance " .. tostring(instance.id) .. " for party " .. tostring(party_id) .. ".")
end

local function begin_interaction(player_id, area_id, reference)
    if pending_interactions[player_id] then return end
    pending_interactions[player_id] = true

    async(function()
        local object = reference.object
        local properties = object.custom_properties or {}
        local npc = reference.npc
        local mugshot_texture = npc.mug_texture_path
        local mugshot_animation = npc.mug_animation_path or DEFAULT_MUG_ANIMATION

        local intro = as_string(properties["Intro Message"], DEFAULT_INTRO)
        local question = as_string(properties.Question, DEFAULT_QUESTION)
        local declined = as_string(properties["Declined Message"], DEFAULT_DECLINED)
        local started = as_string(properties["Started Message"], DEFAULT_STARTED)

        await(Async.message_player(player_id, intro, mugshot_texture, mugshot_animation))

        -- Do not leave a question open if the player has left the source area.
        if Net.get_player_area(player_id) ~= area_id then
            pending_interactions[player_id] = nil
            return
        end

        local response = await(Async.question_player(player_id, question, mugshot_texture, mugshot_animation))
        if Net.get_player_area(player_id) ~= area_id then
            pending_interactions[player_id] = nil
            return
        end

        if response ~= 1 then
            await(Async.message_player(player_id, declined, mugshot_texture, mugshot_animation))
            pending_interactions[player_id] = nil
            return
        end

        await(Async.message_player(player_id, started, mugshot_texture, mugshot_animation))
        if Net.get_player_area(player_id) == area_id then
            launch_party(player_id, area_id, object)
        end
        pending_interactions[player_id] = nil
    end)
end

function FootBomb.handle_actor_interaction(player_id, actor_id, button)
    if button ~= nil and button ~= 0 then return end
    if pending_interactions[player_id] then return end

    local area_id = Net.get_player_area(player_id)
    if not area_id then return end

    local area_refs = npc_refs[area_id]
    local reference = area_refs and area_refs[tostring(actor_id)]
    if reference then
        begin_interaction(player_id, area_id, reference)
    end
end

function FootBomb.handle_player_transfer(player_id)
    local record = EzMapInstance.get_for_player(player_id)
    if not record then return end

    local current_area = Net.get_player_area(player_id)
    if current_area ~= record.area_id then
        unregister_member(record, player_id)
        cleanup_if_empty(record)
    end
end

function FootBomb.handle_player_disconnect(player_id)
    pending_interactions[player_id] = nil
    local record = EzMapInstance.get_for_player(player_id)
    if not record then return end

    unregister_member(record, player_id)
    cleanup_if_empty(record)
end

return FootBomb
