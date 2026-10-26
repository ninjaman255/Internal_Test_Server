# Server Scripts — Documentation Bundle

> **Documentation scope and accuracy**

> This index and its references were refreshed against the current `internal_test_server.zip` Library upload (2026-10-25). Subsystem guides preserve their detailed explanations; the per-script reference library supplies an individual Markdown page for every Lua file in the archive. Source-derived inventories do not imply live runtime testing.

## Snapshot inventory

- Lua source files indexed: **230**.
- Individual Lua reference pages: **230**.
- Inspection date: **2026-10-25** (static source review; no live server runtime test implied).

## 🗂️ Table of Contents

- [Animation Engine](animation-engine.md) — animation and sequencing utilities
- [Displayer](displayer.md) — text, sprites, timers, sliced panels, and display helpers
- [Input Controller](input-controller.md) — shared per-player input registry and ownership
- [World Attachment](world-attachment.md) — sprite/actor point-to-map coordinate helpers
- [Enum](enum.md) — enum and enum-set utilities
- [ezlibs Custom](ezlibs-custom.md) — FootBomb Ref and Nebulous Liberations
- [ezlibs Scripts](ezlibs-scripts.md) — shared server scripts and infrastructure
- [Net Games Tournament](net-games-tourney.md) — tournament management and UI
- [Net Games](net-games.md) — game, UI, dialogue, and NPC systems
- [Scripts Tree Reference](scripts-tree.md) — directory-by-directory inventory of the scripts tree
- [Assets and File Paths](assets-and-file-paths.md) — asset roots and literal paths referenced by Lua
- [Per-Script Reference Library](script-reference/README.md) — browse references by directory

## Individual script references

Every entry below opens the source reference generated from the matching Lua file in this archive. Paths are relative to `scripts/`.

### `./`

- [`animation_points_test.lua`](script-reference/animation_points_test.lua.md)
- [`cosmo.lua`](script-reference/cosmo.lua.md)
- [`example_pvp_script.lua`](script-reference/example_pvp_script.lua.md)
- [`run-gen.lua`](script-reference/run-gen.lua.md)
- [`run-tests.lua`](script-reference/run-tests.lua.md)
- [`simon-says.lua`](script-reference/simon-says.lua.md)
- [`world-attachment.lua`](script-reference/world-attachment.lua.md)

### `HP_Manager`

- [`HP_Manager/background_manage.lua`](script-reference/HP_Manager/background_manage.lua.md)
- [`HP_Manager/main.lua`](script-reference/HP_Manager/main.lua.md)
- [`HP_Manager/realtime_manage.lua`](script-reference/HP_Manager/realtime_manage.lua.md)
- [`HP_Manager/warp_manage.lua`](script-reference/HP_Manager/warp_manage.lua.md)

### `HP_Manager/constants`

- [`HP_Manager/constants/constants.lua`](script-reference/HP_Manager/constants/constants.lua.md)

### `HP_Manager/extensions`

- [`HP_Manager/extensions/extensions.lua`](script-reference/HP_Manager/extensions/extensions.lua.md)

### `animation-engine`

- [`animation-engine/animation-engine.lua`](script-reference/animation-engine/animation-engine.lua.md)
- [`animation-engine/animation-enums.lua`](script-reference/animation-engine/animation-enums.lua.md)
- [`animation-engine/animation-sequences.lua`](script-reference/animation-engine/animation-sequences.lua.md)
- [`animation-engine/math-utils.lua`](script-reference/animation-engine/math-utils.lua.md)

### `avatar_registry`

- [`avatar_registry/main.lua`](script-reference/avatar_registry/main.lua.md)

### `avatar_utils`

- [`avatar_utils/avatar_utils.lua`](script-reference/avatar_utils/avatar_utils.lua.md)
- [`avatar_utils/base64.lua`](script-reference/avatar_utils/base64.lua.md)
- [`avatar_utils/main.lua`](script-reference/avatar_utils/main.lua.md)

### `avatar_utils/lua_yes_parser`

- [`avatar_utils/lua_yes_parser/lib.lua`](script-reference/avatar_utils/lua_yes_parser/lib.lua.md)

