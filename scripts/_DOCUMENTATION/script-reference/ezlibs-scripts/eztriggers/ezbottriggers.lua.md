# `ezlibs-scripts/eztriggers/ezbottriggers.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eztriggers/ezbottriggers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezbottriggers.lua Bot-only variant of eztriggers. Mirrors the rectangle/ellipse trigger API of eztriggers, but tracks bots instead of players. It does not touch eztriggers or its player-only state, so the two modules can be used side by side on the same source objects. Fed by eznpcs via ezbus events: bot_created { bot_id, area_id, x, y, z } bot_moved   { bot_id, area_id, x, y, z } bot_removed { bot_id } Each returned emitter fires: entered  { bot_id = ..., object = ..., reason = ..., x, y, z } departed { bot_id = ..., object = ..., reason = ..., x, y, z } The x/y/z values describe the position that caused the transition, so listeners can reconcile overlapping triggers without any Net lookup.

## Module location

- **Source:** `ezlibs-scripts/eztriggers/ezbottriggers.lua`
- **Reference:** `script-reference/ezlibs-scripts/eztriggers/ezbottriggers.lua.md`
- **Source SHA-256 prefix:** `291eee989a43`

## Source header notes

- ezbottriggers.lua
- Bot-only variant of eztriggers.
- Mirrors the rectangle/ellipse trigger API of eztriggers, but tracks bots
- instead of players. It does not touch eztriggers or its player-only state,
- so the two modules can be used side by side on the same source objects.
- Fed by eznpcs via ezbus events:

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezbus` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `resolve_trigger_key` | `trigger_object, trigger_id` |
| `ezbottriggers.add_radius_trigger` | `area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id` |
| `ezbottriggers.add_rectangle_trigger` | `area_id, trigger_object, width, height, trigger_id` |
| `set_bot_overlap` | `trigger_info, bot_id, is_inside, reason, x, y, z` |
| `ezbottriggers.handle_bot_move` | `bot_id, x, y, z, area_id` |
| `ezbottriggers.clear_radius_overlaps_for_bot` | `bot_id, reason` |
| `ezbottriggers.clear_rectangle_overlaps_for_bot` | `bot_id, reason` |
| `ezbottriggers.handle_bot_created` | `bot_id, area_id, x, y, z` |
| `ezbottriggers.handle_bot_removed` | `bot_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`EventEmitter`, `get_bot_area`, `get_bot_position`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEBUG_BOT_TRIGGER_GEOMETRY` | `false` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
