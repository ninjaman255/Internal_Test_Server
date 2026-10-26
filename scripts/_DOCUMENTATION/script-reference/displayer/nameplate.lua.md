# `displayer/nameplate.lua`

> **Source reference**
>
> Refreshed from the current `displayer/nameplate.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `displayer/nameplate.lua`
- **Reference:** `script-reference/displayer/nameplate.lua.md`
- **Source SHA-256 prefix:** `aa5aa842fae1`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/animation-engine/animation-engine` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Nameplate:new` | `font_system` |
| `Nameplate:setTextAPI` | `api` |
| `Nameplate:ensureAssets` | `player_id` |
| `Nameplate:cleanupPlayer` | `player_id` |
| `Nameplate:_redraw` | `player_id, np, assets` |
| `Nameplate:attach` | `player_id, player_data, box_id, box_data, cfg` |
| `Nameplate:erase` | `player_id, player_data, box_data` |
| `Nameplate:begin_close` | `player_id, player_data, box_data, cfg` |
| `Nameplate:update` | `player_id, player_data, box_data, dt` |
| `on_update` | `values` |
| `on_complete` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `provide_asset_for_player`, `player_alloc_sprite`, `player_dealloc_sprite`, `player_draw_sprite`, `player_erase_sprite`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_left.png` |
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle.png` |
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_right.png` |
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_left_frame_gray.png` |
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_middle_frame_gray.png` |
| `/server/assets/net-games/displayer/textbox_bn6_nameplate_right_frame_gray.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
