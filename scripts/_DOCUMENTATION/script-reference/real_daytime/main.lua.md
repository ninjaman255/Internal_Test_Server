# `real_daytime/main.lua`

> **Source reference**
>
> Refreshed from the current `real_daytime/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `real_daytime/main.lua`
- **Reference:** `script-reference/real_daytime/main.lua.md`
- **Source SHA-256 prefix:** `3344655d910a`

## Source header notes

- [[

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_area_settings` | `area_id` |
| `get_current_time` | `settings` |
| `get_day_phase` | `time` |
| `get_day_date` | `time` |
| `get_day_type` | `time` |
| `restore_foreground` | `area_id, settings` |
| `apply_day_phase` | `area_id, settings, phase` |
| `clear_day_properties` | `area_id` |
| `update_area` | `area_id` |
| `AmbientManage.refresh_area` | `area_id` |
| `AmbientManage.get_day_night_mode` | `area_id` |
| `AmbientManage.get_timezone` | `area_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_area_custom_property`, `get_foreground`, `get_foreground_velocity`, `get_foreground_parallax`, `set_foreground`, `set_area_custom_property`, `list_areas`, `on`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/real_daytime/dawn.png` |
| `/server/assets/real_daytime/morning.png` |
| `/server/assets/real_daytime/night.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
