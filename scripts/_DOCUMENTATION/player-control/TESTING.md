# 🧪 PlayerControl v2 — Regression validation

[🏠 Home](../index.md) · [🎮 API guide](README.md)

The test scripts are bundled under `scripts/player-control/tests/` and use mocked OpenNetBattle `Net` calls. They do **not** demonstrate successful live-client behavior.

From the server root, with a compatible Lua interpreter and module path:

```sh
texlua scripts/player-control/tests/smoke.lua
texlua scripts/player-control/tests/integration.lua
texlua scripts/player-control/tests/reliability.lua
```

| Test | Focus |
|---|---|
| `smoke.lua` | Existing scoped capture/focus, nested sessions, HUD, cleanup |
| `integration.lua` | Real shared InputController, PlayerControl integration |
| `reliability.lua` | Injected errors, failed unlock/retry, camera restore, nested camera scopes, forced ownership changes, late interactions and free-camera handoff |

## Recommended in-game tests

1. HP Manager object: open, navigate Background Manager, edit, save/cancel once, return, repeat; check background name and no stranded capture.
2. Jukebox: open from map object and as HP Manager child, navigate albums/tracks, close; ensure parent resumes exactly once.
3. Free camera: enter, hold a direction, hand off to HP Manager; ensure no repeated movement or residual repeat cadence.
4. FootBomb: warp into instance, select bot/skin/bomb, progress match and rounds, leave/disconnect; verify camera follows intended bot and engine movement is restored only on valid exit.
5. Nebulous Liberation: enter mission, run menu/loot message/camera sequence/battle/return and disconnect during a sequence; ensure legacy capture leases are released and messages finish before camera takeover.
6. Endless Runner, EZ warps, NPC dialog, Simon Says, tournament, trains: verify their legacy capture and HUD lifetimes (these use the transitional adapter, not yet full sessions).
7. Force an error during input cleanup and verify `get_debug_state(player_id).pending_releases` drains after recovery without another owner's resources being released.

## Limitations

`texlua` syntax checks and mock tests cannot validate the live OpenNetBattle client. Camera lease safety is partial until all direct scripted-camera callers migrate. Do not treat this patch as equivalent to fully end-to-end tested game behavior.

### Removal of standalone capture module

Run `texlua scripts/player-control/tests/migration.lua` as well as the existing three suites. Validate two independently named cutscene captures alongside a menu, nested MenuAPI teardown, denied foreign menu activation and disconnect cleanup. Confirm no first-party `.lua` file imports the removed module.

Confirm `scripts/_DEBUGGING/player_control/_FULL-log.log` receives lifecycle events during live testing, alongside the existing HP Manager and Jukebox logs. Mock test execution does not flush disk logs unless the shared logger's tick callback is exercised.
