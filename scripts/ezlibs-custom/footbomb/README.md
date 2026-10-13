# FootBomb round-start animation update

Updated `main.lua` to apply role-specific round positioning and animations:

- Round bots are moved to the named `Kicker` or `Defender 2` point.
- Both bots are initially set to `IDLE_UR` when positioned.
- A human assigned the `Defender` role has their camera faded in, then an independent one-second async delay runs before their bot switches to `FOOTBOMB_READY_DEFENSE`.
- The delay is asynchronous and does not block the other participant or match flow.
- Ref NPC mugshot defaults use `/server/assets/net-game-footbomb/bots/` and `ref-prog-mug`, matching the supplied updated version.

The animation change uses `Net.set_bot_animation_state` when available, falling back to `Net.set_bot_animation`. Please confirm which setter your server runtime exposes and test in-game; this package has not been tested on a live server.
