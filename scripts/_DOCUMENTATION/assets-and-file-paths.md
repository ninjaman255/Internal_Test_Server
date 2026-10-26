# Assets and File Paths — Scripts Reference

> **Scope and accuracy**

> Refreshed from Lua literal path strings and the asset tree in `internal_test_server.zip` on 2026-10-25. Literal inventories cannot detect all dynamically assembled paths; runtime mount mappings have not been tested.

## Path conventions

- `/server/assets/...` is an absolute-style path used by runtime scripts; packaged assets may appear under `assets/` in the archive.
- `assets/...` and `../assets/...` are preserved exactly as written; do not assume their resolution is identical.
- `.animation` files are metadata used by sprite animation systems; verify paired assets and exact casing when deploying.

## Asset tree included in the archive

Total non-directory files under `assets/`: **1384**.

| Archive directory | File count |
|---|---:|
| `assets/` | 1384 |
| `assets/Backgrounds/` | 4 |
| `assets/HP_Manager/` | 21 |
| `assets/NebuLibsAssets/` | 101 |
| `assets/avatars/` | 148 |
| `assets/c-slider/` | 1 |
| `assets/demo/` | 25 |
| `assets/ezlibs-assets/` | 465 |
| `assets/indy-trains/` | 62 |
| `assets/jukebox/` | 49 |
| `assets/misc/` | 2 |
| `assets/net-game-footbomb/` | 76 |
| `assets/net-games/` | 94 |
| `assets/ow/` | 27 |
| `assets/real_daytime/` | 3 |
| `assets/sfx/` | 1 |
| `assets/simon-says/` | 17 |
| `assets/tiles/` | 19 |
| `assets/tourney/` | 259 |
| `assets/ui/` | 10 |
| `assets/HP_Manager/Ambient_Manager/` | 3 |
| `assets/HP_Manager/Tilesets/` | 2 |
| `assets/HP_Manager/Wallpapers/` | 4 |
| `assets/NebuLibsAssets/backgrounds/` | 9 |
| `assets/NebuLibsAssets/bots/` | 28 |
| `assets/NebuLibsAssets/encounters/` | 43 |
| `assets/NebuLibsAssets/mugs/` | 16 |
| `assets/NebuLibsAssets/sound effects/` | 4 |
| `assets/avatars/0010502e-1d40-4633-854f-1f6c8ba2a587/` | 4 |
| `assets/avatars/00b9be27-f67d-472e-98e8-b61da08979bd/` | 4 |
| `assets/avatars/07cf72bc-9171-42ed-bd0c-a99396023837/` | 4 |
| `assets/avatars/0fa6ef81-6c68-4e65-8e0e-376c2cd3ca51/` | 4 |
| `assets/avatars/11d93aae-6f8e-450b-9c93-8912cf796070/` | 4 |
| `assets/avatars/125436de-4a39-4efc-95b8-7f07109067e5/` | 4 |
| `assets/avatars/184b7d0c-5809-4b7d-81b9-4b3974111d67/` | 4 |
| `assets/avatars/203ba1f1-0adf-45fe-b656-c93b87bc3a13/` | 4 |
| `assets/avatars/2352f8ce-a4f2-48b9-a94c-dbe19bd45aef/` | 4 |
| `assets/avatars/247d2b03-03d9-4296-8fa1-5efe38dcb133/` | 4 |
| `assets/avatars/2494f1f1-b26d-4605-8c6e-fe46c477c5b9/` | 4 |
| `assets/avatars/2c6e39da-2057-4cb2-a156-20ecd60a118b/` | 4 |
| `assets/avatars/388c67a6-d295-4264-899d-93bbc5f517c9/` | 4 |
| `assets/avatars/46ec5069-3506-47b7-8630-2803e87b7dfc/` | 4 |
| `assets/avatars/4abc574e-9f5c-45f0-b800-269fd9c14007/` | 4 |
| `assets/avatars/5cb05f3f-9c4e-47b0-8f18-5203f41dd2f7/` | 4 |
| `assets/avatars/62efd916-07be-44c4-9acc-3fc83af56174/` | 4 |
| `assets/avatars/64829aa2-404b-4eaf-83ad-25dd1699e012/` | 4 |
| `assets/avatars/676933b7-94aa-47db-8eb0-08c4facff4a7/` | 4 |
| `assets/avatars/7973be89-a9d7-4327-b1e0-b3086bfe416e/` | 4 |
| `assets/avatars/805029b0-1a43-4599-86e9-ccbd00b732d4/` | 4 |
| `assets/avatars/82ead818-5783-4143-b5ee-f9a3bc9db097/` | 4 |
| `assets/avatars/a4f73611-cf86-4541-b81f-5af7f5639042/` | 4 |
| `assets/avatars/a7c74221-912b-48d6-8d55-6c43dd1b789e/` | 4 |
| `assets/avatars/ad385ac7-a6ff-43fc-8688-682e35f24602/` | 4 |
| `assets/avatars/c1ed9979-b4d7-488a-bfe9-62a9eb38b40c/` | 4 |
| `assets/avatars/c748dc37-8600-4b50-8dbc-5cb8fb9d7a4f/` | 4 |
| `assets/avatars/cb022b68-4c78-4b84-b36e-a0a625bcb622/` | 4 |
| `assets/avatars/e016aed2-0935-4025-bac9-8ec2d06cbe1e/` | 4 |
| `assets/avatars/e5ffaa0d-f080-4729-a19f-0549b2033fe4/` | 4 |
| `assets/avatars/e716ad4a-91b2-44a6-91b4-d46963ff8c38/` | 4 |
| `assets/avatars/e902ee3f-7d02-407d-a02f-b1e7f6f6bb6d/` | 4 |
| `assets/avatars/eb3841e7-ec55-4c13-a3ca-02503e14214b/` | 4 |
| `assets/avatars/f866a3e4-f7e6-4b81-9b35-94119cddbbaa/` | 4 |
| `assets/avatars/fd45dddf-248b-4de6-a54a-6407ba21406c/` | 4 |
| `assets/avatars/ffca0211-3718-4f10-9fd2-de535abc9a2e/` | 4 |
| `assets/avatars/mug/` | 2 |
| `assets/avatars/sheet/` | 2 |
| `assets/ezlibs-assets/.git/` | 49 |
| `assets/ezlibs-assets/ezbuttons/` | 9 |
| `assets/ezlibs-assets/ezcheckpoints/` | 21 |
| `assets/ezlibs-assets/ezencounters/` | 75 |
| `assets/ezlibs-assets/ezexplosions/` | 2 |
| `assets/ezlibs-assets/ezfarms/` | 12 |
| `assets/ezlibs-assets/ezmystery/` | 17 |
| `assets/ezlibs-assets/eznpcs/` | 244 |
| `assets/ezlibs-assets/ezrushroads/` | 8 |
| `assets/ezlibs-assets/ezusers/` | 2 |
| `assets/ezlibs-assets/ezwarps/` | 11 |
| `assets/ezlibs-assets/ezweather/` | 8 |
| `assets/ezlibs-assets/sfx/` | 6 |
| `assets/indy-trains/demo/` | 11 |
| `assets/jukebox/records/` | 3 |
| `assets/jukebox/tracks/` | 36 |
| `assets/jukebox/ui-sprites/` | 10 |
| `assets/net-game-footbomb/bombs/` | 12 |
| `assets/net-game-footbomb/bots/` | 37 |
| `assets/net-game-footbomb/goal-post/` | 2 |
| `assets/net-game-footbomb/music/` | 2 |
| `assets/net-game-footbomb/particles/` | 1 |
| `assets/net-game-footbomb/sfx/` | 3 |
| `assets/net-game-footbomb/tiles/` | 2 |
| `assets/net-game-footbomb/ui/` | 14 |
| `assets/net-game-footbomb/upgrades/` | 2 |
| `assets/net-games/cursors/` | 7 |
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

