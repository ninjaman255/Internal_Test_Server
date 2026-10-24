-- npc_behaviors.lua
-- Composable behavior objects for eznpcs.
--
-- Tiled object type: NPC Behavior
--   Attached NPC: object reference to an NPC or NPC template
--   Behavior: registered behavior key (currently Pushback)
--
-- This module intentionally does not create bots. It attaches behavior to bots
-- created and owned by eznpcs, or to each instance spawned from a template.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('npc_behaviors')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezcache = require('scripts/ezlibs-scripts/ezcache')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local ezpushback = require('scripts/ezlibs-scripts/eznpcs/ezpushback')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

local npc_behaviors = {
    implementations = {},
    objects_by_area = {},
    attached = {}, -- key -> true; prevents duplicate attachment
    spawned_instances = {}, -- NPC Spawner events received before behavior objects load
}

local function key(area_id, behavior_object_id, bot_id)
    return tostring(area_id) .. ':' .. tostring(behavior_object_id) .. ':' .. tostring(bot_id)
end

function npc_behaviors.register(name, implementation)
    assert(type(name) == 'string' and name ~= '', 'behavior name must be a non-empty string')
    assert(type(implementation) == 'table' and type(implementation.attach) == 'function',
        'behavior implementation must provide attach(context)')
    if npc_behaviors.implementations[name] then
        logger:warn('Replacing NPC behavior implementation:', name)
    end
    npc_behaviors.implementations[name] = implementation
end

local function attach_one(area_id, behavior_object, bot_id, context)
    if not bot_id then return false end
    local props = behavior_object.custom_properties or {}
    if not tu.is_true(props.Enabled == nil and true or props.Enabled) then return false end
    local behavior_name = tostring(props.Behavior or 'Pushback')
    local implementation = npc_behaviors.implementations[behavior_name]
    if not implementation then
        logger:for_area(area_id):warn('[npc_behaviors] Unknown behavior "' .. behavior_name
            .. '" on object ' .. tostring(behavior_object.id))
        return false
    end
    local attachment_key = key(area_id, behavior_object.id, bot_id)
    if npc_behaviors.attached[attachment_key] then return true end
    local ok, result, err = pcall(implementation.attach, {
        area_id = area_id,
        behavior_object = behavior_object,
        behavior_object_id = behavior_object.id,
        target_object_id = props['Attached NPC'],
        bot_id = bot_id,
        context = context or {},
        config = props,
    })
    if not ok then
        logger:for_area(area_id):warn('[npc_behaviors] Attach failed for object '
            .. tostring(behavior_object.id) .. ': ' .. tostring(result))
        return false
    end
    if not result then
        logger:for_area(area_id):warn('[npc_behaviors] Behavior "' .. behavior_name
            .. '" did not attach to bot ' .. tostring(bot_id) .. ': ' .. tostring(err or 'no details'))
        return false
    end
    npc_behaviors.attached[attachment_key] = true
    return true
end

local function attach_for_target(area_id, target_object_id, bot_id, context)
    if target_object_id == nil or bot_id == nil then return end
    local area_objects = npc_behaviors.objects_by_area[area_id] or {}
    for _, behavior_object in pairs(area_objects) do
        local props = behavior_object.custom_properties or {}
        if tostring(props['Attached NPC'] or '') == tostring(target_object_id) then
            -- Legacy Pushback NPC already installs this behavior itself. Avoid
            -- duplicate trigger rectangles if a map accidentally mixes formats.
            if context and context.target_object_type == 'Pushback NPC'
                and tostring(props.Behavior or 'Pushback') == 'Pushback' then
                logger:for_area(area_id):warn('[npc_behaviors] Skipping duplicate Pushback behavior '
                    .. tostring(behavior_object.id) .. ' attached to legacy Pushback NPC '
                    .. tostring(target_object_id))
            else
                attach_one(area_id, behavior_object, bot_id, context)
            end
        end
    end
end

npc_behaviors.register('Pushback', {
    attach = function(args)
        local cfg = args.config or {}
        local entry, err = ezpushback.attach_behavior(
            args.area_id,
            args.behavior_object_id,
            cfg,
            args.bot_id,
            args.context.x,
            args.context.y,
            args.context.z,
            args.context.name or ('NPC Behavior ' .. tostring(args.behavior_object_id)))
        return entry ~= nil, err
    end,
})

