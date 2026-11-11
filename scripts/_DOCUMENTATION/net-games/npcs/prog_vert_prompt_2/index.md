# 📄 `prog_vert_prompt_2.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_2.lua`](../../../../net-games/npcs/prog_vert_prompt_2.lua)  
> **Source lines:** 246  
> **SHA-256 (UTF-8):** `8511a5cc309f4636bfa8d53a6f57627b69d37b451d02b9ada7068a6e85506e71`  
> **Named/assigned functions detected:** 5  
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

Current source inventory for `scripts/net-games/npcs/prog_vert_prompt_2.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 15 | `scripts/libs/direction` |
| 16 | `scripts/net-games/dialogue/startup` |
| 18 | `scripts/net-games/dialogue/dialogue` |
| 19 | `scripts/net-games/dialogue/prompt_vertical` |
| 20 | `scripts/net-games/npcs/talk_presets` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 204 | `Net` | `actor_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 51 | `copy_frame_preset` | `preset` | local |
| 64 | `build_options` | `(none)` | local |
| 77 | `build_ui_config` | `box_id` | local |
| 166 | `build_layout_config` | `(none)` | local |
| 235 | `on_select` | `choice, index` | assigned/declared |

### Detailed parameter inventory

#### 1. `copy_frame_preset(preset)`

- **Line:** 51
- **Declaration:** local
- **Nearby code comment:** Frame dye preset (from talk_presets.lua)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `preset` | Declared by this function; type not inferred. |

#### 2. `build_options()`

- **Line:** 64
- **Declaration:** local
- **Nearby code comment:** Options builder (menu entries)
- **Parameters:** none explicitly declared.

#### 3. `build_ui_config(box_id)`

- **Line:** 77
- **Declaration:** local
- **Nearby code comment:** Shared UI config (So the prompt + follow-up dialogue stay visually identical)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `box_id` | Declared by this function; type not inferred. |

#### 4. `build_layout_config()`

- **Line:** 166
- **Declaration:** local
- **Nearby code comment:** Shared menu layout config
- **Parameters:** none explicitly declared.

#### 5. `on_select(choice, index)`

- **Line:** 235
- **Declaration:** table/global or assignment
- **Nearby code comment:** When the player selects an option: Reuse the existing textbox AND keep the mugshot consistent.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `choice` | Declared by this function; type not inferred. |
| 2 | `index` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 65 | `t` |
| 92 | `mugshot` |
| 114 | `backdrop` |
| 140 | `indicator` |
| 146 | `nameplate` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 34 |
| `Net.get_bot_name` | 1 | 46 |
| `Net.get_object_by_name` | 1 | 28 |
| `Net.get_player_position` | 1 | 212 |
| `Net.on` | 1 | 204 |
| `Net.set_bot_direction` | 1 | 213 |