## Literal paths referenced in Lua source

Found **273** unique matching literal paths across the indexed Lua files. This table lists source files containing each path.

### `../assets/objects/BoktaiDolls2.tsx`

- **Occurrences in files:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/BoktaiDolls28x33.tsx`

- **Occurrences in files:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Ducky.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/EXE6_Shortcuts.tsx`

- **Occurrences in files:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/EXE6_boss_markers.tsx`

- **Occurrences in files:** 4
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Junkpiles.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/LanHpAnimatedTiles.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Teddy.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/Zarydoll.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/bass_plush.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/beyblade.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/coffee.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/fountain.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/frag.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/jukebox.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/midrug_72x96_72x96.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_huge_128x96_128x96.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_mid_72x96_72x96.tsx`

- **Occurrences in files:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_pairs_128x96_128x96.tsx`

- **Occurrences in files:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/pokemon_small_32x32_32x32.tsx`

- **Occurrences in files:** 3
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/skull_1.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/skull_2.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/toy.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `../assets/objects/tree.tsx`

- **Occurrences in files:** 2
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `/server/assets/Backgrounds/`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/constants/constants.lua`

### `/server/assets/HP_Manager/Wallpapers/linux_wallpaper.png`

- **Occurrences in files:** 2
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/Wallpapers/macos_wallpaper.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/Wallpapers/windows_wallpaper.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/background_icon.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/background_manage_bar.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/background_manage.lua`

