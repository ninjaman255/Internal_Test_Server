local helpers = require('scripts/ezlibs-scripts/helpers')
local object_registry = require('scripts/ezlibs-scripts/object_registry')

local eztriggers = {}

-- Geometry diagnostics are disabled in normal operation.
local DEBUG_BUTTON_TRIGGER_GEOMETRY = false

local function is_button_trigger(trigger_info)
    return trigger_info and type(trigger_info.id) == "string"
        and string.sub(trigger_info.id, 1, 7) == "button_"
end

eztriggers.interact_triggers = {}
eztriggers.radius_triggers = {}
eztriggers.rectangle_triggers = {}
eztriggers._event_table = {}

function eztriggers.add_location_event_trigger(area_id,object)
    local event_name = object.custom_properties["Event Name"]
    local emitter

    local trigger_name = "unnamed"
    if object.name and string.len(object.name) > 0 then
        trigger_name = object.name
    end

    print("[eztriggers] Configuring ("..trigger_name..") Location Trigger ↴")

    if object.data then
        local collision_shape_type = object.data.type
        if collision_shape_type == "ellipse" then
            emitter = eztriggers.add_radius_trigger(area_id, object, object.width, object.height, object.width/2,object.height/2)
        elseif collision_shape_type == "rect" then
            emitter = eztriggers.add_rectangle_trigger(area_id, object, object.width, object.height)
        else
            -- no satisfied condition
            warn("[eztriggers] No collision shape supported: "..collision_shape_type)
        end
    else
        warn("[eztriggers] Location trigger is missing collision data.")
    end
    
    if emitter then
        print("[eztriggers]"..object.data.type.." trigger added (width="..object.width..", height="..object.height..")")
        local extra_str = "."
        if event_name then
            --If the trigger had an event name, add a handler for activating that event
            emitter:on("entered",function (event_info)
                local event = eztriggers._event_table[event_name]
                if event then
                    local lock = helpers.get_lock(event_info.player_id, event_info.player_id..":"..event_name)
                    if lock then
                        event.action(event_info.player_id,event_info.object).and_then(function()
                            lock.release()
                        end)
                    end
                end
            end)
            print("[eztriggers] Successfully added Location Trigger "..trigger_name.." for event: "..event_name)
        else
            warn("[eztriggers] added Location Trigger "..trigger_name.." however no Event Name has been specifed")
        end
    end
end

function eztriggers.add_interact_trigger(area_id,trigger_object)
    if not trigger_object then
        return nil
    end
    if not eztriggers.interact_triggers[area_id] then
        eztriggers.interact_triggers[area_id] = {}
    end
    if not eztriggers.interact_triggers[area_id][trigger_object.id] then
        local emitter = Net.EventEmitter.new()
        eztriggers.interact_triggers[area_id][trigger_object.id] = {object=trigger_object,emitter=emitter}
        return emitter
    else
        warn("[eztriggers] "..trigger_object.id.." is already registered as a interact trigger")
    end
end

function eztriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)
    if not trigger_object or area_id == nil or trigger_object.id == nil then
        warn("[eztriggers] Cannot register ellipse trigger without area and object IDs")
        return nil
    end

    if not eztriggers.radius_triggers[area_id] then
        eztriggers.radius_triggers[area_id] = {}
    end

    -- A trigger's registry key may differ from its source object's ID. This is
    -- needed when multiple buttons intentionally use the same Tiled trigger
    -- object: each button receives its own emitter and overlap state.
    local trigger_key = trigger_id or trigger_object.id
    if eztriggers.radius_triggers[area_id][trigger_key] then
        warn("[eztriggers] Trigger key " .. tostring(trigger_key) .. " is already registered as an ellipse trigger in area " .. tostring(area_id))
        return nil
    end

    local width = tonumber(diameter_x)
    local height = tonumber(diameter_y)
    local object_x = tonumber(trigger_object.x)
    local object_y = tonumber(trigger_object.y)
    center_x = tonumber(center_x)
    center_y = tonumber(center_y)

    if not width or not height or not object_x or not object_y or not center_x or not center_y then
        warn("[eztriggers] Invalid ellipse trigger geometry for object " .. tostring(trigger_object.id))
        return nil
    end

    local emitter = Net.EventEmitter.new()
    local trigger_info = {
        id = trigger_key,
        object = trigger_object,
        emitter = emitter,
        overlapping_players = {},
        radius_x = width / 2,
        radius_y = height / 2,
        center_x = object_x + center_x,
        center_y = object_y + center_y
    }
    eztriggers.radius_triggers[area_id][trigger_key] = trigger_info
    if DEBUG_BUTTON_TRIGGER_GEOMETRY and is_button_trigger(trigger_info) then
        print(string.format(
            "[eztriggers][geometry][REGISTER][ELLIPSE] area=%s trigger_id=%s source_object_id=%s source_x=%s source_y=%s source_z=%s raw_width=%s raw_height=%s center_offset_x=%s center_offset_y=%s center_x=%s center_y=%s radius_x=%s radius_y=%s bounds=[%s,%s]-[%s,%s]",
            tostring(area_id), tostring(trigger_key), tostring(trigger_object.id),
            tostring(trigger_object.x), tostring(trigger_object.y), tostring(trigger_object.z),
            tostring(diameter_x), tostring(diameter_y), tostring(center_x), tostring(center_y),
            tostring(trigger_info.center_x), tostring(trigger_info.center_y),
            tostring(trigger_info.radius_x), tostring(trigger_info.radius_y),
            tostring(trigger_info.center_x - trigger_info.radius_x),
            tostring(trigger_info.center_y - trigger_info.radius_y),
            tostring(trigger_info.center_x + trigger_info.radius_x),
            tostring(trigger_info.center_y + trigger_info.radius_y)))
    end
    return emitter
