-- ezbottriggers.lua
-- Bot-only variant of eztriggers.
--
-- Mirrors the rectangle/ellipse trigger API of eztriggers, but tracks bots
-- instead of players. It does not touch eztriggers or its player-only state,
-- so the two modules can be used side by side on the same source objects.
--
-- Fed by eznpcs via ezbus events:
--   bot_created { bot_id, area_id, x, y, z }
--   bot_moved   { bot_id, area_id, x, y, z }
--   bot_removed { bot_id }
--
-- Each returned emitter fires:
--   entered  { bot_id = ..., object = ..., reason = ..., x, y, z }
--   departed { bot_id = ..., object = ..., reason = ..., x, y, z }
-- The x/y/z values describe the position that caused the transition, so
-- listeners can reconcile overlapping triggers without any Net lookup.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezbottriggers')
local ezbus = require('scripts/ezlibs-scripts/ezbus')

local ezbottriggers = {}

local DEBUG_BOT_TRIGGER_GEOMETRY = false

ezbottriggers.radius_triggers = {}
ezbottriggers.rectangle_triggers = {}

local function resolve_trigger_key(trigger_object, trigger_id)
    if trigger_id ~= nil then return trigger_id end
    if trigger_object and trigger_object.id ~= nil then return trigger_object.id end
    return nil
end

function ezbottriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)
    if not trigger_object or area_id == nil or trigger_object.id == nil then
        logger:warn("[ezbottriggers] Cannot register ellipse trigger without area and object IDs")
        return nil
    end

    if not ezbottriggers.radius_triggers[area_id] then
        ezbottriggers.radius_triggers[area_id] = {}
    end

    local trigger_key = resolve_trigger_key(trigger_object, trigger_id)
    if ezbottriggers.radius_triggers[area_id][trigger_key] then
        logger:for_area(area_id):warn("[ezbottriggers] Trigger key " .. tostring(trigger_key) .. " is already registered as an ellipse trigger in area " .. tostring(area_id))
        return nil
    end

    local width = tonumber(diameter_x)
    local height = tonumber(diameter_y)
    local object_x = tonumber(trigger_object.x)
    local object_y = tonumber(trigger_object.y)
    center_x = tonumber(center_x) or 0
    center_y = tonumber(center_y) or 0

    if not width or not height or not object_x or not object_y then
        logger:for_area(area_id):warn("[ezbottriggers] Invalid ellipse trigger geometry for object " .. tostring(trigger_object.id))
        return nil
    end

    local emitter = Net.EventEmitter.new()
    local trigger_info = {
        id = trigger_key,
        object = trigger_object,
        emitter = emitter,
        overlapping_bots = {},
        radius_x = width / 2,
        radius_y = height / 2,
        center_x = object_x + center_x,
        center_y = object_y + center_y
    }
    ezbottriggers.radius_triggers[area_id][trigger_key] = trigger_info

    if DEBUG_BOT_TRIGGER_GEOMETRY then
        logger:info(string.format(
            "[ezbottriggers][geometry][REGISTER][ELLIPSE] area=%s trigger_id=%s source_object_id=%s center=(%s,%s) radii=(%s,%s)",
            tostring(area_id), tostring(trigger_key), tostring(trigger_object.id),
            tostring(trigger_info.center_x), tostring(trigger_info.center_y),
            tostring(trigger_info.radius_x), tostring(trigger_info.radius_y)))
    end
    return emitter
end

function ezbottriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)
    if not trigger_object or area_id == nil or trigger_object.id == nil then
        logger:warn("[ezbottriggers] Cannot register rectangle trigger without area and object IDs")
        return nil
    end

    if not ezbottriggers.rectangle_triggers[area_id] then
        ezbottriggers.rectangle_triggers[area_id] = {}
    end

    local trigger_key = resolve_trigger_key(trigger_object, trigger_id)
    if ezbottriggers.rectangle_triggers[area_id][trigger_key] then
        logger:for_area(area_id):warn("[ezbottriggers] Trigger key " .. tostring(trigger_key) .. " is already registered as a rectangle trigger in area " .. tostring(area_id))
        return nil
    end

    local object_x = tonumber(trigger_object.x)
    local object_y = tonumber(trigger_object.y)
    local trigger_width = tonumber(width) or tonumber(trigger_object.width)
    local trigger_height = tonumber(height) or tonumber(trigger_object.height)
    if not object_x or not object_y or not trigger_width or not trigger_height
        or trigger_width < 0 or trigger_height < 0 then
        logger:for_area(area_id):warn("[ezbottriggers] Invalid rectangle trigger geometry for object " .. tostring(trigger_object.id))
        return nil
    end

    local emitter = Net.EventEmitter.new()
    local trigger_info = {
        id = trigger_key,
        object = trigger_object,
        emitter = emitter,
        overlapping_bots = {},
        width = trigger_width,
        height = trigger_height
    }
    ezbottriggers.rectangle_triggers[area_id][trigger_key] = trigger_info

    if DEBUG_BOT_TRIGGER_GEOMETRY then
        logger:info(string.format(
            "[ezbottriggers][geometry][REGISTER][RECTANGLE] area=%s trigger_id=%s source_object_id=%s origin=(%s,%s) size=(%s,%s)",
            tostring(area_id), tostring(trigger_key), tostring(trigger_object.id),
            tostring(object_x), tostring(object_y),
            tostring(trigger_info.width), tostring(trigger_info.height)))
    end
    return emitter
end

-- x/y/z describe the position that caused the transition, so listeners can
-- resolve overlapping triggers from the same authoritative state.
local function set_bot_overlap(trigger_info, bot_id, is_inside, reason, x, y, z)
    if not trigger_info or bot_id == nil then
        return false
    end

    local was_inside = trigger_info.overlapping_bots[bot_id] == true
    if was_inside == is_inside then
        return false
    end

    if is_inside then
        trigger_info.overlapping_bots[bot_id] = true
        trigger_info.emitter:emit("entered", {
            bot_id = bot_id,
            object = trigger_info.object,
            reason = reason,
            x = x, y = y, z = z
        })
    else
        trigger_info.overlapping_bots[bot_id] = nil
        trigger_info.emitter:emit("departed", {
            bot_id = bot_id,
            object = trigger_info.object,
            reason = reason,
            x = x, y = y, z = z
        })
    end
    return true
end

-- Reconcile a single bot's occupancy against the triggers in its current area.
function ezbottriggers.handle_bot_move(bot_id, x, y, z, area_id)
    if bot_id == nil or type(x) ~= "number" or type(y) ~= "number" then
        return
    end
    z = tonumber(z) or 0

    local bot_area_id = area_id
    if not bot_area_id then
        local ok, actual = pcall(Net.get_bot_area, bot_id)
        if ok then bot_area_id = actual end
    end
    if not bot_area_id then
        ezbottriggers.clear_radius_overlaps_for_bot(bot_id, "area_unavailable")
        ezbottriggers.clear_rectangle_overlaps_for_bot(bot_id, "area_unavailable")
        return
    end

    local area_radius_triggers = ezbottriggers.radius_triggers[bot_area_id]
    if area_radius_triggers ~= nil then
        for _, trigger_info in pairs(area_radius_triggers) do
            local trigger_z = tonumber(trigger_info.object.z) or 0
            if trigger_z ~= z then
                set_bot_overlap(trigger_info, bot_id, false, "height_changed", x, y, z)
            else
                local rad_x = trigger_info.radius_x
                local rad_y = trigger_info.radius_y
                if type(rad_x) == "number" and type(rad_y) == "number" and rad_x > 0 and rad_y > 0 then
                    local dx = x - trigger_info.center_x
                    local dy = y - trigger_info.center_y
                    local inside_ellipse = ((dx * dx) / (rad_x * rad_x) + (dy * dy) / (rad_y * rad_y)) <= 1.0
                    if DEBUG_BOT_TRIGGER_GEOMETRY then
                        logger:debug(string.format(
                            "[ezbottriggers][geometry][CHECK][ELLIPSE] bot=%s area=%s trigger_id=%s bot_xyz=(%s,%s,%s) inside=%s",
                            tostring(bot_id), tostring(bot_area_id), tostring(trigger_info.id),
                            tostring(x), tostring(y), tostring(z), tostring(inside_ellipse)))
                    end
                    set_bot_overlap(trigger_info, bot_id, inside_ellipse, "movement", x, y, z)
                else
                    set_bot_overlap(trigger_info, bot_id, false, "invalid_trigger_size", x, y, z)
                end
            end
        end
    end

    local area_rectangle_triggers = ezbottriggers.rectangle_triggers[bot_area_id]
    if area_rectangle_triggers ~= nil then
        for _, trigger_info in pairs(area_rectangle_triggers) do
            local trigger_z = tonumber(trigger_info.object.z) or 0
            if trigger_z ~= z then
                set_bot_overlap(trigger_info, bot_id, false, "height_changed", x, y, z)
            else
                local obj_x = tonumber(trigger_info.object.x)
                local obj_y = tonumber(trigger_info.object.y)
                local obj_w = tonumber(trigger_info.width) or tonumber(trigger_info.object.width)
                local obj_h = tonumber(trigger_info.height) or tonumber(trigger_info.object.height)
                local inside_aabb = false
                if obj_x and obj_y and obj_w and obj_h and obj_w >= 0 and obj_h >= 0 then
                    inside_aabb = x >= obj_x and y >= obj_y
                        and x <= obj_x + obj_w and y <= obj_y + obj_h
                end
                if DEBUG_BOT_TRIGGER_GEOMETRY then
                    logger:debug(string.format(
                        "[ezbottriggers][geometry][CHECK][RECTANGLE] bot=%s area=%s trigger_id=%s bot_xyz=(%s,%s,%s) inside=%s",
                        tostring(bot_id), tostring(bot_area_id), tostring(trigger_info.id),
                        tostring(x), tostring(y), tostring(z), tostring(inside_aabb)))
                end
                set_bot_overlap(trigger_info, bot_id, inside_aabb, "movement", x, y, z)
            end
        end
    end