### `/server/assets/HP_Manager/board.png`

- **Occurrences in files:** 2
- **Referenced by:** `HP_Manager/background_manage.lua`, `HP_Manager/realtime_manage.lua`

### `/server/assets/HP_Manager/border.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/emblem.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/lb_button.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/background_manage.lua`

### `/server/assets/HP_Manager/music_icon.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/rb_button.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/background_manage.lua`

### `/server/assets/HP_Manager/realtime_icon.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/HP_Manager/warp_icon.png`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/main.lua`

### `/server/assets/NebuLibsAssets/bots/beast breath.animation`

- **Occurrences in files:** 5
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/beast breath.png`

- **Occurrences in files:** 5
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/bigbrute.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/bigbrute.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blizzardman.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blizzardman.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/blur.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`

### `/server/assets/NebuLibsAssets/bots/blur.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`

### `/server/assets/NebuLibsAssets/bots/explosion.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/bots/explosion.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/bots/item.animation`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/loot.lua`

### `/server/assets/NebuLibsAssets/bots/item.png`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/loot.lua`

### `/server/assets/NebuLibsAssets/bots/paralyze.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/bots/paralyze.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/bots/recover.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/NebuLibsAssets/bots/recover.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/NebuLibsAssets/bots/shademan.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/shademan.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/snowball.animation`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/bots/snowball.png`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/blizzardman.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/blizzardman.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 0.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 1.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 2.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 3.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 4.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 5.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 6.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 7.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts 8.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/order pts.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/mugs/shademan.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/mugs/shademan.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/NebuLibsAssets/sound effects/explode.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

### `/server/assets/NebuLibsAssets/sound effects/hurt.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

### `/server/assets/NebuLibsAssets/sound effects/paralyze.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

### `/server/assets/NebuLibsAssets/sound effects/recover.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/constants.lua`, `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`

### `/server/assets/avatars/...`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/eznpcs/eznpcs.lua`

### `/server/assets/avatars/<id>/player.animation`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `/server/assets/avatars/<id>/player.png`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `/server/assets/avatars/<id>/player_mug.animation`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `/server/assets/avatars/<id>/player_mug.png`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `/server/assets/basic_mob1.zip`

- **Occurrences in files:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/basic_mob2.zip`

- **Occurrences in files:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/basic_mob3.zip`

- **Occurrences in files:** 1
- **Referenced by:** `libs/encounters.lua`

### `/server/assets/demo/cyber_bat.animation`

- **Occurrences in files:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/cyber_bat.png`

- **Occurrences in files:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/megaman.animation`

- **Occurrences in files:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/megaman.png`

- **Occurrences in files:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/order_points.animation`

- **Occurrences in files:** 3
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/order_points.png`

- **Occurrences in files:** 3
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/protoman-bn5.animation`

- **Occurrences in files:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/protoman-bn5.png`

- **Occurrences in files:** 2
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/roll.animation`

- **Occurrences in files:** 3
- **Referenced by:** `cosmo.lua`, `test-runner/tests/demo.lua`

### `/server/assets/demo/roll.png`

