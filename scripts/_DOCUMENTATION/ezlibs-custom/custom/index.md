# 📄 `custom.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/custom.lua`](../../../ezlibs-custom/custom.lua)  
> **Source lines:** 188  
> **SHA-256 (UTF-8):** `cab051cda0211f42d3bd2e8b4d1bc8a4a65486e18ccb9794cc58becdaf712789`  
> **Named/assigned functions detected:** 1  
> **Table initializers detected (simple pattern):** 7

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/custom.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 5 | `scripts/ezlibs-scripts/ezbus` |
| 11 | `scripts/ezlibs-custom/endless-runner/endless-runner` |
| 140 | `scripts/ezlibs-custom/nebulous-liberations/main` |
| 141 | `scripts/ezlibs-custom/footbomb/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 67 | `ezbus` | `custom_warp` |
| 79 | `ezbus` | `endless_runner_encounter_triggered` |
| 86 | `ezbus` | `endless_runner_reward` |
| 98 | `ezbus` | `endless_runner_encounter_started` |
| 102 | `ezbus` | `endless_runner_encounter_finished` |
| 107 | `ezbus` | `endless_runner_floor_started` |
| 112 | `ezbus` | `endless_runner_floor_completed` |
| 117 | `ezbus` | `endless_runner_run_completed` |
| 123 | `ezbus` | `endless_runner_run_ended` |
| 129 | `ezbus` | `endless_runner_hp_changed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 147 | `dispatch` | `method_name, ...` | local |

### Detailed parameter inventory

#### 1. `dispatch(method_name, ...)`

- **Line:** 147
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `method_name` | Declared by this function; type not inferred. |
| 2 | `...` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 25 | `ENDLESS_RUNNER_FLOOR_PLAN` |
| 36 | `rewards` |
| 47 | `ENDLESS_RUNNER_ENTER_OPTIONS` |
| 69 | `base_area_ids` |
| 139 | `plugins` |
| 145 | `custom` |
| 162 | `forwarded_methods` |

## Net API calls

No direct `Net.method(...)` call expression matched.
