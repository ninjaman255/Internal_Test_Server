# HP Manager — Save and submenu return regression

[HP Manager guide](README.md) · [Real Daytime integration](../real_daytime/INTEGRATION.md)

## Symptoms

- Background-selection bar or Real Time settings text appears after answering the native save prompt.
- Timezone, foreground phase, or background velocity/parallax appears edited but is not persisted after closing/reopening.
- Parent desktop is not repainted, or a successful repaint is reported as a failure.

## Source-derived causes and corrections

| Source | Cause | Change |
|---|---|---|
| `hp_manager/main.lua` | Returned `nil` after drawing desktop; child callbacks repainted synchronously inside native UI completion. | Explicit success return; guard original desktop session and area; defer repaint 0.08 seconds; defensively clear child UI before drawing. |
| `hp_manager/realtime_manage.lua` | Animation tick could redraw while the save prompt was open; normal completion cleared the registry before `control:close` so `on_close` skipped cleanup. | Tick stops when closing; single `finish_realtime_session` path keeps session registered through `on_close`; removes all UI on every exit. |
| `hp_manager/realtime_manage.lua` | Save reread live engine values, and a failed persistence write was only logged but not rolled back. | Save the editor preview, validate it, and roll back area and record on file-write failure. |
| `hp_manager/background_manage.lua` | Persistence failures lacked detailed file errors; invalid area background state was not guarded. | Checked temp-write/close/backup/commit and safer initialization; retain unconditional UI removal and preview. |
| `real_daytime/main.lua` | Custom UTC offsets were converted using local timezone instead of UTC. | `os.date("!*t", ...)`; `sync` stays local. |
| `hp_manager/warp_manage.lua` | An empty initial save file was reported as invalid. | Treat an empty/whitespace file as no saved warps. |

## Debugging layout

Check `scripts/_DEBUGGING/hp_manager/`: `_FULL-log.log`, `_DESKTOP.log`, `_BACKGROUND.log`, `_REAL-TIME.log`, `_WARP.log`. The supplied logs had interaction/registration lines and an empty-Warp-file error but no captured Background/Real Time save callbacks. New log statements record editor opening, save prompts, response, completion, and failures.

## Live regression checklist

1. Open HP Manager object 185 in `default.tmx`.
2. Open Background Manager, change texture, velocity and parallax, save Yes, return to desktop, and reopen to verify values. Repeat with No and confirm original values restored.
3. Open Real Time Manager, change `Ambient_day_night` and `Ambient_timezone`, save, verify the world foreground changes to the right phase, and reopen. Repeat with No.
4. Verify *no* child text or sprites remain after a native save prompt and the desktop redraws once.
5. Restart the server and confirm both saved `.dat` files are read and applied.
6. Check the subsystem logs if the live engine does not match the mock tests.

**Important:** Mock tests validate lifecycle and Lua logic, not actual OpenNetBattle client rendering. Back up `scripts/hp_manager/data/*.dat` before installing.
