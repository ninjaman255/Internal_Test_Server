-- PlayerControl: scoped input capture, logical focus, HUD and camera leases.
-- Engine input lock suppresses default movement; virtual_input stays available.
-- Screens should acquire a session, then close it. Child screens inherit the
-- player's capture lifetime without temporarily restoring engine movement.
local InputAPI = require("scripts/input-controller/main")
local Suppression = require("scripts/player-control/resources/ui-suppression")
local CameraFocus = require("scripts/player-control/camera-focus")
local M = {}
-- Control lifecycle logging is shared with the rest of the server. Only
-- transitions are recorded; no per-tick/per-button console spam.
local event_streams={}
do
    local ok,shared=pcall(require,"scripts/logger/logger")
    if ok and shared and type(shared.register)=="function" then
        local registered,system=pcall(shared.register,"player_control",{console=false})
        if registered and system then
            for _,kind in ipairs({"input","capture","camera","handoff"}) do
                local found,logger=pcall(system.register_subsystem,system,kind,{console=false})
                if found then event_streams[kind]=logger end
            end
        end
    end
end
local function lifecycle(kind,message,data)
    local stream=event_streams[kind]
    if stream and type(stream.debug_data)=="function" then
        pcall(stream.debug_data,stream,message,data or {})
    end
end
local states, pending, named_resources = {}, {}, {}
local serial = 0
local Session = {}
Session.__index = Session

local profiles = {
    desktop={capture=true, focus=true}, menu={capture=true, focus=true},
    music_menu={capture=true, focus=true, hud=true},
    settings_menu={capture=true, focus=true},
    native_ui={capture=true, focus=false}, cinematic={capture=true, focus=false},
    capture_only={capture=true, focus=false}, free_camera={capture=true, focus=true},
    minigame={capture=true, focus=true}, mission_transition={capture=true, focus=false},
}
local guards = {"Up","Down","Left","Right","UpLeft","UpRight","DownLeft","DownRight",
                "Confirm","Cancel","ShoulderL","ShoulderR"}

local function report(where, err)
    print("[PlayerControl] "..tostring(where)..": "..tostring(err))
end
local function top(state)
    for i=#state.stack,1,-1 do
        local s=state.stack[i]
        if not s.closed then return s end
    end
end
local function focused(state)
    local s=top(state)
    return s and not s.native and s.focus and s or nil
end
local function safe_callback(session, callback, label, ...)
    local ok, err = pcall(callback, ...)
    if not ok then report(tostring(session.label).." "..label,err) end
    return ok,err
end

-- A failed Net restore leaves the handle registered in UISuppression. Retain
-- the handle for a later retry instead of pretending it has been released.
local function release_or_queue(pid, handle, label)
    if not handle or handle.released then return true end
    local ok, err = Suppression.release(handle)
    if not ok then
        pending[pid] = pending[pid] or {}
        pending[pid]["suppression:"..handle.id] = {handle=handle, label=label, release=Suppression.release}
        report("deferred "..label,err)
        return false
    end
    if pending[pid] then pending[pid]["suppression:"..handle.id]=nil end
    return true
end
function M.retry_cleanup(pid)
    local list=pending[pid]
    if not list then return true end
    local done=true
    for id,item in pairs(list) do
        if item.handle.released then list[id]=nil
        else
            local ok,err=item.release(item.handle)
            if ok then list[id]=nil
            else done=false; report("retry "..item.label,err) end
        end
    end
    if not next(list) then pending[pid]=nil end
    return done
end

-- Named resource scopes belong to PlayerControl, independently from its
-- button-focus stack. They are intended for native dialogues, cutscenes and
-- warps that need engine capture without claiming logical menu input.
-- A player/owner pair is idempotent, matching the lifecycle of existing game
-- operations. For overlapping operations, use DIFFERENT owner keys.
local function resource_for(pid, owner, create)
    if pid == nil then error("player_id required", 3) end
    if owner == nil or tostring(owner) == "" then error("capture owner required", 3) end
    local by_player=named_resources[pid]
    if not by_player and create then by_player={}; named_resources[pid]=by_player end
    local resource=by_player and by_player[tostring(owner)]
    if not resource and create then
        resource={owner=tostring(owner),player_id=pid}
        by_player[tostring(owner)]=resource
    end
    return resource
