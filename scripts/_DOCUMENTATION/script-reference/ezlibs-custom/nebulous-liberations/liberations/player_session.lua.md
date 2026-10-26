# `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/player_session.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

player_session.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/player_session.lua.md`
- **Source SHA-256 prefix:** `4026229fd864`

## Source header notes

- player_session.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/ability` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/loot` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| `scripts/ezlibs-custom/nebulous-liberations/utils/paralyze_effect` |
| `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/libs/emotes` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `PlayerSession:new` | `instance, player` |
| `PlayerSession:emote_state` | `` |
| `PlayerSession:message_with_points` | `message` |
| `PlayerSession:question_with_points` | `question` |
| `PlayerSession:quiz_with_points` | `a, b, c` |
| `PlayerSession:get_ability_permission` | `` |
| `PlayerSession:get_pass_turn_permission` | `` |
| `PlayerSession:initiate_encounter` | `encounter_path, data` |
| `PlayerSession:heal` | `amount` |
| `PlayerSession:hurt` | `amount` |
| `PlayerSession:paralyze` | `` |
| `PlayerSession:pass_turn` | `` |
| `PlayerSession:complete_turn` | `` |
| `PlayerSession:give_turn` | `` |
| `PlayerSession:find_matching_gates` | `` |
| `PlayerSession:find_gate_points` | `id` |
| `PlayerSession:find_closest_guardian` | `` |
| `PlayerSession:liberate_panels` | `panels, results` |
| `PlayerSession:get_cash` | `panel, destroy_items` |
| `PlayerSession:loot_panels` | `panels, remove_traps, destroy_items` |
| `PlayerSession:liberate_and_loot_panels` | `panels, results, remove_traps, destroy_items` |
| `PlayerSession:handle_disconnect` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`set_player_emote`, `unlock_player_input`, `set_player_emotion`, `play_sound_for_player`, `lock_player_input`, `unlock_player_camera`, `get_player_money`, `set_player_money`, `slide_player_camera`

## Engine `Async` calls

`create_promise`, `sleep`, `await`, `promisify`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/mugs/order pts.png` |
| `/server/assets/NebuLibsAssets/mugs/order pts 0.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 1.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 2.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 3.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 4.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 5.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 6.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 7.animation` |
| `/server/assets/NebuLibsAssets/mugs/order pts 8.animation` |
| `/server/assets/NebuLibsAssets/sound effects/hurt.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