object_registry.register_handler('NPC Behavior', function(area_id, object)
    npc_behaviors.objects_by_area[area_id] = npc_behaviors.objects_by_area[area_id] or {}
    npc_behaviors.objects_by_area[area_id][tostring(object.id)] = object
    local props = object.custom_properties or {}
    if props['Attached NPC'] == nil or tostring(props['Attached NPC']) == '' then
        logger:for_area(area_id):warn('[npc_behaviors] NPC Behavior object ' .. tostring(object.id)
            .. ' is missing Attached NPC object reference')
    end
end, false)

-- Static NPCs are created during object_registry.load_all(). Since the behavior
-- object can appear earlier or later in Tiled's object order, attach_all() is
-- called after eznpcs.load_npcs() has completed the map scan.
function npc_behaviors.attach_all()
    for area_id, behavior_objects in pairs(npc_behaviors.objects_by_area) do
        for _, behavior_object in pairs(behavior_objects) do
            local props = behavior_object.custom_properties or {}
            local target_id = props['Attached NPC']
            if target_id ~= nil and tostring(target_id) ~= '' then
                local target = ezcache.get_object_by_id_cached(area_id, target_id)
                if target and target.type == 'Pushback NPC' then
                    logger:for_area(area_id):warn('[npc_behaviors] Behavior object '
                        .. tostring(behavior_object.id) .. ' targets legacy Pushback NPC '
                        .. tostring(target_id) .. '; use one pushback mechanism, not both')
                else
                    local bot_id = eznpcs.get_bot_for_placeholder(area_id, target_id)
                    if bot_id then
                        attach_one(area_id, behavior_object, bot_id, {
                            target_object_type = target and target.type,
                            x = target and target.x, y = target and target.y,
                            z = target and target.z, name = target and target.name,
                        })
                    end
                end
                -- Spawner handlers may run before this behavior object is
                -- encountered in object_registry.load_all(). Replay stored
                -- template instances after all behavior definitions are known.
                for _, instance in ipairs(npc_behaviors.spawned_instances) do
                    if tostring(instance.area_id) == tostring(area_id)
                        and tostring(instance.template_object_id) == tostring(target_id) then
                        attach_for_target(area_id, target_id, instance.bot_id, {
                            target_object_type = instance.template_type,
                            x = instance.spawn_x, y = instance.spawn_y, z = instance.spawn_z,
                            name = instance.template_name, spawner_id = instance.spawner_id,
                        })
                    end
                end
            end
        end
    end
end

-- Handles per-player and quest-exclusive NPCs created after map preload.
ezbus:on('npc_created_from_object', function(event)
    if type(event) ~= 'table' or not event.area_id or not event.object_id or not event.bot_id then return end
    attach_for_target(event.area_id, event.object_id, event.bot_id, {
        target_object_type = event.object_type,
        x = event.x, y = event.y, z = event.z, name = event.name,
        player_id = event.player_id,
    })
end)

-- A template's behaviors are cloned onto each NPC Spawner instance.
ezbus:on('npc_spawned_from_spawner', function(event)
    if type(event) ~= 'table' or not event.area_id or not event.template_object_id or not event.bot_id then return end
    npc_behaviors.spawned_instances[#npc_behaviors.spawned_instances + 1] = {
        area_id = event.area_id, template_object_id = event.template_object_id,
        bot_id = event.bot_id, template_type = event.template_type,
        spawn_x = event.spawn_x, spawn_y = event.spawn_y, spawn_z = event.spawn_z,
        template_name = event.template_name, spawner_id = event.spawner_id,
    }
    attach_for_target(event.area_id, event.template_object_id, event.bot_id, {
        target_object_type = event.template_type,
        x = event.spawn_x, y = event.spawn_y, z = event.spawn_z,
        name = event.template_name, spawner_id = event.spawner_id,
    })
end)

-- Any bot removal invalidates dedupe state. ezpushback independently owns and
-- tears down its trigger entry on the same lifecycle event.
ezbus:on('bot_removed', function(event)
    if type(event) ~= 'table' or not event.bot_id then return end
    local suffix = ':' .. tostring(event.bot_id)
    for attachment_key in pairs(npc_behaviors.attached) do
        if attachment_key:sub(-#suffix) == suffix then
            npc_behaviors.attached[attachment_key] = nil
        end
    end
end)

return npc_behaviors
