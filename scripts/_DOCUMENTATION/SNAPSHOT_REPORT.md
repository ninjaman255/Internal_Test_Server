> **2026-11-11 PlayerControl overlay:** This file is the original snapshot report, **not** a regenerated report for the overlaid `internal_test_server(4).zip`. For patched modules and remaining legacy lock callers see [change digest](PLAYERCONTROL_CHANGELOG.md), [current API](player-control/README.md), and [migration inventory](player-control/MIGRATION_AUDIT.md).

# 🧭 Internal Test Server — Documentation Snapshot

> **Snapshot:** user-uploaded `internal_test_server(2).zip` · **Date of refresh:** 2026-11-11

## Contents

- [Inventory](#inventory)
- [Newly documented modules](#newly-documented-modules)
- [Changed reference line counts](#changed-reference-line-counts)
- [Removed or unmatched legacy index paths](#removed-or-unmatched-legacy-index-paths)
- [Verification limitations](#verification-limitations)

## Inventory

| Source area | Lua files | Named / assigned functions | Initializer tables |
|---|---|---|---|
| `assets` | 23 | 172 | 49 |
| `encounters` | 24 | 0 | 1734 |
| `scripts` | 231 | 3132 | 2701 |

- **278 Lua source files** included, including non-script encounter definitions and battle-mod scripts.
- **73 directory indexes** and **278 file-level references** generated.
- **59 source entries** did not have matching generated documentation previously.
- **27 old source references** had a changed or unparseable line count.
- **0 unmatched legacy index paths** were omitted instead of advertising removed source files.

## Newly documented modules

- `assets/bosses/com_louise_mob_HeelNavi/HeelNavi/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/PanelGrab/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/battle_helpers.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/character.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Doomer/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Gloomer/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/AreaGrab/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/battle_helpers.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/character.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/Volgear/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/battle_helpers.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/mob_tracker.lua`
- `assets/bosses/com_louise_mob_HeelNavi/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/battle_helpers.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/character.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/AreaGrab/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/Cannonball/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/HeroSword/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/Lilbomb/entry.lua`
- `assets/bosses/com_louise_mob_HeelNavi/shared/fx_helper.lua`
- `encounters/Chichi.lua`
- `encounters/Chichi2.lua`
- `encounters/Chichi3.lua`
- `encounters/Chichi4.lua`
- `encounters/Chichi5.lua`
- `encounters/DEBUGLIB.lua`
- `encounters/LiberationEasyMode.lua`
- `encounters/LiberationHardMode.lua`
- `encounters/LiberationNormalMode.lua`
- `encounters/MasterBattle.lua`
- `encounters/NewLiberation1.lua`
- `encounters/SnowPark3.lua`
- `encounters/example liberation friendly.lua`
- `encounters/liberation1.lua`
- `encounters/ponddrive1.lua`
- `encounters/ponddrive2.lua`
- `encounters/porttown1.lua`
- `encounters/porttown2.lua`
- `encounters/porttown3.lua`
- `encounters/rewards.lua`
- `encounters/school.lua`
- `encounters/testground.lua`
- `encounters/testlib.lua`
- `encounters/undernet1.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/battle_scale.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/mettaur.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_bigbrute.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_blizzardman.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_shademan.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/logger.lua`
- `scripts/ezlibs-custom/nebulous-liberations/liberations/points_guage.lua`
- `scripts/ezlibs-scripts/announcements_feed.lua`
- `scripts/ezlibs-scripts/ezbottriggers.lua`
- `scripts/ezlibs-scripts/ezencounters/rewards.lua`
- `scripts/ezlibs-scripts/ezwarps/default_spawn_guard.lua`

## Changed reference line counts

| Source | Previous documented lines | Current source lines |
|---|---|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants.lua` | 155 | 174 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua` | 101 | 194 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua` | 276 | 344 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua` | 279 | 271 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception.lua` | 246 | 249 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` | 1715 | 2289 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/loot.lua` | 361 | 368 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu.lua` | 382 | 448 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua` | 290 | 511 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua` | 125 | 152 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua` | 561 | 592 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/selection.lua` | 185 | 189 |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/validation.lua` | 201 | 254 |
| `scripts/ezlibs-custom/nebulous-liberations/main.lua` | 715 | 731 |
| `scripts/ezlibs-custom/nebulous-liberations/player.lua` | 290 | 328 |
| `scripts/ezlibs-scripts/ezannounce.lua` | undocumented | 199 |
| `scripts/ezlibs-scripts/ezcheckpoints.lua` | 528 | 533 |
| `scripts/ezlibs-scripts/ezencounters/main.lua` | 292 | 446 |
| `scripts/ezlibs-scripts/ezlibs-tiled-schema.lua` | 3139 | 4029 |
| `scripts/ezlibs-scripts/ezmapinstance.lua` | 555 | 532 |
| `scripts/ezlibs-scripts/ezmemory.lua` | 1233 | 1264 |
| `scripts/ezlibs-scripts/eztriggers.lua` | undocumented | 370 |
| `scripts/ezlibs-scripts/ezwarps/main.lua` | 339 | 347 |
| `scripts/ezlibs-scripts/generate-ezlibs-tiled.lua` | 2023 | 2309 |
| `scripts/input-controller/input-controller.lua` | 660 | 672 |
| `scripts/libs/encounters.lua` | undocumented | 143 |
| `scripts/utils/async.lua` | 171 | 302 |

## Removed or unmatched legacy index paths

*None.*

## Verification limitations

- ZIP passed CRC testing before extraction and the source snapshot was used directly without mixing versions.
- Documentation is a **static reference** and is not a proof of runtime correctness, successful calls, or Lua parser completeness.
- The function and table extractor is conservative about named declarations and direct table constructor keys, but does not resolve control flow, inheritance, dynamic fields, or callbacks assigned through computed keys.
- 16 first-party authored README/guide files have source-alignment notices and links to the current reference; their existing long-form narrative is preserved, not exhaustively rewritten. Vendor files and generator-owned references were left untouched.
