# 📄 `ezweather.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezweather.lua`](../../../ezlibs-scripts/ezweather.lua)  
> **Source lines:** 149  
> **SHA-256 (UTF-8):** `b1c16dc4138f3dcc9f45ffae21ac34dc68cc2558a40044f574e09be574fd75db`  
> **Named/assigned functions detected:** 8  
> **Table initializers detected:** 7

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezweather.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/ezbus` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 25 | `ezweather.start_rain_in_area` | `area_id` | assigned/declared |
| 51 | `ezweather.start_snow_in_area` | `area_id` | assigned/declared |
| 77 | `ezweather.start_fog_in_area` | `area_id` | assigned/declared |
| 98 | `fade_camera_for_players_in_area` | `area_id` | assigned/declared |
| 105 | `ezweather.get_area_weather` | `area_id` | assigned/declared |
| 113 | `ezweather.clear_weather_in_area` | `area_id` | assigned/declared |
| 135 | `ezweather.handle_player_transfer` | `player_id` | assigned/declared |
| 142 | `ezweather.handle_player_join` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `ezweather.start_rain_in_area(area_id)`

- **Line:** 25
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 2. `ezweather.start_snow_in_area(area_id)`

- **Line:** 51
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 3. `ezweather.start_fog_in_area(area_id)`

- **Line:** 77
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 4. `fade_camera_for_players_in_area(area_id)`

- **Line:** 98
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 5. `ezweather.get_area_weather(area_id)`

- **Line:** 105
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 6. `ezweather.clear_weather_in_area(area_id)`

- **Line:** 113
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 7. `ezweather.handle_player_transfer(player_id)`

- **Line:** 135
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `ezweather.handle_player_join(player_id)`

- **Line:** 142
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 2 | `ezweather` |
| 5 | `volatile_memory` |
| 9 | `fine_weather_properties` |
| 11 | `weather_properties` |
| 30 | `camera_tint` |
| 56 | `camera_tint` |
| 82 | `camera_tint` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.fade_player_camera` | 3 | 101 |
| `Net.get_area_custom_properties` | 3 | 13 |
| `Net.get_player_area` | 2 | 137 |
| `Net.list_areas` | 1 | 10 |
| `Net.list_players` | 1 | 99 |
| `Net.set_area_custom_property` | 16 | 38 |
| `Net.set_song` | 2 | 35 |
