# 🧪 Shared logger validation

[🏠 Documentation home](../index.md) · [🪵 Shared Logger](README.md) · [🔄 Migration](MIGRATION.md)

## Offline tests

The logger update was tested in a standalone Lua runtime using a stub `Net:on` and the actual `scripts/libs/json.lua` implementation.

| Check | Expected behavior |
|---|---|
| Import canonical module plus both compatibility paths | A single registry; only one tick listener and one player_join listener |
| Write subsystem message | Present in `_<SUBSYSTEM>.log` and `_FULL-log.log` |
| Write area-scoped message | Present in area file, subsystem file and full log |
| Write legacy `(message, data)` JSONL | JSONL with `timestamp`, `level`, `msg`, `data` |
| Legacy `logIfChanged` | Consecutive same-level messages deduplicated |
| Bad legacy log path | Error; must not write outside `scripts/_DEBUGGING` |
| Full server Lua syntax | All modified `.lua` files must parse with `loadfile` |

## Failure-recovery regression tests

- An existing writable log directory must be flushed successfully **without invoking mkdir** even if `os.execute` is broken.
- If directory creation returns an error but the file can subsequently open, the flush must succeed.
- If both file open and directory creation fail, retain buffered entries, rate-limit the warning, and retry after backoff.
- `createLogger` must remap legacy `debugging.log`, `debugging.lua`, and `_FULL-LOG.log` to `_FULL-log.log`.
- The combined log must use `_FULL-log.log` exactly; subsystem names remain unchanged.

## Recommended in-game checks

1. Restart the server and open HP Manager. Check `scripts/_DEBUGGING/hp_manager/_FULL-log.log` and `_DESKTOP.log`.
2. Edit Background, then cancel or save. Check `_BACKGROUND.log` and verify the previous input and cleanup behavior.
3. Open Real Time and Warp editors. Check `_REAL-TIME.log`, `_WARP.log` and any error records, including a missing/invalid warp-data file.
4. Open Jukebox from the desktop and standalone. Check `_MAIN.log` in `scripts/_DEBUGGING/jukebox/`.
5. Open a Liberation mission and FootBomb. Check that system/subsystem files are created under the new root and previous file formatting is retained.
6. Confirm existing older log files are not overwritten or deleted. Historical log copies must be managed separately.

**Scope:** Mocked Lua tests verify logging behavior; actual live OpenNetBattle interactions require server/client testing. This change does not claim to correct unrelated game logic.
