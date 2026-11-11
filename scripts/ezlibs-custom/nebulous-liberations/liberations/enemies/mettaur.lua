-- Mettaur overworld template and directional shockwave AI.
-- Registered by enemy_templates.lua after its shared AI helpers are defined.
-- No separate enemy constructor: EnemyTemplates.create handles instance lifecycle.
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local GuardInterception = require("scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local Direction = require("scripts/libs/direction")

return function(EnemyTemplates)
-- Mettaur's overworld shockwave attack. This uses the Liberation selection
-- system, not the client-side Mettaur battle mod. The selection is a straight
-- three-tile line in the bot's current isometric direction.
-- These overworld sprites use the native 48x56 animation frames and are
-- intentionally NOT resized to BigBrute's previous bot appearance.
local METTAUR_OW_TEXTURE = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/mettaur_ow.png"
local METTAUR_OW_ANIMATION = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/mettaur_ow.animation"
local SHOCKWAVE_TEXTURE = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/shockwave.png"
local SHOCKWAVE_ANIMATION = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/shockwave.animation"
local SHOCKWAVE_DIRECTION = {
    [Direction.UP_LEFT] = { suffix = "UL", dx = -1, dy = 0 },
    [Direction.UP_RIGHT] = { suffix = "UR", dx = 0, dy = -1 },
    [Direction.DOWN_RIGHT] = { suffix = "DR", dx = 1, dy = 0 },
    [Direction.DOWN_LEFT] = { suffix = "DL", dx = 0, dy = 1 },
}
local SHOCKWAVE_RANGE = 3
local SHOCKWAVE_STEP_SECONDS = 0.12
local SHOCKWAVE_FRAME_SECONDS = {0.09, 0.10, 0.11, 0.125, 0.125, 0.13}
-- All four ATTACK_* states in mettaur_ow.animation have eight frames:
-- 0.10 + 0.10 + 0.10 + 0.09 + 0.09 + 0.13 + 0.10 + 0.12 = 0.83s.
-- Allow one small network/frame margin before starting the first shockwave.
-- Keep this value synchronized if those animation frame durations change.
local METTAUR_ATTACK_ANIMATION_SECONDS = 0.83 + 0.05

local function has_terrain_tile(instance, x, y, z)
    -- Net.get_tile can fail outside the map, so guard against the end of a
    -- straight line reaching the map boundary.
    local ok, tile = pcall(Net.get_tile, instance.area_id, x, y, z)
    return ok and type(tile) == "table" and type(tile.gid) == "number" and tile.gid > 0
end

-- A shockwave is one straight three-tile ray in the direction the Mettaur
-- faces. The normal enemy turn loop calls this once; no client battle AI is
-- involved. First try to align with the target by moving to a nearby valid
-- enemy-owned panel, then always play the attack (a miss still has visuals).
local function aligned_shockwave_direction(x, y, target_x, target_y)
    local dx, dy = target_x - x, target_y - y
    if dx == 0 and dy < 0 and -dy <= SHOCKWAVE_RANGE then
        return Direction.UP_RIGHT, -dy
    elseif dx == 0 and dy > 0 and dy <= SHOCKWAVE_RANGE then
        return Direction.DOWN_LEFT, dy
    elseif dy == 0 and dx < 0 and -dx <= SHOCKWAVE_RANGE then
        return Direction.UP_LEFT, -dx
    elseif dy == 0 and dx > 0 and dx <= SHOCKWAVE_RANGE then
        return Direction.DOWN_RIGHT, dx
    end
    return nil, nil
end

local function find_shockwave_firing_position(self, target)
    local tx = math.floor(target.x)
    local ty = math.floor(target.y)
    local best, best_score

    -- Reposition by at most two tiles per turn. EnemyHelpers.move already
    -- handles teleport animation and enemy bot facing/scale restoration.
    for offset_y = -2, 2 do
        for offset_x = -2, 2 do
            local x = self.x + offset_x
            local y = self.y + offset_y
            local direction, distance = aligned_shockwave_direction(x, y, tx, ty)
            if direction then
                local movable = (offset_x == 0 and offset_y == 0)
                    or EnemyHelpers.can_move_to(self.instance, x, y, self.z, self)
                if movable then
                    local travel = SHOCKWAVE_DIRECTION[direction]
                    local clear = true
                    for step = 1, distance do
                        if not has_terrain_tile(self.instance,
                            x + travel.dx * step, y + travel.dy * step, self.z) then
                            clear = false
                            break
                        end
                    end
                    if clear then
                        local travel_distance = math.abs(offset_x) + math.abs(offset_y)
                        local score = travel_distance * 10 + distance
                        if best_score == nil or score < best_score then
                            best = { x = x, y = y, direction = direction }
                            best_score = score
                        end
                    end
                end
            end
        end
    end
    return best
end

function EnemyTemplates.ai.shockwave_line(self)
    local co = coroutine.create(function()
        local closest = EnemyHelpers.find_closest_player_session(self.instance, self)
        if not closest or not closest.player then return end
        local target = closest.player
        local firing_position = find_shockwave_firing_position(self, target)

        if firing_position and
            (firing_position.x ~= self.x or firing_position.y ~= self.y) then
            Async.await(EnemyHelpers.move(self.instance, self,
                firing_position.x, firing_position.y, self.z,
                firing_position.direction))
        end

        -- If an aligned firing position exists, use that exact axis. When
        -- no such position is reachable, launch toward the nearest player
        -- anyway: don't silently skip the turn just because the player is
        -- outside the three-tile hitbox.
        local direction
        if firing_position then
            direction = firing_position.direction
            Net.set_bot_direction(self.id, direction)
        else
            EnemyHelpers.face_position(self, target.x, target.y)
            direction = Net.get_bot_direction(self.id)
        end
        local travel = SHOCKWAVE_DIRECTION[direction]
        if not travel then return end
        self.direction = direction
        self.selection:move(self, direction)

        self.selection:indicate()
        Async.await(Async.sleep(0.5))

        local caught_sessions = self.selection:detect_player_sessions()
        EnemyHelpers.play_attack_animation(self)
        -- Net.animate_bot initiates the animation without awaiting its frames.
        -- Complete Mettaur's entire directional pickaxe swing before spawning
        -- shockwaves. The attack remains within the same enemy turn.
        Async.await(Async.sleep(METTAUR_ATTACK_ANIMATION_SECONDS))

        -- Start Guard interception when the shockwave begins, not at the start
        -- of the wind-up; otherwise the Guard can return before impact.
        local records = nil
        if #caught_sessions > 0 then
            records = GuardInterception.prepare_attack(
                self.instance, self, caught_sessions,
                SHOCKWAVE_RANGE * SHOCKWAVE_STEP_SECONDS)
        end

        local spawned_bots = {}
        for distance = 1, SHOCKWAVE_RANGE do
            local x = self.x + travel.dx * distance
            local y = self.y + travel.dy * distance
            if not has_terrain_tile(self.instance, x, y, self.z) then
                break
            end
            local bot_id = Net.create_bot({
                texture_path = SHOCKWAVE_TEXTURE,
                animation_path = SHOCKWAVE_ANIMATION,
                animation = "SHOCKWAVE_" .. travel.suffix,
                direction = direction,
                area_id = self.instance.area_id,
                warp_in = false,
                x = x + 0.5,
                y = y + 0.5,
                z = self.z,
            })
            if bot_id then
                spawned_bots[#spawned_bots + 1] = bot_id
            end
            Async.await(Async.sleep(SHOCKWAVE_STEP_SECONDS))
        end

        if records then
            GuardInterception.apply_damage(records, self.attack_damage or 20, self)
            GuardInterception.finish_attack(self.instance, records)
        end

        local remaining = 0
        for _, duration in ipairs(SHOCKWAVE_FRAME_SECONDS) do
            remaining = remaining + duration
        end
        Async.await(Async.sleep(remaining))
        for _, bot_id in ipairs(spawned_bots) do
            Net.remove_bot(bot_id, false)
        end
        self.selection:remove_indicators()
    end)
    return Async.promisify(co)
end

-- Register the assets before an instance clones/preloads its area. This is
-- deliberately done at module load, rather than only when Mettaur spawns.
Preloader.add_asset(SHOCKWAVE_TEXTURE)
Preloader.add_asset(SHOCKWAVE_ANIMATION)
-- Registration occurs before instances clone their areas; supplying both
-- files here lets the OW bot use its new skin immediately on spawn.
Preloader.add_asset(METTAUR_OW_TEXTURE)
Preloader.add_asset(METTAUR_OW_ANIMATION)

EnemyTemplates.register("Mettaur", {
    battle_name = "Mettaur",
    default_ow_bot_encounter_name = "Mettaur",
    is_special_encounter = true,
    -- Matches the registered V1 Mettaur character mod's base health.
    health = 40,
    max_health = 40,
    -- Native-resolution Mettaur overworld sheet (four directional idle/attack
    -- states). The client-side battle character is configured separately.
    texture_path = METTAUR_OW_TEXTURE,
    animation_path = METTAUR_OW_ANIMATION,
    ai_type = "shockwave_line",
    attack_damage = 20,
    attack_texture = SHOCKWAVE_TEXTURE,
    attack_animation_path = SHOCKWAVE_ANIMATION,
    -- 1x3 unbroken line forward. The Selection module rotates it for each
    -- of UL, UR, DR and DL; this is not a square/AOE attack.
    shape = { {1}, {1}, {1} },
    shape_offset_x = 0,
    shape_offset_y = 0,
})


end
