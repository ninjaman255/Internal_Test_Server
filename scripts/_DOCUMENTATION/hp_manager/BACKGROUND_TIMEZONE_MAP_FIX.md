# 🧰 Background assets, sync timezone, and Tiled map audit

[HP Manager guide](README.md) · [Save diagnostics](DIAGNOSTIC_READBACK.md) · [Real Daytime guide](../real_daytime/README.md)

## Why the logs looked correct but the background did not

The observed logs at **14:21:30** and **14:21:55** show the chosen background and numeric values successfully persisted and returned by `Net.get_background`. The **shipped server archive**, however, stores the paired files under `assets/Backgrounds/` (capital B), while the previous editor generated `/server/assets/backgrounds/` (lowercase b). This can break case-sensitive asset lookup or client file resolution while the Windows server reports valid values.

The editor now enumerates the case-matching source directory and generates `/server/assets/Backgrounds/{name}.png` and `.animation`. Previously saved paths with a lowercase `backgrounds/` segment are normalized **in memory**, without silently rewriting or deleting `background_data.dat`. It explicitly calls the existing `Net.provide_asset(area_id, path)` for both texture and animation before `Net.set_background`. An asset temporarily missing at startup now generates a warning and preserves its saved choice instead of removing the record.

## Sync vs custom time semantics

| Mode | Clock used | Meaning of `Ambient_timezone` |
|---|---|---|
| `sync` | `os.date("*t", os.time() + offset * 60)` | Minute adjustment **relative to server-local time**; `0` is unshifted sync |
| `cus` | `os.date("!*t", os.time() + offset * 60)` | Absolute UTC offset in minutes |
| `off` | No day/night foreground override | Retains the prior time-property calculation behavior |

Both modes now use configured offsets, unlike the previous `sync` code, which always forced `timezone=nil`. If the adjusted time remains within the same phase (e.g., 14:00 to 15:00), the overlay may not visibly change. The editor time label and the runtime use matching clocks. Moving the slider within the same phase retains the existing foreground, preventing repeated remove/reapply flicker.

## TMX audit (source: latest provided `internal_test_server(4).zip`)

All six areas were inspected: `default`, `default-copy`, `cutscene-test`, `endless-runner`, `footbomb`, and `tile_map_no_objects`. Each has `Background Texture`, `Background Animation`, `Background Vel X`, and `Background Vel Y` with matching asset files in the archive. `Background Parallax` is not defined on these maps; runtime `Net.get_background_parallax` reported `0`, and this editor supports changing it without a required map property. No absent mandatory background fields were identified.

**Ambient properties:** None of the six TMX maps originally declared `Ambient_day_night` or `Ambient_timezone`. These can instead be supplied at runtime when `realtime_data.dat` is loaded, as the new logs show for `default`. Without either a map property or saved data, Real Daytime skips the area by design. We added `Ambient_day_night=off` and `Ambient_timezone=0` **only to `areas/default.tmx`**, where the `HP_Manager` object (ID `185`, type `HP_Manager`) exists, providing a safe baseline without enabling lighting in previously unconfigured areas.

**Important:** Do not add day/night properties to every map indiscriminately. Maps not configured for it should remain unaffected. Existing area data files are not overwritten by this update.

## Live verification

1. Confirm the server has `assets/Backgrounds/bomb.png`, `bomb.animation`, `clockman.png`, and `clockman.animation` (capital B path as shipped).
2. Restart the server. Open Background Manager, select the alternate background, and save. The next log should show a capitalized path in `save requested`/`live readback`.
3. Change velocity/parallax; verify disk and live snapshots. Reconnect the client and ensure it displays the chosen texture.
4. For timezone, use `sync` and change the offset enough to cross dawn/morning/afternoon/night boundaries. Compare the editor time label to `real_daytime/_FOREGROUND.log` and the visible foreground.
5. Restart and check the persisted settings again. Save and discard behavior, including desktop handoff, should remain the same.

Offline tests validated the Lua paths and mocked Net calls; a live ONB client is still needed to confirm the rendering symptom.
