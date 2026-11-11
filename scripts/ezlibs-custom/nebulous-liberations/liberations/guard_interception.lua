local ezbus = require("scripts/ezlibs-scripts/ezbus")
local Direction = require("scripts/libs/direction")
local SharedLogger = require("scripts/logger/logger")
local log = SharedLogger.register("nebulous-liberations"):register_subsystem("guard-interception")

local GuardInterception = {}
local registered_buses = {}
local GUARD_RANGE_TILES = 2
local APPROACH_DURATION = 0.12
local PUSHBACK_DISTANCE = 0.22
local PUSHBACK_DURATION = 0.10
local RETURN_DURATION = 0.14

local animation_suffix = {
    [Direction.UP_LEFT] = "UL",
    [Direction.UP_RIGHT] = "UR",
    [Direction.DOWN_LEFT] = "DL",
    [Direction.DOWN_RIGHT] = "DR",
}

local function get_position(player)
    if not player then return nil end
    local ok, position = pcall(Net.get_player_position, player.id)
    if not ok or type(position) ~= "table" then return nil end
    if tonumber(position.x) == nil or tonumber(position.y) == nil or tonumber(position.z) == nil then
        return nil
    end
    return { x = tonumber(position.x), y = tonumber(position.y), z = tonumber(position.z) }
end

local function is_guard_session(session)
    return session
        and session.health > 0
        and session.ability
        and session.ability.name == "Guard"
        and session.player
end

local function is_eligible_attacker(attacker)
    return type(attacker) == "table"
        and (attacker.is_boss == true or attacker.is_special_encounter == true)
end

local function face_attacker(guard_player, guard_position, attacker)
    local attacker_x = tonumber(attacker.x)
    local attacker_y = tonumber(attacker.y)
    if attacker_x == nil or attacker_y == nil then return end

    -- Enemy model coordinates are tile-based; bot coordinates are centered.
    local direction = Direction.diagonal_from_offset(
        (attacker_x + 0.5) - guard_position.x,
        (attacker_y + 0.5) - guard_position.y
    )
    local suffix = animation_suffix[direction]
    if suffix then
        pcall(Net.animate_player, guard_player.id, "IDLE_" .. suffix, true)
    end
end

local function animate_interception(instance, guard_session, protected_session, attacker, impact_delay)
    local guard_player = guard_session.player
    local protected_player = protected_session.player
    local guard_start = get_position(guard_player)
    local protected_position = get_position(protected_player)
    if not guard_start or not protected_position then return false end
    if math.floor(guard_start.z) ~= math.floor(protected_position.z) then return false end

    local attacker_x = tonumber(attacker.x)
    local attacker_y = tonumber(attacker.y)
    if attacker_x == nil or attacker_y == nil then return false end
    if tonumber(attacker.z) ~= nil and math.floor(attacker.z) ~= math.floor(protected_position.z) then
        return false
    end

    local dx = protected_position.x - (attacker_x + 0.5)
    local dy = protected_position.y - (attacker_y + 0.5)
    local length = math.sqrt(dx * dx + dy * dy)
    if length < 0.001 then return false end
    dx, dy = dx / length, dy / length

    -- The guard occupies the protected player's position during the attack,
    -- then recoils slightly away from the attacker before returning.
    local push_x = protected_position.x + dx * PUSHBACK_DISTANCE
    local push_y = protected_position.y + dy * PUSHBACK_DISTANCE
    local hold_duration = math.max(0, (tonumber(impact_delay) or 0.5) - APPROACH_DURATION)
    local keyframes = {
        {
            properties = {
                { property = "X", value = guard_start.x, ease = "Linear" },
                { property = "Y", value = guard_start.y, ease = "Linear" },
                { property = "Z", value = guard_start.z, ease = "Linear" },
            },
            duration = 0,
        },
        {
            properties = {
                { property = "X", value = protected_position.x, ease = "Linear" },
                { property = "Y", value = protected_position.y, ease = "Linear" },
                { property = "Z", value = protected_position.z, ease = "Linear" },
            },
            duration = APPROACH_DURATION,
        },
        {
            properties = {
                { property = "X", value = protected_position.x, ease = "Linear" },
                { property = "Y", value = protected_position.y, ease = "Linear" },
                { property = "Z", value = protected_position.z, ease = "Linear" },
            },
            duration = hold_duration,
        },
        {
            properties = {
                { property = "X", value = push_x, ease = "Linear" },
                { property = "Y", value = push_y, ease = "Linear" },
                { property = "Z", value = protected_position.z, ease = "Linear" },
            },
            duration = PUSHBACK_DURATION,
        },
        {
            properties = {
                { property = "X", value = guard_start.x, ease = "Linear" },
                { property = "Y", value = guard_start.y, ease = "Linear" },
                { property = "Z", value = guard_start.z, ease = "Linear" },
            },
            duration = RETURN_DURATION,
        },
    }

    local ok, result = pcall(Net.animate_player_properties, guard_player.id, keyframes)
    if not ok or result == false then
        log:warn_data("Guard interception animation failed", {
            instance_area_id = instance.area_id,
            guard_player_id = guard_player.id,
            protected_player_id = protected_player.id,
            error = tostring(result),
        })
        return false
    end

    face_attacker(guard_player, protected_position, attacker)
    return true
