# `net-games/dialogue/dialogue.lua`

> **Source reference**
>
> Refreshed from the current `net-games/dialogue/dialogue.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/dialogue/dialogue.lua Hardened net-games dialogue lifecycle. Keeps the creator-side Displayer architecture while preserving production behavior learned from shadis_hp: held-input handoff protection, real visual teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

## Module location

- **Source:** `net-games/dialogue/dialogue.lua`
- **Reference:** `script-reference/net-games/dialogue/dialogue.lua.md`
- **Source SHA-256 prefix:** `6489da0b4308`

## Source header notes

- scripts/net-games/dialogue/dialogue.lua
- Hardened net-games dialogue lifecycle.
- Keeps the creator-side Displayer architecture while preserving production
- behavior learned from shadis_hp: held-input handoff protection, real visual
- teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/displayer/displayer` |
| `scripts/displayer/text-display` |
| `scripts/input/input` |
| `scripts/net-games/dialogue/constants` |
| `scripts/net-games/dialogue/prompt` |
| `scripts/net-games/dialogue/prompt_vertical` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ensure_backdrop_sprite` | `player_id` |
| `draw_backdrop` | `player_id, backdrop, z` |
| `erase_backdrop` | `player_id` |
| `set_input_locked` | `player_id, locked` |
| `ensure_listener` | `` |
| `default_opts` | `` |
| `merge` | `a, b` |
| `mk_box_id` | `player_id, ui` |
| `gate_handoff_input` | `player_id, seconds` |
| `close_instance` | `player_id, reason` |
| `finish_instance` | `player_id, inst` |
| `attach_tick` | `` |
| `Dialogue.is_active` | `player_id` |
| `Dialogue.prompt_yesno` | `player_id, opts` |
| `Dialogue.prompt_menu` | `player_id, opts` |
| `Dialogue.start` | `player_id, script, opts` |
| `Dialogue.close` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`has_asset`, `provide_asset_for_player`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `lock_player_input`, `unlock_player_input`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `LISTENER_ATTACHED` | `false` |
| `BACKDROP_TEXTURE` | `"/server/assets/net-games/displayer/empty_white.png"` |
| `LISTENER_ATTACHED` | `true` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/displayer/empty_white.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
