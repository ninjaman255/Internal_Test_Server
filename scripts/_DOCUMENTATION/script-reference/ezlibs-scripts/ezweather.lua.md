# `ezlibs-scripts/ezweather.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezweather.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezweather source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezweather.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezweather.lua.md`
- **Source SHA-256 prefix:** `feab3c87a13e`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezbus` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezweather.start_rain_in_area` | `area_id` |
| `ezweather.start_snow_in_area` | `area_id` |
| `ezweather.start_fog_in_area` | `area_id` |
| `fade_camera_for_players_in_area` | `area_id` |
| `ezweather.get_area_weather` | `area_id` |
| `ezweather.clear_weather_in_area` | `area_id` |
| `ezweather.handle_player_transfer` | `player_id` |
| `ezweather.handle_player_join` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `get_area_custom_properties`, `set_song`, `set_area_custom_property`, `list_players`, `fade_player_camera`, `get_player_area`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezweather/rain.animation` |
| `/server/assets/ezlibs-assets/ezweather/rain.png` |
| `/server/assets/ezlibs-assets/ezweather/snow.animation` |
| `/server/assets/ezlibs-assets/ezweather/snow.png` |
| `/server/assets/ezlibs-assets/ezweather/fog.animation` |
| `/server/assets/ezlibs-assets/ezweather/fog.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
