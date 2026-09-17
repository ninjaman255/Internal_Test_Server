-- scripts/net-games/ui-safe.lua
-- Small hardened sprite helper for reusable net-games UI.
-- Public coordinates are virtual 240x160 coordinates.
--
-- Production lessons captured here:
--   * arbitrary assets are checked before provide_asset_for_player when possible;
--   * changing a texture/animation allocates a fresh physical sprite id to avoid
--     stale client-side texture caching;
--   * positions are pixel-snapped by default;
--   * unchanged draws are not retransmitted;
--   * all owned sprites are cleaned on disconnect.

local UISafe = {}

local players = {}
local generation = 0

local function player_state(player_id)
    players[player_id] = players[player_id] or {}
    return players[player_id]
end

local function confirmed_missing(path)
    if not path or path == "" then return true end
    if not Net.has_asset then return false end
    local ok, exists = pcall(Net.has_asset, path)
    return ok and exists == false
end

function UISafe.asset_exists(path)
    return not confirmed_missing(path)
end

function UISafe.safe_provide(player_id, path)
    if not path or path == "" or confirmed_missing(path) then return false end
    return pcall(Net.provide_asset_for_player, player_id, path)
end

local function same_draw(a, b)
    if not a or not b then return false end
    local keys = {
        "x", "y", "z", "sx", "sy", "r", "g", "b", "opacity", "a",
        "ro", "ox", "oy", "color_mode", "anim_state",
    }
    for _, key in ipairs(keys) do
        if a[key] ~= b[key] then return false end
    end
    return true
end

local function erase_entry(player_id, entry)
    if not entry then return end
    if entry.draw_id then pcall(Net.player_erase_sprite, player_id, entry.draw_id) end
    if entry.sprite_id then pcall(Net.player_dealloc_sprite, player_id, entry.sprite_id) end
end

local function allocate_entry(player_id, logical_id, texture_path, anim_path, anim_state)
    if not UISafe.safe_provide(player_id, texture_path) then return nil end
    if anim_path and anim_path ~= "" and not UISafe.safe_provide(player_id, anim_path) then return nil end

    generation = generation + 1
    local sprite_id = "ngui_asset_" .. tostring(player_id) .. "_" .. tostring(logical_id) .. "_" .. tostring(generation)
    local ok = pcall(Net.player_alloc_sprite, player_id, sprite_id, {
        texture_path = texture_path,
        anim_path = anim_path or "",
        anim_state = anim_state or "",
    })
    if not ok then return nil end

    return {
        logical_id = logical_id,
        draw_id = "ngui_draw_" .. tostring(logical_id),
        sprite_id = sprite_id,
        texture_path = texture_path,
        anim_path = anim_path or "",
        last_draw = nil,
    }
end

local function virtual_to_screen(v, pixel_snap)
    local px = (tonumber(v) or 0) * 2
    if pixel_snap ~= false then return math.floor(px + 0.5) end
    return px
end

function UISafe.draw(player_id, logical_id, texture_path, options)
    options = options or {}
    logical_id = tostring(logical_id)
    local state = player_state(player_id)
    local entry = state[logical_id]
    local anim_path = options.anim_path or options.animation_path or ""

    if entry and (entry.texture_path ~= texture_path or entry.anim_path ~= anim_path) then
        -- A new physical allocation is intentional: some clients retain the old
        -- texture when the same sprite identity is repurposed.
        erase_entry(player_id, entry)
        state[logical_id] = nil
        entry = nil
    end

    if not entry then
        entry = allocate_entry(player_id, logical_id, texture_path, anim_path, options.anim_state)
        if not entry then return false end
        state[logical_id] = entry
    end

    local draw = {
        id = entry.draw_id,
        x = virtual_to_screen(options.x, options.pixel_snap),
        y = virtual_to_screen(options.y, options.pixel_snap),
        z = options.z or 100,
        sx = options.sx or options.scale or 2.0,
        sy = options.sy or options.scale or options.sx or 2.0,
        r = options.r or 255,
        g = options.g or 255,
        b = options.b or 255,
        opacity = options.opacity or 255,
        a = options.a or 255,
        ro = options.ro or 0,
        ox = options.ox,
        oy = options.oy,
        color_mode = options.color_mode or 0,
        anim_state = options.anim_state or "",
    }

    if same_draw(entry.last_draw, draw) then return true, false end

    local ok = pcall(Net.player_draw_sprite, player_id, entry.sprite_id, draw)
    if ok then
        entry.last_draw = draw
        return true, true
    end
    return false
end

function UISafe.erase(player_id, logical_id)
    local state = players[player_id]
    if not state then return false end
    logical_id = tostring(logical_id)
    local entry = state[logical_id]
    if not entry then return false end
    erase_entry(player_id, entry)
    state[logical_id] = nil
    return true
end

function UISafe.cleanup_player(player_id)
    local state = players[player_id]
    if not state then return end
    for _, entry in pairs(state) do erase_entry(player_id, entry) end
    players[player_id] = nil
end

function UISafe.invalidate(player_id, logical_id)
    local state = players[player_id]
    local entry = state and state[tostring(logical_id)]
    if entry then entry.last_draw = nil end
end

Net:on("player_disconnect", function(event)
    if event and event.player_id then UISafe.cleanup_player(event.player_id) end
end)

return UISafe
