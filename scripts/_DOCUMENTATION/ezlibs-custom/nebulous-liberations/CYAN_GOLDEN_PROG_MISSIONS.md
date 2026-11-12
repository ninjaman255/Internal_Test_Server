# Cyan Server — Golden Prog Liberation Mission Import

**Source:** `cyan_server.zip` supplied on November 11, 2026. Mission files are sourced from that archive, not synthesized. All nine encounter tables are copied byte-for-byte. General-purpose tile assets have been moved back to `assets/tiles/` without altering their bytes.

## Installation

1. Back up your `areas/`, `encounters/`, `assets/`, and `scripts/events/` directories.
2. Extract **`CYAN_GOLDEN_PROG_LIBERATIONS_TILES_ORGANIZED_DROPIN_2026-11-11.zip`** into your server root. The nine mission maps will replace any existing files with those exact names.
3. **Golden Progs and gates are in hub maps.** Do **not** blindly overwrite a newer `default.tmx`: the companion **source/reference ZIP** has original hub maps `default`, `christmas`, `ooo`, and `undernet1` for deliberate replacement or a Tiled object-layer merge. Those old hub maps are not installed automatically.
4. The two Golden Prog dialogue events are implemented in `scripts/events/eznpcs_events.lua`. The latest inspected `scripts(2).zip` has no such loader file; if your current server already has one, **merge these event definitions** instead of overwriting your other NPC events.
5. Maintain a working `/server/assets/ezlibs-assets/ezencounters/ezencounters.zip` with the required enemy mods. Source copies are supplied **only in the companion optional bundle**, to avoid reverting your more recent encounter/scaling fixes.
6. Restart; load each gate's source hub area; interact with Golden Prog; test mission start and return to the expected waiting/respawn areas. Verify the map and encounter errors in your Nebulous Liberations logs.

## Asset layout

- `assets/ezlibs-custom/nebulous-liberations/tiles/`: Liberation-specific panel, dark-panel, collision, selection, and attack-indicator tilesets. Generic environment and utility tilesets are stored under `assets/tiles/`. Every imported TSX has its corresponding image in the same folder. Existing tile GIDs and map objects are preserved.
- `assets/ezlibs-custom/nebulous-liberations/backgrounds/`: liberation backgrounds, corrected from obsolete `NebuLibsAssets` URLs.
- `assets/ezlibs-custom/nebulous-liberations/bots/`, `/mugs/`, `/sound effects/`, `/ui/`: source liberation visual/audio resources.
- `assets/ezlibs-assets/eznpcs/sheet/prog-gold.*` and `/mug/prog-gold.png`: NPC asset lookup files, left in the existing EZNPC asset directory.
- `encounters/*.lua`: area-specific encounter tables used by current `PanelEncounters`, not the old map-level `NebulousEncounters/*.zip` property.
- Music references remain at their original server paths; referenced tracks are included if available in cyan_server.

## Gate-to-mission map (source object IDs retained)

| Hub map | Gate object ID | Gate name | Liberation Map File Name | Optional map display name |
|---|---|---|---|---|
| default | 185 | WiltMan Liberation | DEBUGLIB |  |
| default | 197 | Beta Liberation | NewLiberation1 |  |
| default | 249 | WiltMan Liberation | LiberationEasyMode |  |
| default | 255 | WiltMan Liberation | LiberationNormalMode |  |
| default | 260 | WiltMan Liberation | LiberationHardMode |  |
| christmas | 49 | GATE 2 | testground | PracticeArea2 |
| ooo | 60 | GATE TEST | testlib |  |
| undernet1 | 128 | WiltMan Liberation | liberation1 | Undernet2 |

**Note:** `example liberation friendly` is reachable from a **Rematch Prog** in `undernet1` rather than a matching Liberation Gate. It is included.

## Golden Prog NPCs

| Hub map | NPC object ID | NPC name | First Dialogue | Next 1 |
|---|---|---|---|---|
| default | 188 | Rematch Prog | — | 190 |
| default | 198 | Rematch Prog | — | 200 |
| default | 202 | Ability Prog | 254 | — |
| default | 215 | Ability Prog | 267 | — |
| default | 228 | Ability Prog | 266 | — |
| default | 250 | Rematch Prog | 268 | — |
| default | 256 | Rematch Prog | 269 | — |
| default | 262 | Rematch Prog | 270 | — |
| christmas | 52 | Rematch Prog | — | 54 |
| christmas | 79 | Ability Prog | — | 80 |
| ooo | 305 | Rematch Prog | — | 307 |
| ooo | 313 | Ability Prog | — | 314 |
| ooo | 328 | Ability Prog | — | 329 |
| undernet1 | 223 | Rematch Prog | — | 225 |

