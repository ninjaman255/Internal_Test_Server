# FootBomb scripts — configuration refactor

`main.lua` now imports the shared configuration and roster modules instead of duplicating their values:

- `constants.lua`: source area, asset folders/default Ref assets, cursor assets, off-map position, selector layout, prompt styling, bomb-selector coordinates, direction choices, scoreboard asset/layout, and input-settle delay.
- `navi_options.lua`: selectable Navi names, texture/animation paths, and default animation state.
- `bomb_options.lua`: selectable bomb/ball skins.
- `animation_states.lua`: shared animation-state names, including the bomb preview and small-bomb states.

The main script also rejects a missing direction rather than silently treating it as `Up`; the prompt displays `none` until the player makes a selection. Existing direction-selection input clearing and release gating are preserved.

The script bundle has not been tested on a live OpenNetBattle server. Please test it in-game after replacing the existing FootBomb script files.


## Round scoring and scoreboard

After both participants confirm their directions, the round is resolved once:

- Matching Kicker and Defender directions award the point to the Defender.
- Different directions award the point to the Kicker.
- The point is credited to the winner's player slot (Player 1 or Player 2), not their role.

During each round’s direction choice, both Kicker and Defender see three evenly spaced cursors slightly above screen center. All use the `CURSOR_UP` animation at scale 2.0; the currently selected direction bobs vertically.

The scoreboard is drawn near the top center for each human participant. Player 1's score is drawn to the left of the board image and Player 2's score to the right. The board image is expected at `/server/assets/net-game-footbomb/ui/score-board.png`, with a corresponding `score-board.animation` file for `games.add_ui_element`.


## Result animation phase

The result phase begins only after both participants have confirmed their directions. The point is held until the animation completes:

1. The Kicker uses `WALK_UR` while moving to the Tiled point object named `Move Forward`.
2. The Kicker switches to `WALK_U` and moves to the Bomb point/bomb bot.
3. The bomb bot moves to `Bomb 1`, `Bomb 2`, or `Bomb 3` according to the Kicker's selected direction (`Left`, `Up`, or `Right`). Defender movement points remain `Defender 1`, `Defender 2`, and `Defender 3`.
4. Once the bomb reaches its target, the precomputed round winner receives a point and the scoreboard updates.

The map must include point objects named exactly `Move Forward`, `Defender 1`, `Defender 2`, `Defender 3`, `Bomb 1`, `Bomb 2`, and `Bomb 3`, in addition to the existing required points (including `Bomb`, the bomb spawn point). Movement speeds and update interval are configured in `constants.lua` as `RESULT_KICKER_WALK_UR_SPEED`, `RESULT_KICKER_WALK_U_SPEED`, `RESULT_BOMB_MOVE_SPEED`, and `RESULT_MOVE_STEP_SECONDS`.

Movement uses repeated `Net.move_bot` calls to interpolate between points. The bundle has not been tested on a live server; confirm the movement timing and animation names in-game.


### Interpolated result movement

The result phase uses `Net.animate_bot_properties()` keyframes to interpolate bot X/Y/Z over a duration derived from distance and the configured movement speed. It does not fall back to repeated `Net.move_bot()` calls, so missing animation-property support fails safely rather than teleporting bots. The Kicker movement keyframes preserve `WALK_UR` and `WALK_U`; the bomb keeps its current animation while moving toward the selected Defender point.

## Synchronized Defender response

- Defender jump speed is configured with `RESULT_DEFENDER_JUMP_SPEED` in `constants.lua` (default `60`). For Left/Right, the bomb and Defender use the same movement duration so they arrive together. The Defender uses `FOOTBOMB_JUMP_LEFT` or `FOOTBOMB_JUMP_RIGHT`; Up stays at `Defender 2` with `FOOTBOMB_READY_DEFENSE`.


### Defender arrival animation override

After synchronized bomb/Defender movement completes, FootBomb explicitly reapplies the Defender's intended animation through the `Net.animate_bot()` wrapper (`set_result_animation`). This is necessary because the `Animation` property in `Net.animate_bot_properties()` keyframes may revert to an idle state after interpolation ends. Left/Right reapply the matching jump animation; Up reapplies `FOOTBOMB_READY_DEFENSE`.


## Configurable match length and match point

The Ref-Prog NPC supports the custom property `Points to Win`. It defaults to `10` when the property is missing or invalid; set it to a positive whole number to change the target for matches launched from that NPC.

After the target is reached, the player behind gets one round to tie or take the lead. If they tie, the match continues. If they take the lead, the former leader gets the same one-round chance. The match ends when the player given that chance finishes the round still behind. After each result, the game holds the scene for 1.5 seconds before transitioning. A Kicker goal triggers the ezexplosions burst and fades the camera to white; a Defender point uses the normal black camera fade. The final score remains on the scoreboard for about three seconds, then the players are transferred back to the non-instanced area where they spoke to Ref-Prog and the match instance is cleaned up.
