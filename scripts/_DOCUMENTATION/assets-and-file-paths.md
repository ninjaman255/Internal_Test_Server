# Assets and File Paths — Scripts Reference

> **Scope and accuracy**

> This inventory is based on literal asset-path strings found in Lua files under `scripts/` and the asset files included in `internal_test_server.zip`. Paths are preserved as written in source. The archive stores many corresponding files under `assets/`, while runtime code often refers to them through `/server/assets/...`; verify the deployment mount/layout before changing either side. This is source inspection, not live deployment verification.

## Table of Contents

- [Path conventions](#path-conventions)
- [Asset tree included in the archive](#asset-tree-included-in-the-archive)
- [Paths referenced by scripts](#paths-referenced-by-scripts)
- [Module asset families](#module-asset-families)
- [Path maintenance checklist](#path-maintenance-checklist)

## Path conventions

- **`/server/assets/...`** — absolute-style runtime asset paths used by scripts. In this archive, the packaged asset files generally live under the top-level `assets/` directory and must be mapped to the runtime server asset root by deployment.
- **`assets/...`** — relative paths in scripts or project files; resolve them according to the caller/engine context rather than assuming they are equivalent to `/server/assets/...`.
- **`../assets/objects/*.tsx`** — relative Tiled tileset references. Keep the relationship between a `.tmx` map and its referenced tilesets intact.
- **`.png`** — sprite/texture image; **`.animation`/`.anim`** — animation metadata; **`.ogg`/`.wav`** — audio; **`.tsx`** — Tiled tileset; **`.zip`** — bundled encounter/mob archive where used.

## Asset tree included in the archive

The archive contains **1033 non-directory files under `assets/`**. The following directory counts are recursive and include nested files:

| Archive directory | File count |
|---|---:|
| `assets/` | 1033 |
| `assets/avatars/` | 8 |
| `assets/backgrounds/` | 2 |
| `assets/demo/` | 25 |
| `assets/ezlibs-assets/` | 446 |
| `assets/indy-trains/` | 62 |
| `assets/misc/` | 2 |
| `assets/net-game-footbomb/` | 63 |
| `assets/net-games/` | 92 |
| `assets/ow/` | 27 |
| `assets/sfx/` | 1 |
| `assets/simon-says/` | 17 |
| `assets/tiles/` | 19 |
| `assets/tourney/` | 259 |
| `assets/ui/` | 10 |
| `assets/avatars/mug/` | 4 |
| `assets/avatars/sheet/` | 4 |
| `assets/ezlibs-assets/.git/` | 49 |
| `assets/ezlibs-assets/ezbuttons/` | 9 |
| `assets/ezlibs-assets/ezcheckpoints/` | 6 |
| `assets/ezlibs-assets/ezencounters/` | 74 |
| `assets/ezlibs-assets/ezexplosions/` | 2 |
| `assets/ezlibs-assets/ezfarms/` | 12 |
| `assets/ezlibs-assets/ezmystery/` | 17 |
| `assets/ezlibs-assets/eznpcs/` | 241 |
| `assets/ezlibs-assets/ezrushroads/` | 8 |
| `assets/ezlibs-assets/ezusers/` | 2 |
| `assets/ezlibs-assets/ezwarps/` | 11 |
| `assets/ezlibs-assets/ezweather/` | 8 |
| `assets/ezlibs-assets/sfx/` | 6 |
| `assets/indy-trains/demo/` | 11 |
| `assets/net-game-footbomb/bombs/` | 12 |
| `assets/net-game-footbomb/bots/` | 33 |
| `assets/net-game-footbomb/goal-post/` | 2 |
| `assets/net-game-footbomb/particles/` | 1 |
| `assets/net-game-footbomb/sfx/` | 1 |
| `assets/net-game-footbomb/tiles/` | 2 |
| `assets/net-game-footbomb/ui/` | 10 |
| `assets/net-game-footbomb/upgrades/` | 2 |
| `assets/net-games/cursors/` | 5 |
| `assets/net-games/displayer/` | 42 |
| `assets/net-games/fonts/` | 15 |
| `assets/net-games/meters/` | 2 |
| `assets/net-games/mini-map/` | 4 |
| `assets/net-games/sfx/` | 5 |
| `assets/net-games/ui/` | 14 |
| `assets/ow/prog/` | 27 |
| `assets/tourney/bgs/` | 10 |
| `assets/tourney/liscense-graphic/` | 1 |
| `assets/tourney/music/` | 4 |
| `assets/tourney/npc-navis-testing/` | 84 |
| `assets/tourney/npc-navis/` | 81 |
| `assets/tourney/sfx/` | 4 |
| `assets/tourney/tourney-board-elements/` | 71 |
| `assets/ui/menuAPI/` | 10 |

### Asset directory overview

| Asset family | Observed purpose / examples |
|---|---|
| `assets/avatars/` | Avatar mugshots and sheets, generally paired with `.png` and `.animation` files. Some names are encoded identifiers; preserve filenames exactly. |
| `assets/backgrounds/` | Background art and animation definitions. |
| `assets/demo/` | Demo/test sprites, mugs, animation files, audio, and Tiled tilesets. |
| `assets/ezlibs-assets/` | Assets grouped by ezlibs module, including buttons, checkpoints, encounters, explosions, farms, NPC mugs, Rush roads, warps, weather, and shared SFX. |
| `assets/NebuLibsAssets/` | Nebulous Liberations bot sprites/animations, mug assets, and sound effects referenced by its modules. |
| `assets/net-game-footbomb/` | FootBomb bot/bomb/UI asset groups referenced by the FootBomb module. |
| `assets/net-games/` | Shared cursors, display textures, fonts, meters, UI frames/menus, and UI SFX. |
| `assets/ow/prog/` | PROG overworld sprites and mugshots, including recolors. |
| `assets/simon-says/` | Simon Says board/chat/indicator graphics, audio, and Navi-related files. |
| `assets/tourney/` | Tournament music, SFX, board elements, and NPC Navi test assets. |
| `assets/tiles/` | Tiled tileset definitions for liberation collision, attack indicators, and selected tiles. |
| `assets/objects/` | Tiled object tilesets referenced with relative `../assets/objects/*.tsx` paths. |

## Paths referenced by scripts

The table below lists literal strings detected in Lua source. The source column names every script containing the string. Paths may be constructed dynamically elsewhere and therefore are not necessarily exhaustive of runtime asset requests.

### `../assets/objects/BoktaiDolls2.tsx`
- **Occurrences:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/BoktaiDolls28x33.tsx`
- **Occurrences:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Ducky.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/EXE6_Shortcuts.tsx`
- **Occurrences:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/EXE6_boss_markers.tsx`
- **Occurrences:** 4
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Junkpiles.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/LanHpAnimatedTiles.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Teddy.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Zarydoll.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/bass_plush.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/beyblade.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/coffee.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/fountain.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/frag.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/jukebox.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/midrug_72x96_72x96.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_huge_128x96_128x96.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_mid_72x96_72x96.tsx`
- **Occurrences:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_pairs_128x96_128x96.tsx`
- **Occurrences:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_small_32x32_32x32.tsx`
- **Occurrences:** 3
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/skull_1.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/skull_2.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/toy.tsx`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/tree.tsx`
- **Occurrences:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `/server/assets/NebuLibsAssets/bots/beast breath.animation`
- **Occurrences:** 5
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/beast breath.png`
- **Occurrences:** 5
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/bigbrute.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/bigbrute.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blizzardman.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blizzardman.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blur.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`

### `/server/assets/NebuLibsAssets/bots/blur.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`

### `/server/assets/NebuLibsAssets/bots/explosion.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/bots/explosion.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/bots/item.animation`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/loot.lua`

### `/server/assets/NebuLibsAssets/bots/item.png`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/loot.lua`

### `/server/assets/NebuLibsAssets/bots/paralyze.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/bots/paralyze.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/bots/recover.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/NebuLibsAssets/bots/recover.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/NebuLibsAssets/bots/shademan.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/shademan.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/snowball.animation`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/snowball.png`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/blizzardman.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/blizzardman.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 0.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 1.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 2.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 3.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 4.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 5.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 6.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 7.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 8.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/shademan.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/shademan.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/sound effects/explode.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/sound effects/hurt.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/sound effects/paralyze.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/sound effects/recover.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/basic_mob1.zip`
- **Occurrences:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/basic_mob2.zip`
- **Occurrences:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/basic_mob3.zip`
- **Occurrences:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/demo/cyber_bat.animation`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/cyber_bat.png`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/megaman.animation`
- **Occurrences:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/megaman.png`
- **Occurrences:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/order_points.animation`
- **Occurrences:** 3
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/order_points.png`
- **Occurrences:** 3
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/protoman-bn5.animation`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/protoman-bn5.png`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/roll.animation`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/roll.png`
- **Occurrences:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/shock.animation`
- **Occurrences:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/shock.png`
- **Occurrences:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/encounters/big_brute_encounter.zip`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/encounters/dependencies/com_Dawn_Shademan.zip`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/ezlibs-assets/ezbuttons/`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezbuttons.lua`

### `/server/assets/ezlibs-assets/ezcheckpoints/`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezcheckpoints.lua`

### `/server/assets/ezlibs-assets/ezexplosions/explosion.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/ezexplosions/explosion.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/ezfarms/card_error.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/ezfarms/hoe.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/rain.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/scythe.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/swap_tool.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/water_tile.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/wind.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/eznpcs/`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/eznpcs/eznpcs.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/eznpcs/dialogue_types.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/denpa-warp-sf2.png`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-scripts/ezannounce.lua`, `ezlibs-scripts/ezannounce/ezannounce.lua`, `ezlibs-scripts/ezemail.lua`, `ezlibs-scripts/ezmail.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/luigi-idle.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezannounce.lua`, `ezlibs-scripts/ezannounce/ezannounce.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation`
- **Occurrences:** 6
- **Referenced by:** `ezlibs-scripts/ezannounce.lua`, `ezlibs-scripts/ezannounce/ezannounce.lua`, `ezlibs-scripts/ezemail.lua`, `ezlibs-scripts/ezmail.lua`

### `/server/assets/ezlibs-assets/ezrushroads/fed_rush.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rushy.anim`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rushy.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezwarps/earthquake.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/fall_in_animation.lua`, `ezlibs-scripts/ezwarps/fall_off_2.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/log_in.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/log_out.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/logout.animation`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/logout.png`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezweather/fog.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/fog.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/rain.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/rain.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/snow.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/snow.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/sfx/compress.ogg`
- **Occurrences:** 2
- **Referenced by:** `ezlibs-scripts/ezpress.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/explode.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/sfx/hurt.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/item_get.ogg`
- **Occurrences:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`, `ezlibs-scripts/ezfarms.lua`, `ezlibs-scripts/ezmemory.lua`, `ezlibs-scripts/ezmystery.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/panel_change.ogg`
- **Occurrences:** 4
- **Referenced by:** `events/eznpcs_onceitem.lua`, `ezlibs-scripts/ezcheckpoints.lua`, `ezlibs-scripts/generate-ezlibs-tiled.lua`

### `/server/assets/ezlibs-assets/sfx/recover.ogg`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-scripts/main.lua`

### `/server/assets/jukebox/`
- **Occurrences:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `/server/assets/net-game-footbomb/bombs/`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-game-footbomb/bots/`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-game-footbomb/ui/score-board.animation`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-game-footbomb/ui/score-board.png`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-games/cursors/green_cursor.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/cursors/text_cursor.animation`
- **Occurrences:** 3
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`, `net-games/dialogue/prompt.lua`, `test-runner/tests/demo.lua`

### `/server/assets/net-games/cursors/text_cursor.png`
- **Occurrences:** 3
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`, `net-games/dialogue/prompt.lua`, `test-runner/tests/demo.lua`

### `/server/assets/net-games/displayer/empty_white.png`
- **Occurrences:** 7
- **Referenced by:** `displayer/scrolling-sprite-list.lua`, `displayer/scrolling-text-list.lua`, `displayer/text-display.lua`, `net-games/dialogue/dialogue.lua`, `net-games/dialogue/prompt.lua`, `net-games/dialogue/prompt_vertical.lua`, `net-games/npcs/prog_banner_dialogue.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_left.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_left_frame_gray.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle_frame_gray.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_right.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_right_frame_gray.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/fonts/fonts_battle.animation`
- **Occurrences:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_black_shimmer.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_compressed.animation`
- **Occurrences:** 1
- **Referenced by:** `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_compressed.png`
- **Occurrences:** 11
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_dark_compressed.animation`
- **Occurrences:** 1
- **Referenced by:** `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_dark_compressed.png`
- **Occurrences:** 12
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`, `net-games/npcs/prog_basic_freedraw.lua`

### `/server/assets/net-games/fonts/fonts_gradient.animation`
- **Occurrences:** 11
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_shimmer.animation`
- **Occurrences:** 2
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_shimmer.png`
- **Occurrences:** 1
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_thick.animation`
- **Occurrences:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_thin.animation`
- **Occurrences:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_tiny.animation`
- **Occurrences:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_wide.animation`
- **Occurrences:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/meters/order_points.animation`
- **Occurrences:** 3
- **Referenced by:** `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/meters/order_points.png`
- **Occurrences:** 3
- **Referenced by:** `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/sfx/cancel.ogg`
- **Occurrences:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/card_confirm.ogg`
- **Occurrences:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/card_desc.ogg`
- **Occurrences:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/card_desc_close.ogg`
- **Occurrences:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/choose.ogg`
- **Occurrences:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/cursor_move.ogg`
- **Occurrences:** 4
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`, `net-games/dialogue/prompt.lua`, `net-games/dialogue/prompt_vertical.lua`, `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/screen_open.ogg`
- **Occurrences:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/text.ogg`
- **Occurrences:** 14
- **Referenced by:** `net-games/bn-textbox.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/prog_vert_prompt_sapphire.lua`, `net-games/npcs/talk_presets.lua`, `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/ui/card_shop_exit.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/card_shop_item.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/highlight_default.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/highlight_shop.png`
- **Occurrences:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an.animation`
- **Occurrences:** 3
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an_frame.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_shop_an.png`
- **Occurrences:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_shop_an_frame.png`
- **Occurrences:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/scrollbar.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/ow/prog/`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_talk_colors.lua`

### `/server/assets/ow/prog/prog_mug.animation`
- **Occurrences:** 19
- **Referenced by:** `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug.png`
- **Occurrences:** 8
- **Referenced by:** `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_charcoal_grey.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_emerald.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_lime.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_orange.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_pink.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_purple.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_red.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_sapphire.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_turquoise.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_white.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_yellow.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_ow.animation`
- **Occurrences:** 18
- **Referenced by:** `net-games/npcs/prog_banner_dialogue.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_freedraw.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/prog_vert_prompt_pink.lua`, `net-games/npcs/prog_vert_prompt_red.lua`, `net-games/npcs/prog_vert_prompt_sapphire.lua`, `net-games/npcs/talk.lua`

### `/server/assets/ow/prog/prog_ow.png`
- **Occurrences:** 12
- **Referenced by:** `net-games/npcs/prog_banner_dialogue.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_freedraw.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk.lua`

### `/server/assets/ow/prog/prog_ow_charcoal_grey.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`

### `/server/assets/ow/prog/prog_ow_emerald.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/ow/prog/prog_ow_pink.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_pink.lua`

### `/server/assets/ow/prog/prog_ow_red.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_red.lua`

### `/server/assets/ow/prog/prog_ow_sapphire.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_sapphire.lua`

### `/server/assets/simon-says/board.animation`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/board.png`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/chat.animation`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/chat.png`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/correct.ogg`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/count.ogg`
- **Occurrences:** 3
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/game_start.ogg`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/indicators.animation`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/indicators.png`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/normal-navi-bn4_green`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/normal-navi-bn4_green-mug`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/succeed.ogg`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/time_up.ogg`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/wrong_answer.ogg`
- **Occurrences:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/tiles/Liberation Collision.tsx`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/instance.lua`

### `/server/assets/tiles/attack indicator.tsx`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`

### `/server/assets/tiles/selected tile.tsx`
- **Occurrences:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`

### `/server/assets/tourney/music/bbn4_tournament_announcement.ogg`
- **Occurrences:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/npc-navis-testing/`
- **Occurrences:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-npcs.lua`

### `/server/assets/tourney/npc-navis-testing/gutsman/mug.png`
- **Occurrences:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/npc-navis-testing/mug.png`
- **Occurrences:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/sfx/bar-move.ogg`
- **Occurrences:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/sfx/cheer.ogg`
- **Occurrences:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/sfx/mug-bleep.ogg`
- **Occurrences:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/tourney-board-elements/`
- **Occurrences:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/ui/menuAPI/`
- **Occurrences:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `assets/avatars/mug/`
- **Occurrences:** 4
- **Referenced by:** `avatar_utils/main.lua`, `ezlibs-scripts/avatar_utils/main.lua`

### `assets/avatars/sheet/`
- **Occurrences:** 4
- **Referenced by:** `avatar_utils/main.lua`, `ezlibs-scripts/avatar_utils/main.lua`

### `assets/avatars/sheet/secret.png`
- **Occurrences:** 2
- **Referenced by:** `avatar_utils/avatar_utils.lua`, `ezlibs-scripts/avatar_utils/avatar_utils.lua`

### `assets/card.png`
- **Occurrences:** 1
- **Referenced by:** `net-games/navi-emotes/navi-emotes.lua`

## Module asset families

### ezlibs assets

The source uses `/server/assets/ezlibs-assets/` as the shared module asset root. Subfolders visible in source include `ezbuttons/`, `ezcheckpoints/`, `ezexplosions/`, `ezfarms/`, `eznpcs/`, `ezrushroads/`, `ezwarps/`, `ezweather/`, and `sfx/`. Button, weather, warp, NPC, and effect modules pair image/animation definitions and/or audio as appropriate. See `ezlibs-scripts.md` for the consuming module details.

### Net-games shared UI

The source references `/server/assets/net-games/` for cursor art, displayer textures, fonts, meters, UI components, and sound effects. Examples include `cursors/text_cursor.png` with `text_cursor.animation`, font textures/animations under `fonts/`, vertical prompt UI assets under `ui/`, and UI sounds under `sfx/`.

### FootBomb

The FootBomb configuration and runtime refer to `/server/assets/net-game-footbomb/` for bot sprites, bomb skins, and UI assets. Navi options are configured in `scripts/ezlibs-custom/footbomb/navi_options.lua`; bomb skin options are configured in `bomb_options.lua`; shared paths/tuning live in `constants.lua`. Asset presence should be checked against the packaged tree and deployment root.

### Nebulous Liberations

The liberation modules reference `/server/assets/NebuLibsAssets/` for bots, mugs, and sound effects. Keep filenames with spaces, such as `sound effects/explode.ogg` and `mugs/order pts.png`, unchanged.

### Tournament

Tournament code references `/server/assets/tourney/` for the announcement music, board elements, SFX, and NPC test mug assets. Board art and positional/layout configuration are maintained separately in the tournament UI/layout modules.

### Tiled resources

Maps and Tiled object definitions may reference `../assets/objects/*.tsx` and other tileset `.tsx` files. Do not rename or relocate tilesets without updating each referring map. The archive also contains object tilesets in its top-level `assets/objects/` tree.

## Path maintenance checklist

1. Search the Lua source for the exact old path before renaming an asset.
2. Confirm the matching file exists in the packaged `assets/` tree and is deployed under the expected `/server/assets/` root.
3. Keep sprite images paired with the correct `.animation` metadata where the code requests both.
4. Preserve spaces, case, punctuation, and encoded avatar filenames exactly.
5. For relative `.tsx` references, verify paths relative to the map or tileset that declares them.
6. Do not assume every packaged asset is actively used: this archive includes demo, test, vendored, and git metadata files as well as runtime resources.

---

## Current archive coverage (2026-10-23)

This documentation bundle was refreshed against the supplied `scripts_internal_test_server.zip` snapshot. For exact per-file imports, event subscriptions, function declarations, and source location, use the linked [per-script reference library](script-reference/README.md). These references supplement rather than replace the subsystem explanations above.
