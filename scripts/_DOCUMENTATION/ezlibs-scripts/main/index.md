# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/main.lua`](../../../ezlibs-scripts/main.lua)  
> **Source lines:** 257  
> **SHA-256 (UTF-8):** `e5ce0a7a8ea7ec1042242a00031a99e7dfe81b5b635c6a2b4f4e63f87c12137a`  
> **Named/assigned functions detected:** 0  
> **Table initializers detected:** 4

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 4 | `scripts/ezlibs-scripts/helpers` |
| 5 | `scripts/ezlibs-scripts/ezbus` |
| 6 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 7 | `scripts/ezlibs-scripts/ezcache` |
| 8 | `scripts/ezlibs-scripts/ezencounters/main` |
| 9 | `scripts/ezlibs-scripts/ezbattle_results` |
| 10 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 11 | `scripts/ezlibs-scripts/ezmemory` |
| 12 | `scripts/ezlibs-scripts/ezmystery` |
| 13 | `scripts/ezlibs-scripts/ezweather` |
| 14 | `scripts/ezlibs-scripts/ezwarps/main` |
| 15 | `scripts/ezlibs-scripts/ezfarms` |
| 17 | `scripts/ezlibs-scripts/ezcheckpoints` |
| 18 | `scripts/ezlibs-scripts/ezannounce/ezannounce` |
| 19 | `scripts/ezlibs-scripts/ezemail` |
| 20 | `scripts/ezlibs-scripts/ezexplosions` |
| 21 | `scripts/ezlibs-scripts/ezrushroads` |
| 22 | `scripts/ezlibs-scripts/ezpress` |
| 23 | `scripts/ezlibs-scripts/ezusers` |
| 24 | `scripts/ezlibs-scripts/ezbbs` |
| 25 | `scripts/ezlibs-scripts/ezbuttons` |
| 26 | `scripts/ezlibs-scripts/eznpcs/ezpushback` |
| 27 | `scripts/ezlibs-scripts/eznpcs/npc_behaviors` |
| 28 | `scripts/ezlibs-scripts/eztriggers/ezbottriggers` |
| 29 | `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` |
| 70 | `scripts/ezlibs-scripts/object_registry` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 77 | `Net` | `battle_results` |
| 100 | `Net` | `battle_exit` |
| 115 | `Net` | `shop_purchase` |
| 123 | `Net` | `shop_close` |
| 131 | `Net` | `custom_warp` |
| 139 | `Net` | `player_move` |
| 147 | `Net` | `player_request` |
| 156 | `Net` | `tile_interaction` |
| 164 | `Net` | `post_selection` |
| 172 | `Net` | `board_close` |
| 180 | `Net` | `player_avatar_change` |
| 196 | `Net` | `player_join` |
| 208 | `Net` | `actor_interaction` |
| 216 | `Net` | `tick` |
| 224 | `Net` | `player_disconnect` |
| 233 | `Net` | `object_interaction` |
| 241 | `Net` | `player_area_transfer` |
| 249 | `Net` | `textbox_response` |

## Functions

No named function declarations matched. Anonymous callbacks may exist.

## Tables

| Source line | Assignment |
|---:|---|
| 33 | `plugins` |
| 54 | `sfx` |
| 83 | `stats` |
| 181 | `details` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.on` | 18 | 77 |
| `Net.provide_asset_for_player` | 1 | 204 |
