# FootBomb module refactor

Deploy this folder as `scripts/ezlibs-custom/footbomb/`. The existing loader should continue requiring `scripts/ezlibs-custom/footbomb/main`.

## Modules

- `main.lua` — NPC registration/interaction, match creation, transfer and cleanup, selection UI, player representation, input and camera update.
- `constants.lua` — shared asset paths, UI text, coordinates, scales, and defaults.
- `animation_states.lua` — canonical animation state names: `IDLE_D`, `FOOTBOMB_IDLE_DEFENSE`, `FOOTBOMB_READY_DEFENSE`, `FOOTBOMB_JUMP_RIGHT`, and `Preview`.
- `navi_options.lua` — seven Navi entries and their sprite/animation paths and initial animation state.
- `bomb_options.lua` — ball skin options used by the preview selector.

## Navi roster

MegaMan, Roll, Normal Navi, ProtoMan, Glyde, GutsMan, and Prog are listed in the asset pack. All entries currently start at `FOOTBOMB_IDLE_DEFENSE`; gameplay-specific states are available from `animation_states.lua` for later transitions.

## Notes

The original match logic is retained as much as possible. The refactor separates static configuration and selection rosters from behavior. The ball skin selector remains UI-only, and the gameplay loop/scoring flow is not implemented in the supplied source. Test the deployed scripts in the server runtime before production use.
