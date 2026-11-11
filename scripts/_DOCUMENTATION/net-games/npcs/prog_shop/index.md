# 📄 `prog_shop.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_shop.lua`](../../../../net-games/npcs/prog_shop.lua)  
> **Source lines:** 64  
> **SHA-256 (UTF-8):** `b4bf2aa31bb0e91585bf973b2f85d943584243583259a7717ae0555312fbde19`  
> **Named/assigned functions detected:** 1  
> **Table initializers detected (simple pattern):** 3

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/net-games/npcs/prog_shop.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 9 | `scripts/net-games/npcs/talk` |

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 25 | `on_interact` | `player_id, _bot_id, bot_name` | assigned/declared |

### Detailed parameter inventory

#### 1. `on_interact(player_id, _bot_id, bot_name)`

- **Line:** 25
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `_bot_id` | Declared by this function; type not inferred. |
| 3 | `bot_name` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 35 | `options` |
| 38 | `texts` |
| 52 | `assets` |

## Net API calls

No direct `Net.method(...)` call expression matched.
