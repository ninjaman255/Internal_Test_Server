# 🧩 PlayerControl — Documentation refresh and source notes (2026-11-11)

[🏠 Documentation home](index.md) · [🎮 API](player-control/README.md) · [🛠 Migration audit](player-control/MIGRATION_AUDIT.md)

## Scope

**Inputs:** `internal_test_server(4).zip`, followed by `internal_test_server_player_control_dropin_2026-11-11.zip` as an overlay. This update changes **documentation only**. Newer PlayerControl and migrated module references supersede the old generated source-line/hashes for those modules.

| System | Documented source behavior | Follow-up |
|---|---|---|
| PlayerControl | Scoped engine-capture/HUD leases; nested logical focus; focus guards and diagnostic state | Other legacy callers still bypass shared capture |
| InputController | `claim_input` invalid-owner/destroyed guard; unchanged raw/edge/repeat processing | Integrate remaining direct claim users |
| HP Manager | Boot registration, desktop root, child editors, object interaction | Live test map object 185 and editor returns |
| Background/Real Time/Warp | Capture-safe child contexts, native UI and transfer cleanup | Validate async prompts and persistence |
| Jukebox | Standalone/child music menu, capture/HUD leases, callback after close event | Verify playback/UI live |
| Camera | Free-camera suppression handle and transfer/disconnect cleanup | Global camera ownership still not managed |
| Maps | Fixed `hp_manager` tileset casing across five TMX maps | Runtime interaction still requires live testing |
| Real Daytime | Preserved existing author guide; added editor-versus-runtime compatibility note | Reconcile timezone limit mismatch in future code update |

The previous generated docs and modules may describe old versions. Use this changelog and refreshed script references for affected files. The documentation inventory includes a static scan of every direct `Net.lock_player_input` / `Net.unlock_player_input` reference in the overlaid Lua tree.

### Validation plan

- Verify all documentation links and the central index reachability.
- Verify every regenerated source path and SHA against the *overlaid source tree*.
- Run the existing `scripts/player-control/tests/smoke.lua` and `integration.lua` tests in a compatible Lua interpreter if installed.
- Verify live map interactions, native UI, and engine camera movement separately. Markdown references do not prove the server code runs correctly.

## Baseline documentation drift discovered

The centralized library originated from a broader older project snapshot. Comparing old generated references against the latest ZIP found **58 archive-only source references** and **72 previously hash-mismatched source references (now regenerated)**. Archive-only pages now have a visible historical warning and no dead source link; source-changed pages have now been regenerated from the current Lua. The patched control-system source references were regenerated and include current source hashes. These warnings do not change Lua.

Two additional authored READMEs were centralized in the documentation set: `net-game-tourney/readme.md` and `ezlibs-custom/endless-runner/README.md`.
