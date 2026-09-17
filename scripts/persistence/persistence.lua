-- persistence.lua
-- Persistent JSON file storage with automatic debounced saving and per‑file instance management.
-- Supports chained updates and waiting for save completion via promise‑returning save().
-- Automatically creates missing directories when saving.
-- Now includes saveData() for direct writes without altering internal state, and
-- dirty flag is cleared only after successful write.

local json = require('scripts/libs/json')
local Utility = require('scripts/utils/utility')

local update_interval = 2          -- seconds to wait after last change before saving
local instances = {}                -- cache of active instances by file path

-- Pretty‑print control (set to true or a custom indent string)
local PrettyPrint = true

-- ----------------------------------------------------------------------------
-- OS‑aware directory creation helper (matches your utils example)
-- ----------------------------------------------------------------------------
local is_windows = package.config:sub(1,1) == '\\'

local function ensure_directory_exists(filePath)
    -- Normalise backslashes to forward slashes
    local normalized = filePath:gsub("\\", "/")
    local dir = normalized:match("^(.*)/[^/]*$")
    if not dir or dir == "" then return end

    -- Prefer engine API if available (non‑blocking)
    if file and file.CreateDir then
        file.CreateDir(dir)
        return
    end

    -- Fallback to synchronous shell command
    local cmd
    if is_windows then
        cmd = 'mkdir "' .. dir .. '" 2>nul'
    else
        cmd = 'mkdir -p "' .. dir .. '" 2>/dev/null'
    end
    os.execute(cmd)
end

local function async_ensure_dir(filePath)
    return Utility.create_promise(function(resolve)
        ensure_directory_exists(filePath)
        resolve()
    end)
end

-- ----------------------------------------------------------------------------
-- Global tick handler for debounced saves
-- ----------------------------------------------------------------------------
Net:on("tick", function(event)
    local delta = event.delta_time
    for _, inst in pairs(instances) do
        if inst.save_delay then
            inst.save_delay = inst.save_delay - delta
            if inst.save_delay <= 0 then
                inst.save_delay = nil
                if inst.dirty then
                    inst:_save_internal()
                end
            end
        end
    end
end)

