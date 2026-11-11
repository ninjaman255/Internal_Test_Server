# MenuAPI

> 📡 **Current-source update · 2026-11-11:** This authored guide is retained from the uploaded `internal_test_server(2).zip`. Its existing narrative/examples have **not** been exhaustively rewritten. For refreshed function signatures, parameters, dependencies, table initializers, and source line numbers, see the [regenerated module index](index.md) and [current systems guide](../../CURRENT_SYSTEMS.md). If older instructions here conflict with the current Lua implementation, follow the linked source references.


MenuAPI is a small BN-style menu layer built on net-games **Displayer**, **InputController**, and `ui-safe.lua`. It handles menu stacks, input locking, held-button handoffs, scrolling lists, profile cards, confirmation prompts, safe sprite cleanup, and partial redraws.

```lua
local MenuAPI = require("scripts/net-games/menuAPI/main")

MenuAPI.open(player_id, {
  type = "scroll_list",
  title = "Choose one",
  rows = {
    { id="a", text="Alpha", right="10" },
    { id="b", text="Beta" },
  },
  on_select = function(row, index)
    print("picked", row.id, index)
  end,
})
```

Built-in types are `scroll_list`, `info_window`, `compact_menu`, `confirm_prompt`, and `profile_list`. Most visual values can be overridden with `layout = { ... }`; rows may also provide `icon_texture`, `icon_anim`, `icon_state`, `enabled=false`, `right`, and `on_select`.

Useful calls:

```lua
MenuAPI.is_open(player_id)
MenuAPI.get_state(player_id)
MenuAPI.set_rows(player_id, rows, true) -- true keeps matching row.id selected
MenuAPI.set_profile(player_id, profile)
MenuAPI.refresh(player_id)
MenuAPI.close(player_id)
MenuAPI.close_all(player_id)
```

`confirm_prompt` uses `default_selection = 1` (Yes) or `2` (No), `lines = {...}`, and `on_result = function(yes) ... end`.

Default art is expected under `/server/assets/ui/menuAPI/` (`menu1.png`, `menu2.png`, `menu3.png`, `cursor.png`, `scroll.png`). Copy that asset folder from `shadis_hp`, or override texture paths in each menu's `layout`.

## 🎮 Managed controller ownership (November 2026)

MenuAPI opens a `PlayerControl` session for the root menu and a child session for each pushed menu. Only the top session polls the shared InputController. A foreign focus owner cannot be displaced or reclaimed from the server tick. Each closed menu removes its own UI through `session:on_close`, including on player disconnect.

`MenuAPI.open(player_id, spec)` returns `nil, reason` when another unrelated PlayerControl root is active. For a menu opened intentionally from an already managed parent, pass `spec.parent_session=parent_session`. Native input settling is applied by `session:guard_input(...)`.

`MenuAPI.close(player_id,{keep_locked=true})` and `close_all(...,{keep_locked=true})` preserve the former option by acquiring a named PlayerControl engine capture before releasing the menu. Opening a new MenuAPI root or closing without `keep_locked` releases that retained capture. For new code, prefer an explicitly owned PlayerControl capture scope instead.
