# November 11, 2026 — Asset restructure and HP Manager stability patch

## Install (drop-in archive)

1. **Back up your server and persistent HP Manager data first.**
2. Remove the old directory `assets/ezlibs-custom/nebulous-liberations/` entirely, since flat files have been moved and the new layout should not coexist with stale copies.
3. Extract this ZIP at the server root (the same folder containing `scripts/`, `areas/`, and `assets/`). All Lua files are complete files, not snippets or diffs.
4. Restart the server so Lua modules and Tiled assets are reloaded.
5. Test HP Manager background selection/settings and save/cancel; test Real Time settings, Warp board, Jukebox; test a Nebulous Liberation mission including tileset indicators and Mettaur's directional shockwave.

## Implementation

* Refactored asset paths to new `bots/npcs/`, `bots/attacks/`, `bots/effects/`, `tiles/`, and `ui/` directory layout.
* The Liberation shared-tileset publisher now reads TSX/PNG files from `tiles/`; the existing TMX embedder automatically normalizes old source paths on maps that have a `Liberation Config` object.
* Removed the redundant explicit HP Manager require in `scripts/ezlibs-scripts/main.lua` because logs confirmed a second standalone module initialization.
* Prevented an existing parent/child HP desktop session from re-opening via redundant object interaction events; added guarded child launch/abort and UI cleanup.
* Fixed Background Manager's name disappearing while editing settings, plus duplicate/stale save-response handling in Background and Real Time editors.
* Real Time editor timezone clamp matches its runtime validation (−840 to +840 minutes).

## Diagnostics from the provided log

* HP Manager listener registered **twice**, and object 185 received repeated interaction events. This patch removes a redundant import and adds in-process duplicate-registration protection.
* `Could not read shared liberation tileset asset` repeatedly: old shared TSX/PNG source paths predated the restructure.
* `textbox_response: stray (no pending resolver)` appeared repeatedly. The guarded HP dialogs may reduce overlaps, but the log alone does not prove they caused every stray response.
* `scripts/ezlibs-custom/pets` missing from `eznpcs_onceitem.lua` is **not fixed here**; the requested asset folder does not contain that module.
* `Warp Manager Invalid warp data file` was logged; this patch handles a failed warp-screen open, but it does **not** replace or repair the persistent warp data file.

## Validation

* All modified Lua files were syntax-checked using a LuaTeX Lua interpreter.
* Existing PlayerControl smoke and real-InputController integration tests passed.
* HP Manager module-registration/object re-entry mocked test passed.
* Background Manager label and single-save-prompt mocked test passed.
* All literal, fully qualified Nebulous Liberations asset references resolve to supplied files.
* All `.tsx` image references and six `.tmx` XML files parsed successfully.
* Live OpenNetBattle runtime/client testing is still required; the tester cannot verify in-game visuals or engine message dispatch.
