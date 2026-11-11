# 🧩 PlayerControl v2 — Implementation report

[🏠 Documentation home](../index.md) · [🎮 Developer API](README.md) · [🛠 Migration audit](MIGRATION_AUDIT.md) · [🧪 Tests](TESTING.md)

## Implemented

* Kept OpenNetBattle's `Net.lock_player_input` semantics: native movement is suppressed while scripted `virtual_input` remains available.
* Added owner-scoped repeat policies in InputController and protected input-specific event dispatch in EventEmitter.
* Added failure-safe `on_close`, `on_error`, `on_suspend`, and `on_resume` callbacks to PlayerControl sessions.
* Added exclusive camera leases, parent/child camera handoffs, stale camera-call rejection and retryable engine restoration.
* Moved free-camera controller to PlayerControl sessions with protected activation/rollback and duration-estimated pending slides.
* Migrated FootBomb to one managed minigame session per participant, handling capture, HUD, logical focus and camera together.
* Replaced gameplay direct engine input/HUD calls in other modules with feature-owned compatibility leases. Those modules retain their existing interaction logic and input patterns, including asynchronous phases.
* Added a failure-injection regression suite and refreshed developer documentation.

## Live testing still necessary

The automated tests use mocked `Net` calls. Please verify HP Manager settings and Jukebox, FootBomb camera/selection phases, the Liberation loot-message → camera flow, Endless Runner, NPC dialogs, cutscenes, warps and Simon Says on a running OpenNetBattle server. Older scripted camera callers still bypass camera leases, and some raw `virtual_input` listeners still exist. See [MIGRATION_AUDIT.md](MIGRATION_AUDIT.md).

## Installation

Extract the drop-in ZIP into your server root, preserving each `scripts/...` path. It contains **complete files**, not diffs. Back up existing files first. Restart the server to replace loaded Lua modules. The ZIP's root `MODIFIED_FILES_MANIFEST.md` names every added/modified file.
