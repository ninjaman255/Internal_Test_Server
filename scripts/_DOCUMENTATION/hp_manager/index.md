# 🖥️ HP Manager — Documentation index

[🏠 Documentation home](../index.md)

| Reference | Purpose |
|---|---|
| [README.md](README.md) | Guide: desktop + editors |
| [DIAGNOSTIC_READBACK.md](DIAGNOSTIC_READBACK.md) | Save/write/readback and foreground debugging guide |
| [INPUT_HANDOFF_FIX.md](INPUT_HANDOFF_FIX.md) | Post-save input rearming, log evidence, and regression test |
| [index.md](main/index.md) | Desktop main.lua reference |
| [index.md](background_manage/index.md) | Background editor |
| [index.md](realtime_manage/index.md) | Real Time settings editor |
| [index.md](warp_manage/index.md) | Warp native board editor |
| [index.md](constants/constants/index.md) | Constants and paths |
| [index.md](extensions/extensions/index.md) | Extensions |

## November 2026 reliability notes

- HP Manager's standalone script entry point is authoritative; a redundant bootstrap import was removed after logs showed the listener registering twice.
- The desktop ignores re-entrant object interactions while a desktop or child session is active.
- Background Manager keeps its background-name label visible on both the chooser and settings screen.
- Background and Real Time editors are single-flight for save prompts and reject stale/duplicate responses.
- Child modules expose abort cleanup when a parent catches a failed open; UI or persistence failures should not leave input capture stuck.
- Real Time editor offsets are now restricted to **−840 to +840 minutes**, consistent with the runtime validation.
- [Related Nebulous Liberations asset migration and log findings](../ezlibs-custom/nebulous-liberations/ASSET_PATHS.md).

**Save, timezone, foreground and submenu-return repair:** [Regression guide](SAVE_AND_RETURN_FIX.md)
