# Nebulous Liberations — Asset Directory Layout (2026-11-11)

This page documents the **user-supplied** asset archive `nebulous-liberations.zip`.
Install its contents under `assets/ezlibs-custom/nebulous-liberations/`.

| Folder | Resources |
|---|---|
| `backgrounds/` | Liberation background images and animations |
| `bots/npcs/` | Overworld enemy sprites and animations (including `mettaur_ow`) |
| `bots/attacks/` | Snowball, Beast Breath, directional Shockwave, hit/attack textures |
| `bots/effects/` | Blur, explosion, paralyze, recover and hit effects |
| `bots/` | Item sprites |
| `mugs/` | NPC mug textures and animations |
| `tiles/` | Liberation Collision, attack indicator, selected tile TSX + PNG |
| `ui/` | Liberation option menu sprites and animations |
| `sound effects/` | Existing effect sounds |

## Engine paths and Tiled maps

* Server asset URI: `/server/assets/ezlibs-custom/nebulous-liberations/<folder>/<asset>`.
* TMX tileset URI: `../assets/ezlibs-custom/nebulous-liberations/tiles/<tileset>.tsx`.
* `tileset_embedder.lua` publishes the shared tileset TSX/PNG files **before** modifying maps, using their new `tiles/` directory.
* Directional Mettaur Shockwave now uses `bots/attacks/shockwave.png` and `.animation` (its directional animation states were checked against the old asset).
* The supplied archive does **not** contain `shockwaves_all_directions.*` or `mugshot_and_health_bar_point33scale.png`; do not depend on those old flat assets.

## HP Manager repair notes

The provided log showed repeated `HP_Manager` object interaction events and two module registration notices, plus unconsumed `textbox_response` events. The `ezlibs-scripts/main.lua` extra HP Manager import has been removed because this server already loads the module through its standalone script bootstrap; the main module also guards duplicate registration in one Lua environment.

The Background Manager keeps its selected background name visible while editing settings. Background and Real Time editors reject duplicate opens, use session identity checks around asynchronous save responses, and close their control sessions even when save/revert operations fail. The desktop also has an explicit child-abort recovery path if the editor fails midway through opening.

**Runtime verification needed:** Interact with the HP Manager object once, open Background Manager, edit settings and cancel/save, then open Real Time Manager and repeat. Confirm that only one save prompt appears and that the desktop can be reopened after an error. The unrelated missing `scripts/ezlibs-custom/pets` module reported by the log is not included in this asset patch.

The Real Time editor timezone adjustment was also constrained to −840 through +840 minutes, matching `scripts/real_daytime/main.lua` and persistent-data validation.
