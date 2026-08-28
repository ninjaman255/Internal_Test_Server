-- save-game.lua (revised)
local persistence = require('scripts/persistence/persistence')
local Utility = require("scripts/utils/utility")

local MAX_SAVE_INSTANCES = 3
local SAVE_PATH_PATTERN = "scripts/save-files/%s/save%d.json"

local instances = {}

local function sanitize_filename_component(str)
    if not str then return "" end
    local sanitized = str:gsub("[^%w%.%-_]", "_")
    sanitized = sanitized:gsub("^%.", "_"):gsub("%.$", "_")
    return sanitized
end

local is_windows = package.config:sub(1,1) == '\\'

local function escape_path_for_shell(path)
    if is_windows then
        return '"' .. path:gsub('"', '""') .. '"'
    else
        return "'" .. path:gsub("'", "'\\''") .. "'"
    end
end

local function ensure_directory_exists(filePath)
    local dir = filePath:match("^(.*)/[^/]*$")
    if not dir or dir == "" then return end

    if file and file.CreateDir then
        file.CreateDir(dir)
        return
    end

    local f = io.open(dir, "r")
    if f then f:close(); return end

    if is_windows then
        os.execute('mkdir ' .. escape_path_for_shell(dir) .. ' 2>nul')
    else
        os.execute('mkdir -p ' .. escape_path_for_shell(dir))
    end
end

local function ensure_save_file_exists(filePath)
    ensure_directory_exists(filePath)
    local file = io.open(filePath, "r")
    if file then file:close(); return end
    file = io.open(filePath, "w")
    if not file then
        error("Cannot create save file: " .. filePath)
    end
    file:write("{}")
    file:close()
end

local function deep_copy(orig)
    if type(orig) ~= "table" then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        copy[deep_copy(k)] = deep_copy(v)
    end
    return copy
end

local function new(filePath)
    local p = persistence(filePath)

    local self = {
        filePath = filePath,
        persistence = p,
        saved_data = nil,
        working_data = nil,
        loaded = false,
        dirty = false,
    }

    function self:load()
        return p:load():and_then(function(data)
            self.saved_data = deep_copy(data)
            self.working_data = deep_copy(data)
            self.loaded = true
            self.dirty = false
            return self.working_data
        end)
    end

    function self:edit(func)
        if not self.loaded then error("game_save: not loaded. Call :load() first.") end
        func(self.working_data)
        self.dirty = true
    end

    function self:save()
        if not self.loaded then error("game_save: not loaded. Call :load() first.") end
        if not self.dirty then
            return Utility.create_promise(function(resolve) resolve() end)
        end

        -- Make a deep copy to avoid later modifications affecting the write
        local copy_for_save = deep_copy(self.working_data)

        -- Use saveData to write directly; persistence internal data remains unchanged
        return self.persistence:saveData(copy_for_save):and_then(function()
            self.saved_data = deep_copy(self.working_data)
            self.dirty = false
        end)
    end

    function self:revert()
        if not self.loaded then error("game_save: not loaded. Call :load() first.") end
        self.working_data = deep_copy(self.saved_data)
        self.dirty = false
    end

    function self:getData()
        if not self.loaded then error("game_save: not loaded. Call :load() first.") end
        local copy = {}
        for k, v in pairs(self.working_data) do copy[k] = v end
        return copy
    end

    function self:isModified()
        return self.dirty
    end

    function self:getWorkingTable()
        if not self.loaded then error("game_save: not loaded. Call :load() first.") end
        return self.working_data
    end

    return self
end

local function get_game_save(player_id, index)
    if type(player_id) ~= "string" then
        error("player_id must be a string")
    end
    if type(index) ~= "number" or index % 1 ~= 0 or index < 1 or index > MAX_SAVE_INSTANCES then
        error(string.format("index must be an integer between 1 and %d", MAX_SAVE_INSTANCES))
    end

    local secret = Net.get_player_secret(player_id)
    if type(secret) ~= "string" or secret == "" then
        error("Unable to retrieve valid player secret for player_id " .. tostring(player_id))
    end

    local safe_secret = sanitize_filename_component(secret)

    if not instances[safe_secret] then
        instances[safe_secret] = {}
    end

    local inst = instances[safe_secret][index]
    if not inst then
        local filePath = string.format(SAVE_PATH_PATTERN, safe_secret, index)
        ensure_save_file_exists(filePath)
        inst = new(filePath)
        instances[safe_secret][index] = inst
    end
    return inst
end

return get_game_save