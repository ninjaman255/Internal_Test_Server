# `ezlibs-custom/footbomb/sfx_driver.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/footbomb/sfx_driver.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Sound driver for FootBomb round events. Reacts to semantic round events by playing sounds. All timing lives in the round's event emitters; this module only decides WHAT to play, not WHEN. Adding a new sound effect is a one-line addition here — no changes needed to `resolve_round_winner` or any animation code. The driver is attached once per round (see `SfxDriver.attach`). It does NOT subscribe to per-instance lifecycle events; those are handled centrally in main.lua. The driver only cares about round-phase events.

## Module location

- **Source:** `ezlibs-custom/footbomb/sfx_driver.lua`
- **Relative reference:** `script-reference/ezlibs-custom/footbomb/sfx_driver.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `SfxDriver.attach` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`EXPLOSION`, `THUD`

## Source notes

- Approximate source size: 59 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