## Golden Prog event objects

| Hub map | Object ID | Event Name | Liberation Map | Ability Item |
|---|---|---|---|---|
| default | 191 | Refight Liberation | DEBUGLIB | — |
| default | 201 | Refight Liberation | NewLiberation1 | — |
| default | 207 | Grant Liberation Mission Ability | — | GutsHamr |
| default | 208 | Grant Liberation Mission Ability | — | OldSaber |
| default | 213 | Grant Liberation Mission Ability | — | NumGadgt |
| default | 220 | Grant Liberation Mission Ability | — | HeroSwrd |
| default | 221 | Grant Liberation Mission Ability | — | WideSwrd |
| default | 226 | Grant Liberation Mission Ability | — | ShdwShoe |
| default | 233 | Grant Liberation Mission Ability | — | Burner |
| default | 234 | Grant Liberation Mission Ability | — | HexSickle |
| default | 239 | Grant Liberation Mission Ability | — | Blaster |
| default | 245 | Grant Liberation Mission Ability | — | HevyShld |
| default | 246 | Grant Liberation Mission Ability | — | Bazooka |
| default | 253 | Refight Liberation | LiberationEasyMode | — |
| default | 259 | Refight Liberation | LiberationNormalMode | — |
| default | 265 | Refight Liberation | LiberationHardMode | — |
| christmas | 55 | Refight Liberation | testground | — |
| christmas | 84 | Grant Liberation Mission Ability | — | Burner |
| christmas | 85 | Grant Liberation Mission Ability | — | HexSickle |
| christmas | 90 | Grant Liberation Mission Ability | — | Blaster |
| ooo | 308 | Refight Liberation | testlib | — |
| ooo | 318 | Grant Liberation Mission Ability | — | HeroSwrd |
| ooo | 319 | Grant Liberation Mission Ability | — | WideSwrd |
| ooo | 324 | Grant Liberation Mission Ability | — | ShdwShoe |
| ooo | 333 | Grant Liberation Mission Ability | — | GutsHamr |
| ooo | 334 | Grant Liberation Mission Ability | — | OldSaber |
| ooo | 339 | Grant Liberation Mission Ability | — | NumGadgt |
| undernet1 | 226 | Refight Liberation | example liberation friendly | — |

## Compatibility / outstanding limitations

- These are the **source server's authored maps and encounters**, not a claim of live testing on your current client. Some old encounter definitions and authored bot names may require your current EZEncounters mod set.
- Original `cyan_server.zip` map references to `/server/assets/NebuLibsAssets/` were corrected to the existing Nebulous Liberations folder. Imported mission-specific TSX sources use `assets/ezlibs-custom/nebulous-liberations/tiles/`, while generic environmental TSX sources use `assets/tiles/`. The numeric `firstgid` assignments, tile layer payloads, all objects, and linked IDs are preserved.
- Obsolete map-level `/server/assets/encounters/NebulousEncounters/*.zip` properties were removed **only when those ZIPs were missing from cyan_server.zip**; the modern area `encounters/<area>.lua` tables remain.
- Custom map properties such as `Respawn Area = ooo/christmas/undernet1` depend on the matching hub areas being installed and registered. The original hub maps are in the reference archive.
- Never blindly restore the optional old `ezencounters.zip`/mob mods over your current updated version. They are source backup/reference files for checking missing enemies.
- `eznpcs_events.lua` includes the two source-defined Golden Prog handlers and invokes the existing onceitem loader. Other historic NPC events are available as reference, not installed by default.
- No engine APIs were guessed: `eznpcs.add_event`, `LibPlugin.start_game_for_player`, and EZMemory item calls are copied from the original event handlers.

## Validation

- XML parsed for all nine mission maps, all referenced TSX files, and all linked TSX images in both tile directories.
- Verified every mission's object count and every external tile declaration `firstgid` was unchanged.
- Verified nine encounter tables, mission gate targets, and referenced image/background/music assets.
- Older original hub map variants are separated from automatic installation.

## Generic tileset relocation

Seven general-purpose TSX/image pairs (`IceTileTopper`, `Netopia_Tileset_directional_paths`, `block-undernet`, `central_arrows3`, `invis tile`, `portpanels`, `tree`) are installed under `assets/tiles/`. If the previous ZIP was already extracted, delete the old duplicates from the custom tiles folder **after** installing this new ZIP. See `RELOCATED_TILE_CLEANUP_AND_INSTALL.md` for all 14 specific paths.

Generated inventory counts: {'mission_map': 9, 'encounter_table': 9, 'tileset_tsx': 18, 'tileset_image': 18, 'liberation_asset': 58, 'map_music': 4, 'golden_prog_asset': 4, 'golden_prog_events': 1}.
