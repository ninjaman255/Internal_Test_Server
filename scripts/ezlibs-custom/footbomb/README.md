# FootBomb animation parser versioning

## Animation format versions

- **v2.0 (active FootBomb format):** `.animation` files using `animation state="STATE"` and `frame duration="0.0833333"`. FootBomb continues to select these paths from `navi_options.lua`.
- **v2.5 (alternate format):** `.ani` files using `!frame_rate 60`, `!image_path "..."`, `anim STATE`, and frame durations such as `dur=5f`. The parser converts frame counts to seconds using the declared frame rate.
- `boom.load(path)` detects the format from the file contents and returns `animation.version` and `animation.format_version` as `"2.0"` or `"2.5"`. Unknown/non-v2.0 syntax is handled as v2.5 and returns a diagnostic error if it cannot be parsed.

The public API remains compatible: `get_state`, `get_frame`, `get_point`, `duration`/`get_duration`, `refresh`, and `update`. Animation points are optional and are retained when present.

## Optional diagnostics

Verbose diagnostics are disabled during normal gameplay to avoid dumping every frame and point to the server log on every module load. To enable them temporarily, set `RUN_ANIMATION_DIAGNOSTICS = true` in `constants.lua`. The `animation_diagnostics.lua` module checks each active `.animation` file and its matching `.ani` counterpart and logs detected format/version, image path, states, frame counts, frame rectangles/origins/flips/durations, labeled points, and whether the configured initial state exists. This is read-only and does not change live bot animations. Failures are logged and do not intentionally stop FootBomb startup.

Set `RUN_DIRECTION_MAPPING_TEST = true` in the same `DIAGNOSTICS` section to print the nine Left/Up/Right kicker/defender mapping predictions at module load. This test logs predictions only; it does not simulate a live round. Both flags default to `false`.

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

The ball bot stores its selected looping animation state (`Small-Bomb` by default; `Big-Bomb` if configured) on the bomb-bot record. Its movement keyframes and attached-ball track contain position properties only; animation state is set separately so a position track cannot overwrite the intended looping animation. The attached-ball track is built once using the parsed `Ball` point's animation-frame boundaries, with short positive-duration position keyframes rather than a polling loop. Immediately before the result camera fade, FootBomb reasserts the bomb's stored looping animation so it remains selected through the transition.

While attached, the ball's Z coordinate is `defender Z + Gameplay.RESULT_BALL_Z_LIFT` (default `4`). The initial catch travel stays on the defender's current Z layer; Z is excluded from horizontal travel-distance calculations. During the remaining defender jump, the ball track uses the same quadratic start-to-target path used by the defender's jump movement, avoiding a handoff snap if `Net.get_bot_position` still reports a stale position. The full position track is submitted to `Net.animate_bot_properties`; it does not switch to a live-position polling loop at the end of the jump.


### Instance-area bot asset preflight

When a FootBomb instance is created, `main.lua` now validates every selectable Navi and bomb animation with `Boom.load` before creating any bots. It verifies the states used by gameplay (including `Small-Bomb`, `Big-Bomb`, and `Preview`), checks that each referenced texture/animation file exists on the server, then calls `Net.provide_asset(instance_area_id, path)` for the instance area's Navi textures, animations, mug textures, shared mug animation, and all bomb textures/animations. If an asset is missing, malformed, or cannot be provided, instance setup fails before bots or players are exposed to a partially provisioned match. Player-specific provisioning remains in place for UI assets.

Result movement uses a short positive-duration start frame followed by timed position-only frames. The start-frame duration is deducted from the first movement segment so it does not extend the planned total duration. Animation state is applied separately through `Net.animate_bot`, avoiding competing animation writes from the movement property track. The attached-ball track also uses position-only keyframes and refuses to proceed if `Net.animate_bot_properties` is unavailable. `Boom` parses and validates animation-file states and named points; it is not itself the network keyframe scheduler.


### Avoiding client-side animation reloads

Navi avatars are assigned when the bot is created. During gameplay, defense, jump, idle, and walk phases should only change the animation state (and direction when needed); they should not call `Net.set_bot_avatar` again. Reassigning the same texture/animation path on every state transition can trigger client-side asset reload/loading indicators and may briefly interrupt rendering. The bomb avatar is assigned when each round's bomb bot is spawned; subsequent movement/result phases only select its animation state.


## Pass 1 maintenance notes

- Verbose animation-file diagnostics and the direction-mapping log test are opt-in through `constants.lua` and default to disabled.
- Removed two unreferenced local movement helpers from `main.lua` and removed the unused `RESULT_MOVE_STEP_SECONDS` setting. These changes do not alter live movement paths.
- The configuration's `RESULT_BALL_Z_LIFT = 4` is the active default; update this documentation alongside the value if it is intentionally tuned later.
