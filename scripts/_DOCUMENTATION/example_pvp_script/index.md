# 📄 `example_pvp_script.lua` — Current Lua reference

[🏠 Documentation home](../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/example_pvp_script.lua`](../../example_pvp_script.lua)  
> **Source lines:** 105  
> **SHA-256 (UTF-8):** `1a38f1e923fdace13d83e8388edda8d91f053d5f7076ac4f5c2895bed4adfda7`  
> **Named/assigned functions detected:** 0  
> **Table initializers detected:** 2

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/example_pvp_script.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 16 | `Net` | `player_connect` |
| 20 | `Net` | `tile_interaction` |
| 24 | `Net` | `player_disconnect` |
| 31 | `Net` | `actor_interaction` |
| 78 | `Net` | `textbox_response` |

## Functions

No named function declarations matched. Anonymous callbacks may exist.

## Tables

| Source line | Assignment |
|---:|---|
| 13 | `requests` |
| 14 | `questioned_requests` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_player` | 1 | 21 |
| `Net.exclusive_player_emote` | 1 | 101 |
| `Net.get_player_mugshot` | 1 | 66 |
| `Net.initiate_pvp` | 1 | 97 |
| `Net.on` | 5 | 16 |
| `Net.question_player` | 1 | 68 |