end

function eztriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)
    if not trigger_object or area_id == nil or trigger_object.id == nil then
        warn("[eztriggers] Cannot register rectangle trigger without area and object IDs")
        return nil
    end

    if not eztriggers.rectangle_triggers[area_id] then
        eztriggers.rectangle_triggers[area_id] = {}
    end

    -- Use the optional runtime ID as the registry key so separate consumers
    -- can register independent emitters against the same source object.
    local trigger_key = trigger_id or trigger_object.id
    if eztriggers.rectangle_triggers[area_id][trigger_key] then
        warn("[eztriggers] Trigger key " .. tostring(trigger_key) .. " is already registered as a rectangle trigger in area " .. tostring(area_id))
        return nil
    end

    local object_x = tonumber(trigger_object.x)
    local object_y = tonumber(trigger_object.y)
    local trigger_width = tonumber(width) or tonumber(trigger_object.width)
    local trigger_height = tonumber(height) or tonumber(trigger_object.height)
    if not object_x or not object_y or not trigger_width or not trigger_height
        or trigger_width < 0 or trigger_height < 0 then
        warn("[eztriggers] Invalid rectangle trigger geometry for object " .. tostring(trigger_object.id))
        return nil
    end

    local emitter = Net.EventEmitter.new()
    local trigger_info = {
        id = trigger_key,
        object = trigger_object,
        emitter = emitter,
        overlapping_players = {},
        width = trigger_width,
        height = trigger_height
    }
    eztriggers.rectangle_triggers[area_id][trigger_key] = trigger_info
    if DEBUG_BUTTON_TRIGGER_GEOMETRY and is_button_trigger(trigger_info) then
        print(string.format(
            "[eztriggers][geometry][REGISTER][RECTANGLE] area=%s trigger_id=%s source_object_id=%s source_x=%s source_y=%s source_z=%s source_width=%s source_height=%s registered_width=%s registered_height=%s bounds=[%s,%s]-[%s,%s]",
            tostring(area_id), tostring(trigger_key), tostring(trigger_object.id),
            tostring(trigger_object.x), tostring(trigger_object.y), tostring(trigger_object.z),
            tostring(trigger_object.width), tostring(trigger_object.height),
            tostring(trigger_info.width), tostring(trigger_info.height),
            tostring(object_x), tostring(object_y),
            tostring(object_x + trigger_info.width), tostring(object_y + trigger_info.height)))
    end
    return emitter
end

function eztriggers.handle_object_interaction(player_id,object_id,button)
    --check interact triggers
    local player_area = Net.get_player_area(player_id)
    if not eztriggers.interact_triggers[player_area] then 
        return 
    end
    for trigger_id, trigger_info in pairs(eztriggers.interact_triggers[player_area]) do
        if object_id == trigger_id then
            trigger_info.emitter:emit("interaction",{player_id=player_id,object=trigger_info.object,button=button})
        end
    end
end


-- Emit a transition only when the player's recorded overlap state changes.
-- Update the overlap table before emitting so re-entrant listeners cannot
-- observe the old state or cause duplicate transitions.
local function set_player_overlap(trigger_info, player_id, is_inside, reason)
    if not trigger_info or player_id == nil then
        return false
    end

    local was_inside = trigger_info.overlapping_players[player_id] == true
    if was_inside == is_inside then
        return false
    end

    if is_inside then
        trigger_info.overlapping_players[player_id] = true
        trigger_info.emitter:emit("entered", {
            player_id = player_id,
            object = trigger_info.object,
            reason = reason
        })
    else
        trigger_info.overlapping_players[player_id] = nil
        trigger_info.emitter:emit("departed", {
            player_id = player_id,
            object = trigger_info.object,
            reason = reason
        })
    end

    return true
end