- **Occurrences in files:** 3
- **Referenced by:** `cosmo.lua`, `test-runner/tests/demo.lua`

### `/server/assets/demo/shock.anim`

- **Occurrences in files:** 1
- **Referenced by:** `cosmo.lua`

### `/server/assets/demo/shock.animation`

- **Occurrences in files:** 1
- **Referenced by:** `test-runner/tests/demo.lua`

### `/server/assets/demo/shock.png`

- **Occurrences in files:** 2
- **Referenced by:** `cosmo.lua`, `test-runner/tests/demo.lua`

### `/server/assets/encounters/big_brute_encounter.zip`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/ezlibs-assets/ezbuttons/`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezbuttons.lua`

### `/server/assets/ezlibs-assets/ezcheckpoints/`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezcheckpoints.lua`

### `/server/assets/ezlibs-assets/ezencounters/Shademan.zip`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`, `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

### `/server/assets/ezlibs-assets/ezexplosions/explosion.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/ezexplosions/explosion.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/ezfarms/card_error.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/ezfarms/hoe.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/rain.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/scythe.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/swap_tool.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/water_tile.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/ezfarms/wind.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezfarms.lua`

### `/server/assets/ezlibs-assets/eznpcs/`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/eznpcs/eznpcs.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/eznpcs/dialogue_types.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/denpa-warp-sf2.png`

- **Occurrences in files:** 4
- **Referenced by:** `ezlibs-scripts/ezannounce/ezannounce.lua`, `ezlibs-scripts/ezannounce.lua`, `ezlibs-scripts/ezemail.lua`, `ezlibs-scripts/ezmail.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/luigi-idle.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezannounce/ezannounce.lua`, `ezlibs-scripts/ezannounce.lua`

### `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation`

- **Occurrences in files:** 6
- **Referenced by:** `ezlibs-scripts/ezannounce/ezannounce.lua`, `ezlibs-scripts/ezannounce.lua`, `ezlibs-scripts/ezemail.lua`, `ezlibs-scripts/ezmail.lua`

### `/server/assets/ezlibs-assets/ezrushroads/fed_rush.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rushy.anim`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezrushroads/rushy.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezrushroads.lua`

### `/server/assets/ezlibs-assets/ezwarps/earthquake.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/fall_in_animation.lua`, `ezlibs-scripts/ezwarps/fall_off_2.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`, `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/log_in.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/log_out.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/logout.animation`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezwarps/logout.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezwarps/log_in_animation.lua`

### `/server/assets/ezlibs-assets/ezweather/fog.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/fog.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/rain.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/rain.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/snow.animation`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/ezweather/snow.png`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezweather.lua`

### `/server/assets/ezlibs-assets/sfx/compress.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-scripts/ezpress.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/explode.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/ezexplosions.lua`

### `/server/assets/ezlibs-assets/sfx/hurt.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/item_get.ogg`

- **Occurrences in files:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`, `ezlibs-scripts/ezfarms.lua`, `ezlibs-scripts/ezmemory.lua`, `ezlibs-scripts/ezmystery.lua`, `ezlibs-scripts/main.lua`

### `/server/assets/ezlibs-assets/sfx/panel_change.ogg`

- **Occurrences in files:** 5
- **Referenced by:** `events/eznpcs_onceitem.lua`, `ezlibs-scripts/ezcheckpoints.lua`, `ezlibs-scripts/ezlibs-tiled-schema.lua`, `ezlibs-scripts/generate-ezlibs-tiled.lua`

### `/server/assets/ezlibs-assets/sfx/recover.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-scripts/main.lua`

### `/server/assets/indy-trains/`

- **Occurrences in files:** 12
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/conductor-prog-mug.animation`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/conductor-prog-mug.png`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/conductor-prog.animation`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/conductor-prog.png`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/lightpath.png`

- **Occurrences in files:** 2
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/lightpath_`

- **Occurrences in files:** 2
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/pedestal.png`

