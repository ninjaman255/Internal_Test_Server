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


## Defender jump catches using v2.0 `Ball` points

FootBomb assumes the Navi animation assets used for gameplay are in the v2.0 `.animation` format. The `scripts/boom/main.lua` parser is used to read each selected Navi's jump animation frames and their named `Ball` points.

When the Kicker and Defender choose the same **Left** or **Right** direction, the ball travels to the Defender's `Ball` point at the midpoint of the Defender's movement. It then follows the point's frame-relative X/Y offset while the Defender finishes the jump and remains attached through the result hold until the camera fade begins. The point offset is calculated from the parsed frame bounds (`w`/`h`) and that frame's `originx`/`originy`. The resulting sprite-pixel offset is **not** added directly to `Net` bot X/Y: bot positions are in isometric map coordinates, not sprite pixels. FootBomb converts the screen-pixel offset through the inverse isometric projection using `Net.get_tile_width()` and `Net.get_tile_height()` for the bot's area (with the documented 64x32 defaults as fallback). Horizontal/vertical flips mirror both the point and pivot within the frame bounds. This avoids treating a 12x24-pixel sprite offset as a 12x24-map-unit movement that would send the ball off the field.

If a matching jump state cannot be parsed or has no `Ball` point, FootBomb logs `BALL_CATCH` and preserves the normal bomb path instead of claiming a catch. Non-matching directions and the stationary **Up** defense keep the existing result movement.

The code can be syntax-checked and its parser can be tested against supplied v2.0 assets, but live position updates and visual alignment still need to be confirmed in the OpenNetBattle runtime.


### Center catches, ball animation, and draw order

When both players choose **Up** (the center direction) and the Defender wins, the ball first reaches the center target, then attaches to the Defender's `Ball` point in `FOOTBOMB_READY_DEFENSE`. The follower samples looping animation states using their loop duration and remains active until the result camera fade begins.

The ball bot stores `AnimationStates.SMALL_BOMB` as its persistent animation state. Smooth movement keyframes retain that state, and attachment position updates use `Net.animate_bot_properties` for X/Y/Z only, avoiding repeated `Net.move_bot` calls that may cause some clients to fall back to an empty/default animation. If the property API is unavailable, the position helper falls back to `Net.move_bot`.

While attached, the ball's Z coordinate is `defender Z + Gameplay.RESULT_BALL_Z_LIFT` (default `0.1`) so it is only slightly above the Defender. The initial catch travel stays on the defender's current Z layer; Z is excluded from horizontal travel-distance calculations. During the remaining defender jump, the follower uses the same eased start-to-target path used by the defender's movement keyframes, avoiding a handoff snap if `Net.get_bot_position` still reports a stale position. After that movement duration, the follower switches to the live defender position. Follow samples are logged periodically for diagnosing any remaining coordinate mismatch.
