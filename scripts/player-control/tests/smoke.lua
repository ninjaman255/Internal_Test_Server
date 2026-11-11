-- Run from server root with: texlua scripts/player-control/tests/smoke.lua
-- Mocks only Net and InputAPI; runs the real PlayerControl + UISuppression.
package.path = "./?.lua;./?/init.lua;" .. package.path
local handlers = {}
local count = {lock=0, unlock=0, hud=0}
Net = {}
function Net:on(name, fn)
  handlers[name]=handlers[name] or {}
  handlers[name][#handlers[name]+1]=fn
end
function Net.lock_player_input(pid) count.lock=count.lock+1 end
function Net.unlock_player_input(pid) count.unlock=count.unlock+1 end
function Net.toggle_player_hud(pid) count.hud=count.hud+1 end
local InputAPI = {}
local controllers={}
function InputAPI.create_controller(pid)
  local ctrl={owner=nil, handlers={}, first=0.30, interval=0.10, destroyed=false}
  function ctrl:get_input_owner() return self.owner end
  function ctrl:claim_input(owner)
    if self.owner then return false end
    self.owner=owner
    self:emit('input_owner_changed',{owner=owner})
    return true
  end
  function ctrl:release_input(owner)
    if self.owner~=owner then return false end
    self.owner=nil
    self:emit('input_owner_changed',{owner=nil})
    return true
  end
  function ctrl:has_input_control(owner) return self.owner==owner end
  function ctrl:get_repeat_delays() return self.first,self.interval end
  function ctrl:set_repeat_delays(first,repeat_delay)
    self.first=first;self.interval=repeat_delay
  end
  function ctrl:require_release(actions, owner) self.guards=actions end
  function ctrl:consume(owner) end
  function ctrl:is_action_pressed(action,owner) return self.owner==owner and self.pressed==action end
  function ctrl:is_action_repeated(action,owner) return self.owner==owner and self.repeated==action end
  function ctrl:on(event,fn)
    self.handlers[event]=self.handlers[event] or {}
    table.insert(self.handlers[event],fn)
  end
  function ctrl:off(event,fn)
    local hs=self.handlers[event] or {}
    for i=#hs,1,-1 do if hs[i]==fn then table.remove(hs,i) end end
  end
  function ctrl:emit(event,data)
    for _,fn in ipairs(self.handlers[event] or {}) do fn(data) end
  end
  controllers[pid]=ctrl
  return ctrl
end
function InputAPI.get_controller(pid) return controllers[pid] end
package.loaded['scripts/input-controller/main']=InputAPI
local Control = require('scripts/player-control/main')
local function verify(test_name, expected, actual)
  assert(expected==actual, test_name..': expected '..tostring(expected)..', got '..tostring(actual))
end
local root=assert(Control.begin('player1',{owner='HP Manager',profile='desktop'}))
verify('initial lock',1,count.lock)
local ctrl=InputAPI.get_controller('player1')
local clicked=0
root:on_pressed('Confirm',function() clicked=clicked+1 end)
ctrl:emit('button_pressed',{action='Confirm',input_owner=ctrl.owner})
verify('parent gets button',1,clicked)
local child=assert(root:child({owner='Jukebox',profile='music_menu'}))
verify('shared capture',1,count.lock)
verify('hud hidden',1,count.hud)
ctrl:emit('button_pressed',{action='Confirm',input_owner=ctrl.owner})
verify('parent suspended',1,clicked)
local child_clicks=0
child:on_pressed('Confirm',function() child_clicks=child_clicks+1 end)
ctrl:emit('button_pressed',{action='Confirm',input_owner=ctrl.owner})
verify('child receives button',1,child_clicks)
assert(child:yield_to_native_ui())
verify('no native input dispatch',false,child:is_current())
ctrl:emit('button_pressed',{action='Confirm',input_owner=ctrl.owner})
verify('native ignores buttons',1,child_clicks)
assert(child:resume_buttons())
child:close()
verify('no premature unlock',0,count.unlock)
verify('hud restored',2,count.hud)
ctrl:emit('button_pressed',{action='Confirm',input_owner=ctrl.owner})
verify('parent focus resumed',2,clicked)
root:close()
verify('unlocked once',1,count.unlock)
verify('all handlers removed',0,#(ctrl.handlers.button_pressed or {}))
-- Idempotency and restart.
root:close()
verify('no double unlock',1,count.unlock)
local next_session=assert(Control.begin('player1',{owner='Next',profile='menu'}))
verify('new capture',2,count.lock)
next_session:close()
verify('new release',2,count.unlock)
-- Other owner may not be force-claimed.
ctrl.owner='external game'
local blocked,err=Control.begin('player1',{owner='blocked',profile='menu'})
verify('exclusive denial',nil,blocked)
assert(type(err)=='string')
ctrl.owner=nil
-- Disconnection automatically closes all nested sessions.
local a=assert(Control.begin('player2',{owner='top',profile='desktop'}))
local b=assert(a:child({owner='child',profile='settings_menu'}))
for _,handler in ipairs(handlers.player_disconnect or {}) do handler({player_id='player2'}) end
assert(not a:is_alive() and not b:is_alive())
verify('disconnect releases capture',3,count.unlock)
print('PlayerControl smoke tests passed')
