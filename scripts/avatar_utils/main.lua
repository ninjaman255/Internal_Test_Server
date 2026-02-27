-- NaviSpot.lua
-- Module to cache player avatar and mugshot assets locally on avatar change.
-- Exports functions to retrieve cached paths.

local avatar_utils = require('scripts/avatar_utils/avatar_utils')

-- Cache structure: cache[player_secret] = {
--   sheet = { texture = path, animation = path },
--   mug   = { texture = path, animation = path }
-- }
local cache = {}
local handler_registered = false

local function get_player_secret(player_id)
    -- Retrieve the player's unique safe secret
    return Net.get_player_secret(player_id)
end

--- Copies the player's current avatar and mugshot to local files and registers them as assets.
--- @param player_id string
--- @return table|nil cached entry or nil on failure
local function update_player_avatar(player_id)
    local secret = get_player_secret(player_id)
    if not secret then
        print("NaviSpot: Failed to get secret for player", player_id)
        return nil
    end

    -- Define local paths
    local sheet_texture_path   = "assets/avatars/sheet/" .. secret .. ".png"
    local sheet_animation_path = "assets/avatars/sheet/" .. secret .. ".animation"
    local mug_texture_path     = "assets/avatars/mug/" .. secret .. ".png"
    local mug_animation_path   = "assets/avatars/mug/" .. secret .. ".animation"

    -- Copy both avatar and mugshot using the utility function
    local success = avatar_utils.copy_player_avatar_to(
        player_id,
        sheet_texture_path,
        sheet_animation_path,
        mug_texture_path,
        mug_animation_path
    )

    if not success then
        print("NaviSpot: Failed to copy avatar for player", player_id)
        return nil
    end

    -- Store in cache
    local entry = {
        sheet = {
            texture = sheet_texture_path,
            animation = sheet_animation_path
        },
        mug = {
            texture = mug_texture_path,
            animation = mug_animation_path
        }
    }
    cache[secret] = entry
    return entry
end

-- Register the avatar change handler only once
if not handler_registered then
    Net:on("player_avatar_change", function(event)
        -- event contains: player_id, texture_path, animation_path, name, element, max_health, prevent_default
        -- We ignore the provided paths and always fetch the latest full set
        update_player_avatar(event.player_id)
    end)
    handler_registered = true
end

--- Public API: retrieve cached avatar paths for a given player secret.
--- @param secret string the player's secret (from Net.get_player_secret)
--- @return table|nil the cached sheet/mug paths or nil if not yet cached
local function get_player_avatar_paths(secret)

    return cache[secret]
end

--- Public API: force an immediate refresh for a player ID (useful if you need the data right away).
--- @param player_id string
--- @return table|nil the updated cached entry
local function refresh_player_avatar(player_id)
    return update_player_avatar(player_id)
end

-- Return the public interface
return {
    get_player_avatar_paths = get_player_avatar_paths,
    refresh_player_avatar = refresh_player_avatar,
    -- For debugging/inspection
    _cache = cache
}