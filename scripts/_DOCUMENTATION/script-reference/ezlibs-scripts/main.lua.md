# `ezlibs-scripts/main.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/main.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/events/eznpcs_onceitem` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezannounce/ezannounce` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbattle_results` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbbs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbuttons` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcheckpoints` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemail` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezencounters/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezexplosions` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezfarms` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmystery` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/ezpushback` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezpress` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezrushroads` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/ezbottriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezusers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezweather` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `battle_exit` | `Net:on(...)` subscription found in source. |
| `battle_results` | `Net:on(...)` subscription found in source. |
| `board_close` | `Net:on(...)` subscription found in source. |
| `custom_warp` | `Net:on(...)` subscription found in source. |
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_area_transfer` | `Net:on(...)` subscription found in source. |
| `player_avatar_change` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `player_move` | `Net:on(...)` subscription found in source. |
| `player_request` | `Net:on(...)` subscription found in source. |
| `post_selection` | `Net:on(...)` subscription found in source. |
| `shop_close` | `Net:on(...)` subscription found in source. |
| `shop_purchase` | `Net:on(...)` subscription found in source. |
| `textbox_response` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |
| `tile_interaction` | `Net:on(...)` subscription found in source. |

## Source notes

- Approximate source size: 253 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