- **Occurrences in files:** 2
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/pedestal_`

- **Occurrences in files:** 2
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/train_arrive.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/train_arrive_short.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/train_away.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/train_depart.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/indy-trains/train_jingle.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `indy-trains/main.lua`

### `/server/assets/jukebox/`

- **Occurrences in files:** 1
- **Referenced by:** `events/eznpcs_onceitem.lua`

### `/server/assets/jukebox/records/`

- **Occurrences in files:** 1
- **Referenced by:** `jukebox/main.lua`

### `/server/assets/jukebox/records/MMBN7_OST-alouetteEXE/base.png`

- **Occurrences in files:** 1
- **Referenced by:** `jukebox/constants/ui-data.lua`

### `/server/assets/jukebox/tracks/`

- **Occurrences in files:** 2
- **Referenced by:** `jukebox/main.lua`

### `/server/assets/jukebox/ui-sprites/jukebox-backdrop.png`

- **Occurrences in files:** 3
- **Referenced by:** `jukebox/constants/ui-data.lua`, `jukebox/main.lua`

### `/server/assets/jukebox/ui-sprites/jukebox-frame.png`

- **Occurrences in files:** 3
- **Referenced by:** `jukebox/constants/ui-data.lua`, `jukebox/main.lua`

### `/server/assets/jukebox/ui-sprites/records/record.animation`

- **Occurrences in files:** 3
- **Referenced by:** `jukebox/constants/ui-data.lua`, `jukebox/main.lua`

### `/server/assets/jukebox/ui-sprites/shade-screen.png`

- **Occurrences in files:** 3
- **Referenced by:** `jukebox/constants/ui-data.lua`, `jukebox/main.lua`

### `/server/assets/net-game-footbomb/`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-game-footbomb/sfx/explosion.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/footbomb/sfx_driver.lua`

### `/server/assets/net-game-footbomb/sfx/item-thud.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/footbomb/sfx_driver.lua`

### `/server/assets/net-games/cursors/green_cursor.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/cursors/text_cursor.animation`

- **Occurrences in files:** 10
- **Referenced by:** `HP_Manager/background_manage.lua`, `HP_Manager/main.lua`, `HP_Manager/realtime_manage.lua`, `ezlibs-custom/endless-runner/endless-runner.lua`, `ezlibs-custom/footbomb/constants.lua`, `jukebox/main.lua`, `net-games/dialogue/prompt.lua`, `test-runner/tests/demo.lua`

### `/server/assets/net-games/cursors/text_cursor.png`

- **Occurrences in files:** 9
- **Referenced by:** `HP_Manager/background_manage.lua`, `HP_Manager/main.lua`, `HP_Manager/realtime_manage.lua`, `ezlibs-custom/footbomb/constants.lua`, `jukebox/main.lua`, `net-games/dialogue/prompt.lua`, `test-runner/tests/demo.lua`

### `/server/assets/net-games/cursors/vibrant_text_cursor.png`

- **Occurrences in files:** 2
- **Referenced by:** `ezlibs-custom/endless-runner/endless-runner.lua`, `ezlibs-custom/footbomb/constants.lua`

### `/server/assets/net-games/displayer/empty_white.png`

- **Occurrences in files:** 7
- **Referenced by:** `displayer/scrolling-sprite-list.lua`, `displayer/scrolling-text-list.lua`, `displayer/text-display.lua`, `net-games/dialogue/dialogue.lua`, `net-games/dialogue/prompt.lua`, `net-games/dialogue/prompt_vertical.lua`, `net-games/npcs/prog_banner_dialogue.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_left.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_left_frame_gray.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle_frame_gray.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_right.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/displayer/textbox_bn6_nameplate_right_frame_gray.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/nameplate.lua`

### `/server/assets/net-games/fonts/fonts_battle.animation`

- **Occurrences in files:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_black_shimmer.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_compressed.animation`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_compressed.png`

- **Occurrences in files:** 11
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_dark_compressed.animation`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_dark_compressed.png`

- **Occurrences in files:** 12
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`, `net-games/npcs/prog_basic_freedraw.lua`

### `/server/assets/net-games/fonts/fonts_gradient.animation`

- **Occurrences in files:** 11
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_shimmer.animation`

- **Occurrences in files:** 2
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_shimmer.png`

- **Occurrences in files:** 1
- **Referenced by:** `displayer/font-system.lua`

### `/server/assets/net-games/fonts/fonts_thick.animation`

- **Occurrences in files:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_thin.animation`

