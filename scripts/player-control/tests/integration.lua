-- Integration smoke test using the REAL shared InputController, with Net mocked.
-- Run from server root: texlua scripts/player-control/tests/integration.lua
package.path = './?.lua;./?/init.lua;' .. package.path
local callbacks={}
local counters={lock=0,unlock=0,hud=0}
Net={}
function Net:on(event,fn)
  callbacks[event]=callbacks[event] or {}
  callbacks[event][#callbacks[event]+1]=fn
end
function Net.lock_player_input(id) counters.lock=counters.lock+1 end
function Net.unlock_player_input(id) counters.unlock=counters.unlock+1 end
function Net.toggle_player_hud(id) counters.hud=counters.hud+1 end
local function emit(name,payload)
  for _,fn in ipairs(callbacks[name] or {}) do fn(payload) end
end
local InputAPI=require('scripts/input-controller/main')
local Control=require('scripts/player-control/main')
emit('player_join',{player_id='realctrl'})
local parent=assert(Control.begin('realctrl',{owner='desktop',profile='desktop'}))
local ctrl=assert(InputAPI.get_controller('realctrl'))
local events={{'Confirm','Confirm',false}}
-- When a key was held during the handoff, the release guard must ignore it.
ctrl:handle_raw_input({{name='Confirm',state=1}})
local item=parent:poll(events)
assert(item and #item.events==1, 'parent should see initial Confirm')
local child=assert(parent:child({owner='child',profile='settings_menu'}))
assert(not child:poll(events) or #child:poll(events).events==0,
  'child inherited the parent Confirm press')
ctrl:handle_raw_input({{name='Confirm',state=3}})
ctrl:handle_raw_input({{name='Confirm',state=1}})
local child_event=child:poll(events)
assert(child_event and #child_event.events==1, 'child did not see fresh Confirm')
child:close()
assert(counters.unlock==0, 'closing child restored engine input')
parent:close()
assert(counters.lock==1 and counters.unlock==1, 'unbalanced capture')
emit('player_disconnect',{player_id='realctrl'})
print('PlayerControl with real InputController: passed')
