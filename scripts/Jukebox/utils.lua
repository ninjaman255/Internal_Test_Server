local utils = {}

-- Detects the operating system (windows or unix).
function utils.get_os()
    if package.config:sub(1, 1) == "\\" then
        return "windows"
    else
        return "unix"
    end
end

-- Lists files in a directory using the appropriate system command.
-- Returns a simple list of file/directory names (strings).
function utils.listFiles(directory)
    local os_type = utils.get_os()
    local songTable = {}
    local cmd = ""

    if os_type == "windows" then
        cmd = 'dir "' .. directory .. '" /b'
    else
        cmd = 'ls "' .. directory .. '"'
    end

    local handle = io.popen(cmd)
    if handle then
        for file in handle:lines() do
            table.insert(songTable, file)
        end
        handle:close()
    else
        print("Error listing files in directory.")
    end
    return songTable
end

-- Lists immediate subdirectories.
function utils.listDirectories(directory)
    local directories = {}
    local os_type = utils.get_os()
    local cmd

    if os_type == "windows" then
        cmd = 'dir "' .. directory .. '" /ad /b'
    else
        cmd = 'find "' .. directory .. '" -mindepth 1 -maxdepth 1 -type d'
    end

    local handle = io.popen(cmd)
    if not handle then
        print("[Jukebox] Failed to list directories: " .. directory)
        return directories
    end

    for entry in handle:lines() do
        local name = os_type == "windows"
            and entry or entry:match("([^/]+)$")

        if name and name ~= "" then
            directories[#directories + 1] = name
        end
    end

    handle:close()
    return directories
end

return utils
