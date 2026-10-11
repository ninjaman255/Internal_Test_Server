-- panel_registry.lua
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")

local PanelRegistry = {}

-- Registry tables
PanelRegistry.by_type = {}          -- type -> definition
PanelRegistry.gid_to_type = {}       -- gid -> type
PanelRegistry.type_gids = {}         -- type -> list of gids

-- Register a panel type
function PanelRegistry.register(type_name, definition)
    definition = definition or {}
    definition.type = type_name

    local registered = PanelRegistry.by_type[type_name]
    if not registered then
        registered = { type = type_name, gids = {} }
        PanelRegistry.by_type[type_name] = registered
        PanelRegistry.type_gids[type_name] = registered.gids
    end

    -- Preserve previously registered GIDs when registration happens one tile
    -- at a time, as the map bootstrap does.
    registered.gids = registered.gids or {}
    PanelRegistry.type_gids[type_name] = registered.gids
    for _, gid in ipairs(definition.gids or {}) do
        if PanelRegistry.gid_to_type[gid] == nil then
            PanelRegistry.gid_to_type[gid] = type_name
        end
        local found = false
        for _, existing_gid in ipairs(registered.gids) do
            if existing_gid == gid then
                found = true
                break
            end
        end
        if not found then
            registered.gids[#registered.gids + 1] = gid
        end
    end

    -- Keep any other metadata from the latest definition without replacing
    -- the accumulated GID list.
    for key, value in pairs(definition) do
        if key ~= "gids" and key ~= "type" then
            registered[key] = value
        end
    end
end

-- Get panel type by GID
function PanelRegistry.get_type_by_gid(gid)
    return PanelRegistry.gid_to_type[gid]
end

-- Get definition by type name
function PanelRegistry.get_definition(type_name)
    return PanelRegistry.by_type[type_name]
end

-- Check if a GID corresponds to a specific panel type
function PanelRegistry.is_type(gid, type_name)
    local t = PanelRegistry.get_type_by_gid(gid)
    return t == type_name
end

-- Check if a panel is liberatable
function PanelRegistry.is_liberatable(gid)
    local t = PanelRegistry.get_type_by_gid(gid)
    if not t then return false end
    for _, lib_type in ipairs(Constants.LiberatablePanelTypes) do
        if t == lib_type then return true end
    end
    return false
end

-- Check if a panel is walkable (for enemies)
function PanelRegistry.is_walkable(gid)
    local t = PanelRegistry.get_type_by_gid(gid)
    if not t then return false end
    for _, walk_type in ipairs(Constants.WalkablePanelTypes) do
        if t == walk_type then return true end
    end
    return false
end

-- Check if a panel triggers shadowstep
function PanelRegistry.is_shadowstep(gid)
    local t = PanelRegistry.get_type_by_gid(gid)
    if not t then return false end
    for _, ss_type in ipairs(Constants.ShadowstepPanelTypes) do
        if t == ss_type then return true end
    end
    return false
end

return PanelRegistry