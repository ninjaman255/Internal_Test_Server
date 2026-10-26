# `test-runner/tests/backups/test.lua`

> **Source reference**
>
> Refreshed from the current `test-runner/tests/backups/test.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `test-runner/tests/backups/test.lua`
- **Reference:** `script-reference/test-runner/tests/backups/test.lua.md`
- **Source SHA-256 prefix:** `216a88d51484`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/displayer` |
| `scripts/color-picker/color-picker` |

## `Net:on` subscriptions

| Event |
|---|
| `battle_results` |
| `player_disconnect` |
| `player_join` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `schedule` | `delay, callback` |
| `rainbowUpdate` | `text_index, char, elapsed` |
| `next_step` | `` |
| `test_Displayer` | `player_id` |
| `perChar` | `idx, ch, ctx` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `toggle_player_hud`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/sfx/text.ogg` |
| `/server/assets/net-games/meters/order_points.png` |
| `/server/assets/net-games/meters/order_points.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
