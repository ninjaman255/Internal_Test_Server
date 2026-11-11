# 📄 `prog_vert_prompt.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt.lua`](../../../../net-games/npcs/prog_vert_prompt.lua)  
> **Source lines:** 227  
> **SHA-256 (UTF-8):** `d7204ed7c5074e4c3313538d808f3d293b630c27ab505ef48379740b19dce4e1`  
> **Named/assigned functions detected:** 4  
> **Table initializers detected (simple pattern):** 5

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/net-games/npcs/prog_vert_prompt.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 10 | `scripts/libs/direction` |
| 11 | `scripts/net-games/dialogue/startup` |
| 13 | `scripts/net-games/dialogue/dialogue` |
| 14 | `scripts/net-games/dialogue/prompt_vertical` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 185 | `Net` | `actor_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 45 | `build_options` | `(none)` | local |
| 58 | `build_ui_config` | `box_id` | local |
| 149 | `build_layout_config` | `(none)` | local |
| 216 | `on_select` | `choice, index` | assigned/declared |

### Detailed parameter inventory

#### 1. `build_options()`

- **Line:** 45
- **Declaration:** local
- **Nearby code comment:** Options builder (menu entries)
- **Parameters:** none explicitly declared.

#### 2. `build_ui_config(box_id)`

- **Line:** 58
- **Declaration:** local
- **Nearby code comment:** Shared UI config (So the prompt + follow-up dialogue stay visually identical)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `box_id` | Declared by this function; type not inferred. |

#### 3. `build_layout_config()`

- **Line:** 149
- **Declaration:** local
- **Nearby code comment:** Shared menu layout config
- **Parameters:** none explicitly declared.

#### 4. `on_select(choice, index)`

- **Line:** 216
- **Declaration:** table/global or assignment
- **Nearby code comment:** When the player selects an option: Reuse the existing textbox AND keep the mugshot consistent.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `choice` | Declared by this function; type not inferred. |
| 2 | `index` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 46 | `t` |
| 77 | `mugshot` |
| 108 | `backdrop` |
| 126 | `indicator` |
| 132 | `nameplate` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 28 |
| `Net.get_bot_name` | 1 | 40 |
| `Net.get_object_by_name` | 1 | 22 |
| `Net.get_player_position` | 1 | 193 |
| `Net.on` | 1 | 185 |
| `Net.set_bot_direction` | 1 | 194 |
