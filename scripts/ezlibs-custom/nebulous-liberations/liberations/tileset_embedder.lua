-- tileset_embedder.lua
-- Ensures maps containing a Tiled "Liberation Config" object reference the
-- shared Nebulous Liberations tilesets. Shared TSX/PNG assets are published
-- before TMX files are modified. The caller can await Embedder.run().

local Embedder = {}
local log = require("scripts/logger/logger").register("nebulous-liberations"):register_subsystem("tileset-embedder")

local SHARED_TILESETS = {
    {
        filename = "Liberation Collision.tsx",
        source = "../assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx",
        file_path = "assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx",
        asset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx",
        image_filename = "Liberation Collision.png",
        tilecount = 1,
    },
    {
        filename = "selected tile.tsx",
        source = "../assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.tsx",
        file_path = "assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.tsx",
        asset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.tsx",
        image_filename = "selected tile.png",
        tilecount = 6,
    },
    {
        filename = "attack indicator.tsx",
        source = "../assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.tsx",
        file_path = "assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.tsx",
        asset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.tsx",
        image_filename = "attack indicator.png",
        tilecount = 1,
    },
}

local TARGET_BY_FILENAME = {}
for _, tileset in ipairs(SHARED_TILESETS) do
    TARGET_BY_FILENAME[tileset.filename] = tileset
end

local function basename(path)
    return (path or ""):match("([^/\\]+)$") or path
end

local function source_to_file_path(source)
    if type(source) ~= "string" or source == "" then return nil end
    local path = source:gsub("^/server/", "")
    path = path:gsub("^%.%./", "")
    path = path:gsub("^%./", "")
    return path
end

-- Tiled map tilesets are usually external, self-closing declarations. This
-- parser also records inline tilesets so their tile ranges are not overlapped.
local function parse_tilesets(tmx)
    local entries = {}
    for attributes in tmx:gmatch("<tileset%s+([^>]-)>") do
        local firstgid = tonumber(attributes:match('firstgid="(%d+)"'))
        local source = attributes:match('source="([^"]+)"')
        local tilecount = tonumber(attributes:match('tilecount="(%d+)"'))
        if firstgid then
            entries[#entries + 1] = {
                firstgid = firstgid,
                source = source,
                filename = source and basename(source) or nil,
                inline_tilecount = tilecount,
            }
        end
    end
    return entries
end

local function get_liberation_config(area_id)
    local object_ids = Net.list_objects(area_id) or {}
    for _, object_id in ipairs(object_ids) do
        local object = Net.get_object_by_id(area_id, object_id)
        if object and object.type == "Liberation Config" then
            local properties = object.custom_properties or {}
            return object, properties["Liberation Tileset"]
        end
    end
    return nil, nil
end

local function publish_shared_assets()
    local all_assets_published = true
    for _, tileset in ipairs(SHARED_TILESETS) do
        local asset_files = {
            { file_path = tileset.file_path, asset_path = tileset.asset_path },
            {
                file_path = "assets/ezlibs-custom/nebulous-liberations/tiles/" .. tileset.image_filename,
                asset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/" .. tileset.image_filename,
            },
        }
        for _, asset in ipairs(asset_files) do
            local read_ok, content = pcall(function()
                return Async.await(Async.read_file(asset.file_path))
            end)
            if not read_ok or type(content) ~= "string" or content == "" then
                all_assets_published = false
                log:error_data("Could not read shared liberation tileset asset", {
                    file_path = asset.file_path,
                    asset_path = asset.asset_path,
                    error = read_ok and "empty or non-string file content" or tostring(content),
                })
            else
                local update_ok, update_error = pcall(function()
                    Net.update_asset(asset.asset_path, content)
                end)
                if not update_ok then
                    all_assets_published = false
                    log:error_data("Could not publish shared liberation tileset asset", {
                        file_path = asset.file_path,
                        asset_path = asset.asset_path,
                        error = tostring(update_error),
                    })
                else
                    log:debug_data("Published shared liberation tileset asset", {
                        file_path = asset.file_path,
                        asset_path = asset.asset_path,
                    })
                end
            end
        end
    end
    return all_assets_published
end

local function read_tileset_tilecount(entry)
    if entry.filename and TARGET_BY_FILENAME[entry.filename] then
        return TARGET_BY_FILENAME[entry.filename].tilecount
    end
    if entry.inline_tilecount then
        return entry.inline_tilecount
    end
    if not entry.source then
        return nil, "tileset has neither an external source nor a tilecount"
    end

    local file_path = source_to_file_path(entry.source)
    if not file_path then return nil, "invalid source path" end

    local read_ok, content = pcall(function()
        return Async.await(Async.read_file(file_path))
    end)
    if not read_ok then return nil, tostring(content) end
    if type(content) ~= "string" then
        return nil, "no content returned for " .. file_path
    end

    local tilecount = tonumber(content:match('<tileset[^>]-tilecount="(%d+)"'))
    if not tilecount then
        return nil, "could not parse tilecount from " .. file_path
    end
    return tilecount
end

local function next_gid_after_existing_tilesets(entries)
    local max_gid = 0
    for _, entry in ipairs(entries) do
        local tilecount, err = read_tileset_tilecount(entry)
        if not tilecount then
            return nil, err
        end
        if tilecount > 0 then
            max_gid = math.max(max_gid, entry.firstgid + tilecount - 1)
        end
    end
    return max_gid + 1
end

