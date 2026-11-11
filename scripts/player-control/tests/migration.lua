-- Run at server root: texlua scripts/player-control/tests/migration.lua
package.path='./?.lua;./?/init.lua;'..package.path
local listeners={}
local calls={lock=0,unlock=0,hud=0}
Net={}
function Net:on(name,fn)
  listeners[name]=listeners[name] or {}
  listeners[name][#listeners[name]+1]=fn
end
local function emit(name,e)
  for _,fn in ipairs(listeners[name] or {}) do fn(e or {}) end
end
function Net.lock_player_input(pid) calls.lock=calls.lock+1 end
function Net.unlock_player_input(pid) calls.unlock=calls.unlock+1 end
function Net.toggle_player_hud(pid) calls.hud=calls.hud+1 end
function Net.get_player_position(pid) return {x=1,y=1,z=0} end
function Net.unlock_player_camera(pid) end
function Net.track_with_player_camera(pid) end
function Net.is_player(pid) return true end
local text_names={}
package.loaded['scripts/net-games/main']={}
package.loaded['scripts/displayer/displayer']={
    Text={drawStatic=function(pid,id,value) text_names[id]=true end,
          removeStatic=function(pid,id) text_names[id]=nil end},
    Font={allocateAllFontsForPlayer=function() end},
}
package.loaded['scripts/net-games/ui-safe']={
    draw=function()return true end,erase=function()return true end,
    safe_provide=function()return true end,
}
local API=require('scripts/input-controller/main')
local Control=require('scripts/player-control/main')
local Menu=require('scripts/net-games/menuAPI/main')
emit('player_join',{player_id='migration'})
local ctrl=assert(API.get_controller('migration'))
-- Keyed capture resources share the underlying engine lock with a menu and
-- do not steal ownership from a managed focus session.
assert(Control.acquire_capture('migration','cutscene:a'))
assert(Control.acquire_capture('migration','cutscene:a'))
assert(Control.acquire_capture('migration','cutscene:b'))
assert(calls.lock==1,'repeated resource acquisition locked engine twice')
local first=assert(Menu.open('migration',{type=2,title='Info'}))
assert(first.control_session:is_current(),'menu lacks focus')
local child=assert(Menu.open('migration',{type=3,title='Choose',rows={'A','B'}}))
assert(child.control_session:is_current(),'child lacks focus')
assert(not first.control_session:is_current(),'parent focus was not suspended')
assert(Menu.close('migration',{reason='cancel'}))
assert(first.control_session:is_current(),'parent menu did not regain focus')
assert(Control.has_capture('migration','cutscene:b'),'menu released a cutscene capture')
assert(Menu.close('migration',{reason='done'}))
assert(not Control.get_active('migration'),'menu session leaked')
assert(Control.release_capture('migration','cutscene:a'))
assert(calls.unlock==0,'one capture owner released another owner')
assert(Control.release_capture('migration','cutscene:b'))
assert(calls.unlock==1,'final capture owner did not unlock')
-- The existing menu option to retain engine capture after UI teardown
-- remains usable, without preserving the old UI session or input owner.
local retained=assert(Menu.open('migration',{type=2,title='Retained'}))
assert(Menu.close('migration',{keep_locked=true}))
assert(Control.has_capture('migration','menuAPI:retained:migration'))
local next_menu=assert(Menu.open('migration',{type=2,title='Following'}))
assert(not Control.has_capture('migration','menuAPI:retained:migration'))
assert(next_menu.control_session:is_current())
Menu.close_all('migration')
-- Existing PlayerControl roots deny an unrelated root menu; neither is
-- overwritten nor left in a half-open MenuAPI stack.
local root=assert(Control.begin('migration',{owner='external-menu',profile='menu'}))
local denied=Menu.open('migration',{title='Denied'})
assert(not denied and not Menu.is_open('migration'),'foreign root menu was opened')
assert(root:is_current(),'foreign menu took focus')
root:close()
-- Native dialogue handoff preserves the parent session and refuses late or
-- duplicated response completion.
local native=assert(Control.begin('migration',{owner='native-parent',profile='menu'}))
local handoff=assert(native:begin_native_handoff({swallow_seconds=0.35}))
assert(not native:is_current(),'native dialog failed to suspend input')
assert(handoff:resume(),'native response failed to restore input')
assert(native:is_current(),'parent did not regain focus after native response')
assert(not handoff:resume(),'same dialog response resumed twice')
native:close()

-- Closing the owner session removes the menu's rendered UI and menu stack.
local a=assert(Menu.open('migration',{type=3,title='Disconnect',rows={'X'}}))
assert(Menu.is_open('migration'))
assert(Control.suppress_hud('migration','dialogue:hud'))
emit('player_disconnect',{player_id='migration'})
assert(not Menu.is_open('migration'),'menu leaked after disconnect')
assert(not Control.get_active('migration'),'focus leaked after disconnect')
assert(not Control.has_capture('migration','cutscene:a'))
assert(calls.hud==2,'HUD was not restored after disconnect')
print('PlayerControl migration and MenuAPI nested-session tests passed')