- **Occurrences in files:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_tiny.animation`

- **Occurrences in files:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/fonts/fonts_wide.animation`

- **Occurrences in files:** 3
- **Referenced by:** `displayer/font-system.lua`, `net-games/main.lua`

### `/server/assets/net-games/meters/order_points.animation`

- **Occurrences in files:** 3
- **Referenced by:** `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/meters/order_points.png`

- **Occurrences in files:** 3
- **Referenced by:** `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/sfx/cancel.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/card_confirm.ogg`

- **Occurrences in files:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/card_desc.ogg`

- **Occurrences in files:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/card_desc_close.ogg`

- **Occurrences in files:** 3
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/net-games/sfx/choose.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/cursor_move.ogg`

- **Occurrences in files:** 5
- **Referenced by:** `ezlibs-custom/endless-runner/endless-runner.lua`, `ezlibs-custom/footbomb/constants.lua`, `net-games/dialogue/prompt.lua`, `net-games/dialogue/prompt_vertical.lua`, `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/screen_open.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `/server/assets/net-games/sfx/text.ogg`

- **Occurrences in files:** 14
- **Referenced by:** `net-games/bn-textbox.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/prog_vert_prompt_sapphire.lua`, `net-games/npcs/talk_presets.lua`, `test-runner/tests/backups/test.lua`

### `/server/assets/net-games/text_cursor.animation`

- **Occurrences in files:** 2
- **Referenced by:** `jukebox/constants/ui-data.lua`

### `/server/assets/net-games/text_cursor.png`

- **Occurrences in files:** 2
- **Referenced by:** `jukebox/constants/ui-data.lua`

### `/server/assets/net-games/ui/card_shop_exit.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/card_shop_item.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/highlight_default.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/highlight_shop.png`

- **Occurrences in files:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an.animation`

- **Occurrences in files:** 3
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_an_frame.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_shop_an.png`

- **Occurrences in files:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/prompt_vert_menu_shop_an_frame.png`

- **Occurrences in files:** 2
- **Referenced by:** `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/net-games/ui/scrollbar.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/dialogue/prompt_vertical.lua`

### `/server/assets/ow/prog/`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_talk_colors.lua`

### `/server/assets/ow/prog/prog_mug.animation`

- **Occurrences in files:** 19
- **Referenced by:** `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug.png`

- **Occurrences in files:** 8
- **Referenced by:** `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_charcoal_grey.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_emerald.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_lime.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_orange.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_pink.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_purple.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_red.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_sapphire.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_turquoise.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_white.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_mug_yellow.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/talk_presets.lua`

### `/server/assets/ow/prog/prog_ow.animation`

- **Occurrences in files:** 18
- **Referenced by:** `net-games/npcs/prog_banner_dialogue.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_freedraw.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`, `net-games/npcs/prog_vert_prompt_emerald.lua`, `net-games/npcs/prog_vert_prompt_lime.lua`, `net-games/npcs/prog_vert_prompt_pink.lua`, `net-games/npcs/prog_vert_prompt_red.lua`, `net-games/npcs/prog_vert_prompt_sapphire.lua`, `net-games/npcs/talk.lua`

### `/server/assets/ow/prog/prog_ow.png`

- **Occurrences in files:** 12
- **Referenced by:** `net-games/npcs/prog_banner_dialogue.lua`, `net-games/npcs/prog_basic_dialogue.lua`, `net-games/npcs/prog_basic_freedraw.lua`, `net-games/npcs/prog_basic_nameplate.lua`, `net-games/npcs/prog_dramatic_dialogue.lua`, `net-games/npcs/prog_dyed_dialogue(bak).lua`, `net-games/npcs/prog_prompt_dialogue.lua`, `net-games/npcs/prog_prompt_dialogue_2.lua`, `net-games/npcs/prog_shop.lua`, `net-games/npcs/prog_vert_prompt.lua`, `net-games/npcs/prog_vert_prompt_2.lua`, `net-games/npcs/talk.lua`

### `/server/assets/ow/prog/prog_ow_charcoal_grey.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_charcoal_grey.lua`