local function normalize_shared_sources(tmx, entries)
    local updated = tmx
    local found = {}
    for _, entry in ipairs(entries) do
        local target = entry.filename and TARGET_BY_FILENAME[entry.filename]
        if target then
            found[target.filename] = true
            if entry.source ~= target.source then
                local escaped_source = entry.source:gsub("([^%w])", "%%%1")
                local pattern = '(<tileset%s+[^>]-source=")' .. escaped_source .. '(")'
                updated = updated:gsub(pattern, function(prefix, suffix)
                    return prefix .. target.source .. suffix
                end, 1)
            end
        end
    end
    return updated, found
end

local function insert_declarations(tmx, declarations)
    local block = table.concat(declarations, "\n") .. "\n"
    local insertion_start = tmx:find("<layer", 1, true)
    if not insertion_start then insertion_start = tmx:find("<objectgroup", 1, true) end
    if not insertion_start then insertion_start = tmx:find("<imagelayer", 1, true) end
    if not insertion_start then insertion_start = tmx:find("<group", 1, true) end
    if insertion_start then
        return tmx:sub(1, insertion_start - 1) .. block .. tmx:sub(insertion_start)
    end

    local map_close = tmx:find("</map>", 1, true)
    if map_close then
        return tmx:sub(1, map_close - 1) .. block .. tmx:sub(map_close)
    end
    return nil, "could not find a safe insertion point in TMX"
end

local function write_updated_map(area_id, map_path, original, updated)
    if updated == original then
        log:debug_data("Liberation map tilesets already correct", {
            area_id = area_id,
            map_path = map_path,
        })
        return
    end

    local write_ok, write_result = pcall(function()
        return Async.await(Async.write_file(map_path, updated))
    end)
    if not write_ok or write_result == false then
        log:error_data("Failed writing liberation TMX file", {
            area_id = area_id,
            map_path = map_path,
            error = write_ok and "Async.write_file returned false" or tostring(write_result),
        })
        return
    end

    local asset_path = "/server/" .. map_path
    local update_ok, update_error = pcall(function()
        Net.update_asset(asset_path, updated)
    end)
    if not update_ok then
        log:error_data("TMX file written but server asset update failed", {
            area_id = area_id,
            map_path = map_path,
            asset_path = asset_path,
            error = tostring(update_error),
        })
        return
    end

    log:info_data("Updated liberation TMX shared tileset references", {
        area_id = area_id,
        map_path = map_path,
        asset_path = asset_path,
    })
end

local function process_map(area_id)
    local config_object, config_tileset_path = get_liberation_config(area_id)
    if not config_object then return end

    if type(config_tileset_path) ~= "string" or config_tileset_path == "" then
        log:warn_data("Liberation Config has no Liberation Tileset property; embedding shared tilesets anyway", {
            area_id = area_id,
            object_id = config_object.id,
            property_name = "Liberation Tileset",
        })
    end

    local map_path = "areas/" .. area_id .. ".tmx"
    local read_ok, tmx = pcall(function()
        return Async.await(Async.read_file(map_path))
    end)
    if not read_ok or type(tmx) ~= "string" or tmx == "" then
        log:error_data("Could not read liberation TMX file", {
            area_id = area_id,
            map_path = map_path,
            error = read_ok and "empty or non-string file content" or tostring(tmx),
        })
        return
    end

    local entries = parse_tilesets(tmx)
    local normalized, found = normalize_shared_sources(tmx, entries)
    local missing = {}
    for _, tileset in ipairs(SHARED_TILESETS) do
        if not found[tileset.filename] then
            missing[#missing + 1] = tileset
        end
    end

    if #missing == 0 then
        write_updated_map(area_id, map_path, tmx, normalized)
        return
    end

    local next_gid, gid_error = next_gid_after_existing_tilesets(entries)
    if not next_gid then
        log:error_data("Skipped TMX modification because GIDs could not be assigned safely", {
            area_id = area_id,
            map_path = map_path,
            error = gid_error,
        })
        return
    end

    local declarations = {}
    for _, tileset in ipairs(missing) do
        declarations[#declarations + 1] = string.format(
            ' <tileset firstgid="%d" source="%s"/>',
            next_gid,
            tileset.source
        )
        next_gid = next_gid + tileset.tilecount
    end

    local updated, insert_error = insert_declarations(normalized, declarations)
    if not updated then
        log:error_data("Could not safely insert shared tilesets into liberation TMX", {
            area_id = area_id,
            map_path = map_path,
            error = insert_error,
        })
        return
    end

    write_updated_map(area_id, map_path, tmx, updated)
end

function Embedder.run()
    local co = coroutine.create(function()
        local assets_published = publish_shared_assets()
        if not assets_published then
            log:error("Skipping TMX edits because one or more shared liberation assets could not be published")
            return
        end

        local list_ok, areas = pcall(Net.list_areas)
        if not list_ok or type(areas) ~= "table" then
            error("Could not list areas for liberation tileset embedding: " .. tostring(areas))
        end

        local processed = 0
        for _, area_id in ipairs(areas) do
            local process_ok, process_error = pcall(process_map, area_id)
            if not process_ok then
                log:error_data("Unexpected error while embedding liberation map tilesets", {
                    area_id = area_id,
                    error = tostring(process_error),
                })
            else
                processed = processed + 1
            end
        end

        log:info_data("Liberation tileset embedding pass complete", {
            areas_checked = #areas,
            maps_processed = processed,
        })
    end)
    return Async.promisify(co)
end

return Embedder
