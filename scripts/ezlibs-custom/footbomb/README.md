# FootBomb animation parser versioning

## Animation format versions

- **v2.0 (active FootBomb format):** `.animation` files using `animation state="STATE"` and `frame duration="0.0833333"`. FootBomb continues to select these paths from `navi_options.lua`.
- **v2.5 (alternate format):** `.ani` files using `!frame_rate 60`, `!image_path "..."`, `anim STATE`, and frame durations such as `dur=5f`. The parser converts frame counts to seconds using the declared frame rate.
- `boom.load(path)` detects the format from the file contents and returns `animation.version` and `animation.format_version` as `"2.0"` or `"2.5"`. Unknown/non-v2.0 syntax is handled as v2.5 and returns a diagnostic error if it cannot be parsed.

The public API remains compatible: `get_state`, `get_frame`, `get_point`, `duration`/`get_duration`, `refresh`, and `update`. Animation points are optional and are retained when present.

## Startup diagnostics

FootBomb's `animation_diagnostics.lua` checks each active `.animation` file and its matching `.ani` counterpart (when configured by the same basename). Logs begin with `ANIM_DIAGNOSTICS:` and include detected version, image path, states, frame counts, total state durations, each frame's rectangle/origin/flip flags and duration, any labeled points, and whether the configured initial state exists. This is read-only diagnostics and does not change live bot animations. Missing or malformed assets are logged without intentionally stopping FootBomb startup.

## Install

Copy the package paths into the server project, preserving directory structure:

- `scripts/boom/main.lua`
- `scripts/ezlibs-custom/footbomb/*.lua`
- `scripts/ezlibs-custom/footbomb/README.md`

Keep the Navi assets in the server project at `assets/net-game-footbomb/bots/` (the game APIs may identify these assets as `/server/assets/net-game-footbomb/bots/`). The `.ani` companions are inspected for compatibility but are not switched into gameplay automatically.
