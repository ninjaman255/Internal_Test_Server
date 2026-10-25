--[[
avatar_registry.lua

Thin stateful wrapper over avatar_utils.copy_player_avatar_to that:
  * Copies a player's avatar + mugshot into a directory of your choosing.
  * Registers the resulting files as engine assets (via copy_player_avatar_to).
  * Remembers the resulting /server/... paths so any caller can look them up
    by player_id without re-doing any I/O.

Typical use:

    local AvatarRegistry = require("scripts/avatar_utils/avatar_registry")

    -- Copy once.
    local entry = AvatarRegistry.get_or_copy(player_id)
    -- entry.texture_path       -> "/server/assets/avatars/<id>/player.png"
    -- entry.animation_path     -> "/server/assets/avatars/<id>/player.animation"
    -- entry.mug_texture_path   -> "/server/assets/avatars/<id>/player_mug.png"
    -- entry.mug_animation_path -> "/server/assets/avatars/<id>/player_mug.animation"

    -- Anywhere else, retrieve without I/O:
    local tex, anim, mug_tex, mug_anim = AvatarRegistry.get_paths(player_id)

    -- Handy for Net.create_bot(...) and friends:
    local bot = AvatarRegistry.get_bot_def(player_id, {
        animation = "IDLE_DR",
        x = 10, y = 10, z = 0,
        area_id = area_id,
    })

    -- Clean up when you're done:
    AvatarRegistry.remove(player_id, { delete_files = true })

Caveats:
  * Calling copy() again for the same player with a *different* base_dir
    leaves the old files on disk and their old assets registered. Call
    remove() first if you care.
  * Two different players must not share a base_dir. The default does the
    right thing (per-player subdirectory); only override base_dir if you
    know what you're doing.

Optional self-management: uncomment the block at the very bottom of this
file to auto-clean on player_disconnect.
]]

local avatar_utils = require("scripts/avatar_utils/avatar_utils")

local AvatarRegistry = {}

local DEFAULT_BASE = "assets/avatars"

local FILE_NAMES = {
    texture       = "player.png",
    animation     = "player.animation",
    mug_texture   = "player_mug.png",
    mug_animation = "player_mug.animation",
}

-- player_id -> entry  (see AvatarRegistry.copy for the shape)
local registry = {}

local PATH_KEYS = {
    "texture_path", "animation_path", "mug_texture_path", "mug_animation_path",
}

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

local function sanitize(s)
    return (tostring(s or ""):gsub("[^%w_%-]", "_"))
end

local function join_path(a, b)
    a = tostring(a or "")
    b = tostring(b or "")
    if a == "" then return b end
    if b == "" then return a end
    return (a:gsub("/+$", "") .. "/" .. b:gsub("^/+", ""))
end

local function default_base_dir(player_id)
    return join_path(DEFAULT_BASE, sanitize(player_id))
end

--- @return table<string, string>  # disk paths, WITHOUT the /server/ prefix
local function build_disk_paths(base_dir)
    return {
        texture       = join_path(base_dir, FILE_NAMES.texture),
        animation     = join_path(base_dir, FILE_NAMES.animation),
        mug_texture   = join_path(base_dir, FILE_NAMES.mug_texture),
        mug_animation = join_path(base_dir, FILE_NAMES.mug_animation),
    }
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