### `avatar_utils/lua_yes_parser/example`

- [`avatar_utils/lua_yes_parser/example/main.lua`](script-reference/avatar_utils/lua_yes_parser/example/main.lua.md)

### `avatar_utils/lua_yes_parser/src`

- [`avatar_utils/lua_yes_parser/src/element.lua`](script-reference/avatar_utils/lua_yes_parser/src/element.lua.md)
- [`avatar_utils/lua_yes_parser/src/enums.lua`](script-reference/avatar_utils/lua_yes_parser/src/enums.lua.md)
- [`avatar_utils/lua_yes_parser/src/keyval.lua`](script-reference/avatar_utils/lua_yes_parser/src/keyval.lua.md)

### `avatar_utils/lua_yes_parser/src/utils`

- [`avatar_utils/lua_yes_parser/src/utils/trim.lua`](script-reference/avatar_utils/lua_yes_parser/src/utils/trim.lua.md)

### `boom`

- [`boom/main.lua`](script-reference/boom/main.lua.md)

### `camera`

- [`camera/camera-controller.lua`](script-reference/camera/camera-controller.lua.md)
- [`camera/camera-manager.lua`](script-reference/camera/camera-manager.lua.md)
- [`camera/main.lua`](script-reference/camera/main.lua.md)

### `color-picker`

- [`color-picker/color-picker.lua`](script-reference/color-picker/color-picker.lua.md)

### `displayer`

- [`displayer/displayer.lua`](script-reference/displayer/displayer.lua.md)
- [`displayer/font-system.lua`](script-reference/displayer/font-system.lua.md)
- [`displayer/nameplate.lua`](script-reference/displayer/nameplate.lua.md)
- [`displayer/scrolling-sprite-list.lua`](script-reference/displayer/scrolling-sprite-list.lua.md)
- [`displayer/scrolling-text-list.lua`](script-reference/displayer/scrolling-text-list.lua.md)
- [`displayer/sliced-sprite.lua`](script-reference/displayer/sliced-sprite.lua.md)
- [`displayer/text-display.lua`](script-reference/displayer/text-display.lua.md)
- [`displayer/text-layout.lua`](script-reference/displayer/text-layout.lua.md)
- [`displayer/timer-display.lua`](script-reference/displayer/timer-display.lua.md)
- [`displayer/timer-system.lua`](script-reference/displayer/timer-system.lua.md)

### `enum`

- [`enum/enum.lua`](script-reference/enum/enum.lua.md)
- [`enum/enumset.lua`](script-reference/enum/enumset.lua.md)
- [`enum/main.lua`](script-reference/enum/main.lua.md)
- [`enum/predefined-enums.lua`](script-reference/enum/predefined-enums.lua.md)

### `events`

- [`events/eznpcs_onceitem.lua`](script-reference/events/eznpcs_onceitem.lua.md)

### `ezlibs-custom`

- [`ezlibs-custom/custom.lua`](script-reference/ezlibs-custom/custom.lua.md)

### `ezlibs-custom/endless-runner`

- [`ezlibs-custom/endless-runner/endless-runner.lua`](script-reference/ezlibs-custom/endless-runner/endless-runner.lua.md)

### `ezlibs-custom/footbomb`

- [`ezlibs-custom/footbomb/animation_diagnostics.lua`](script-reference/ezlibs-custom/footbomb/animation_diagnostics.lua.md)
- [`ezlibs-custom/footbomb/animation_points.lua`](script-reference/ezlibs-custom/footbomb/animation_points.lua.md)
- [`ezlibs-custom/footbomb/animation_states.lua`](script-reference/ezlibs-custom/footbomb/animation_states.lua.md)
- [`ezlibs-custom/footbomb/bomb_options.lua`](script-reference/ezlibs-custom/footbomb/bomb_options.lua.md)
- [`ezlibs-custom/footbomb/constants.lua`](script-reference/ezlibs-custom/footbomb/constants.lua.md)
- [`ezlibs-custom/footbomb/main.lua`](script-reference/ezlibs-custom/footbomb/main.lua.md)
- [`ezlibs-custom/footbomb/navi_options.lua`](script-reference/ezlibs-custom/footbomb/navi_options.lua.md)
- [`ezlibs-custom/footbomb/result_timeline.lua`](script-reference/ezlibs-custom/footbomb/result_timeline.lua.md)
- [`ezlibs-custom/footbomb/sfx_driver.lua`](script-reference/ezlibs-custom/footbomb/sfx_driver.lua.md)
- [`ezlibs-custom/footbomb/state.lua`](script-reference/ezlibs-custom/footbomb/state.lua.md)