-- ----------------------------------------------------------------------------
-- Persistence instance constructor
-- ----------------------------------------------------------------------------
local function new(filePath)
    local self = {
        filePath = filePath,
        data = nil,
        loaded = false,
        saving = false,
        dirty = false,
        save_delay = nil,
        pending = false,
        after_save = {},
    }

    function self:_mark_dirty()
        self.dirty = true
        if not self.save_delay then
            self.save_delay = update_interval
        else
            self.save_delay = update_interval  -- reset timer
        end
    end

    function self:load()
        if self.loaded then
            return Utility.create_promise(function(resolve) resolve(self.data) end)
        end
        return Utility.create_promise(function(resolve)
            Async.read_file(self.filePath).and_then(function(content)
                local ok, decoded = pcall(function()
                    if content and content ~= "" then
                        return json.decode(content)
                    end
                    return {}
                end)
                if ok then
                    self.data = decoded
                else
                    print("Failed to decode JSON from " .. self.filePath .. ": " .. tostring(decoded))
                    self.data = {}
                end
                self.loaded = true
                resolve(self.data)
            end)
        end)
    end

    function self:getData()
        if not self.loaded then
            error("Data not loaded yet. Call :load() first.")
        end
        local copy = {}
        for k, v in pairs(self.data) do
            copy[k] = v
        end
        return copy
    end

    function self:setData(newData)
        if not self.loaded then
            error("Data not loaded yet. Call :load() first.")
        end
        self.data = newData
        self:_mark_dirty()
    end

    function self:update(func)
        if not self.loaded then
            error("Data not loaded yet. Call :load() first.")
        end
        func(self.data)
        self:_mark_dirty()
    end

    function self:removeKey(key)
        self:update(function(data) data[key] = nil end)
    end

    function self:setKey(key, value)
        self:update(function(data) data[key] = value end)
    end

    function self:clear()
        if not self.loaded then
            error("Data not loaded yet. Call :load() first.")
        end
        self.data = {}
        self:_mark_dirty()
    end

    -- Helper for nested path access
    local function split(str, delim)
        local result = {}
        if not str or str == "" then return result end
        for part in str:gmatch("[^" .. delim .. "]+") do
            table.insert(result, part)
        end
        return result
    end

    local function resolve_path(data, path, create)
        if type(path) == "string" then
            if path == "" then return nil, nil end
            local parts = split(path, ".")
            if #parts == 0 then return nil, nil end
            path = parts
        end
        local current = data
        for i = 1, #path - 1 do
            local part = path[i]
            if type(current) ~= "table" then return nil, nil end
            if current[part] == nil then
                if create then current[part] = {} else return nil, nil end
            end
            current = current[part]
        end
        if type(current) ~= "table" then return nil, nil end
        return current, path[#path]
    end

    function self:removePath(path)
        self:update(function(data)
            local parent, key = resolve_path(data, path, false)
            if parent and key then parent[key] = nil end
        end)
    end

    function self:setPath(path, value)
        self:update(function(data)
            local parent, key = resolve_path(data, path, true)
            if parent and key then parent[key] = value end
        end)
    end

    -- Internal save (called by timer or manual) – does NOT clear dirty here
    function self:_save_internal()
        if self.saving then
            error("_save_internal called while already saving")
        end
        self.saving = true

        local ok, content
        if PrettyPrint then
            ok, content = pcall(json.encode, self.data, PrettyPrint)
        else
            ok, content = pcall(json.encode, self.data)
        end

        if not ok then
            print("Failed to encode data to JSON: " .. tostring(content))
            self.saving = false
            for _, cb in ipairs(self.after_save) do cb() end
            self.after_save = {}
            return Utility.create_promise(function(resolve) resolve() end)
        end

        print("Writing to " .. self.filePath)

        local dir_promise = async_ensure_dir(self.filePath)

        local save_promise = Utility.create_promise(function(resolve)
            dir_promise:and_then(function()
                Async.write_file(self.filePath, content).and_then(
                    function()
                        print("Write successful")
                        self.saving = false
                        -- Clear dirty ONLY on success
                        self.dirty = false

                        if self.pending then
                            self.pending = false
                            local next_save_promise = self:_save_internal()
                            next_save_promise:and_then(function()
                                for _, cb in ipairs(self.after_save) do cb() end
                                self.after_save = {}
                            end)
                        else
                            for _, cb in ipairs(self.after_save) do cb() end
                            self.after_save = {}
                        end
                        resolve()
                    end,
                    function(err)
                        print("Write failed: " .. tostring(err))
                        self.saving = false
                        -- dirty remains true (retry later)
                        for _, cb in ipairs(self.after_save) do cb() end
                        self.after_save = {}
                        self.pending = false
                        resolve()
                    end
                )
            end)
        end)

        return save_promise
    end

    -- Public save: forces an immediate save (bypasses timer)
    function self:save()
        self.save_delay = nil
        if not self.dirty then
            return Utility.create_promise(function(resolve) resolve() end)
        end

        -- Do NOT clear dirty here – will be cleared after success
        if self.saving then
            self.pending = true
            return Utility.create_promise(function(resolve)
                table.insert(self.after_save, resolve)
            end)
        else
            return self:_save_internal()
        end
    end

    -- NEW: Save arbitrary data without modifying internal state.
    -- Used by save‑game to avoid inconsistency on failure.
    function self:saveData(data)
        return Utility.create_promise(function(resolve)
            local ok, content
            if PrettyPrint then
                ok, content = pcall(json.encode, data, PrettyPrint)
            else
                ok, content = pcall(json.encode, data)
            end
            if not ok then
                print("Failed to encode data for saveData: " .. tostring(content))
                resolve()
                return
            end
            ensure_directory_exists(self.filePath)
            Async.write_file(self.filePath, content).and_then(
                function()
                    resolve()
                end,
                function(err)
                    print("saveData write failed: " .. tostring(err))
                    resolve()
                end
            )
        end)
    end

    function self:ready(callback)
        return self:load():and_then(callback)
    end

    function self:updateAndSave(func)
        self:update(func)
    end

    return self
end

-- Manager: returns the instance for a given file path (creates if not exist)
local function get_instance(filePath)
    if not filePath or type(filePath) ~= "string" then
        error("filePath must be a string")
    end
    local inst = instances[filePath]
    if not inst then
        inst = new(filePath)
        instances[filePath] = inst
    end
    return inst
end

return get_instance