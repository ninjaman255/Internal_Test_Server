# `ezlibs-custom/nebulous-liberations/main.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/nebulous-liberations/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

main.lua Nebulous Liberations ezlibs custom plugin entry point. This module follows scripts/ezlibs-scripts/main.lua's plugin contract: it returns a table of handle_* functions and does not register its own Net event listeners. The ezlibs dispatcher passes event fields to these methods.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/main.lua`
- **Relative reference:** `script-reference/ezlibs-custom/nebulous-liberations/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/instance` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/validation` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/player` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/nebulous-liberations/utils/parties` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `LibPlugin.handle_actor_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_battle_results` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_player_avatar_change` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_player_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_player_request` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_textbox_response` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.handle_tile_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.on_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LibPlugin.start_game_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `detect_door_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_available_instance_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `leave_party` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `transfer_players_to_new_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 351 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
