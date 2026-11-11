# 📄 `prog_dramatic_dialogue.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_dramatic_dialogue.lua`](../../../../net-games/npcs/prog_dramatic_dialogue.lua)  
> **Source lines:** 110  
> **SHA-256 (UTF-8):** `9f3067dd088f69cf88a8ca36e53df93185cdc5e554cdc677515b2f0e7dce58c1`  
> **Named/assigned functions detected:** 2  
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

Current source inventory for `scripts/net-games/npcs/prog_dramatic_dialogue.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 7 | `scripts/libs/direction` |
| 8 | `scripts/net-games/dialogue/dialogue` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 41 | `Net` | `actor_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 11 | `dbg` | `msg` | local |
| 106 | `on_finish` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `dbg(msg)`

- **Line:** 11
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `msg` | Declared by this function; type not inferred. |

#### 2. `on_finish()`

- **Line:** 106
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 70 | `ui` |
| 81 | `backdrop` |
| 92 | `indicator` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 24 |
| `Net.get_object_by_name` | 1 | 21 |
| `Net.get_player_position` | 1 | 53 |
| `Net.on` | 1 | 41 |
| `Net.set_bot_direction` | 1 | 54 |