end

local function build_attack_records(event)
    local instance = event.instance
    local attacker = event.attacker
    local target_sessions = event.target_sessions or {}
    local records, used_guards = {}, {}

    for _, target_session in ipairs(target_sessions) do
        local target_player = target_session and target_session.player
        local target_position = get_position(target_player)
        local damage_session = target_session
        local redirected = false

        if target_position and is_eligible_attacker(attacker) then
            for _, guard_session in pairs(instance.player_sessions or {}) do
                if guard_session ~= target_session and is_guard_session(guard_session) then
                    local guard_position = get_position(guard_session.player)
                    if guard_position and math.floor(guard_position.z) == math.floor(target_position.z) then
                        local dist_x = math.abs(math.floor(guard_position.x) - math.floor(target_position.x))
                        local dist_y = math.abs(math.floor(guard_position.y) - math.floor(target_position.y))
                        if math.max(dist_x, dist_y) <= GUARD_RANGE_TILES
                            and not used_guards[guard_session.player.id] then
                            local moved = animate_interception(
                                instance, guard_session, target_session, attacker, event.impact_delay
                            )
                            if moved then
                                damage_session = guard_session
                                redirected = true
                                used_guards[guard_session.player.id] = true
                                ezbus:emit("liberation_guard_interception_started", {
                                    instance_area_id = instance.area_id,
                                    attacker_id = attacker.id,
                                    guard_player_id = guard_session.player.id,
                                    protected_player_id = target_player.id,
                                    impact_delay = event.impact_delay,
                                })
                            end
                            break
                        end
                    end
                end
            end
        end

        records[#records + 1] = {
            damage_session = damage_session,
            redirected = redirected,
            visual_position = target_position,
            original_session = target_session,
        }
    end

    return records
end

local function get_instance_bus(instance)
    local name = "nebulous-liberations:guard:" .. tostring(instance.area_id)
    local bus = ezbus.get(name)
    if not registered_buses[name] then
        registered_buses[name] = true
        bus:on("prepare_attack", function(event)
            event.records = build_attack_records(event)
        end)
    end
    return bus
end

function GuardInterception.prepare_attack(instance, attacker, target_sessions, impact_delay)
    local event = {
        instance = instance,
        attacker = attacker,
        target_sessions = target_sessions or {},
        impact_delay = impact_delay or 0.5,
        records = {},
    }
    get_instance_bus(instance):emit("prepare_attack", event)
    return event.records
end

function GuardInterception.apply_damage(records, amount, attacker)
    local damaged = {}
    for _, record in ipairs(records or {}) do
        local session = record.damage_session
        if session and not damaged[session.player.id] then
            damaged[session.player.id] = true
            -- Apply the hit to the selected physical target through the normal
            -- hurt path. Guard protection is intentionally NOT bypassed here:
            -- if the intercepting player also has Guard (or is protected by a
            -- teammate with Guard), that player must be protected from this hit
            -- as well. PlayerSession:hurt only blocks damage; it does not start
            -- another interception, so this cannot bounce the hit between players.
            local multiplier = attacker and tonumber(attacker.ow_damage_multiplier) or 1
            if multiplier <= 0 or multiplier ~= multiplier or multiplier == math.huge then multiplier = 1 end
            local damage = math.max(0, math.floor((tonumber(amount) or 0) * multiplier + 0.5))
            session:hurt(damage, attacker)
        end
    end
end

function GuardInterception.finish_attack(instance, records)
    ezbus:emit("liberation_guard_interception_impact", {
        instance_area_id = instance.area_id,
        interceptions = records or {},
    })
end

return GuardInterception
