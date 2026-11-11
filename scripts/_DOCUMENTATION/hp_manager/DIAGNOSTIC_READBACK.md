# 🔎 HP Manager — Save, disk readback, and live-state diagnostics

[Documentation index](index.md) · [HP Manager guide](README.md) · [Real Daytime guide](../real_daytime/README.md)

## Scope

This update adds **read-only diagnostics** to Background Manager, Real Time Manager, and Real Daytime, plus **committed-file byte verification** to the two editor persistence routines. It preserves the current `PlayerControl` handoff/settle rules and UI arrangement.

| Component | Shared logger system / subsystem | Log location (beneath `scripts/_DEBUGGING/`) |
|---|---|---|
| Background Manager | `hp_manager` / `background` | `hp_manager/_BACKGROUND.log` |
| Real Time Manager | `hp_manager` / `real-time` | `hp_manager/_REAL-TIME.log` |
| HP desktop | `hp_manager` / `desktop` | `hp_manager/_DESKTOP.log` |
| Real Daytime runtime | `real_daytime` / `foreground` | `real_daytime/_FOREGROUND.log` |
| Jukebox | `jukebox` / `main` | `jukebox/_MAIN.log` |

The shared logger also mirrors subsystem entries into each system's **`_FULL-log.log`**. The new diagnostics use the existing `log:info`, `log:debug` and `log:error` methods, and follow current system/subsystem formatting.

## Background Manager

When loading persisted records at startup, the Background Manager logs the texture/animation paths, `velocity_x`, `velocity_y`, and `parallax` for each loaded area. When it applies them, it logs both the **requested** values and the values returned by `Net.get_background`, `Net.get_background_velocity`, and `Net.get_background_parallax`.

On Save, it records:

1. `save requested` — exact independent editor preview of texture, animation, velocity X/Y and parallax.
2. `persisted … (verified readback)` — bytes on disk match those written; the backup is only removed afterward.
3. `disk write result … success=true/false` — whether the persistence call succeeded.
4. `disk readback` — parse the target area's record from the actual current `.dat` file.
5. `live readback` — independent query of the background currently applied to the area.

A committed-file mismatch fails the save and attempts to restore the previous `.bak` file. The existing editor failure path reverts the in-memory record and the live preview.

**Interpretation:** An identical requested/disk/live snapshot confirms the Lua-side operation at that moment. It does *not* establish that a remote client's graphics updated or that no other script will change the background later.

## Real Time Manager

The editor logs the selected `mode` and `timezone`, the disk write result, a readback from `realtime_data.dat`, and the live `Ambient_day_night`/`Ambient_timezone` properties. On startup it logs records loaded and applied to areas.

`effective_timezone` in these messages is an **explanation of mode behavior**, not another saved property:

| Mode | Time calculation | Offset used for foreground? |
|---|---|---|
| `sync` | Server-local `os.date("*t", os.time() + offset * 60)` | Yes, as a relative minute adjustment to the server-local clock |
| `cus` | UTC plus the saved minute offset | Yes, interpreted as an absolute UTC offset |
| `off` | No foreground override; custom offset can still affect computed time properties | No foreground override |

Accepted custom offsets remain **−840 through +840 minutes**.

## Real Daytime foreground logs

The `real_daytime` / `foreground` subsystem records when its cached original foreground is captured, an explicit `refresh_area` begins/completes, a phase-specific foreground is set, or the original foreground is restored. These messages include **area, action, mode, timezone, computed phase, live texture/animation, live velocity X/Y, and live parallax**.

Normal per-tick polling does **not** print a message every frame. New log entries appear only on a phase transition, an explicit refresh, or startup initialization when relevant.

### Reproduction and evidence collection

1. Start the server; preserve the startup `loaded area` and `startup apply` entries.
2. Open HP Manager, change Background texture plus both velocities and parallax, choose **Save**, then inspect `save requested`, `disk readback`, and `live readback`.
3. Reopen the editor and verify its preview against the persisted record; restart the server and compare its `loaded area` and `startup apply` entries.
4. Switch Real Time to `cus` with a known offset; check `save requested`, `disk readback` and `real_daytime/_FOREGROUND.log` for the selected day phase.
5. Switch Real Time to `off` and verify `action=restore-original` / `action=refresh-complete` restores the original foreground. Compare with what the client actually displays.
6. If Jukebox still prints duplicate startup logs, inspect whether the two events are in the **same Lua process**. Its guard prevents duplication inside one global Lua environment, not across independent server processes.

## File safety and limitations

- Existing `scripts/hp_manager/data/background_data.dat`, `realtime_data.dat`, and any `.bak` files are **not included** in the drop-in update.
- Diagnostics record server asset paths but do not contain authentication credentials.
- A successful disk readback validates the server's current persistence file. It does not guarantee the server restart or client rendering until those are tested.
- Existing legacy `warp_data.dat` warnings and the missing `scripts/ezlibs-custom/pets` dependency are separate from these changes.

## Asset-path reconciliation

The shipped background asset directory is `assets/Backgrounds/` (capital **B**). The editor now uses `/server/assets/Backgrounds/` and normalizes older saved lowercase paths in memory; it does not rewrite the settings file on server startup. The texture and animation are provided to the area via the already-used `Net.provide_asset(area_id, path)` API before a background is applied. A server-side `Net.get_background()` readback does not certify that each client rendered or downloaded the asset.

See [migration and TMX audit](BACKGROUND_TIMEZONE_MAP_FIX.md).