end
local function prune_resource(pid, owner)
    local by_player=named_resources[pid]
    local item=by_player and by_player[tostring(owner)]
    if item and not item.input and not item.hud then by_player[tostring(owner)]=nil end
    if by_player and not next(by_player) then named_resources[pid]=nil end
end
local function acquire_resource(pid, owner, field, fn)
    local item=resource_for(pid,owner,true)
    if item[field] and not item[field].released then return true end
    local handle,err=fn(pid,item.owner)
    if not handle then
        prune_resource(pid,owner)
        error("PlayerControl "..field.." acquisition failed: "..tostring(err),3)
    end
    item[field]=handle
    return true
end
local function release_resource(pid,owner,field)
    if pid==nil then return false end
    local item=resource_for(pid,owner,false)
    if not item or not item[field] then return true end
    local handle=item[field]
    item[field]=nil
    prune_resource(pid,owner)
    if handle.released then return true end
    -- Keep unsuccessful releases in PlayerControl's recovery queue. Never
    -- discard an outstanding suppression handle, including on disconnect.
    if not release_or_queue(pid,handle,field.." "..tostring(owner)) then
        return false,"resource release deferred for retry"
    end
    return true
end
function M.acquire_capture(pid,owner)
    local ok=acquire_resource(pid,owner,"input",Suppression.acquire_input_lock)
    lifecycle("capture","engine input acquired",{player_id=pid,owner=owner})
    return ok
end
function M.release_capture(pid,owner)
    local ok,err=release_resource(pid,owner,"input")
    lifecycle("capture","engine input release",{player_id=pid,owner=owner,success=ok,error=err})
    return ok,err
end
function M.has_capture(pid,owner)
    local item=resource_for(pid,owner,false)
    return item~=nil and item.input~=nil and not item.input.released
end
function M.suppress_hud(pid,owner)
    local ok=acquire_resource(pid,owner,"hud",Suppression.acquire_engine_hud)
    lifecycle("capture","engine HUD suppressed",{player_id=pid,owner=owner})
    return ok
end
function M.restore_hud(pid,owner)
    local ok,err=release_resource(pid,owner,"hud")
    lifecycle("capture","engine HUD restored",{player_id=pid,owner=owner,success=ok,error=err})
    return ok,err
end
-- Optional explicit lifetime for feature code. No logical input is claimed.
function M.begin_capture_scope(pid,owner,options)
    options=options or {}
    local ok,err=pcall(M.acquire_capture,pid,owner)
    if not ok then return nil,err end
    if options.hud then
        local hud_ok,hud_err=pcall(M.suppress_hud,pid,owner)
        if not hud_ok then M.release_capture(pid,owner);return nil,hud_err end
    end
    local scope={player_id=pid,owner=owner,closed=false}
    function scope:close()
        if self.closed then return true end
        self.closed=true
        local hud_ok=M.restore_hud(self.player_id,self.owner)
        local input_ok=M.release_capture(self.player_id,self.owner)
        return hud_ok and input_ok
    end
    return scope
end

local function state_for(pid)
    local state=states[pid]
    if state then return state end
    local ctrl=InputAPI.get_controller(pid) or InputAPI.create_controller(pid)
    if not ctrl or ctrl.destroyed then return nil,"input controller unavailable" end
    local first, repeat_delay
    if ctrl.get_default_repeat_delays then
        first,repeat_delay=ctrl:get_default_repeat_delays()
    else
        first,repeat_delay=ctrl:get_repeat_delays()
    end
    serial=serial+1
    state={player_id=pid, ctrl=ctrl, owner={player_id=pid,generation=serial},
        stack={}, first=first, interval=repeat_delay, effective=nil}
    states[pid]=state
    return state
end

