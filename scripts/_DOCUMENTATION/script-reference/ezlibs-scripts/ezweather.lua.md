# `ezlibs-scripts/ezweather.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezweather.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezweather.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezweather.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `weather_changed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ezweather.clear_weather_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.get_area_weather` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.start_fog_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.start_rain_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezweather.start_snow_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fade_camera_for_players_in_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 149 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
