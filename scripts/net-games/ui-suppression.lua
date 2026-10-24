-- Shared reference-counted suppression for engine HUD, engine input lock, and custom UI handlers.
-- Engine HUD is separate from all sprites/text/panels created by our UI scripts.
local M = {}
local hud, input, handlers, active = {}, {}, {}, {}
local next_id = 0
local function state_for(store, pid)
  if not store[pid] then store[pid] = { count = 0, requests = {} } end
  return store[pid]
end
local function net_call(name, pid)
  local fn = Net and Net[name]
  if type(fn) ~= "function" then return false, "Net." .. name .. " unavailable" end
  local ok, err = pcall(fn, pid)
  if not ok then return false, err end
  return true
end
local function acquire_engine(store, pid, owner, kind, fn_name)
  if pid == nil then return nil, "player_id required" end
  local s = state_for(store, pid)
  if s.count == 0 then
    local ok, err = net_call(fn_name, pid)
    if not ok then store[pid] = nil; return nil, tostring(err) end
    s.applied = true
  end
  next_id = next_id + 1
  local h = { id = next_id, player_id = pid, kind = kind, released = false }
  s.count = s.count + 1; s.requests[h.id] = owner or "unspecified"; active[h.id] = h
  return h
end
function M.acquire_engine_hud(pid, owner)
  -- Assumes the engine HUD is visible when first acquired. Scripts that participate
  -- in this system must not call Net.toggle_player_hud directly.
  return acquire_engine(hud, pid, owner, "engine_hud", "toggle_player_hud")
end
function M.acquire_input_lock(pid, owner)
  return acquire_engine(input, pid, owner, "input_lock", "lock_player_input")
end
function M.register_handler(name, handler)
  assert(type(name)=="string" and name~="" and type(handler)=="table" and type(handler.acquire)=="function", "invalid suppression handler")
  handlers[name] = handler
end
function M.acquire_element(pid, name, owner, options)
  local handler = handlers[name]
  if not handler then return nil, "unknown UI suppression handler: " .. tostring(name) end
  local resource, err = handler.acquire(pid, owner, options)
  if resource == nil or resource == false then return nil, err or "handler acquire failed" end
  next_id = next_id + 1
  local h = { id=next_id, player_id=pid, kind="element", handler=name, resource=resource, released=false }
  active[h.id] = h
  return h
end
function M.release(h)
  if type(h) ~= "table" or h.released then return false end
  if h.kind == "bundle" then return M.release_profile(h) end
  local store, fn_name
  if h.kind == "engine_hud" then store, fn_name = hud, "toggle_player_hud"
  elseif h.kind == "input_lock" then store, fn_name = input, "unlock_player_input" end
  if store then
    local s = store[h.player_id]
    if not s or not s.requests[h.id] then return false end
    s.requests[h.id] = nil; s.count = math.max(0, s.count - 1)
    if s.count == 0 then
      if s.applied then
        local ok, err = net_call(fn_name, h.player_id)
        if not ok then
          s.count = 1; s.requests[h.id] = "restore_failed"; h.released = false; active[h.id] = h
          return false, "restore failed: " .. tostring(err)
        end
      end
      store[h.player_id] = nil
    end
  elseif h.kind == "element" then
    local handler = handlers[h.handler]
    if handler and type(handler.release) == "function" then
      local ok, err = pcall(handler.release, h.player_id, h.resource, h)
      if not ok then h.released = false; active[h.id] = h; return false, tostring(err) end
    end
  else return false end
  h.released = true; active[h.id] = nil
  return true
end
local profiles = {
  menu = { "engine_hud", "input_lock" },
  cinematic = { "engine_hud", "input_lock" },
  engine_hud_only = { "engine_hud" },
  input_locked = { "input_lock" },
}
function M.register_profile(name, entries)
  assert(type(name)=="string" and name~="" and type(entries)=="table", "invalid profile")
  profiles[name] = entries
end
function M.acquire_profile(pid, name, owner, options)
  local entries = profiles[name]
  if not entries then return nil, "unknown profile: " .. tostring(name) end
  local b = { id=0, player_id=pid, kind="bundle", handles={}, released=false }
  for _, e in ipairs(entries) do
    local h, err
    if e == "engine_hud" then h,err=M.acquire_engine_hud(pid,owner or name)
    elseif e == "input_lock" then h,err=M.acquire_input_lock(pid,owner or name)
    elseif type(e)=="string" then h,err=M.acquire_element(pid,e,owner or name,options)
    elseif type(e)=="table" and e.handler then h,err=M.acquire_element(pid,e.handler,owner or name,e.options or options)
    else err="invalid profile entry" end
    if not h then for i=#b.handles,1,-1 do M.release(b.handles[i]) end; return nil,err end
    b.handles[#b.handles+1]=h
  end
  next_id=next_id+1; b.id=next_id; active[b.id]=b
  return b
end
function M.release_profile(b)
  if type(b)~="table" or b.released then return false end
  local ok_all=true
  for i=#b.handles,1,-1 do if not M.release(b.handles[i]) then ok_all=false end end
  if ok_all then b.released=true; active[b.id]=nil end
  return ok_all
end
function M.cleanup_player(pid)
  local list={}
  for _,h in pairs(active) do if h.player_id==pid then list[#list+1]=h end end
  for i=#list,1,-1 do if list[i].kind=="bundle" then M.release_profile(list[i]) else M.release(list[i]) end end
end
function M.get_debug_state(pid)
  local function summary(s)
    local r={}; if s then for id,owner in pairs(s.requests) do r[#r+1]={id=id,owner=owner} end end
    return {count=s and s.count or 0, requests=r}
  end
  return {engine_hud=summary(hud[pid]), input_lock=summary(input[pid])}
end
return M
