# HP Manager — Native-dialog input handoff fix

## Evidence (2026-11-11, 13:49)

- `hp_manager/REAL-TIME`: at 13:49:06 a save response completed and desktop returned; the real-time editor reopened in the same second. Similar reopen/unchanged close cycles occurred at 13:49:07–08 and 13:49:14–15.
- `hp_manager/BACKGROUND`: at 13:49:19 and 13:49:31 a saved background returned to desktop, then the background editor reopened in the same second, followed by an unchanged close.
- `hp_manager/DESKTOP`: confirms each return callback ran; this does **not** prove the full UI was displayed without being immediately replaced.
- `_WARP.log`: the old 13:06:19 invalid warp-data warning is historical relative to the current 13:49 test.

The short reopen intervals fit a late Confirm/Cancel controller edge being handled when the desktop regains focus. The logs do not record individual raw controller packets, so that physical input origin remains a hypothesis, not proven fact.

## Source change

In `scripts/hp_manager/main.lua`:

- Keep the initial 0.20 second desktop input settle.
- Give a returning desktop 0.40 seconds to settle rather than zero.
- Immediately after a successful, guarded child return, call the existing InputController `require_release` for navigation/confirmation buttons and `swallow` for 0.35 seconds, under the current PlayerControl owner. These APIs already exist in this server.
- Preserve all existing save/discard callbacks, child module calls, and visuals. No new native/Net API is introduced.

## Live test

1. Open HP Manager and open Background Manager; change the texture/velocity; press Cancel, then choose Yes at the native save prompt.
2. Verify `resumed desktop after background` is **not** immediately followed by `opening editor` without a fresh action on the desktop.
3. Reopen Background Manager deliberately, verify saved settings, return unchanged, and repeat with Real Time.
4. Release Confirm/Cancel fully between screens. If the editor still reopens, collect a short log with raw input action names and timestamps; the current logs are insufficient to prove which controller event caused it.
5. Verify persistence independently after a server restart. `finishing save` is a completion-path message, not by itself proof of a successful readback.

The parent PlayerControl session continues holding engine capture; only input event arming is delayed. Existing `scripts/hp_manager/data/*.dat` files are untouched.