### `ezlibs-custom/nebulous-liberations`

- [`ezlibs-custom/nebulous-liberations/main.lua`](script-reference/ezlibs-custom/nebulous-liberations/main.lua.md)
- [`ezlibs-custom/nebulous-liberations/player.lua`](script-reference/ezlibs-custom/nebulous-liberations/player.lua.md)

### `ezlibs-custom/nebulous-liberations/liberations`

- [`ezlibs-custom/nebulous-liberations/liberations/ability.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/ability.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/constants.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/constants.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemy.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/instance.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/instance.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/loot.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/loot.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/player_session.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/player_session.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/preloader.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/preloader.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/selection.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/selection.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/validation.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/validation.lua.md)

### `ezlibs-custom/nebulous-liberations/liberations/enemies`

- [`ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua.md)
- [`ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua.md)

### `ezlibs-custom/nebulous-liberations/utils`

- [`ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`](script-reference/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua.md)
- [`ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`](script-reference/ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua.md)
- [`ezlibs-custom/nebulous-liberations/utils/parties.lua`](script-reference/ezlibs-custom/nebulous-liberations/utils/parties.lua.md)
- [`ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`](script-reference/ezlibs-custom/nebulous-liberations/utils/recover_effect.lua.md)

### `ezlibs-scripts`

- [`ezlibs-scripts/announcements_feed.lua`](script-reference/ezlibs-scripts/announcements_feed.lua.md)
- [`ezlibs-scripts/condition.lua`](script-reference/ezlibs-scripts/condition.lua.md)
- [`ezlibs-scripts/direction.lua`](script-reference/ezlibs-scripts/direction.lua.md)
- [`ezlibs-scripts/ezannounce.lua`](script-reference/ezlibs-scripts/ezannounce.lua.md)
- [`ezlibs-scripts/ezbattle_results.lua`](script-reference/ezlibs-scripts/ezbattle_results.lua.md)
- [`ezlibs-scripts/ezbbs.lua`](script-reference/ezlibs-scripts/ezbbs.lua.md)
- [`ezlibs-scripts/ezbus.lua`](script-reference/ezlibs-scripts/ezbus.lua.md)
- [`ezlibs-scripts/ezbuttons.lua`](script-reference/ezlibs-scripts/ezbuttons.lua.md)
- [`ezlibs-scripts/ezcache.lua`](script-reference/ezlibs-scripts/ezcache.lua.md)
- [`ezlibs-scripts/ezcheckpoints.lua`](script-reference/ezlibs-scripts/ezcheckpoints.lua.md)
- [`ezlibs-scripts/ezchristmas.lua`](script-reference/ezlibs-scripts/ezchristmas.lua.md)
- [`ezlibs-scripts/ezconfig.lua`](script-reference/ezlibs-scripts/ezconfig.lua.md)
- [`ezlibs-scripts/ezemail.lua`](script-reference/ezlibs-scripts/ezemail.lua.md)
- [`ezlibs-scripts/ezemitter.lua`](script-reference/ezlibs-scripts/ezemitter.lua.md)
- [`ezlibs-scripts/ezexplosions.lua`](script-reference/ezlibs-scripts/ezexplosions.lua.md)
- [`ezlibs-scripts/ezfarms.lua`](script-reference/ezlibs-scripts/ezfarms.lua.md)
- [`ezlibs-scripts/ezlibs-tiled-schema.lua`](script-reference/ezlibs-scripts/ezlibs-tiled-schema.lua.md)
- [`ezlibs-scripts/ezlocks.lua`](script-reference/ezlibs-scripts/ezlocks.lua.md)
- [`ezlibs-scripts/ezlogger.lua`](script-reference/ezlibs-scripts/ezlogger.lua.md)
- [`ezlibs-scripts/ezmail.lua`](script-reference/ezlibs-scripts/ezmail.lua.md)
- [`ezlibs-scripts/ezmapinstance.lua`](script-reference/ezlibs-scripts/ezmapinstance.lua.md)
- [`ezlibs-scripts/ezmemory.lua`](script-reference/ezlibs-scripts/ezmemory.lua.md)
- [`ezlibs-scripts/ezmenus.lua`](script-reference/ezlibs-scripts/ezmenus.lua.md)
- [`ezlibs-scripts/ezmystery.lua`](script-reference/ezlibs-scripts/ezmystery.lua.md)
- [`ezlibs-scripts/ezpress.lua`](script-reference/ezlibs-scripts/ezpress.lua.md)
- [`ezlibs-scripts/ezquests.lua`](script-reference/ezlibs-scripts/ezquests.lua.md)
- [`ezlibs-scripts/ezrushroads.lua`](script-reference/ezlibs-scripts/ezrushroads.lua.md)
- [`ezlibs-scripts/ezusers.lua`](script-reference/ezlibs-scripts/ezusers.lua.md)
- [`ezlibs-scripts/ezweather.lua`](script-reference/ezlibs-scripts/ezweather.lua.md)
- [`ezlibs-scripts/generate-ezlibs-tiled.lua`](script-reference/ezlibs-scripts/generate-ezlibs-tiled.lua.md)
- [`ezlibs-scripts/helpers.lua`](script-reference/ezlibs-scripts/helpers.lua.md)
- [`ezlibs-scripts/json.lua`](script-reference/ezlibs-scripts/json.lua.md)
- [`ezlibs-scripts/main.lua`](script-reference/ezlibs-scripts/main.lua.md)
- [`ezlibs-scripts/object_registry.lua`](script-reference/ezlibs-scripts/object_registry.lua.md)
- [`ezlibs-scripts/sha256.lua`](script-reference/ezlibs-scripts/sha256.lua.md)
- [`ezlibs-scripts/urlencode.lua`](script-reference/ezlibs-scripts/urlencode.lua.md)

### `ezlibs-scripts/avatar_utils`

- [`ezlibs-scripts/avatar_utils/avatar_utils.lua`](script-reference/ezlibs-scripts/avatar_utils/avatar_utils.lua.md)
- [`ezlibs-scripts/avatar_utils/base64.lua`](script-reference/ezlibs-scripts/avatar_utils/base64.lua.md)
- [`ezlibs-scripts/avatar_utils/main.lua`](script-reference/ezlibs-scripts/avatar_utils/main.lua.md)

### `ezlibs-scripts/avatar_utils/lua_yes_parser`

- [`ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua`](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua.md)

### `ezlibs-scripts/avatar_utils/lua_yes_parser/src`

- [`ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua`](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua.md)
- [`ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua`](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua.md)
- [`ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua`](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua.md)

### `ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils`

- [`ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim.lua`](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim.lua.md)

### `ezlibs-scripts/ezannounce`

- [`ezlibs-scripts/ezannounce/announcements_feed.lua`](script-reference/ezlibs-scripts/ezannounce/announcements_feed.lua.md)
- [`ezlibs-scripts/ezannounce/ezannounce.lua`](script-reference/ezlibs-scripts/ezannounce/ezannounce.lua.md)

### `ezlibs-scripts/ezcutscenes`

- [`ezlibs-scripts/ezcutscenes/ezcutscenes.lua`](script-reference/ezlibs-scripts/ezcutscenes/ezcutscenes.lua.md)
- [`ezlibs-scripts/ezcutscenes/step_types.lua`](script-reference/ezlibs-scripts/ezcutscenes/step_types.lua.md)

### `ezlibs-scripts/ezencounters`

- [`ezlibs-scripts/ezencounters/main.lua`](script-reference/ezlibs-scripts/ezencounters/main.lua.md)

### `ezlibs-scripts/eznpcs`

- [`ezlibs-scripts/eznpcs/dialogue_types.lua`](script-reference/ezlibs-scripts/eznpcs/dialogue_types.lua.md)
- [`ezlibs-scripts/eznpcs/eznpcs.lua`](script-reference/ezlibs-scripts/eznpcs/eznpcs.lua.md)
- [`ezlibs-scripts/eznpcs/ezpushback.lua`](script-reference/ezlibs-scripts/eznpcs/ezpushback.lua.md)
- [`ezlibs-scripts/eznpcs/npc_behaviors.lua`](script-reference/ezlibs-scripts/eznpcs/npc_behaviors.lua.md)

### `ezlibs-scripts/eztriggers`

- [`ezlibs-scripts/eztriggers/ezbottriggers.lua`](script-reference/ezlibs-scripts/eztriggers/ezbottriggers.lua.md)
- [`ezlibs-scripts/eztriggers/eztriggers.lua`](script-reference/ezlibs-scripts/eztriggers/eztriggers.lua.md)

### `ezlibs-scripts/ezwarps`

- [`ezlibs-scripts/ezwarps/arrow_animation_factory.lua`](script-reference/ezlibs-scripts/ezwarps/arrow_animation_factory.lua.md)
- [`ezlibs-scripts/ezwarps/fall_in_animation.lua`](script-reference/ezlibs-scripts/ezwarps/fall_in_animation.lua.md)
- [`ezlibs-scripts/ezwarps/fall_off_2.lua`](script-reference/ezlibs-scripts/ezwarps/fall_off_2.lua.md)
- [`ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`](script-reference/ezlibs-scripts/ezwarps/lev_beast_in_animation.lua.md)
- [`ezlibs-scripts/ezwarps/lev_beast_out_animation.lua`](script-reference/ezlibs-scripts/ezwarps/lev_beast_out_animation.lua.md)
- [`ezlibs-scripts/ezwarps/log_in_animation.lua`](script-reference/ezlibs-scripts/ezwarps/log_in_animation.lua.md)
- [`ezlibs-scripts/ezwarps/main.lua`](script-reference/ezlibs-scripts/ezwarps/main.lua.md)

### `ezlibs-scripts/tests`

- [`ezlibs-scripts/tests/test_utilities.lua`](script-reference/ezlibs-scripts/tests/test_utilities.lua.md)

### `ezlibs-scripts/utils`

- [`ezlibs-scripts/utils/ezdebug.lua`](script-reference/ezlibs-scripts/utils/ezdebug.lua.md)
- [`ezlibs-scripts/utils/eztiledutils.lua`](script-reference/ezlibs-scripts/utils/eztiledutils.lua.md)
- [`ezlibs-scripts/utils/ezutil.lua`](script-reference/ezlibs-scripts/utils/ezutil.lua.md)
- [`ezlibs-scripts/utils/ezvalidate.lua`](script-reference/ezlibs-scripts/utils/ezvalidate.lua.md)

### `indy-trains`

- [`indy-trains/main.lua`](script-reference/indy-trains/main.lua.md)

### `input-controller`

- [`input-controller/buttons.lua`](script-reference/input-controller/buttons.lua.md)
- [`input-controller/d-pad.lua`](script-reference/input-controller/d-pad.lua.md)
- [`input-controller/input-controller.lua`](script-reference/input-controller/input-controller.lua.md)
- [`input-controller/main.lua`](script-reference/input-controller/main.lua.md)

### `jukebox`

- [`jukebox/main.lua`](script-reference/jukebox/main.lua.md)
- [`jukebox/utils.lua`](script-reference/jukebox/utils.lua.md)

### `jukebox/constants`

- [`jukebox/constants/paths.lua`](script-reference/jukebox/constants/paths.lua.md)
- [`jukebox/constants/ui-data.lua`](script-reference/jukebox/constants/ui-data.lua.md)

### `libs`

- [`libs/direction.lua`](script-reference/libs/direction.lua.md)
- [`libs/emotes.lua`](script-reference/libs/emotes.lua.md)
- [`libs/emotions.lua`](script-reference/libs/emotions.lua.md)
- [`libs/encounters.lua`](script-reference/libs/encounters.lua.md)
- [`libs/enums.lua`](script-reference/libs/enums.lua.md)
- [`libs/json.lua`](script-reference/libs/json.lua.md)

### `libs/stardust`

- [`libs/stardust/core.lua`](script-reference/libs/stardust/core.lua.md)

### `logger`

- [`logger/logger.lua`](script-reference/logger/logger.lua.md)

### `net-game-tourney`

- [`net-game-tourney/main.lua`](script-reference/net-game-tourney/main.lua.md)
- [`net-game-tourney/tournament-constants.lua`](script-reference/net-game-tourney/tournament-constants.lua.md)
- [`net-game-tourney/tournament-core.lua`](script-reference/net-game-tourney/tournament-core.lua.md)
- [`net-game-tourney/tournament-flow.lua`](script-reference/net-game-tourney/tournament-flow.lua.md)
- [`net-game-tourney/tournament-manager.lua`](script-reference/net-game-tourney/tournament-manager.lua.md)
- [`net-game-tourney/tournament-npcs.lua`](script-reference/net-game-tourney/tournament-npcs.lua.md)
- [`net-game-tourney/tournament-state.lua`](script-reference/net-game-tourney/tournament-state.lua.md)
- [`net-game-tourney/tournament-ui.lua`](script-reference/net-game-tourney/tournament-ui.lua.md)
- [`net-game-tourney/ui-pos.lua`](script-reference/net-game-tourney/ui-pos.lua.md)

### `net-games`

- [`net-games/bn-textbox.lua`](script-reference/net-games/bn-textbox.lua.md)
- [`net-games/layout-manager.lua`](script-reference/net-games/layout-manager.lua.md)
- [`net-games/main.lua`](script-reference/net-games/main.lua.md)
- [`net-games/ui-safe.lua`](script-reference/net-games/ui-safe.lua.md)
- [`net-games/ui-suppression-examples.lua`](script-reference/net-games/ui-suppression-examples.lua.md)
- [`net-games/ui-suppression.lua`](script-reference/net-games/ui-suppression.lua.md)

### `net-games/dialogue`

- [`net-games/dialogue/constants.lua`](script-reference/net-games/dialogue/constants.lua.md)
- [`net-games/dialogue/dialogue.lua`](script-reference/net-games/dialogue/dialogue.lua.md)
- [`net-games/dialogue/prompt.lua`](script-reference/net-games/dialogue/prompt.lua.md)
- [`net-games/dialogue/prompt_vertical.lua`](script-reference/net-games/dialogue/prompt_vertical.lua.md)
- [`net-games/dialogue/startup.lua`](script-reference/net-games/dialogue/startup.lua.md)

### `net-games/helpers`

- [`net-games/helpers/net-helpers.lua`](script-reference/net-games/helpers/net-helpers.lua.md)

### `net-games/menuAPI`

- [`net-games/menuAPI/main.lua`](script-reference/net-games/menuAPI/main.lua.md)

### `net-games/navi-emotes`

- [`net-games/navi-emotes/constants.lua`](script-reference/net-games/navi-emotes/constants.lua.md)
- [`net-games/navi-emotes/navi-emotes.lua`](script-reference/net-games/navi-emotes/navi-emotes.lua.md)

### `net-games/npcs`

- [`net-games/npcs/menu_options.lua`](script-reference/net-games/npcs/menu_options.lua.md)
- [`net-games/npcs/npc_api.lua`](script-reference/net-games/npcs/npc_api.lua.md)
- [`net-games/npcs/prog_banner_dialogue.lua`](script-reference/net-games/npcs/prog_banner_dialogue.lua.md)
- [`net-games/npcs/prog_basic_dialogue.lua`](script-reference/net-games/npcs/prog_basic_dialogue.lua.md)
- [`net-games/npcs/prog_basic_freedraw.lua`](script-reference/net-games/npcs/prog_basic_freedraw.lua.md)
- [`net-games/npcs/prog_basic_nameplate.lua`](script-reference/net-games/npcs/prog_basic_nameplate.lua.md)
- [`net-games/npcs/prog_dramatic_dialogue.lua`](script-reference/net-games/npcs/prog_dramatic_dialogue.lua.md)
- [`net-games/npcs/prog_dyed_dialogue(bak).lua`](script-reference/net-games/npcs/prog_dyed_dialogue(bak).lua.md)
- [`net-games/npcs/prog_dyed_dialogue.lua`](script-reference/net-games/npcs/prog_dyed_dialogue.lua.md)
- [`net-games/npcs/prog_prompt_dialogue.lua`](script-reference/net-games/npcs/prog_prompt_dialogue.lua.md)
- [`net-games/npcs/prog_prompt_dialogue_2.lua`](script-reference/net-games/npcs/prog_prompt_dialogue_2.lua.md)
- [`net-games/npcs/prog_shop.lua`](script-reference/net-games/npcs/prog_shop.lua.md)
- [`net-games/npcs/prog_talk_colors.lua`](script-reference/net-games/npcs/prog_talk_colors.lua.md)
- [`net-games/npcs/prog_talk_dialogue.lua`](script-reference/net-games/npcs/prog_talk_dialogue.lua.md)
- [`net-games/npcs/prog_vert_prompt.lua`](script-reference/net-games/npcs/prog_vert_prompt.lua.md)
- [`net-games/npcs/prog_vert_prompt_2.lua`](script-reference/net-games/npcs/prog_vert_prompt_2.lua.md)
- [`net-games/npcs/prog_vert_prompt_charcoal_grey.lua`](script-reference/net-games/npcs/prog_vert_prompt_charcoal_grey.lua.md)
- [`net-games/npcs/prog_vert_prompt_emerald.lua`](script-reference/net-games/npcs/prog_vert_prompt_emerald.lua.md)
- [`net-games/npcs/prog_vert_prompt_lime.lua`](script-reference/net-games/npcs/prog_vert_prompt_lime.lua.md)
- [`net-games/npcs/prog_vert_prompt_pink.lua`](script-reference/net-games/npcs/prog_vert_prompt_pink.lua.md)
- [`net-games/npcs/prog_vert_prompt_red.lua`](script-reference/net-games/npcs/prog_vert_prompt_red.lua.md)
- [`net-games/npcs/prog_vert_prompt_sapphire.lua`](script-reference/net-games/npcs/prog_vert_prompt_sapphire.lua.md)
- [`net-games/npcs/talk.lua`](script-reference/net-games/npcs/talk.lua.md)
- [`net-games/npcs/talk_presets.lua`](script-reference/net-games/npcs/talk_presets.lua.md)
- [`net-games/npcs/talk_vert_menu.lua`](script-reference/net-games/npcs/talk_vert_menu.lua.md)

### `net-games/utilities`

- [`net-games/utilities/lockable-table.lua`](script-reference/net-games/utilities/lockable-table.lua.md)

### `persistence`

- [`persistence/logger.lua`](script-reference/persistence/logger.lua.md)
- [`persistence/persistence.lua`](script-reference/persistence/persistence.lua.md)
- [`persistence/save-game.lua`](script-reference/persistence/save-game.lua.md)

### `real_daytime`

- [`real_daytime/main.lua`](script-reference/real_daytime/main.lua.md)

### `test-runner`

- [`test-runner/expect.lua`](script-reference/test-runner/expect.lua.md)
- [`test-runner/main.lua`](script-reference/test-runner/main.lua.md)

### `test-runner/tests`

- [`test-runner/tests/demo.lua`](script-reference/test-runner/tests/demo.lua.md)

### `test-runner/tests/backups`

- [`test-runner/tests/backups/test.lua`](script-reference/test-runner/tests/backups/test.lua.md)

### `tests`

- [`tests/animation_points_test.lua`](script-reference/tests/animation_points_test.lua.md)

### `utils`

- [`utils/async.lua`](script-reference/utils/async.lua.md)
- [`utils/event-emitter.lua`](script-reference/utils/event-emitter.lua.md)
- [`utils/utility.lua`](script-reference/utils/utility.lua.md)

## Maintenance notes

- Each Lua source file has an individual Markdown reference under `script-reference/`, retaining the source directory structure.
- The reference pages inventory detectable imports, Net/event-bus subscriptions, function declarations, and uppercase constants. Verify source for complete signatures and runtime behavior.
- Subsystem guides include a current-archive coverage note and link to the per-script reference library.