--- Copy a player's avatar + mugshot to disk and register them as assets.
--- @param player_id string
--- @param base_dir  string|nil  Directory to write into, WITHOUT the /server/
---                              prefix. Defaults to
---                              "assets/avatars/<sanitized-player-id>".
--- @return table|nil entry
--- @return string|nil err
function AvatarRegistry.copy(player_id, base_dir)
    if not player_id then
        return nil, "player_id is required"
    end

    base_dir = base_dir or default_base_dir(player_id)
    local p = build_disk_paths(base_dir)

    local ok = avatar_utils.copy_player_avatar_to(
        player_id,
        p.texture,
        p.animation,
        p.mug_texture,
        p.mug_animation
    )
    if not ok then
        return nil, "copy_player_avatar_to failed"
    end

    local entry = {
        player_id          = player_id,
        base_dir           = base_dir,

        -- Public paths: with /server/ prefix, ready to pass to Net APIs
        -- (create_bot, draw_sprite, message_player, etc.).
        texture_path       = "/server/" .. p.texture,
        animation_path     = "/server/" .. p.animation,
        mug_texture_path   = "/server/" .. p.mug_texture,
        mug_animation_path = "/server/" .. p.mug_animation,
    }

    -- Soft verification: if Net.has_asset is available, warn (don't fail) if
    -- the engine hasn't reflected the registrations yet. Some engines may
    -- lag visibility by a tick; copy is still considered successful.
    local ok_verify, err_verify = pcall(function()
        for _, key in ipairs(PATH_KEYS) do
            assert(Net.has_asset(entry[key]),
                "asset not registered after copy: " .. entry[key])
        end
    end)
    if not ok_verify then
        print("[AvatarRegistry] warning: " .. tostring(err_verify))
    end

    registry[player_id] = entry
    return entry
end

--- Look up a previously copied entry with no I/O.
--- @param player_id string
--- @return table|nil
function AvatarRegistry.get(player_id)
    return registry[player_id]
end

--- Return an existing entry, or copy() one if it's missing.
--- @param player_id string
--- @param base_dir  string|nil
--- @return table|nil
function AvatarRegistry.get_or_copy(player_id, base_dir)
    return registry[player_id] or AvatarRegistry.copy(player_id, base_dir)
end

--- @param player_id string
--- @return boolean
function AvatarRegistry.has(player_id)
    return registry[player_id] ~= nil
end

--- Multi-return convenience for callers that only want the paths.
--- @param player_id string
--- @return string|nil texture
--- @return string|nil animation
--- @return string|nil mug_texture
--- @return string|nil mug_animation
function AvatarRegistry.get_paths(player_id)
    local e = registry[player_id]
    if not e then return nil end
    return e.texture_path, e.animation_path, e.mug_texture_path, e.mug_animation_path
end

--- Build a Net.create_bot-style parameter table from a cached avatar.
--- Any extra keys in `overrides` are applied on top (name, x, y, z, etc.).
--- @param player_id string
--- @param overrides table|nil
--- @return table|nil
function AvatarRegistry.get_bot_def(player_id, overrides)
    local e = registry[player_id]
    if not e then return nil end

    local def = {
        texture_path   = e.texture_path,
        animation_path = e.animation_path,
    }
    if overrides then
        for k, v in pairs(overrides) do def[k] = v end
    end
    return def
end

--- Remove a player's avatar entry.
--- @param player_id string
--- @param opts table|nil
---   opts.remove_assets (default true)  – call Net.remove_asset for each path
---   opts.delete_files  (default false) – also os.remove() the four files
--- @return boolean removed
function AvatarRegistry.remove(player_id, opts)
    opts = opts or {}
    local e = registry[player_id]
    if not e then return false end

    if opts.remove_assets ~= false then
        for _, key in ipairs(PATH_KEYS) do
            local asset_path = e[key]
            pcall(function()
                if not Net.has_asset or Net.has_asset(asset_path) then
                    Net.remove_asset(asset_path)
                end
            end)
        end
    end

    if opts.delete_files then
        local disk = build_disk_paths(e.base_dir)
        for _, path in pairs(disk) do
            pcall(os.remove, path)
        end
    end

    registry[player_id] = nil
    return true
end

--- Remove every cached entry. Options are forwarded to remove().
function AvatarRegistry.clear(opts)
    for pid in pairs(registry) do
        AvatarRegistry.remove(pid, opts)
    end
end

--- Snapshot of the registry (shallow copy).
--- @return table<player_id, entry>
function AvatarRegistry.list()
    local out = {}
    for pid, e in pairs(registry) do out[pid] = e end
    return out
end

-- ---------------------------------------------------------------------------
-- Optional self-management: auto-clean on disconnect.
-- Uncomment if you want the registry to tear itself down.
-- ---------------------------------------------------------------------------
-- Net:on("player_disconnect", function(event)
--     AvatarRegistry.remove(event.player_id, { delete_files = true })
-- end)

return AvatarRegistry