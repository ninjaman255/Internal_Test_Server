# `ezlibs-scripts/main.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Main source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/main.lua`
- **Reference:** `script-reference/ezlibs-scripts/main.lua.md`
- **Source SHA-256 prefix:** `5be35481d331`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/ezencounters/main` |
| `scripts/ezlibs-scripts/ezbattle_results` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezmystery` |
| `scripts/ezlibs-scripts/ezweather` |
| `scripts/ezlibs-scripts/ezwarps/main` |
| `scripts/ezlibs-scripts/ezfarms` |
| `scripts/events/eznpcs_onceitem` |
| `scripts/ezlibs-scripts/ezcheckpoints` |
| `scripts/ezlibs-scripts/ezannounce/ezannounce` |
| `scripts/ezlibs-scripts/ezemail` |
| `scripts/ezlibs-scripts/ezexplosions` |
| `scripts/ezlibs-scripts/ezrushroads` |
| `scripts/ezlibs-scripts/ezpress` |
| `scripts/ezlibs-scripts/ezusers` |
| `scripts/ezlibs-scripts/ezbbs` |
| `scripts/ezlibs-scripts/ezbuttons` |
| `scripts/ezlibs-scripts/eznpcs/ezpushback` |
| `scripts/ezlibs-scripts/eznpcs/npc_behaviors` |
| `scripts/ezlibs-scripts/eztriggers/ezbottriggers` |
| `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` |
| `scripts/ezlibs-scripts/object_registry` |

## `Net:on` subscriptions

| Event |
|---|
| `battle_results` |
| `battle_exit` |
| `shop_purchase` |
| `shop_close` |
| `custom_warp` |
| `player_move` |
| `player_request` |
| `tile_interaction` |
| `post_selection` |
| `board_close` |
| `player_avatar_change` |
| `player_join` |
| `actor_interaction` |
| `tick` |
| `player_disconnect` |
| `object_interaction` |
| `player_area_transfer` |
| `textbox_response` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `provide_asset_for_player`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/hurt.ogg` |
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` |
| `/server/assets/ezlibs-assets/sfx/recover.ogg` |
| `/server/assets/ezlibs-assets/ezfarms/card_error.ogg` |
| `/server/assets/ezlibs-assets/sfx/compress.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
