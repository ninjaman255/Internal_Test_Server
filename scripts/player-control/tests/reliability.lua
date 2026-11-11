-- Failure-injection and camera focus integration tests against actual Lua modules.
-- Run at the server root: texlua scripts/player-control/tests/reliability.lua
package.path="./?.lua;./?/init.lua;"..package.path
local listeners,call_counts={}, {lock=0,unlock=0,hud=0,untrack=0,track=0,move=0}
local fail={unlock=0, track=0, untrack=0, position=0}
Net={}
function Net:on(name,callback)
    listeners[name]=listeners[name] or {}
    listeners[name][#listeners[name]+1]=callback
end
local function emit(name,event)
    for _,callback in ipairs(listeners[name] or {}) do callback(event) end
end
function Net.lock_player_input(pid) call_counts.lock=call_counts.lock+1 end
function Net.unlock_player_input(pid)
    if fail.unlock>0 then fail.unlock=fail.unlock-1;error("injected unlock error") end
    call_counts.unlock=call_counts.unlock+1
end
function Net.toggle_player_hud(pid) call_counts.hud=call_counts.hud+1 end
function Net.unlock_player_camera(pid)
    if fail.untrack>0 then fail.untrack=fail.untrack-1;error("injected untrack error") end
    call_counts.untrack=call_counts.untrack+1
end
function Net.track_with_player_camera(pid)
    if fail.track>0 then fail.track=fail.track-1;error("injected track error") end
    call_counts.track=call_counts.track+1
end
function Net.get_player_position(pid)
    if fail.position>0 then fail.position=fail.position-1;error("injected position error") end
    return {x=2,y=3,z=0}
end
function Net.move_player_camera(pid,x,y,z) call_counts.move=call_counts.move+1 end
function Net.slide_player_camera(pid,x,y,z,duration) return true end

local InputAPI=require('scripts/input-controller/main')
local Control=require('scripts/player-control/main')
local ControlResources=require('scripts/player-control/main')
local CameraFocus=require('scripts/player-control/camera-focus')
local CameraController=require('scripts/camera/camera-controller')
local mode=require('scripts/enum/predefined-enums').CameraMode.PlayerControlled
local function join(pid)
    emit('player_join',{player_id=pid})
    return assert(InputAPI.get_controller(pid))
end
local function count(name) return call_counts[name] end
local function eq(a,b,label) assert(a==b,(label or "mismatch").." expected "..tostring(b).." got "..tostring(a)) end

local ctrl=join('r1')
local base_first,base_interval=ctrl:get_repeat_delays()
local desktop=assert(Control.begin('r1',{owner='desktop',profile='desktop'}))
local close_calls=0
local suspend_calls=0
local resume_calls=0
desktop:on_close(function() close_calls=close_calls+1;error('fake UI disposal error') end)
desktop:on_suspend(function() suspend_calls=suspend_calls+1 end)
desktop:on_resume(function() resume_calls=resume_calls+1 end)
local child=assert(desktop:child({owner='child',profile='menu',first_repeat_delay=.07,repeat_delay=.02}))
eq(suspend_calls,1,'parent suspend once')
local a,b=ctrl:get_repeat_delays();eq(a,.07,'child first repeat');eq(b,.02,'child repeat')
child:yield_to_native_ui()
local after_pause=resume_calls
child:yield_to_native_ui()
eq(resume_calls,after_pause,'no redundant transition')
child:resume_buttons()
child:close()
a,b=ctrl:get_repeat_delays();eq(a,base_first,'parent first repeat');eq(b,base_interval,'parent repeat')
fail.unlock=1
local closed=desktop:close()
assert(not closed,'first release must remain retryable')
eq(close_calls,1,'close callback exactly once')
local state=Control.get_debug_state('r1')
eq(#state.pending_releases,1,'failed capture held')
assert(Control.retry_cleanup('r1'))
eq(#Control.get_debug_state('r1').pending_releases,0,'retry clears capture')
assert(desktop:close(),'close is idempotent')
eq(close_calls,1,'no duplicate callback')

-- One input edge listener throwing must not stop the remaining listeners.
local ctrl2=join('r2')
local continued=0
ctrl2:on('button_pressed',function() error('broken legacy subscriber') end)
ctrl2:on('button_pressed',function() continued=continued+1 end)
ctrl2:handle_raw_input({{name='Confirm',state=1}})
assert(continued>0,'a throwing listener interrupted input dispatch')

-- Shared compatibility capture: repeated locks from one owner are idempotent.
local before=count('lock')
ControlResources.acquire_capture('r3','feature:a')
ControlResources.acquire_capture('r3','feature:a')
ControlResources.acquire_capture('r3','feature:b')
eq(count('lock'),before+1,'shared engine lock')
ControlResources.release_capture('r3','feature:a')
assert(ControlResources.has_capture('r3','feature:b'),'unrelated capture was released')
ControlResources.release_capture('r3','feature:b')

-- Explicit camera leases cannot be overwritten by another root.
local player=join('r4')
local root=assert(Control.begin('r4',{owner='scene',profile='cinematic',camera='exclusive'}))
local cam=assert(root:camera())
assert(cam:move_to(1,2,0))
local denied=Control.begin('r4',{owner='intruder',profile='cinematic',camera='exclusive'})
assert(not denied,'competing root was accepted')
local nested=assert(root:child({owner='child-camera',profile='cinematic',camera='exclusive'}))
local child_camera=assert(nested:camera())
assert(not cam:move_to(3,4,0),'suspended camera owner moved camera')
assert(child_camera:move_to(5,6,0))
local before_track=count('track')
nested:close()
eq(count('track'),before_track,'child restored player tracking')
assert(cam:move_to(7,8,0))
fail.track=1
local released=root:close()
assert(not released,'camera restoration failure lost the lease')
eq(#Control.get_debug_state('r4').pending_releases,1,'camera restore pending')
assert(Control.retry_cleanup('r4'),'camera retry failed')
assert(CameraFocus.get_current('r4')==nil,'stale camera lease')

-- CameraController uses PlayerControl as the exclusive input/camera owner.
local playerctrl=join('r5')
local camera=CameraController:new('r5',{mode=mode})
fail.position=1
local success=camera:activate(mode,true)
assert(not success and not camera.is_active and not camera.input_session,
    'camera partial activation left state behind')
assert(CameraFocus.get_current('r5')==nil,'failed activation leaked camera lease')
assert(camera:activate(mode,true),'camera should recover from failed activate')
local active=camera.input_session
assert(active and active:is_current(),'camera has no managed input focus')
local first,interval=playerctrl:get_repeat_delays()
assert(first~=base_first or interval~=base_interval,'camera repeat policy not active')
-- Forced ownership theft is legacy-only, but old camera must not re-track.
local before_forced=count('track')
assert(playerctrl:claim_input({rogue=true},true))
assert(not camera.is_active,'camera ignored ownership loss')
eq(count('track'),before_forced,'old camera restored tracking after ownership loss')
eq(playerctrl:get_repeat_delays(),base_first,'old repeat policy persisted')
assert(playerctrl:release_input(playerctrl:get_input_owner()))
local menu=assert(Control.begin('r5',{owner='new-menu',profile='menu'}))
menu:close()
local CameraManager=require('scripts/camera/camera-manager')
CameraManager.PlayerControllers['r5']=camera
assert(camera:activate(mode,true))
local menu2=assert(Control.begin('r5',{
    owner='hp_desktop',profile='desktop',handoff_free_camera=true,
}))
assert(not camera.is_active,'explicit free-camera handoff did not deactivate camera')
assert(menu2:is_current(),'new desktop did not obtain input after camera handoff')
menu2:close()
CameraManager.PlayerControllers['r5']=nil

emit('player_disconnect',{player_id='r1'})
emit('player_disconnect',{player_id='r2'})
emit('player_disconnect',{player_id='r4'})
emit('player_disconnect',{player_id='r5'})
print('PlayerControl reliability tests passed')
