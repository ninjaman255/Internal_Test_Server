# 🖥️ HP Manager — Desktop and editors

[🏠 Documentation home](../index.md) · [📚 Module index](index.md) · [🎮 PlayerControl](../player-control/README.md) · [🗺️ Tiled setup](../areas/HP_MANAGER_TILED.md)

## 🧭 Contents
- [Purpose and startup](#purpose-and-startup)
- [Desktop choices](#desktop-choices)
- [Open/close lifecycle](#openclose-lifecycle)
- [Editor APIs](#editor-apis)
- [Input conventions](#input-conventions)
- [Editor data and native UI](#editor-data-and-native-ui)
- [Cleanup and pitfalls](#cleanup-and-pitfalls)
- [Source files](#source-files)
- [Shared system logging](#shared-system-logging)

**Current asset/timezone migration:** [Background path & map audit](BACKGROUND_TIMEZONE_MAP_FIX.md).

**Latest save/return regression guides:** [Background, Real Time and foreground fixes](SAVE_AND_RETURN_FIX.md) · [Post-save input handoff](INPUT_HANDOFF_FIX.md).

## Purpose and startup

`hp_manager/main.lua` registers a `Net:on("object_interaction", ...)` listener when the module loads. `ezlibs-scripts/main.lua` now guards `require('scripts/hp_manager/main')` with `pcall` and logs a failed import. The handler checks a player-area object with `.type` or `.class` equal to `HP_Manager` and accepts button `0` or omitted `event.button`. This requires your active server bootstrap to load `ezlibs-scripts/main.lua`.

## Desktop choices

| ID | Label | Availability / role |
|---|---|---|
| `exit` | Exit | Always present; selected by default. |
| `warp` | Warp Manager | Always present; edits saved warp controller destinations. |
| `background` | Background Manager | Always present; edits area background-related settings. |
| `real_daytime` | Real Time Manager | Optional. File presence `scripts/real_daytime/main.lua` adds icon; attempts module import. |
| `jukebox` | Music Manager | Optional. File presence `scripts/jukebox/main.lua` adds icon; attempts module import. |

The file-based optional module presence check comes from `hp_manager/constants/constants.lua`'s global `file_exists(path)`. Source code checks file presence to show an icon; a failed `require` is logged and may leave its icon present without a loaded extension. Verify startup logs if a choice appears but does not open.

## Open/close lifecycle

1. `open_hp_manager(player_id)` creates or reuses a **desktop** PlayerControl root (`owner='hp_manager:desktop'`, `profile='desktop'`, `handoff_free_camera=true`). The root stores `area_id` and is reused when returning from a child.
2. UI sprites and labels are created, selected option recorded, and an initial 0.2-second input delay applied for first open; a returning desktop waits 0.40 seconds before accepting another selection.
3. Desktop `Net:on('tick')` polls directional/Confirm/Cancel actions through `session.control:poll`. Navigation wraps across available icons.
4. Selecting a child clears the visible desktop, then calls `*.open` with `{ parent = desktop_control[player_id] }`. HP desktop root **retains its capture lease** throughout the handoff.
5. After the child's session closes, the return callback schedules a **deferred** desktop repaint with `Async.sleep(0.08)`. Its parent must still be alive and in the same area. Before repaint, Background/Real Time overlay elements are erased again defensively. `open_hp_manager` explicitly returns `true` on a successful draw. The returned desktop clears the shared controller's queued edges, requires held buttons to release, and swallows new input for 0.35 seconds to avoid immediately reselecting the just-closed child. Jukebox also supports standalone opening.
6. Exit or unexpected area transfer closes the desktop context and removes desktop UI. PlayerControl closes descendants if necessary.

Cancel first moves selection to Exit unless it is already selected; another Cancel on Exit closes the desktop. Confirm on Exit also closes.

## Editor APIs

| Module | Public function | Parameters | Notes |
|---|---|---|---|
| Desktop | `open_hp_manager` (local) | `player_id, selected_id` | Internal, invoked by object handler and return callbacks; **not exported** by `main.lua`. |
| Background | `BackgroundManage.open` | `player_id, return_to_hp, options` | Options may contain `parent`; creates a `settings_menu` child or standalone root. |
| Real Time | `RealtimeManage.open` | `player_id, return_to_hp, real_day_time, options` | Options may contain `parent`; `real_day_time` is expected to support `refresh_area(area_id)` for live refresh. |
| Warp | `WarpManage.open` | `player_id, return_to_hp, options` | Options may contain `parent`; uses a `native_ui` context and native BBS/board events. |
| Jukebox | `Jukebox.open` | `player_id, on_close, [object_id], [options]` | Parent options may be passed as the third table argument; see Jukebox docs. |

`return_to_hp` is a callback supplied by the desktop; child editors return to their caller only after their own control context is closed (except abort/transfer paths which suppress normal callback). These examples refer to the **real current signatures**, not hypothetical refactor methods.

## Input conventions

| Screen | Input source | Repeat behavior |
|---|---|---|
| Desktop | `control:poll(desktop_actions)` on tick | Directions use InputController repeat; Confirm/Cancel press only. |
| Background | `control:poll(background_actions)` on tick | Horizontal adjustment allows repeat; vertical selection is press-only. |
| Real Time | `control:poll(realtime_actions)` on tick | Horizontal repeat allowed; editor further delays timezone repeats until 0.5 s. |
| Warp | `Net.open_board`, `post_selection`, `board_close` | **Native** board; no scripted button polling. |
| Jukebox | InputController actions via `session.control:input()` | Async 0.2 s input loop; separate pressed/repeated navigation. |

## Editor data and native UI

**Background editor:** Asset lookup uses the packaged `assets/Backgrounds/` directory (capital B); older lowercase saved paths are normalized in memory and area assets are explicitly provided before preview/apply. `background_data.dat` is loaded/saved through a temp-file and backup commit that checks write/close/rename failures; on unexpected transfer/disconnect it restores the prior background/velocity/parallax in memory and closes UI. The editor maintains independent **original** and **preview** texture/animation paths, velocity and parallax. On Cancel, it compares those states. With changes, it hides both screen variants before opening the native `Save changes?` prompt and processes the response once. A successful write commits the preview; a cancelled or failed write restores the original background and previous persisted record. Both screens' sprite/text IDs are always removed at close (including `word_bar`, cursors and settings board). See [Background Manager's source and lifecycle reference](background_manage/index.md).

**Real Time editor:** `realtime_data.dat` and area custom properties `Ambient_day_night` and `Ambient_timezone` are used. The editor holds a separate mode/timezone preview and refreshes the active foreground through the Real Daytime module. Saving uses that preview rather than rereading the mutable live area; failed writes restore the previous record and original area properties. The editor stops *both* input and animation ticks while the native save prompt is open, and keeps its session registered until its PlayerControl `on_close` callback finishes. The editor and runtime accept UTC offsets of −840..+840 minutes; `cus` uses UTC as a base; `sync` uses server-local time **plus the configured minute offset**. See [Real Daytime integration](../real_daytime/INTEGRATION.md).

**Warp editor:** `warp_data.dat` persists controller address/port/location; an empty initial file is treated as no saved warps rather than corrupted data; the board lists grouped Warp Controllers, and selection uses `Async.prompt_player`. Valid destination format is `ADDRESS:PORT`, and accepted port range is `1..65535`. A session-lifetime check guards async results. `Net:post_selection` and `Net:board_close` are native board hooks.

## Cleanup and pitfalls

- `PlayerControl` automatically cleans its stack at `player_disconnect`; the editors also register their own transfer/disconnect hooks to clean up game-specific UI and rollback unsaved edits.
- Do not add direct `Net.unlock_player_input` inside editors; that bypasses the root/child lease count.
- `Net.fade_player_camera` is used on the Warp desktop transition; this does **not** imply a global camera ownership lease.
- One lingering risk is the unconverted legacy systems that call low-level engine locks directly. See [migration audit](../player-control/MIGRATION_AUDIT.md).
- See [Tiled object 185 and startup checks](../areas/HP_MANAGER_TILED.md) if the desktop does not appear.

## Source files

| File | Role | Source API reference |
|---|---|---|
| `main.lua` | Desktop and object interaction | [Reference](main/index.md) |
| `background_manage.lua` | Background editor | [Reference](background_manage/index.md) |
| `realtime_manage.lua` | Time editor | [Reference](realtime_manage/index.md) |
| `warp_manage.lua` | Warp/board editor | [Reference](warp_manage/index.md) |
| `constants/constants.lua` | File paths, file_exists | [Reference](constants/constants/index.md) |
| `extensions/extensions.lua` | Optional extension declarations | [Reference](extensions/extensions/index.md) |

## Shared system logging

All HP Manager editors now use `require("scripts/logger/logger")` with system `hp_manager`. Desktop, background, real-time and warp logs retain their original console message prefixes but are separately available in `_DESKTOP.log`, `_BACKGROUND.log`, `_REAL-TIME.log`, `_WARP.log`, and the combined `_FULL-log.log` under `scripts/_DEBUGGING/hp_manager/`. Jukebox uses its own `jukebox` system with `main` and `utils` subsystems. See [the centralized logger guide](../logger/README.md).

## 2026-11-11 regression repair

The November 11 save regression involved the native-dialog → PlayerControl → parent-desktop transition. The Real Time animation tick could redraw a removed time label during the prompt, and the completion path removed the session registry entry before `on_close` could perform its cleanup. Both editors now close first, then ask HP Manager to redraw after a short deferred handoff. The logged desktop interaction by itself only proves the object registered; subsystem logs (`_BACKGROUND.log`, `_REAL-TIME.log`) now log openings, prompts, decisions, completion and save failures.

**Live validation:** Change an area background and its velocity/parallax, save, then reopen; change `Ambient_day_night` and `Ambient_timezone`, save, reopen, and observe foreground phase. Test save/discard, an aborted prompt, and a server restart. Do not delete the `scripts/hp_manager/data/` directory.

## Diagnostics and save-state readback

See [save/readback and foreground diagnostics](DIAGNOSTIC_READBACK.md) for server-side snapshots and verified file commits.
