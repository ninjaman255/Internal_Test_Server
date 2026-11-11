# 🌤️ Real Daytime — Current HP Manager integration

[🏠 Documentation home](../index.md) · [📖 Original guide](README.md) · [📄 Source reference](main/index.md) · [🖥️ HP Manager](../hp_manager/README.md)

## Runtime versus configuration editor

`real_daytime/main.lua` is the world-time/lighting service; HP Manager's `realtime_manage.lua` is an **optional editor** for the selected area's properties. The runtime does not use PlayerControl. Only the editor creates a `settings_menu` control context.

| Property | Source role |
|---|---|
| `Ambient_day_night` | World-time mode: `sync`, `cus`, `off` |
| `Ambient_timezone` | Offset in minutes; custom runtime validation is **−840..+840**. |
| `Day_time`, time/date-related properties | Runtime-derived values; check the Lua implementation and preserved author guide for the exact names/updates. |

### Verified current bounds

The patched `hp_manager/realtime_manage.lua` edits the timezone in 5-minute increments and clamps to **−840..+840**, matching the custom-timezone range accepted by `real_daytime/main.lua`. Earlier documentation noted a −1440..+1440 mismatch; that does not describe the current supplied code.


## Custom timezone semantics and foreground restoration

`Ambient_timezone` is a **UTC offset in minutes** for `cus` and the optional-offset behavior of `off`. The world-time module uses `os.date("!*t", os.time() + offset * 60)` to avoid applying the Windows/Linux host's local timezone twice. `sync` retains the server-local clock. The HP editor's time label follows the same rule.

Changing the mode or offset previews the area immediately by setting both custom properties then calling the existing `refresh_area(area_id)` function. `refresh_area` restores the cached original foreground before applying the newly selected day phase; switching to `off` must leave the original foreground in place. A failed settings-file write restores the previous custom properties and calls `refresh_area` again.
