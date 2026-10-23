# `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/nebulous-liberations/liberations/player_session.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

player_session.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/player_session.lua`
- **Relative reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/player_session.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/ability` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/loot` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/utils/paralyze_effect` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/emotes` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `PlayerSession:complete_turn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:emote_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:find_closest_guardian` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:find_gate_points` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:find_matching_gates` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:get_ability_permission` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:get_cash` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:get_pass_turn_permission` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:give_turn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:handle_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:heal` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:hurt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:initiate_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:liberate_and_loot_panels` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:liberate_panels` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:loot_panels` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:message_with_points` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:paralyze` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:pass_turn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:question_with_points` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `PlayerSession:quiz_with_points` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 330 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