local function sync_focus(state)
    local ctrl=state.ctrl
    if not ctrl or ctrl.destroyed then return false,"controller destroyed" end
    local new=focused(state)
    local want=false
    for _,s in ipairs(state.stack) do
        if not s.closed and s.focus then want=true; break end
    end
    local claimed=ctrl:has_input_control(state.owner)
    if want and not claimed then
        if ctrl:get_input_owner() ~= nil then
            -- Another input owner is active. Preserve our sessions, but do
            -- not forcibly steal focus away from a minigame/camera/dialog.
            state.effective=nil
            return false,"logical input belongs to another owner"
        end
        if not ctrl:claim_input(state.owner) then
            state.effective=nil
            return false,"unable to claim logical input"
        end
        claimed=true
    elseif not want and claimed then
        if ctrl.clear_owned_repeat_delays then ctrl:clear_owned_repeat_delays(state.owner) end
        ctrl:release_input(state.owner)
        claimed=false
    end
    if new ~= state.effective or claimed ~= state.claimed then
        local old=state.effective
        lifecycle("input","logical focus transition",{player_id=state.player_id,
            old_owner=old and old.label or nil,new_owner=new and new.label or nil,
            controller_claimed=claimed})
        state.effective=new
        state.claimed=claimed
        if old and old~=new then
            for _,fn in ipairs(old.suspend_callbacks) do safe_callback(old,fn,"on_suspend",old) end
        end
        if claimed then
            -- Exactly once on a real focus transition, not on every tick or
            -- reentrant sync. Guard held buttons and discard prior edges.
            ctrl:require_release(guards,state.owner)
            ctrl:consume(state.owner)
        end
        if new and claimed then
            for _,fn in ipairs(new.resume_callbacks) do safe_callback(new,fn,"on_resume",new) end
        end
    end
    if claimed and new then
        local first=new.first_repeat_delay or state.first
        local interval=new.repeat_delay or state.interval
        if new~=state.repeat_session or first~=state.applied_first or interval~=state.applied_interval then
            if ctrl.set_owned_repeat_delays then
                ctrl:set_owned_repeat_delays(state.owner,first,interval)
            else
                ctrl:set_repeat_delays(first,interval)
            end
            state.repeat_session, state.applied_first, state.applied_interval = new, first, interval
        end
    else
        if claimed and ctrl.clear_owned_repeat_delays then ctrl:clear_owned_repeat_delays(state.owner) end
        state.repeat_session=nil
        state.applied_first=nil
        state.applied_interval=nil
    end
    return true
end

local function detach_state(state)
    local ctrl=state.ctrl
    if ctrl and state.pressed_handler and not ctrl.destroyed then
        ctrl:off("button_pressed",state.pressed_handler)
        ctrl:off("button_repeat",state.repeated_handler)
        ctrl:off("button_released",state.released_handler)
        ctrl:off("input_owner_changed",state.owner_handler)
    end
    if ctrl and not ctrl.destroyed then
        if ctrl:has_input_control(state.owner) then
            if ctrl.clear_owned_repeat_delays then ctrl:clear_owned_repeat_delays(state.owner) end
            ctrl:release_input(state.owner)
        end
    end
    if states[state.player_id]==state then states[state.player_id]=nil end
end

local function attach_events(state)
    if state.pressed_handler then return end
    local ctrl=state.ctrl
    local function dispatch(kind,ev)
        if not ev or ev.input_owner~=state.owner then return end
        local s=focused(state)
        if not s or s.closed or state.effective~=s then return end
        if s.delivery=="poll" then return end
        local callbacks = kind=="pressed" and s.pressed or (kind=="repeat" and s.repeated or s.released)
        local callback=callbacks[ev.action]
        if callback then
            local ok,err=safe_callback(s,callback,kind.." "..tostring(ev.action),ev)
            if not ok then
                for _,fn in ipairs(s.error_callbacks) do safe_callback(s,fn,"on_error",err) end
                s:close()
            end
        end
    end
    state.pressed_handler=function(ev) dispatch("pressed",ev) end
    state.repeated_handler=function(ev) dispatch("repeat",ev) end
    state.released_handler=function(ev) dispatch("released",ev) end
    state.owner_handler=function(change)
        if change.owner==nil and #state.stack>0 and states[state.player_id]==state then
            -- A foreign owner yielded; reacquire if we still have a live scope.
            sync_focus(state)
        elseif change.owner~=state.owner then
            if state.effective then
                local old=state.effective
                for _,fn in ipairs(old.suspend_callbacks) do safe_callback(old,fn,"on_suspend",old) end
            end
            state.effective=nil
            state.claimed=false
            state.repeat_session=nil
        end
    end
    ctrl:on("button_pressed",state.pressed_handler)
    ctrl:on("button_repeat",state.repeated_handler)
    ctrl:on("button_released",state.released_handler)
    ctrl:on("input_owner_changed",state.owner_handler)
end

function Session:is_alive() return not self.closed and states[self.player_id]==self.state end
function Session:is_current()
    return self:is_alive() and focused(self.state)==self and self.state.effective==self
        and self.state.ctrl:has_input_control(self.state.owner)
end
function Session:input()
    if self:is_current() then return self.state.ctrl,self.state.owner end
