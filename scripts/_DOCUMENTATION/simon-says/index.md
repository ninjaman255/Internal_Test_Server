# 📄 `simon-says.lua` — Lua API reference

[🏠 Documentation home](../index.md) · [🎮 Simon Says guide](README.md)

> **Source:** [`scripts/simon-says.lua`](../../simon-says.lua)  
> **Source lines:** 517  
> **SHA-256 (UTF-8):** `6e94f03b8d52d455741ed4e89c39d957a2ec8c2aca43d7df2fac192438ececc4`  
> **Local functions:** 12  
> **Engine events:** 4

## Contents
- [Dependencies](#dependencies)
- [Engine events](#engine-events)
- [Local functions and arguments](#local-functions-and-arguments)
- [Local table initializers](#local-table-initializers)
- [Net API references](#net-api-references)
- [Gameplay lifecycle](README.md#lifecycle-and-control-ownership)

## Dependencies
| Source line | `require` path |
|---:|---|
| 1 | `scripts/player-control/main` |
| 9 | `scripts/logger/logger` |
| 19 | `scripts/net-games/main` |

## Engine events
| Source line | Event | Callback responsibility |
|---:|---|---|
| 233 | `player_disconnect` | Release Simon occupancy and clear player state |
| 428 | `actor_interaction` | Start the game after interaction |
| 434 | `virtual_input` | Read button presses and compare to active prompt |
| 497 | `countdown_ended` | Finish game on timeout |

## Local functions and arguments
| Source line | Function | Arguments | Purpose |
|---:|---|---|---|
| 32 | `async` | `p` | Start a coroutine via Async.promisify |
| 36 | `await` | `v` | Wait for an Async operation |
| 38 | `removeValue` | `array, valueToRemove` | Remove one value from a list |
| 81 | `is_simon_button` | `name` | Filter inputs used in Simon Says |
| 99 | `move_player_to` | `player_id, x, y, z` | Move player using server-supported position API |
| 110 | `position_player_for_simon` | `player_id, simon, p` | Put player at Simon front tile and play facing idle |
| 125 | `restore_player_placement` | `player_id, p` | Restore entry position and idle facing |
| 140 | `jiggle_indicator` | `player_id, simon, indicator_state` | Shake indicator with animation-preserving X/Y keyframes |
| 164 | `spawn_simon` | `(none)` | Spawn Simon NPCs from Tiled objects |
| 250 | `simon_says_press` | `player_id` | Choose and display the next instruction |
| 286 | `end_game_cleanup` | `player_id, reason, simon` | Restore HUD/input, UI, position, occupancy |
| 315 | `greet_simon` | `actor_id, player_id` | Start a player session after Simon accepts the game |

## Local table initializers
| Source line | Identifier |
|---:|---|
| 21 | `simon_cache` |
| 22 | `simon_players` |
| 23 | `simon_optional_properties` |
| 25 | `defaults` |
| 50 | `INPUT_CHOICES` |
| 70 | `INDICATOR_STATE` |
| 94 | `IDLE_BY_DIRECTION` |
| 144 | `offsets` |
| 147 | `keyframes` |
| 263 | `possibilities` |

## Net API references
| Method | Occurrences | First source line |
|---|---:|---:|
| `Net.animate_bot_properties` | 1 | 158 |
| `Net.animate_player` | 2 | 120 |
| `Net.create_bot` | 1 | 214 |
| `Net.fade_player_camera` | 4 | 293 |
| `Net.get_object_by_id` | 1 | 172 |
| `Net.get_player_area` | 2 | 238 |
| `Net.get_player_direction` | 1 | 362 |
| `Net.get_player_position` | 1 | 361 |
| `Net.list_areas` | 1 | 165 |
| `Net.list_objects` | 1 | 170 |
| `Net.message_player` | 6 | 322 |
| `Net.move_bot` | 2 | 136 |
| `Net.play_sound_for_player` | 8 | 403 |
| `Net.remove_object` | 1 | 180 |

## Runtime notes

All overlays remain controlled by `scripts/net-games/main.lua`; Simon Says no longer calls its `move_map_element` method for indicator feedback. `Net.animate_bot_properties` applies X/Y keyframes and pins `Animation` to the current prompt state. The script uses `PlayerControl.acquire_capture` and `PlayerControl.release_capture` **once per completed game**. This protects the player from movement while preserving `virtual_input` game buttons.

**Map placement:** Simon is spawned facing Down Right (`IDLE_DR`). The player starts at `(simon.x + 1, simon.y, simon.z)`, visibly facing Up Left (`IDLE_UL`). Entry position and direction are restored on normal win/timeout cleanup.

**Scope:** This reference covers the source file included in this update. OpenNetBattle client-side behavior is subject to live validation.
