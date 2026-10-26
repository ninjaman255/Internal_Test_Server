# `ezlibs-custom/footbomb/sfx_driver.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/sfx_driver.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Sound driver for FootBomb round events. Reacts to semantic round events by playing sounds. All timing lives in the round's event emitters; this module only decides WHAT to play, not WHEN. Adding a new sound effect is a one-line addition here — no changes needed to `resolve_round_winner` or any animation code. The driver is attached once per round (see `SfxDriver.attach`). It does NOT subscribe to per-instance lifecycle events; those are handled centrally in main.lua. The driver only cares about round-phase events.

## Module location

- **Source:** `ezlibs-custom/footbomb/sfx_driver.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/sfx_driver.lua.md`
- **Source SHA-256 prefix:** `b7bceb9fa397`

## Source header notes

- Sound driver for FootBomb round events.
- Reacts to semantic round events by playing sounds. All timing lives in the
- round's event emitters; this module only decides WHAT to play, not WHEN.
- Adding a new sound effect is a one-line addition here — no changes needed
- to `resolve_round_winner` or any animation code.
- The driver is attached once per round (see `SfxDriver.attach`). It does NOT

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `SfxDriver.attach` | `round_events, event_names, play_sound_for_inst, instance_id, file_exists` |
| `safe_play` | `path, reason` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SFX` | `{` |
| `THUD` | `"/server/assets/net-game-footbomb/sfx/item-thud.ogg",` |
| `EXPLOSION` | `"/server/assets/net-game-footbomb/sfx/explosion.ogg",` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-game-footbomb/sfx/item-thud.ogg` |
| `/server/assets/net-game-footbomb/sfx/explosion.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