end
function Session:poll(actions)
    if self.delivery=="callbacks" then return nil end
    local ctrl,owner=self:input()
    if not ctrl then return nil end
    self.delivery="poll"
    local events={}
    for _,item in ipairs(actions or {}) do
        local action,raw,allow_repeat=item[1],item[2],item[3]
        if ctrl:is_action_pressed(action,owner) then
            events[#events+1]={name=raw,state=1}
        elseif allow_repeat and ctrl:is_action_repeated(action,owner) then
            events[#events+1]={name=raw,state=2}
        end
    end
    return {player_id=self.player_id,events=events}
end
function Session:on_pressed(action,fn)
    assert(type(fn)=="function","callback must be a function")
    if self.delivery=="poll" then return nil,"session uses polling" end
    self.delivery="callbacks"
    self.pressed[action]=fn
    return self
end
function Session:on_repeat(action,fn)
    assert(type(fn)=="function","callback must be a function")
    if self.delivery=="poll" then return nil,"session uses polling" end
    self.delivery="callbacks"
    self.repeated[action]=fn
    return self
end
function Session:on_released(action,fn)
    assert(type(fn)=="function","callback must be a function")
    if self.delivery=="poll" then return nil,"session uses polling" end
    self.delivery="callbacks"
    self.released[action]=fn
    return self
end
-- Shared post-dialog/menu guard. Ignore stale input edges for a brief
-- transition and require a fresh press after held keys are released.
function Session:guard_input(seconds, actions)
    local ctrl,owner=self:input()
    if not ctrl then return false,"control context is not current" end
    local timeout=tonumber(seconds) or 0
    if timeout>0 then ctrl:swallow(timeout,owner)
    else ctrl:consume(owner) end
    ctrl:require_release(actions or guards,owner)
    lifecycle("handoff","guarding resumed input",{player_id=self.player_id,
        owner=self.label,swallow_seconds=timeout})
    return true
end
-- A native textbox owns its own client input. Park callback delivery while
-- it is shown and re-arm only this session after the response. The caller
-- keeps ownership of dialog closure and decides when to invoke :resume().
function Session:begin_native_handoff(options)
    options=options or {}
    if not self:is_alive() then return nil,"inactive session" end
    local ok,err=self:yield_to_native_ui()
    if not ok then return nil,err end
    lifecycle("handoff","native dialog suspended",{player_id=self.player_id,owner=self.label})
    local handoff={session=self,finished=false}
    function handoff:resume()
        if self.finished then return false,"native handoff already completed" end
        self.finished=true
        if not self.session:is_alive() then return false,"session closed" end
        if not self.session:resume_buttons() then return false,"session did not regain focus" end
        lifecycle("handoff","native dialog resumed",{player_id=self.session.player_id,
            owner=self.session.label})
        return self.session:guard_input(options.swallow_seconds or 0.35,options.actions)
    end
    return handoff
end

function Session:set_repeat_delays(first,interval)
    if not self:is_alive() then return false end
    self.first_repeat_delay=first
    self.repeat_delay=interval
    if self:is_current() then return sync_focus(self.state) end
    return true
end
function Session:on_close(fn)
    assert(type(fn)=="function","callback must be a function")
    self.close_callbacks[#self.close_callbacks+1]=fn
    return self
end
function Session:on_error(fn)
    assert(type(fn)=="function","callback must be a function")
    self.error_callbacks[#self.error_callbacks+1]=fn
    return self
end
function Session:on_suspend(fn)
    assert(type(fn)=="function","callback must be a function")
    self.suspend_callbacks[#self.suspend_callbacks+1]=fn
    return self
end
function Session:on_resume(fn)
    assert(type(fn)=="function","callback must be a function")
    self.resume_callbacks[#self.resume_callbacks+1]=fn
    return self
end
function Session:yield_to_native_ui()
    if not self:is_alive() then return false end
    self.native=true
    return sync_focus(self.state)
end
function Session:resume_buttons()
    if not self:is_alive() then return false end
    self.native=false
    sync_focus(self.state)
    return self:is_current()
end
function Session:suspend_buttons() return self:yield_to_native_ui() end
function Session:child(opts)
    opts=opts or {}; opts.parent=self
    return M.begin(self.player_id,opts)
end

local function restore_camera(lease)
    if not lease then return true end
    if lease.released then return true end
    local ok,err=CameraFocus.release(lease)
    if not ok then
        local pid=lease.player_id
        pending[pid]=pending[pid] or {}
        pending[pid]["camera:"..lease.id]={handle=lease,label="camera "..tostring(lease.label),release=CameraFocus.release}
        report("camera release",err)
    end
    return ok
end
function Session:close()
    if self.closed then return true end
    if self.closing then return false,"session already closing" end
    self.closing=true
    local state=self.state
    state.closing_depth=(state.closing_depth or 0)+1
    -- Snapshot children: their cleanup callbacks may themselves close scopes.
    local children={}
    for _,item in ipairs(state.stack) do
        local p=item.parent
        while p do
            if p==self then children[#children+1]=item;break end
            p=p.parent
        end
    end
    for i=#children,1,-1 do if not children[i].closed then children[i]:close() end end
    self.closed=true
    for i=#state.stack,1,-1 do
        if state.stack[i]==self then table.remove(state.stack,i);break end
    end
    -- UI cleanup runs before releasing capture and camera ownership.
    for _,fn in ipairs(self.close_callbacks) do safe_callback(self,fn,"on_close",self) end
    if self.camera_handle then
        local restored=restore_camera(self.camera_handle)
        lifecycle("camera","camera lease release",{player_id=self.player_id,
            owner=self.label,success=restored})
    end
    if self.hud_handle then release_or_queue(self.player_id,self.hud_handle,"HUD "..self.label) end
    if self.capture_handle then release_or_queue(self.player_id,self.capture_handle,"capture "..self.label) end
    self.closing=false
    state.closing_depth=state.closing_depth-1
    if #state.stack==0 then
        detach_state(state)
    else
        sync_focus(state)
    end
    lifecycle("input","control session closed",{player_id=self.player_id,
        owner=self.label,session_id=self.id,pending_release=pending[self.player_id]~=nil})
    return not pending[self.player_id]
end

local function rollback_state(state)
    if #state.stack==0 then detach_state(state) end
end
function M.begin(pid,options)
    options=options or {}
    if not pid then return nil,"player_id required" end
    M.retry_cleanup(pid)
    local profile=profiles[options.profile or "menu"]
    if not profile then return nil,"unknown profile "..tostring(options.profile) end
    -- If explicitly requested, yield the standalone free camera before
    -- evaluating whether another PlayerControl root already occupies focus.
    if not options.parent and options.handoff_free_camera then
        local ok,manager=pcall(require,"scripts/camera/camera-manager")
        if ok and manager then
            local cam=manager:get_controller(pid)
            if cam and cam.is_active and cam.input_session then
                manager:deactivate_camera(pid,true)
            end
        end
    end
    local state,err=state_for(pid)
    if not state then return nil,err end
    if (state.closing_depth or 0)>0 then return nil,"a control session is closing" end
    local parent=options.parent
    if parent then
        if not parent:is_alive() or parent.state~=state then return nil,"parent session inactive" end
        if top(state)~=parent then return nil,"parent is not active" end
    elseif #state.stack>0 then
        return nil,"another PlayerControl context is active"
    end
    local focus=options.focus==nil and profile.focus or options.focus
    if focus and state.ctrl:get_input_owner()~=nil and not state.ctrl:has_input_control(state.owner) then
        if options.handoff_free_camera then
            local ok,manager=pcall(require,"scripts/camera/camera-manager")
            if ok and manager then
                local cam=manager:get_controller(pid)
                if cam and cam.is_active and (state.ctrl:get_input_owner()==cam or
                    (cam.input_session and state.ctrl:get_input_owner()==cam.input_session.state.owner)) then
                    manager:deactivate_camera(pid,true)
                end
            end
        end
        if state.ctrl:get_input_owner()~=nil and not state.ctrl:has_input_control(state.owner) then
            rollback_state(state)
            return nil,"input is owned by another system"
        end
    end
    serial=serial+1
    local s=setmetatable({id=serial,player_id=pid,label=options.owner or "anonymous",
        state=state,parent=parent,focus=focus,native=options.native==true,
        closed=false,closing=false,pressed={},repeated={},released={},
        close_callbacks={},error_callbacks={},suspend_callbacks={},resume_callbacks={},
        first_repeat_delay=options.first_repeat_delay,repeat_delay=options.repeat_delay},Session)
    if options.capture~=false and profile.capture then
        s.capture_handle,err=Suppression.acquire_input_lock(pid,s.label)
        if not s.capture_handle then rollback_state(state); return nil,err end
    end
    if options.hud=="hidden" or (options.hud==nil and profile.hud) then
        s.hud_handle,err=Suppression.acquire_engine_hud(pid,s.label)
        if not s.hud_handle then
            release_or_queue(pid,s.capture_handle,"rollback capture "..s.label)
            rollback_state(state)
            return nil,err
        end
    end
    if options.camera=="exclusive" or options.camera=="scripted" then
        local parent_camera = parent and parent.camera_handle or nil
        s.camera_handle,err=CameraFocus.acquire(pid,s,{label=s.label,parent=parent_camera,
            restore_on_release=options.restore_camera~=false})
        if not s.camera_handle then
            release_or_queue(pid,s.hud_handle,"rollback HUD "..s.label)
            release_or_queue(pid,s.capture_handle,"rollback capture "..s.label)
            rollback_state(state)
            return nil,err
        end
    end
    state.stack[#state.stack+1]=s
    attach_events(state)
    local ok,success,why=pcall(sync_focus,state)
    if not ok or not success then
        s:close()
        return nil,ok and why or success
    end
    lifecycle("input","control session started",{player_id=pid,owner=s.label,
        session_id=s.id,profile=options.profile or "menu",parent=parent and parent.label or nil})
    if s.camera_handle then lifecycle("camera","camera lease acquired",{player_id=pid,
        owner=s.label,session_id=s.id}) end
    return s
end

-- These methods call only OpenNetBattle camera APIs used elsewhere in this
-- server. A stale or suspended context cannot change another owner's camera.
function Session:camera()
    local session=self
    if not session.camera_handle then return nil,"session has no camera lease" end
    local api={}
    local function call(name,...)
        if not session:is_alive() or not CameraFocus.is_current(session.camera_handle) then
            return false,"camera lease not current"
        end
        if not Net or type(Net[name])~="function" then return false,"Net."..name.." unavailable" end
        return pcall(Net[name], session.player_id, ...)
    end
    function api:move_to(x,y,z) return call("move_player_camera",x,y,z) end
    function api:slide_to(x,y,z,duration) return call("slide_player_camera",x,y,z,duration) end
    function api:follow_player()
        local ok,err=call("unlock_player_camera")
        if not ok then return false,err end
        return call("track_with_player_camera")
    end
    return api
end

function M.get_active(pid) return states[pid] and top(states[pid]) or nil end
function M.get_debug_state(pid)
    local state=states[pid]
    local entries={}
    if state then
        for i,s in ipairs(state.stack) do
            entries[i]={id=s.id,owner=s.label,current=top(state)==s,native=s.native,
                delivery=s.delivery}
        end
    end
    local release={}
    for id,item in pairs(pending[pid] or {}) do release[#release+1]={id=id,label=item.label} end
    local named={}
    for owner,item in pairs(named_resources[pid] or {}) do
        named[#named+1]={owner=owner,input=item.input~=nil and not item.input.released,
            hud=item.hud~=nil and not item.hud.released}
    end
    return {stack=entries,capture=Suppression.get_debug_state(pid),
        camera=CameraFocus.get_debug_state(pid),pending_releases=release,named_resources=named}
end
function M.cleanup_player(pid)
    local state=states[pid]
    if state then
        while #state.stack>0 do
            local s=state.stack[#state.stack]
            if not s.closed then s:close() else table.remove(state.stack) end
        end
        detach_state(state)
    end
    -- Snapshot the keys: release mutates the owner table.
    local names={}
    for owner in pairs(named_resources[pid] or {}) do names[#names+1]=owner end
    for _,owner in ipairs(names) do
        M.restore_hud(pid,owner)
        M.release_capture(pid,owner)
    end
    named_resources[pid]=nil
    M.retry_cleanup(pid)
    Suppression.cleanup_player(pid)
    CameraFocus.cleanup_player(pid)
end
Net:on("player_disconnect",function(event) M.cleanup_player(event.player_id) end)
-- Recovery attempts are rate-limited to roughly once per second, not every
-- server tick, to avoid log floods while Net restoration is unavailable.
local elapsed=0
Net:on("tick",function(event)
    elapsed=elapsed+(tonumber(event and event.delta_time) or 0)
    if elapsed>=1 then
        elapsed=0
        for pid in pairs(pending) do M.retry_cleanup(pid) end
    end
end)
return M
