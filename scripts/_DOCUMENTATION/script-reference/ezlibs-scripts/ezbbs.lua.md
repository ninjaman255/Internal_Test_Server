# `ezlibs-scripts/ezbbs.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezbbs.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezbbs.lua - Bulletin Board System for ezlibs Handles board interaction, posting, pinning, deleting. Uses ezusers for permission checks. Board data stored in memory/board/<board_name>.json (path from ezconfig).

## Module location

- **Source:** `ezlibs-scripts/ezbbs.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezbbs.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezconfig` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezusers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/json` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `add_display_post` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `bbs_compare_pinned` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `bbs_compare_unpinned` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `bbs_display_order_ids` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `contains_only_whitespace` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_post` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_board_close` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_post_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbbs.handle_textbox_response` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_board` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_board_and_open` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `open_board_with_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `preload_boards` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `push_post` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `sanitize_title` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `save_board` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `shallow_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `show_post` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 475 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
