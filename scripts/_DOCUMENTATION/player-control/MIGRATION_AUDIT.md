# 🛠 PlayerControl — Migration audit (November 11, 2026)

[🏠 Documentation home](../index.md) · [🎮 API guide](README.md) · [🧰 Named capture scopes](CAPTURE_SCOPES.md)

## Completed in this archive

* Removed the standalone input/HUD capture adapter, and migrated **all 26 non-test first-party Lua importers** to `scripts/player-control/main.lua`.
* Added `acquire_capture`, `release_capture`, `has_capture`, `suppress_hud`, `restore_hud`, and `begin_capture_scope` inside the canonical PlayerControl resource manager. Imperative callers preserve their previous idempotent owner keys and do not claim menu focus.
* Moved the implementation of UI suppression to `scripts/player-control/resources/ui-suppression.lua`. The previous `scripts/net-games/ui-suppression.lua` is an import-only compatibility forwarder.
* Converted MenuAPI's stack to parent/child PlayerControl menu sessions, without repeated manual claims in its tick callback. Context focus and capture are released when its UI is removed; disconnect closes all active menus.
* Converted the Nebulous Liberations option menu to a managed polling session, keeping its original cancel-row/promise and panel-layout behavior.
* Fixed the free-camera tile-interaction guard to compare against the actual PlayerControl session owner rather than the old camera-controller object.
* Reused `session:guard_input()` for HP Manager's proven native-dialog return timing (0.40-second desktop delay, 0.35-second swallowed input) and for the other migrated menus.
* Kept the standalone animation-points test entrypoint as a tiny forwarding script to `scripts/tests/animation_points_test.lua`; no test content was removed.

## What is **not** claimed as complete

| Boundary | Why it remains | Next migration |
|---|---|---|
| Scripted camera calls in Liberation, warps, cutscenes, trains and minigames | Many operate inside long-running coroutines and still call raw `Net` camera APIs; replacing them mechanically risks a stale camera or early tracking restore | Migrate per-operation after validating the exact animation and cancellation lifetimes |
| Some raw `virtual_input` consumers | Ownership and action mappings depend on each game mode | Convert to PlayerControl callbacks or polling with a minigame regression suite |
| External Lua modules not in this archive | May still import the deleted module path | Update external code to `scripts/player-control/main`; an old import will intentionally fail |
| `MenuAPI.close(...,{keep_locked=true})` | Compatibility is preserved via a named PlayerControl capture, but new code should own its capture lifetimes explicitly | Use `PlayerControl.begin_capture_scope` for independent work |

## Ownership rules

1. An active menu/camera/minigame must own a PlayerControl session; only nested children may supersede an active parent.
2. Cutscenes or native UI flows needing movement suppression **without focus** use a named PlayerControl capture. Acquiring the same key twice is idempotent; this is not a nested counter.
3. Multiple independent operations must use distinct owner names. Release only the key acquired by the same operation.
4. A native dialog handoff must guard button release when the parent resumes. It must never consume an unrelated controller owner's input.
5. Failed engine restoration retains handles for later `retry_cleanup`; do not force a raw `Net.unlock_player_input` as a workaround.

## Tests and live verification

Run `texlua scripts/player-control/tests/{smoke,integration,reliability,migration}.lua` separately at the server root. The migration tests check overlapping named captures, menu nesting, focus rejection, and disconnect cleanup. These tests use mocked Net APIs; review FootBomb, Liberation, Endless Runner, NPC dialogues, warps and native prompts live before production deployment.

## Diagnostics

PlayerControl records input, named capture, camera lease, and handoff lifecycle transitions via the shared logger in `scripts/_DEBUGGING/player_control/`. It does not log every raw button press or every tick.
