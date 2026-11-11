-- Per-player exclusive camera ownership. This module does NOT lock engine input.
-- A camera lease prevents an old context from restoring player tracking after
-- another context acquires camera control. Older raw Net.camera users must be
-- migrated to this API before the exclusivity guarantee is server-wide.
local M = {}
local owners = {}
local next_id = 0

local function current(pid)
    local stack = owners[pid]
    if stack then
        for i = #stack, 1, -1 do
            if not stack[i].released then return stack[i] end
        end
    end
end

function M.acquire(pid, owner, options)
    options = options or {}
    if not pid or owner == nil then return nil, "player and camera owner required" end
    local previous = current(pid)
    -- Only a declared child of the current lease can temporarily supersede it.
    if previous and options.parent ~= previous then
        return nil, "camera already owned by " .. tostring(previous.label)
    end
    next_id = next_id + 1
    local lease = { id=next_id, player_id=pid, owner=owner,
        parent=previous, label=options.label or tostring(owner), released=false,
        restore_on_release=options.restore_on_release ~= false }
    owners[pid] = owners[pid] or {}
    owners[pid][#owners[pid] + 1] = lease
    return lease
end

function M.is_current(lease)
    return type(lease)=="table" and not lease.released
        and current(lease.player_id)==lease
end

local function call_net(name, ...)
    if not Net or type(Net[name]) ~= "function" then return false,"Net."..name.." unavailable" end
    return pcall(Net[name], ...)
end

-- Release a camera scope. A stale lease can never reset another owner's view.
-- With no parent, optionally return the viewport to ordinary player tracking.
function M.release(lease)
    if type(lease) ~= "table" or lease.released then return false, "already released" end
    local is_top = M.is_current(lease)
    local stack = owners[lease.player_id]
    if not stack then return false, "unknown camera lease" end
    -- Do not close a parent while a child is live: the parent would no longer
    -- be able to decide whether it should restore tracking on resume.
    if not is_top then return false, "camera lease has active child" end
    if lease.restore_on_release and not lease.parent then
        local ok, err = call_net("unlock_player_camera", lease.player_id)
        if not ok then return false, tostring(err) end
        ok, err = call_net("track_with_player_camera", lease.player_id)
        if not ok then return false, tostring(err) end
    end
    lease.released = true
    stack[#stack] = nil
    if #stack==0 then owners[lease.player_id]=nil end
    return true
end

function M.get_current(pid)
    return current(pid)
end

function M.get_debug_state(pid)
    local out = {}
    for _,lease in ipairs(owners[pid] or {}) do
        out[#out + 1] = {id=lease.id, owner=lease.label, released=lease.released}
    end
    return out
end

-- Only for a player that has disconnected; never call engine camera APIs here.
function M.cleanup_player(pid)
    for _, lease in ipairs(owners[pid] or {}) do lease.released=true end
    owners[pid]=nil
end

return M
