-- Compatibility adapter for gameplay modules that still have imperative
-- lock()/unlock() lifecycles. It does not overwrite Net or InputController.
-- Each player/feature has one idempotent input capture lease. Direct Net
-- unlock calls in unrelated scripts cannot prematurely release that lease.
-- New code should use PlayerControl sessions or UISuppression handles instead.
local Suppression=require("scripts/net-games/ui-suppression")
local M={}
local leases={}
local hud_leases={}
local function key_for(owner)
    if owner==nil or owner=="" then error("legacy capture owner required",3) end
    return tostring(owner)
end
function M.lock(pid,owner)
    if pid==nil then error("player required",2) end
    local key=key_for(owner)
    local table_for=leases[pid]
    if not table_for then table_for={};leases[pid]=table_for end
    local existing=table_for[key]
    if existing and not existing.released then return true end
    local handle,err=Suppression.acquire_input_lock(pid,key)
    if not handle then error(tostring(err),2) end
    table_for[key]=handle
    return true
end
function M.unlock(pid,owner)
    if pid==nil then return false end
    local key=key_for(owner)
    local table_for=leases[pid]
    local handle=table_for and table_for[key]
    if not handle then return true end
    if handle.released then
        table_for[key]=nil
        if not next(table_for) then leases[pid]=nil end
        return true
    end
    local ok,err=Suppression.release(handle)
    if not ok then error("capture release failed: "..tostring(err),2) end
    table_for[key]=nil
    if not next(table_for) then leases[pid]=nil end
    return true
end
function M.has(pid,owner)
    local h=leases[pid] and leases[pid][key_for(owner)]
    return h~=nil and not h.released
end

function M.hide_hud(pid,owner)
    if pid==nil then error("player required",2) end
    local key=key_for(owner)
    local all=hud_leases[pid] or {}
    hud_leases[pid]=all
    if all[key] and not all[key].released then return true end
    local handle,err=Suppression.acquire_engine_hud(pid,key)
    if not handle then error(tostring(err),2) end
    all[key]=handle
    return true
end
function M.show_hud(pid,owner)
    if pid==nil then return false end
    local key=key_for(owner)
    local all=hud_leases[pid]
    local handle=all and all[key]
    if not handle then return true end
    if not handle.released then
        local ok,err=Suppression.release(handle)
        if not ok then error("HUD restoration failed: "..tostring(err),2) end
    end
    all[key]=nil
    if not next(all) then hud_leases[pid]=nil end
    return true
end

function M.cleanup_player(pid)
    local all=leases[pid] or {}
    local complete=true
    for name,handle in pairs(all) do
        local ok,err=pcall(M.unlock,pid,name)
        if not ok then
            complete=false
            print("[LegacyCapture] cleanup "..tostring(name)..": "..tostring(err))
        end
    end
    for name,handle in pairs(hud_leases[pid] or {}) do
        local ok,err=pcall(M.show_hud,pid,name)
        if not ok then
            complete=false
            print("[LegacyCapture] cleanup HUD "..tostring(name)..": "..tostring(err))
        end
    end
    return complete
end
function M.get_debug_state(pid)
    local result={}
    for owner,h in pairs(leases[pid] or {}) do
        result[#result+1]={owner=owner,id=h.id,kind="input",released=h.released}
    end
    for owner,h in pairs(hud_leases[pid] or {}) do
        result[#result+1]={owner=owner,id=h.id,kind="hud",released=h.released}
    end
    return result
end
if Net and type(Net.on)=="function" then
    Net:on("player_disconnect",function(e) M.cleanup_player(e.player_id) end)
end
return M