end

function ezbottriggers.clear_radius_overlaps_for_bot(bot_id, reason)
    for _, area_triggers in pairs(ezbottriggers.radius_triggers) do
        for _, trigger_info in pairs(area_triggers) do
            set_bot_overlap(trigger_info, bot_id, false, reason or "cleanup")
        end
    end
end

function ezbottriggers.clear_rectangle_overlaps_for_bot(bot_id, reason)
    for _, area_triggers in pairs(ezbottriggers.rectangle_triggers) do
        for _, trigger_info in pairs(area_triggers) do
            set_bot_overlap(trigger_info, bot_id, false, reason or "cleanup")
        end
    end
end

function ezbottriggers.handle_bot_created(bot_id, area_id, x, y, z)
    if bot_id == nil or area_id == nil then return end

    if type(x) ~= "number" or type(y) ~= "number" then
        local ok_pos, pos = pcall(Net.get_bot_position, bot_id)
        if not ok_pos or type(pos) ~= "table" then return end
        x = tonumber(pos.x)
        y = tonumber(pos.y)
        z = tonumber(pos.z) or 0
        if type(x) ~= "number" or type(y) ~= "number" then return end
    end

    ezbottriggers.handle_bot_move(bot_id, x, y, z, area_id)
end

function ezbottriggers.handle_bot_removed(bot_id)
    if bot_id == nil then return end
    ezbottriggers.clear_radius_overlaps_for_bot(bot_id, "bot_removed")
    ezbottriggers.clear_rectangle_overlaps_for_bot(bot_id, "bot_removed")
end

-- ezbus wiring. eznpcs emits these events in its normal bot lifecycle.
ezbus:on("bot_created", function(event)
    if type(event) ~= "table" then return end
    ezbottriggers.handle_bot_created(event.bot_id, event.area_id, event.x, event.y, event.z)
end)

ezbus:on("bot_moved", function(event)
    if type(event) ~= "table" then return end
    ezbottriggers.handle_bot_move(event.bot_id, event.x, event.y, event.z, event.area_id)
end)

ezbus:on("bot_removed", function(event)
    if type(event) ~= "table" then return end
    ezbottriggers.handle_bot_removed(event.bot_id)
end)

logger:info("[ezbottriggers] Loaded")
return ezbottriggers