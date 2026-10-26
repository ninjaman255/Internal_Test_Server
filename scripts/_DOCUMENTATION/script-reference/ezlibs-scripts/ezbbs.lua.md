# `ezlibs-scripts/ezbbs.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezbbs.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezbbs.lua - Bulletin Board System for ezlibs Handles board interaction, posting, pinning, deleting. Uses ezusers for permission checks. Board data stored in memory/board/<board_name>.json (path from ezconfig).

## Module location

- **Source:** `ezlibs-scripts/ezbbs.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezbbs.lua.md`
- **Source SHA-256 prefix:** `747c651f38a9`

## Source header notes

- ezbbs.lua - Bulletin Board System for ezlibs
- Handles board interaction, posting, pinning, deleting.
- Uses ezusers for permission checks.
- Board data stored in memory/board/<board_name>.json (path from ezconfig).

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/libs/json` |
| `scripts/ezlibs-scripts/ezusers` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezconfig` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `shallow_copy` | `original` |
| `contains_only_whitespace` | `text` |
| `sanitize_title` | `text, limit` |
| `bbs_compare_pinned` | `a, b` |
| `bbs_compare_unpinned` | `a, b` |
| `bbs_display_order_ids` | `board_data` |
| `save_board` | `board_name` |
| `push_post` | `board_name, area_id, post` |
| `show_post` | `player_id, post_id` |
| `create_post` | `player_id, state` |
| `load_board` | `name, callback` |
| `open_board_with_data` | `board_data, player_id, board_name, color, postable, area_id, board_id` |
| `add_display_post` | `src` |
| `load_board_and_open` | `name, player_id, area_id, object, color, postable` |
| `preload_boards` | `` |
| `ezbbs.handle_player_join` | `player_id` |
| `ezbbs.handle_player_disconnect` | `player_id` |
| `ezbbs.handle_object_interaction` | `player_id, object_id, button` |
| `ezbbs.handle_post_selection` | `player_id, post_id` |
| `ezbbs.handle_textbox_response` | `player_id, response` |
| `ezbbs.handle_board_close` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`prepend_posts`, `append_posts`, `list_players`, `message_player`, `get_object_by_id`, `get_player_name`, `open_board`, `list_areas`, `list_objects`, `get_player_area`, `prompt_player`, `remove_post`, `question_player`

## Engine `Async` calls

`promisify`, `await`, `write_file`, `read_file`, `quiz_player`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BOARDS_DIR` | `ezconfig.BOARD_PATH_FOLDER  -- from config (should end with '/')` |
| `TITLE_LIMIT` | `14` |
| `AUTHOR_LIMIT` | `7` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
