# 🔗 ezlibs-scripts — Current Module Dependencies

[🏠 Documentation home](../index.md) · [📚 ezlibs-scripts index](index.md)

> Generated from the uploaded `internal_test_server(2).zip` (2026-11-11). This lists literal module paths passed to `require` in the current Lua source; it does not imply import success, execution order, or transitive dependency completeness.

## Contents

- [Dependency table](#dependency-table)
- [Interpretation](#interpretation)

## Dependency table

| Lua module | Literal `require` module paths |
|---|---|
| [avatar_utils/avatar_utils.lua](avatar_utils/avatar_utils/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/lib`, `scripts/ezlibs-scripts/avatar_utils/base64` |
| [avatar_utils/lua_yes_parser/example/main.lua](avatar_utils/lua_yes_parser/example/main/index.md) | `lib` |
| [avatar_utils/lua_yes_parser/lib.lua](avatar_utils/lua_yes_parser/lib/index.md) | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums`, `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element` |
| [avatar_utils/lua_yes_parser/src/element.lua](avatar_utils/lua_yes_parser/src/element/index.md) | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums`, `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval`, `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim` |
| [avatar_utils/main.lua](avatar_utils/main/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils` |
| [condition.lua](condition/index.md) | `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezquests`, `scripts/ezlibs-scripts/helpers` |
| [ezannounce.lua](ezannounce/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezemail`, `scripts/ezlibs-scripts/ezbus` |
| [ezannounce/ezannounce.lua](ezannounce/ezannounce/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezemail`, `scripts/ezlibs-scripts/ezbus` |
| [ezbbs.lua](ezbbs/index.md) | `scripts/logger/logger`, `scripts/libs/json`, `scripts/ezlibs-scripts/ezusers`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezconfig` |
| [ezbottriggers.lua](ezbottriggers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezbus` |
| [ezbus.lua](ezbus/index.md) | `scripts/ezlibs-scripts/ezemitter` |
| [ezbuttons.lua](ezbuttons/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezcheckpoints`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [ezcheckpoints.lua](ezcheckpoints/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/condition`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [ezchristmas.lua](ezchristmas/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezweather` |
| [ezconfig.lua](ezconfig/index.md) | `scripts/logger/logger`, `ezlibs-config` |
| [ezcutscenes/ezcutscenes.lua](ezcutscenes/ezcutscenes/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/utils/eztiledutils`, `scripts/ezlibs-scripts/ezcutscenes/step_types` |
| [ezcutscenes/step_types.lua](ezcutscenes/step_types/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [ezemail.lua](ezemail/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/ezannounce/ezannounce` |
| [ezencounters/main.lua](ezencounters/main/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezwarps/main`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/ezencounters/rewards` |
| [ezencounters/rewards.lua](ezencounters/rewards/index.md) | `scripts/ezlibs-scripts/ezmemory` |
| [ezexplosions.lua](ezexplosions/index.md) | `scripts/ezlibs-scripts/ezbus`, `scripts/logger/logger` |
| [ezfarms.lua](ezfarms/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/ezweather`, `scripts/ezlibs-scripts/ezmemory`, `table`, `scripts/ezlibs-scripts/helpers` |
| [ezlocks.lua](ezlocks/index.md) | `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezbus` |
| [ezlogger.lua](ezlogger/index.md) | `scripts/ezlibs-scripts/json`, `scripts/ezlibs-scripts/urlencode` |
| [ezmail.lua](ezmail/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/ezannounce/ezannounce` |
| [ezmemory.lua](ezmemory/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/json`, `scripts/ezlibs-scripts/helpers`, `table`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/avatar_utils/main`, `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| [ezmystery.lua](ezmystery/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezlocks`, `scripts/ezlibs-scripts/condition`, `scripts/ezlibs-scripts/ezencounters/main`, `math`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/avatar_utils/main`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils` |
| [eznpcs/dialogue_types.lua](eznpcs/dialogue_types/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezquests`, `scripts/ezlibs-scripts/ezemail`, `scripts/ezlibs-scripts/condition`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezencounters/main`, `scripts/ezlibs-scripts/ezexplosions`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [eznpcs/eznpcs.lua](eznpcs/eznpcs/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/direction`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/object_registry`, `math`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezquests`, `scripts/ezlibs-scripts/utils/eztiledutils`, `scripts/ezlibs-scripts/eznpcs/dialogue_types`, `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` |
| [eznpcs/ezpushback.lua](eznpcs/ezpushback/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezemitter`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [eznpcs/npc_behaviors.lua](eznpcs/npc_behaviors/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/eznpcs/ezpushback`, `scripts/ezlibs-scripts/utils/eztiledutils` |
| [ezpress.lua](ezpress/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezemitter` |
| [ezpushback.lua](ezpushback/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/eztriggers`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezemitter`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| [ezquests.lua](ezquests/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/helpers` |
| [ezrushroads.lua](ezrushroads/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/ezbus` |
| [eztriggers.lua](eztriggers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/object_registry` |
| [eztriggers/ezbottriggers.lua](eztriggers/ezbottriggers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezbus` |
| [eztriggers/eztriggers.lua](eztriggers/eztriggers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/object_registry` |
| [ezusers.lua](ezusers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/sha256`, `scripts/ezlibs-scripts/ezconfig`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| [ezwarps/arrow_animation_factory.lua](ezwarps/arrow_animation_factory/index.md) | `scripts/ezlibs-scripts/ezweather` |
| [ezwarps/default_spawn_guard.lua](ezwarps/default_spawn_guard/index.md) | `scripts/logger/logger` |
| [ezwarps/log_in_animation.lua](ezwarps/log_in_animation/index.md) | `scripts/logger/logger` |
| [ezwarps/main.lua](ezwarps/main/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/json`, `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory`, `scripts/ezlibs-scripts/ezwarps/log_in_animation`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/object_registry`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/ezwarps/default_spawn_guard`, `scripts/ezlibs-scripts/ezwarps/fall_in_animation`, `scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation`, `scripts/ezlibs-scripts/ezwarps/lev_beast_out_animation`, `scripts/ezlibs-scripts/ezwarps/fall_off_2`, `scripts/ezlibs-scripts/ezpress` |
| [ezweather.lua](ezweather/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezbus` |
| [generate-ezlibs-tiled.lua](generate-ezlibs-tiled/index.md) | `scripts/ezlibs-scripts/json` |
| [helpers.lua](helpers/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/utils/ezutil`, `scripts/ezlibs-scripts/urlencode`, `scripts/ezlibs-scripts/ezcache` |
| [main.lua](main/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/helpers`, `scripts/ezlibs-scripts/ezbus`, `scripts/ezlibs-scripts/eztriggers/eztriggers`, `scripts/ezlibs-scripts/ezcache`, `scripts/ezlibs-scripts/ezencounters/main`, `scripts/ezlibs-scripts/ezbattle_results`, `scripts/ezlibs-scripts/eznpcs/eznpcs`, `scripts/ezlibs-scripts/ezmemory`, `scripts/ezlibs-scripts/ezmystery`, `scripts/ezlibs-scripts/ezweather`, `scripts/ezlibs-scripts/ezwarps/main`, `scripts/ezlibs-scripts/ezfarms`, `scripts/ezlibs-scripts/ezcheckpoints`, `scripts/ezlibs-scripts/ezannounce/ezannounce`, `scripts/ezlibs-scripts/ezemail`, `scripts/ezlibs-scripts/ezexplosions`, `scripts/ezlibs-scripts/ezrushroads`, `scripts/ezlibs-scripts/ezpress`, `scripts/ezlibs-scripts/ezusers`, `scripts/ezlibs-scripts/ezbbs`, `scripts/ezlibs-scripts/ezbuttons`, `scripts/ezlibs-scripts/eznpcs/ezpushback`, `scripts/ezlibs-scripts/eznpcs/npc_behaviors`, `scripts/ezlibs-scripts/eztriggers/ezbottriggers`, `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes`, `scripts/ezlibs-scripts/object_registry` |
| [object_registry.lua](object_registry/index.md) | `scripts/logger/logger`, `scripts/ezlibs-scripts/ezcache` |
| [sha256.lua](sha256/index.md) | `bit` |
| [tests/test_utilities.lua](tests/test_utilities/index.md) | `ezutil`, `ezvalidate`, `ezdebug` |
| [urlencode.lua](urlencode/index.md) | `string`, `table` |

## Interpretation

- Modules without a detected literal `require` are omitted from this view, but their exact source reference remains available from the folder index.
- Dynamic path construction and conditional requires may not be represented here.
- See each module reference for line numbers, API calls, events, function signatures, and table declarations.