### `/server/assets/ow/prog/prog_ow_emerald.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_emerald.lua`

### `/server/assets/ow/prog/prog_ow_lime.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_lime.lua`

### `/server/assets/ow/prog/prog_ow_pink.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_pink.lua`

### `/server/assets/ow/prog/prog_ow_red.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_red.lua`

### `/server/assets/ow/prog/prog_ow_sapphire.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/npcs/prog_vert_prompt_sapphire.lua`

### `/server/assets/real_daytime/dawn.png`

- **Occurrences in files:** 1
- **Referenced by:** `real_daytime/main.lua`

### `/server/assets/real_daytime/morning.png`

- **Occurrences in files:** 1
- **Referenced by:** `real_daytime/main.lua`

### `/server/assets/real_daytime/night.png`

- **Occurrences in files:** 1
- **Referenced by:** `real_daytime/main.lua`

### `/server/assets/simon-says/board.animation`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/board.png`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/chat.animation`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/chat.png`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/correct.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/count.ogg`

- **Occurrences in files:** 3
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/game_start.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/indicators.animation`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/indicators.png`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/normal-navi-bn4_green`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/normal-navi-bn4_green-mug`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/succeed.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/time_up.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/simon-says/wrong_answer.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `simon-says.lua`

### `/server/assets/tiles/Liberation Collision.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/instance.lua`

### `/server/assets/tiles/attack indicator.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`

### `/server/assets/tiles/selected tile.tsx`

- **Occurrences in files:** 1
- **Referenced by:** `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`

### `/server/assets/tourney/music/bbn4_tournament_announcement.ogg`

- **Occurrences in files:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/npc-navis-testing/`

- **Occurrences in files:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-npcs.lua`

### `/server/assets/tourney/npc-navis-testing/gutsman/mug.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/npc-navis-testing/mug.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/tourney/sfx/bar-move.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/sfx/cheer.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/sfx/mug-bleep.ogg`

- **Occurrences in files:** 2
- **Referenced by:** `net-game-tourney/tournament-constants.lua`, `net-game-tourney/tournament-flow.lua`

### `/server/assets/tourney/tourney-board-elements/`

- **Occurrences in files:** 1
- **Referenced by:** `net-game-tourney/tournament-constants.lua`

### `/server/assets/ui/menuAPI/`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/menuAPI/main.lua`

### `assets/Backgrounds/`

- **Occurrences in files:** 1
- **Referenced by:** `HP_Manager/constants/constants.lua`

### `assets/avatars`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `assets/avatars/<sanitized-player-id>`

- **Occurrences in files:** 1
- **Referenced by:** `avatar_registry/main.lua`

### `assets/avatars/mug/`

- **Occurrences in files:** 4
- **Referenced by:** `avatar_utils/main.lua`, `ezlibs-scripts/avatar_utils/main.lua`

### `assets/avatars/sheet/`

- **Occurrences in files:** 4
- **Referenced by:** `avatar_utils/main.lua`, `ezlibs-scripts/avatar_utils/main.lua`

### `assets/avatars/sheet/secret.png`

- **Occurrences in files:** 2
- **Referenced by:** `avatar_utils/avatar_utils.lua`, `ezlibs-scripts/avatar_utils/avatar_utils.lua`

### `assets/card.png`

- **Occurrences in files:** 1
- **Referenced by:** `net-games/navi-emotes/navi-emotes.lua`

### `assets/jukebox/records/`

- **Occurrences in files:** 1
- **Referenced by:** `jukebox/constants/paths.lua`

### `assets/jukebox/tracks/`

- **Occurrences in files:** 1
- **Referenced by:** `jukebox/constants/paths.lua`

### `assets/jukebox/ui-sprites/`

- **Occurrences in files:** 1
- **Referenced by:** `jukebox/constants/paths.lua`

## Path maintenance checklist

1. Preserve case and spelling of runtime asset paths.
2. Confirm the deployed asset root maps to the archive’s `assets/` layout.
3. Keep sprite textures and animation metadata paired where the code expects both.
4. Check dynamically assembled asset paths manually; the literal inventory cannot enumerate them.