eztriggers.handle_player_move = function(player_id, x, y, z)
    if player_id == nil or type(x) ~= "number" or type(y) ~= "number" then
        return
    end

    local player_area_id = Net.get_player_area(player_id)
    if not player_area_id then
        -- If the engine no longer reports an area, clear any stale occupancy.
        eztriggers.clear_radius_overlaps_for_player(player_id, "area_unavailable")
        eztriggers.clear_rectangle_overlaps_for_player(player_id, "area_unavailable")
        return
    end

    local area_radius_triggers = eztriggers.radius_triggers[player_area_id]
    if area_radius_triggers ~= nil then
        for _, trigger_info in pairs(area_radius_triggers) do
            local trigger_z = trigger_info.object.z or 0
            if trigger_z ~= z then
                set_player_overlap(trigger_info, player_id, false, "height_changed")
            else
                local rad_x = trigger_info.radius_x
                local rad_y = trigger_info.radius_y
                if type(rad_x) == "number" and type(rad_y) == "number" and rad_x > 0 and rad_y > 0 then
                    local dx = x - trigger_info.center_x
                    local dy = y - trigger_info.center_y
                    local axis_1 = (dx * dx) / (rad_x * rad_x)
                    local axis_2 = (dy * dy) / (rad_y * rad_y)
                    local inside_ellipse = (axis_1 + axis_2) <= 1.0
                    if DEBUG_BUTTON_TRIGGER_GEOMETRY and is_button_trigger(trigger_info) then
                        print(string.format(
                            "[eztriggers][geometry][CHECK][ELLIPSE] player=%s area=%s trigger_id=%s player_xyz=(%s,%s,%s) center=(%s,%s) radii=(%s,%s) normalized_distance=%s inside=%s trigger_z=%s",
                            tostring(player_id), tostring(player_area_id), tostring(trigger_info.id),
                            tostring(x), tostring(y), tostring(z), tostring(trigger_info.center_x),
                            tostring(trigger_info.center_y), tostring(rad_x), tostring(rad_y),
                            tostring(axis_1 + axis_2), tostring(inside_ellipse), tostring(trigger_z)))
                    end
                    set_player_overlap(trigger_info, player_id, inside_ellipse, "movement")
                else
                    -- Invalid/zero-sized triggers cannot contain a player.
                    set_player_overlap(trigger_info, player_id, false, "invalid_trigger_size")
                end
            end
        end
    end

    local area_rectangle_triggers = eztriggers.rectangle_triggers[player_area_id]
    if area_rectangle_triggers ~= nil then
        for _, trigger_info in pairs(area_rectangle_triggers) do
            local trigger_z = trigger_info.object.z or 0
            if trigger_z ~= z then
                set_player_overlap(trigger_info, player_id, false, "height_changed")
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

                if DEBUG_BUTTON_TRIGGER_GEOMETRY and is_button_trigger(trigger_info) then
                    print(string.format(
                        "[eztriggers][geometry][CHECK][RECTANGLE] player=%s area=%s trigger_id=%s player_xyz=(%s,%s,%s) source_object_id=%s origin=(%s,%s) size=(%s,%s) bounds=[%s,%s]-[%s,%s] inside=%s trigger_z=%s",
                        tostring(player_id), tostring(player_area_id), tostring(trigger_info.id),
                        tostring(x), tostring(y), tostring(z), tostring(trigger_info.object.id),
                        tostring(obj_x), tostring(obj_y), tostring(obj_w), tostring(obj_h),
                        tostring(obj_x), tostring(obj_y),
                        tostring(obj_x and obj_w and (obj_x + obj_w) or nil),
                        tostring(obj_y and obj_h and (obj_y + obj_h) or nil),
                        tostring(inside_aabb), tostring(trigger_z)))
                end
                set_player_overlap(trigger_info, player_id, inside_aabb, "movement")
            end
        end
    end
end

function eztriggers.add_event(event_object)
    if not (event_object.name and event_object.action) then
        warn('[eztriggers] Cant add invalid event, events need a name and action {}')
        return
    end

    local entry = eztriggers._event_table[event_object.name]

    if entry ~= nil then
        warn("[eztriggers] "..event_object.name.." is already registered as an event")
    else
        eztriggers._event_table[event_object.name] = event_object
    end
end

function eztriggers.clear_radius_overlaps_for_player(player_id, reason)
    for _, area_triggers in pairs(eztriggers.radius_triggers) do
        for _, trigger_info in pairs(area_triggers) do
            set_player_overlap(trigger_info, player_id, false, reason or "cleanup")
        end
    end
end

function eztriggers.clear_rectangle_overlaps_for_player(player_id, reason)
    for _, area_triggers in pairs(eztriggers.rectangle_triggers) do
        for _, trigger_info in pairs(area_triggers) do
            set_player_overlap(trigger_info, player_id, false, reason or "cleanup")
        end
    end
end

function eztriggers.handle_player_transfer(player_id)
    -- A transfer ends occupancy in every trigger in the previous area. Emit
    -- departures before clearing so consumers such as Pressure Plates can
    -- reconcile their state instead of being left active indefinitely.
    eztriggers.clear_radius_overlaps_for_player(player_id, "area_transfer")
    eztriggers.clear_rectangle_overlaps_for_player(player_id, "area_transfer")
end

function eztriggers.handle_player_disconnect(player_id)
    eztriggers.clear_radius_overlaps_for_player(player_id, "disconnect")
    eztriggers.clear_rectangle_overlaps_for_player(player_id, "disconnect")
end

-- Register handler for Location Trigger objects
object_registry.register_handler("Location Trigger", function(area_id, object)
    eztriggers.add_location_event_trigger(area_id, object)
end)

print("[eztriggers] Loaded")
return eztriggers