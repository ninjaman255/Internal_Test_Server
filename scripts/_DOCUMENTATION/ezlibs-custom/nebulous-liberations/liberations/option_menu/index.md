# 📄 `option_menu.lua` — Nine-slice menu and scrolling selector

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md) · [🟡 Golden Prog guide](../../GOLDEN_PROG_MISSIONS.md)

**Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/option_menu.lua)  
**Source lines:** 596  
**SHA-256 (UTF-8):** `9ae81fc48e53f162c8242f2b269384e18ad66ea4dd8e5a588bfd0fa7157ab42f`

## Table of contents

- [Public API](#public-api)
- [Parameters](#parameters)
- [Menu lifecycle](#menu-lifecycle)
- [Scrolling behavior](#scrolling-behavior)
- [Mugshot and layout](#mugshot-and-layout)
- [Compatibility](#compatibility)

## Public API

```lua
local OptionMenu = require("scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu")
local promise = OptionMenu.select(player_id, labels, title, config)
```

`select()` returns an `Async` promise of a **zero-based** index, or `nil` when unavailable, disconnected or aborted. A `Cancel` choice is appended if not already present; the caller-owned options table is not modified. The Cancel button selects the Cancel row directly.

## Parameters

| Name | Type | Required? | Meaning |
|---|---|---|---|
| `player_id` | player ID | Yes | Player receiving the menu |
| `labels` (`options`) | sequence of strings | Yes | Menu choices, in their original order |
| `title` | string | No | Header text |
| `config` | table | No | Optional settings below; legacy callers can omit it |
| `config.max_visible` | integer | No | Maximum visible option rows; scrolls when the full list is longer |
| `config.centered` | boolean | No | Center the combined mugshot + panel group, rather than bottom right |
| `config.mugshot` | table | No | Optional mug image + animation definition |
| `config.mugshot.texture_path` | string | With mug | `/server/`-prefixed PNG asset |
| `config.mugshot.animation_path` | string | With mug | `/server/`-prefixed `.animation`, required to crop an atlas |
| `config.mugshot.anim_state` | string | No | Defaults to `IDLE` |
| `config.mugshot.width`, `.height` | number | No | Unscaled frame size; default 40×48 |
| `config.mugshot.scale` | number | No | Mug display scale, default 2 |

## Menu lifecycle

The menu requests a managed `PlayerControl.begin` session with `profile="menu"`, provisions UI assets through Displayer/Net, creates the 9-slice header/body panels, and draws an optional animated mug sprite. It starts accepting inputs after `INPUT_SETTLE_SECONDS` and `guard_input(...)`. Its single Net tick listener dispatches current, focused input, retrieving both the controller and its ownership token via `ctrl, owner = session:input()`. These must be assigned directly: using `session and session:input()` would discard the second return value and cause the ownership checks in `InputController` to reject every button query. Disconnect, Cancel, selection, and session teardown all erase the 9-slice panels and mugshot and resolve the promise. The menu never calls `Net.lock_player_input` directly.

## Scrolling behavior

`menu.first_visible` is the index of the first displayed row. `menu.selected` retains the actual index in the full list. `menu_window(menu)` picks up to `max_visible` rows. `update_visible_window(menu)` moves the viewing window only when selection leaves the current five-row viewport; Confirm always returns `menu.selected - 1`. The header shows a selection counter while scrolling. Diagonals are accepted as Up/Down. The menu consumes all cardinal/diagonal input edges in the same tick and acts only on the current direction, preventing a diagonal transition from causing a second unintended move. Held directions use InputController repeat edges. PlayerControl requires a release after opening or returning focus, while Confirm/Cancel are processed as fresh, single press edges. There is no client-side source cropping of text rows: only the chosen subset is drawn.

## Mugshot and layout

Both 9-slice panels have the **same content-measured width** rather than a fixed 220px maximum or a width shared across unrelated menus. At opening, `option_menu.lua` measures the full, unpaginated option list using `TextLayout.measureLine()` with the same THICK font and text scale as Displayer. It includes the active `> ` cursor, the unselected prefix, outer panel padding, child padding, and the header. For scrollable menus, the measurement reserves the widest selection counter (for example, `Liberations 12/12`), so scrolling does **not** resize the panel. All options, including those outside the visible five-row window and Cancel, remain **one line each**. The original 9-slice scale is unchanged.

For an exceptionally long label, the text scale is reduced only as needed to fit the available screen width after reserving room for the mugshot; text does not wrap. With `centered=true`, the menu centers a left-to-right group consisting of the Gold Prog mug (80×96 at 2× scale), a 12px gap and the measured 9-slice menu. The sprite is allocated with explicit `anim_path` and `anim_state=IDLE` so the 120×48 sheet shows **one 40×48 frame**. Cleanup calls `Net.player_erase_sprite` and `Net.player_dealloc_sprite`.

## Input troubleshooting

If the menu is visible but no buttons work, check that the session's `:input()` result is assigned **directly** to two variables. Lua's `and` expression truncates a multi-return function call to one value; passing `nil` as `owner` to `InputController:is_action_pressed()` intentionally returns `false` when focus is claimed. The input handler also drains transitional direction edges together and reads direction-repeat flags to support scrolling without duplicate steps.

## Compatibility

The original three-argument calls still draw the standard **bottom-right** 9-slice menu and keep the original zero-based response/cancel behavior. Their width now fits their own longest title/option line, rather than the former shared `Panel interaction` width. The centered Golden Prog selector is opt-in via the fourth argument. No legacy input ownership or new engine API is required; the width measurement uses the existing Displayer `TextLayout` module.
