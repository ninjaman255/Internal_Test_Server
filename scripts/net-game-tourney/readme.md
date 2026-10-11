# 🏆 Net-Game Tournament System — Complete Documentation

> **Documentation scope**
>
> This document describes `scripts/net-game-tourney/` as it exists in the supplied `internal_test_server.zip`. Names, fields, runtime calls, and configuration aliases below are taken from the Lua source. Lua 5.2 is the language baseline; `Net`, `Async`, `Displayer`, and `games` are project/runtime APIs, not standard Lua libraries. This is a source review, not a claim that every runtime path has been tested on a live server.

## 🗂️ Table of Contents

- [1. Overview and directory layout](#1-overview-and-directory-layout)
- [2. Startup and event wiring — `main.lua`](#2-startup-and-event-wiring--mainlua)
- [3. Module responsibilities and dependency flow](#3-module-responsibilities-and-dependency-flow)
- [4. Tournament state model — `tournament-state.lua`](#4-tournament-state-model--tournament-statelua)
- [5. Core rules — `tournament-core.lua`](#5-core-rules--tournament-corelua)
- [6. Manager, boards, queues, and scheduling — `tournament-manager.lua`](#6-manager-boards-queues-and-scheduling--tournament-managerlua)
- [7. Battle flow — `tournament-flow.lua`](#7-battle-flow--tournament-flowlua)
- [8. Tournament UI — `tournament-ui.lua`](#8-tournament-ui--tournament-uilua)
- [9. NPC pool — `tournament-npcs.lua`](#9-npc-pool--tournament-npcslua)
- [10. Constants and asset paths — `tournament-constants.lua`](#10-constants-and-asset-paths--tournament-constantslua)
- [11. UI coordinates — `ui-pos.lua`](#11-ui-coordinates--ui-poslua)
- [12. Tiled Tournament Board properties](#12-tiled-tournament-board-properties)
- [13. `Net`, `Async`, `games`, and `Displayer` calls](#13-net-async-games-and-displayer-calls)
- [14. Lifecycle, cleanup, and defensive behavior](#14-lifecycle-cleanup-and-defensive-behavior)
- [15. End-to-end flow](#15-end-to-end-flow)
- [16. Observed limitations and maintenance notes](#16-observed-limitations-and-maintenance-notes)
- [17. Cross-reference](#17-cross-reference)

---

<a id="1-overview-and-directory-layout"></a>
## 1. Overview and directory layout

The tournament system is a server-side Lua feature that discovers Tiled objects named/classified as `Tournament Board`, maintains queues for those boards, creates eight-participant brackets, coordinates player-versus-player or player-versus-NPC battles, tracks results, and draws a bracket UI through the project's net-game and displayer systems.

### 1.1 Files

```text
scripts/net-game-tourney/
  main.lua                  -- startup, Net event listeners, periodic cleanup
  tournament-constants.lua  -- asset paths, UI defaults, colors, audio paths
  tournament-core.lua       -- tournament rule facade and bracket initialization
  tournament-flow.lua       -- board viewers, battle execution, round progression
  tournament-manager.lua    -- board discovery, queue/registration/scheduling, rewards
  tournament-npcs.lua       -- NPC roster and per-tournament selection
  tournament-state.lua      -- central in-memory tournament state and results
  tournament-ui.lua         -- bracket sprites, mugshots, progress bars, audio/fades
  ui-pos.lua                -- fixed board coordinates and position lookup helpers
```

### 1.2 Runtime dependencies visible in source

| Dependency | Observed role |
|---|---|
| `scripts/net-games/main` | Required by `main.lua`; initializes the net-games/displayer/input stack. Also imported as `games` by tournament UI/flow. |
| `scripts/displayer/displayer` | Used by `tournament-ui.lua` to create text display objects via `Displayer.Text`. |
| `Net` | Player state, areas/objects, assets, player messaging, input lock, camera fade, HUD/song/sound, and event callbacks. |
| `Async` | Promise/coroutine support, sleeping, quiz/message prompts, encounters, PvP initiation, and awaiting. |
| Lua standard libraries | `math`, `os`, `string`, `table`, `coroutine`, and `tonumber`/`tostring`/`pairs`/`ipairs`/`pcall`/`type` are used in ordinary Lua code. |

`Async` and the local `async`/`await` wrappers are not interchangeable names. The flow and UI modules define local wrappers using `Async.promisify(coroutine.create(fn))` and `Async.await(value)`; calls such as `Async.sleep(...)` remain direct runtime calls.

### 1.3 Main architecture

```text
Net events (main.lua)
        |
        v
TournamentManager  <---- board queues, schedule, registration, rewards
        |     \
        |      +---- TournamentNPCs (NPC roster)
        v
TournamentCore -------- TournamentState (authoritative in-memory data)
        |
        v
TournamentFlow -------- TournamentUI
        |                    |
        +-- Async/Net        +-- games UI elements, Displayer.Text, assets
```

This is a module boundary diagram, not a promise that every call travels only along these arrows. The actual modules call each other directly where needed.

---

<a id="2-startup-and-event-wiring--mainlua"></a>
## 2. Startup and event wiring — `main.lua`

### 2.1 Startup sequence

1. Prints `[Tournament System] Initializing...`.
2. Requires `scripts/net-games/main` before loading tournament manager/UI modules.
3. Requires `tournament-manager` and `tournament-ui`.
4. Calls `TournamentManager.init()`.
5. Prints `[Tournament System] Loaded and ready!`.
6. Registers the tournament's `Net:on(...)` event listeners.

### 2.2 Registered server events

| Event | Validation and behavior |
|---|---|
| `player_join` | Requires `event` and `event.player_id`; calls `TournamentUI.prewarm_player(player_id)`. |
| `object_interaction` | Requires `event.player_id` and `event.object_id`; if `event.button` is present it must equal `0`. Looks up the player's current area and the object by ID. Handles it only when `object.type == "Tournament Board"` or `object.class == "Tournament Board"`. |
| `battle_results` | Requires `event.player_id`; forwards `(event.player_id, event)` to `TournamentManager.handle_battle_result`. |
| `player_area_transfer` | Requires `event.player_id`; forwards to `TournamentManager.handle_player_area_transfer`. |
| `player_disconnect` | Requires `event.player_id`; invalidates UI visual jobs first, then calls `TournamentManager.handle_player_disconnect`. The comment explicitly avoids native sprite cleanup after the player object is gone. |
| `tick` | Reads `event.delta_time`, converts it with `tonumber`, and increments two local timers. Calls orphan cleanup every accumulated 30 seconds and expired-queue cleanup every accumulated 60 seconds, resetting each timer to zero. |

The callbacks use the single `event` parameter. The source does not establish that every possible field is always present, so the event handlers guard the fields they require.

### 2.3 Object interaction details

The board interaction listener obtains the area using `Net.get_player_area(player_id)`, then calls `Net.get_object_by_id(area_id, event.object_id)`. It does not blindly treat every object interaction as a tournament board interaction; the type/class check is explicit.

---

<a id="3-module-responsibilities-and-dependency-flow"></a>
## 3. Module responsibilities and dependency flow

| Module | Responsibility | Important public functions |
|---|---|---|
| `main.lua` | Startup and server event integration | Event callbacks only; no returned module table |
| `tournament-constants.lua` | Shared paths and UI configuration | Returns a constants table |
| `tournament-core.lua` | Bracket initialization and rule-facing facade | `create_tournament`, `add_participant`, `initialize_tournament`, `record_battle`, `advance_round`, `get_winner`, cleanup/query functions |
| `tournament-flow.lua` | Live display coordination and battles | `show_board_to_all`, `hide_board_from_all`, `run_round_battles`, `start_player_battle`, `run_tournament`, champion announcement, disconnect handling |
| `tournament-manager.lua` | Board queues, properties, join/leave/spectate, scheduled starts and rewards | `init`, `handle_board_interaction`, disconnect/transfer/battle handlers, queue queries and cleanup |
| `tournament-npcs.lua` | Weighted metadata roster and unique selection tracking | `get_unique_random_npc(s)`, `get_random_npc(s)`, `cleanup_tournament_npcs` |
| `tournament-state.lua` | Central state storage, participant mapping, match results and positions | `create_tournament`, `add_participant`, `record_battle`, round and spectator functions |
| `tournament-ui.lua` | Per-player UI rendering and visual lifecycle | `show_board`, `cleanup`, `tint_loser`, mugshot movement/squash, progress bars, music/fades, `prewarm_player` |
| `ui-pos.lua` | Coordinate tables and index helpers | `get_mugshot_positions`, `get_progress_bar_positions`, `get_progress_bar_index` |

The modules are required by explicit paths such as `scripts/net-game-tourney/tournament-state`; keep those paths in sync if files are moved.

---

<a id="4-tournament-state-model--tournament-statelua"></a>
## 4. Tournament state model — `tournament-state.lua`

`State` is described in its source as the central state store and says all tournament-state mutation should go through it. It stores data in module-local tables; the implementation shown is in-memory Lua state, not a database persistence layer.

### 4.1 Internal indexes

| Local table | Key | Value/purpose |
|---|---|---|
| `tournaments` | tournament ID | Tournament record |
| `player_tournaments` | player ID | Tournament ID for a registered player participant |
| `npc_results` | composite string key | Cached NPC-versus-NPC battle result |
| `next_tournament_id` | — | Monotonically incremented numeric ID, starting at `1` |

### 4.2 Tournament record

`State.create_tournament(config)` normalizes `config.best_of` to an integer of at least `1`, allocates an ID, and creates a record with these fields:

| Field | Initial value / meaning |
|---|---|
| `id` | Allocated numeric ID |
| `config` | Supplied configuration table (the `best_of` field is normalized on it) |
| `participants` | Empty array, later limited to eight entries |
| `spectators` | Empty table keyed by player ID |
| `matches` | `{ round1 = {}, round2 = {}, round3 = {} }` |
| `status` | `"created"` |
| `current_round` | `0` |
| `host_id` | `config.host_id` |
| `winners` | Empty table |
| `champion` | `nil` |
| `ui_state` | `{ positions = {}, round = 0 }` |
| `revealed_rounds` | Empty table |
| `active_spectator_matches` | Empty table |
| `created_time` | `os.time()` |

### 4.3 Participant record

`State.add_participant(tournament_id, participant_data)` stores a normalized record:

```lua
{
    id = participant_data.id,
    type = participant_data.type,
    name = participant_data.name or tostring(participant_data.id),
    mugshot = participant_data.mugshot,
    weight = tonumber(participant_data.weight) or 50,
    original_index = #tournament.participants + 1,
    eliminated = participant_data.eliminated == true,
    eliminated_round = participant_data.eliminated_round,
    disconnected = participant_data.disconnected == true,
    wants_updates = participant_data.wants_updates ~= false,
    spectating = participant_data.spectating == true,
}
```

Preconditions enforced by the function:

- Tournament must exist.
- Participant count must be below eight.
- `participant_data` and `participant_data.id` must exist.
- A participant ID cannot already appear in that tournament.
- A participant with `type == "player"` cannot already be associated with a tournament in `player_tournaments`.

Returns `true` on success or `false, reason` for rejected additions. The reasons present in source include `"Tournament not found"`, `"Tournament is full"`, `"Invalid participant"`, `"Participant already in tournament"`, and `"Player already in a tournament"`.

### 4.4 Participant removal and lookup

| Function | Behavior |
|---|---|
| `State.get_tournament(id)` | Returns the record or `nil`. |
| `State.get_all_tournaments()` | Returns the internal `tournaments` table itself. Callers can therefore see the live table; this is not a defensive copy. |
| `State.delete_tournament(id)` | Clears player mappings for player participants, removes cached NPC result keys with that tournament's prefix, calls `tournament_npcs.cleanup_tournament_npcs(id)`, then removes the record. No-op if absent. |
| `State.remove_player_from_tournament(player_id)` | Uses the player index, removes the matching player participant from the participant array, and clears the index. Returns a boolean. |
| `State.get_player_tournament(player_id)` | Returns the mapped tournament ID or `nil`. |
| `State.is_player_in_tournament(player_id)` | Tests whether the mapping is non-`nil`. |

### 4.5 Battle and match state

Matches are indexed through `tournament.matches.round1`, `round2`, and `round3`. `record_battle` chooses the matching round table, rejects missing tournaments/matches and already-completed matches, and finds winner/loser participant objects by ID before recording a battle. NPC result cache keys are scoped with tournament, round, match index, and battle index; the code's cache is therefore not just keyed by an NPC's reusable ID.

The module also implements:

- `record_battle_result(...)` — legacy single-battle entry point.
- `get_npc_battle_result(...)` — retrieve/create the cached NPC matchup result through the state logic.
- `is_round_complete(...)` and `advance_round(...)` — round completion/progression.
- `get_winner(...)` — retrieve the tournament winner/champion when available.
- `add_spectator(...)` / `remove_spectator(...)` — maintain spectator records.
- `initialize_positions(...)`, `calculate_round_positions(...)`, and `update_positions(...)` — calculate and store bracket participant positions.
- `cleanup_orphaned_tournaments(max_age_seconds)` — remove old/orphaned tournament state according to the code's age/status checks.

The precise win-count and advancement conditions are implemented in the source; callers should use these state/core APIs instead of duplicating match mutations in a separate module.

### 4.6 Important lifecycle distinction

Removing a player from `player_tournaments` does not by itself prove that every queue, spectator record, active battle, or visual job has been cleared. Manager, flow, and UI cleanup each handle their own part of the lifecycle.

---

<a id="5-core-rules--tournament-corelua"></a>
## 5. Core rules — `tournament-core.lua`

`TournamentCore` is a facade over `tournament-state.lua` plus bracket initialization and configuration normalization.

### 5.1 Configuration normalization

`create_tournament(config)` normalizes these fields before passing the table to state:

| Field | Normalization |
|---|---|
| `pvp_mode` | Defaults to `"auto"` when false/nil |
| `battle_timeout_seconds` | `tonumber(...)` or `10 * 60` seconds |
| `npc_only` | True only when the input is exactly `true` |
| `winner_money_reward` | Non-negative floored number; defaults to `0` |
| `winner_gp_reward` | Non-negative floored number; defaults to `0` |
| `deduct_opposing_team_gp` | True only when exactly `true` |
| `best_of` | Floored integer of at least `1`; defaults to `1` |

Other configuration keys are retained in the supplied table.

### 5.2 Bracket initialization

`initialize_tournament(tournament_id)`:

1. Fetches the tournament; logs and returns `false` if missing.
2. Requires exactly eight participants; otherwise logs the actual count and returns `false`.
3. Shuffles the participant array using `math.random` and records each participant's `original_index` after the shuffle.
4. Creates four `round1` matches, pairing adjacent participants.
5. Initializes each match with `player1`, `player2`, `winner = nil`, `loser = nil`, `completed = false`, `best_of`, `battles = {}`, and `wins = { p1 = 0, p2 = 0 }`.
6. Sets `current_round = 0`, `status = "created"`, initializes positions, and returns `true`.

Although match fields are named `player1` and `player2`, participants can be NPCs as well as players; these names are matchup slots, not proof that both entries are human players.

### 5.3 Public API

| Function | Purpose |
|---|---|
| `create_tournament(config)` | Normalize config and create state record; returns the state module's results (ID and tournament record). |
| `add_participant(tournament_id, participant)` | Delegate participant insertion to state. |
| `initialize_tournament(tournament_id)` | Build the initial four-match bracket; requires eight participants. |
| `initialize_positions(tournament_id)` | Delegate position initialization. |
| `calculate_round_positions(tournament_id, round)` | Calculate positions for a round. |
| `update_positions(tournament_id, round)` | Update position state. |
| `record_battle(tournament_id, round, match_index, winner_id, loser_id, battle_index)` | Record one battle in a best-of series. |
| `record_battle_result(tournament_id, round, match_index, winner_id, loser_id)` | Legacy single-battle API. |
| `get_npc_battle_result(tournament_id, round, match_index, npc1_id, npc2_id, battle_index)` | Get cached NPC battle outcome. |
| `is_round_complete(tournament_id, round)` | Query round completion. |
| `advance_round(tournament_id)` | Delegate round advancement. |
| `complete_round(tournament_id)` | Sets status to `"round_complete"` when the tournament exists; returns boolean. |
| `get_winner(tournament_id)` | Retrieve winner. |
| `add_spectator(tournament_id, player_id, name)` / `remove_spectator(...)` | Delegate spectator changes. |
| `for_each_human_viewer(tournament_id, callback)` | Calls callback `(player_id, record)` for player participants and spectators whose `wants_updates` is not `false`, avoiding duplicate viewer IDs. |
| `cleanup_tournament(tournament_id)` | Delete state. |
| `handle_player_disconnect(player_id)` | Marks a registered participant disconnected when found, removes the player from spectator tables, and clears the player-to-tournament mapping via state removal. |
| `cleanup_orphaned_tournaments()` | Delegate orphan cleanup. |
| `get_tournament(id)`, `get_player_tournament(player_id)`, `is_player_in_tournament(player_id)` | State queries. |

`for_each_human_viewer` checks `p.type == "player"` for participants. It also visits spectator records and uses a `seen` table so a player already seen as a participant is not called twice.

---

<a id="6-manager-boards-queues-and-scheduling--tournament-managerlua"></a>
## 6. Manager, boards, queues, and scheduling — `tournament-manager.lua`

The manager owns the board-facing experience: it scans maps for board objects, maintains per-board queues, interprets custom properties, accepts registrations, handles spectators, schedules starts, and grants rewards.

### 6.1 Queue identity

A queue key is generated from `(area_id, object_id)` by the local `board_key` helper. The queue record created for a board contains:

```lua
{
    key = key,
    board_id = tostring(object_id),
    area_id = area_id,
    players = {},
    waiting_spectators = {},
    host_id = nil,
    status = "waiting",
    active_tournament_id = nil,
    created_time = os.time(),
    board_type = nil,
}
```

The board's area and object ID therefore distinguish queues. `get_or_create_queue` refreshes its settings from the object's `custom_properties` whenever called.

### 6.2 Board properties read by the manager

The implementation supports aliases so existing maps can use alternate property names. Property lookup is shown below as the preferred names followed by the aliases visible in source.

| Purpose | Property names accepted by code | Default/fallback |
|---|---|---|
| Queue/tournament name | `Tournament Name`, `Name` | Existing queue name, then `WCity Tournament` |
| Background theme | `Board Background`, `Tournament Background`, `board_theme` | Existing theme, then `red_orange_bn4` |
| Board title | `Board Title`, `board_title` | Existing title; may remain `nil` |
| Title banner | `Tournament Title`, `Tournament Title Banner`, `Title Banner` | Existing key; UI has its own default |
| NPC pool key | `Tournament NPC Pool`, `NPC Pool` | Existing key, then `default` |
| PvP mode | `Tournament PVP Mode`, `PVP Mode` | Existing mode, then `auto` |
| Force PvP HP | `Tournament Force PVP HP`, `Force PVP HP` | Boolean conversion with existing setting fallback |
| Schedule period in hours | `Tournament Every Hours`, `Every Hours`, `Schedule Every Hours` | Existing value, then configured default |
| Schedule hour offset | `Tournament Hour Offset`, `Schedule Hour Offset`, `Hour Offset` | Existing value, then configured default |
| Schedule start minute | `Tournament Start Minute`, `Start Minute` | Existing value, then configured default |
| Schedule start second | `Tournament Start Second`, `Start Second` | Existing value, then configured default |
| Registration lead time | `Registration Lead Seconds`, `Tournament Registration Seconds`, `Registration Seconds` | Existing value, then configured default |
| Battle timeout | `Tournament Battle Timeout Seconds`, `Battle Timeout Seconds`, `Match Timeout Seconds` | Existing value, then configured default |
| Winner money | `Tournament Money Reward`, `Money Reward`, `Winner Money` | Existing value or `0`; floored and clamped to non-negative |
| Winner GP | `Tournament GP Reward`, `GP Reward`, `Winner GP` | Existing value or `0`; floored and clamped to non-negative |
| GP stakes | `Tournament GP Stakes`, `Deduct Opposing Team GP`, `GP Stakes` | Boolean conversion with existing value or `false` |
| Best-of length | `Tournament Best Of`, `Best Of`, `Match Best Of` | Existing value or `1`; floored and clamped to at least `1` |
| Board behavior type | `Board Type`, `board_type`, `Type` | Lowercased string; `nil` if absent |

Numeric settings are converted with `tonumber`. Boolean settings go through the local `to_bool_or` helper; consult that helper for the exact accepted string/number forms before relying on a Tiled value representation.

### 6.3 Board behavior types

The source includes scheduled-based and auto-start checks. The observed behavior in `should_auto_start_on_full` is:

- `hosted` explicitly does **not** auto-start when full.
- `full_wait` and `mixed_timer` auto-start when full.
- `scheduled` uses the global `SETTINGS.auto_start_when_full` fallback.
- Missing board type uses `SETTINGS.auto_start_when_full`.

The scheduled path calculates a period and candidate start times using `schedule_every_hours`, `schedule_hour_offset`, start minute/second, and registration lead time. The manager also has a registration-open predicate and a scheduler loop. Exact timing should be confirmed against the implementation before configuring a live map, particularly when using custom offsets.

### 6.4 Manager public functions

| Function | Purpose |
|---|---|
| `TournamentManager.handle_board_interaction(player_id, board_object, area_id)` | Main board interaction entry point; routes the player through the queue/tournament interaction logic. |
| `handle_player_disconnect(player_id)` | Removes/updates the player's queue and tournament participation/spectating state. |
| `handle_player_area_transfer(player_id)` | Updates queue/tournament presence when the player changes areas. |
| `cleanup_orphaned_tournaments()` | Cleans stale tournament records and related state. |
| `cleanup_expired_queues()` | Removes or resets expired waiting queues according to manager logic. |
| `handle_battle_result(player_id, battle_data)` | Routes a battle-result event to the relevant tournament flow. |
| `configure(values)` | Updates manager settings from a supplied table, according to its implementation. |
| `scan_tournament_boards()` | Public wrapper for scanning board objects. |
| `get_queue(area_id, object_id)` | Returns the queue for the board key when present. |
| `init()` | Initializes manager scheduling/board scanning behavior. |

The file has many local helpers for queue indexing/removal, busy participant pruning, messaging, reward handling, scheduled starts, active tournament spectators, and board scanning. They are implementation details rather than public module methods.

### 6.5 Registration, starting, and rewards

The manager has separate code paths for adding a player to a queue, adding a waiting spectator, spectating an active tournament, creating a tournament from a queue, and starting a queued tournament. It also has `grant_winner_rewards` and `finish_queue_tournament` helpers.

The reward-related config names visible in the source are `winner_money_reward`, `winner_gp_reward`, and `deduct_opposing_team_gp`. Do not assume a Tiled property alone guarantees a reward: the manager's completion path and player-state checks determine when the reward is actually applied.

---

<a id="7-battle-flow--tournament-flowlua"></a>
## 7. Battle flow — `tournament-flow.lua`

`TournamentFlow` coordinates what viewers see while matches run and initiates the battle runtime APIs. It imports constants, core, UI, and state. It defines local coroutine helpers:

```lua
local async = function(fn)
    local co = coroutine.create(fn)
    return Async.promisify(co)
end

local await = function(value)
    return Async.await(value)
end
```

These are module-local helpers, not globals exported by this file.

### 7.1 Viewer and board lifecycle

The module contains helpers to:

- enumerate tournament viewers and determine whether a viewer is in an active match;
- open or close the board for one player;
- show or hide the board for all viewers;
- refresh already-open boards;
- open live boards for waiting viewers and close all live boards for a tournament;
- send a message to viewers;
- close a board if it is currently open.

Public methods include `close_board_for_player`, `show_board_to_all`, and `hide_board_from_all`. `keep_locked` is accepted by the close/hide paths and affects whether the player remains input-locked after the UI closes.

### 7.2 PvP flow

`run_player_vs_player(tournament, match)` handles a player-versus-player match. Supporting helpers wait for players to be ready, close board UI before a battle, capture/restore HP state, optionally force PvP HP, and wait for the battle outcome with a timeout. The flow checks whether player IDs still correspond to players and whether they are already battling before attempting battle initiation.

The runtime entry point observed in this module is `Async.initiate_pvp(...)`. It is not a Lua standard-library function. Battle completion is also integrated with the top-level `battle_results` event path in `main.lua`/manager; do not treat the initiation call alone as the tournament's complete result-handling contract.

### 7.3 Player-versus-NPC flow

`run_player_vs_npc(tournament, player, npc)` coordinates a player against an NPC participant. The code uses `Async.initiate_encounter(...)`, player readiness/health helpers, and tournament battle state. The exact encounter argument structure is defined by the call sites in this module and the engine API; this README does not infer an external API contract beyond those call sites.

### 7.4 NPC-versus-NPC result handling

`resolve_npc_battle(tournament_id, round, match_index, match)` resolves a matchup without a human participant using the tournament-scoped result API. `TournamentCore.get_npc_battle_result(...)` delegates to the state cache, which keys results by tournament/round/match/battle index so repeated NPC IDs across tournaments do not inherently share the same cached result.

### 7.5 Round execution and visual progression

Public flow functions include:

| Function | Purpose visible from implementation |
|---|---|
| `run_round_battles(tournament_id, round)` | Executes the round's matches and battle progression. |
| `squash_winner_before_move(...)` / `unsquash_winner_after_move(...)` | Coordinate the winner mugshot animation before/after repositioning. |
| `greyscale_specific_loser(...)` | Applies the eliminated/loser visual to the relevant participant. |
| `move_winner_for_match(...)` | Moves the winning participant's UI representation to the next bracket position. |
| `spawn_progress_bar_for_match(...)` | Creates match progress display elements. |
| `remove_progress_bar_overlays(overlays)` | Removes temporary overlays created for progress. |
| `process_round_one_by_one(tournament_id, round)` | Coordinates serial round progression and visuals. |
| `announce_champion(tournament_id)` | Announces the winner/champion. |
| `run_tournament(tournament_id)` | Main tournament progression routine. |
| `handle_player_disconnect(player_id)` | Handles a disconnect in flow-related tournament state. |

The source includes `await_with_timeout`, enemy-survival/stat helpers, HP snapshot/restore helpers, and readiness checks. These are safeguards around asynchronous battles; they should not be replaced by blocking loops.

### 7.6 Timeouts and readiness

The manager/core configuration includes `battle_timeout_seconds`, defaulting to ten minutes in `tournament-core.lua`. The flow's `await_with_timeout` and battle readiness logic are the mechanisms to inspect when debugging hangs or stalled matches. `Net.is_player_battling` is used as a state check; the flow also validates player existence through `Net.is_player` at relevant call sites.

---

<a id="8-tournament-ui--tournament-uilua"></a>
## 8. Tournament UI — `tournament-ui.lua`

The UI module draws the bracket per viewer. It uses constants and coordinate data from `tournament-constants.lua` and `ui-pos.lua`, the net-games `games` module, and `Displayer.Text`.

### 8.1 Visual job invalidation

The module tracks a visual epoch per player. Public functions:

- `invalidate_player_visual_jobs(player_id)` — invalidates in-flight visual jobs for that player.
- `visual_job_is_valid(player_id, expected_epoch)` — checks whether a job still matches the current epoch.
- `get_visual_epoch(player_id)` — returns the current epoch.

The disconnect event invalidates visual jobs before manager cleanup. This prevents delayed async visual work from continuing against a departed player's UI lifecycle.

### 8.2 Asset and visual helpers

The module includes local helpers to check/provide assets safely, create tournament-scoped visual IDs, remember IDs for cleanup, draw/update UI elements, remove UI elements/text, resolve mugshot textures, and normalize title banner names.

Visual IDs are based on tournament identity plus a base ID, reducing collisions between tournament UI elements. Per-player tracking is used so cleanup can remove previously created visual elements and text.

### 8.3 Main board elements

The renderer can create/update:

- bracket background gradient and grid;
- bracket tree image/animation;
- title banner;
- participant mugshots and mug frames;
- progress bars and optional overlays;
- eliminated-participant bars/tints;
- revealed elimination paths;
- champion topper/crown/indicator;
- battle-progress frame updates;
- temporary text via `Displayer.Text`.

Public UI methods include:

| Function | Purpose |
|---|---|
| `show_board(player_id, tournament_data)` | Draws or refreshes the bracket for one player. |
| `cleanup_ui_elements(player_id)` | Removes tracked UI elements. |
| `cleanup(player_id)` | Performs player UI cleanup. |
| `tint_loser(player_id, tournament_data, participant_id)` | Applies the loser/elimination tint. |
| `squash_mugshot(...)` / `unsquash_mugshot(...)` | Animates a participant mugshot's presentation. |
| `move_participant(player_id, tournament_data, participant_id, to_pos)` | Moves a participant visual. |
| `add_progress_bar_with_overlay(...)` | Adds a progress bar and overlay for a match. |
| `remove_progress_bar_overlay(player_id, overlay_id)` | Removes a temporary overlay. |
| `update_battling_frames(player_id, tournament_data)` | Updates frame state for currently battling participants. |
| `show_champion_indicator(player_id, tournament_data)` | Displays the champion indicator. |
| `fade_to_black(seconds)` / `fade_from_black(seconds)` | Uses player camera fade calls. |
| `acquire_tournament_music(area_id)` / `release_tournament_music(area_id)` | Manages tournament announcement music relative to the area's current song. |
| `prewarm_player(player_id)` | Prepares/provides relevant UI assets for a joining player. |

### 8.4 UI lifecycle and cleanup

The module tracks element IDs and text IDs. Removal functions are called during cleanup so a board can be closed without leaving its tournament overlays behind. The epoch mechanism separately guards async work; removing visible elements and invalidating delayed work solve different problems.

The UI module calls the `games` API for UI element add/update/remove operations and calls `Displayer.Text` for text objects. These are project APIs; the exact function signatures should be read from their respective library source rather than inferred from the names alone.

---

<a id="9-npc-pool--tournament-npcslua"></a>
## 9. NPC pool — `tournament-npcs.lua`

### 9.1 NPC record shape

Each entry in `tournament_npcs.NPC_LIST` contains:

```lua
{
    id = "/server/assets/tourney/npc-navis-testing/<npc>/<npc>1.zip",
    name = "...",
    mugshot = "/server/assets/tourney/npc-navis-testing/<npc>/mug.png",
    weight = number,
}
```

The roster in this archive contains AirMan, BlastMan, BurnerMan, Colonel, CircusMan, CutMan, ElementMan, FireMan, Giga Beast, GutsMan, HatMan, IceMan, JammingMan, ProtoMan, QuickMan, Roll, ShadowMan, StarMan, and WoodMan. The source's `weight` is returned as participant metadata. `get_random_npc` selects uniformly with `math.random(1, #NPC_LIST)`; it does not use the `weight` field to perform weighted random selection.

### 9.2 Selection API

| Function | Behavior |
|---|---|
| `get_unique_random_npc(tournament_id)` | Selects an NPC not yet used by that tournament, records it, and returns a participant record with `type = "npc"`. Without a tournament ID, falls back to `get_random_npc()`. If all roster entries are used, resets that tournament's used list. |
| `get_unique_random_npcs(tournament_id, count)` | Calls the unique selector `count` times and returns an array. |
| `get_random_npc()` | Picks any roster entry and returns `{id, name, mugshot, weight, type="npc"}`. If the list is empty, returns the AirMan fallback record. |
| `get_random_npcs(count)` | Returns `count` independent random selections; duplicates are possible. |
| `cleanup_tournament_npcs(tournament_id)` | Clears that tournament's used-NPC list. Called by state deletion. |

The unique selection tracker is keyed by tournament ID, not globally shared between all tournaments.

---

<a id="10-constants-and-asset-paths--tournament-constantslua"></a>
## 10. Constants and asset paths — `tournament-constants.lua`

The root for bracket assets is:

```text
/server/assets/tourney/tourney-board-elements/
```

### 10.1 Background themes

The `bracket_background_path` table maps these keys to `gradient.png` and `grid.png` within a theme directory:

- `blue_bn4`
- `green_bn4`
- `pink_yellow_bn4`
- `pink_bn4`
- `lemon_lime_bn4`
- `green_blue_white_bn4`
- `red_orange_bn4`

The manager's fallback theme is `red_orange_bn4`.

### 10.2 Other configured assets

| Constant | Path/value |
|---|---|
| Progress bar tiers | `progress-bar-base/bottom-tier.png`, `middle-tier.png`, `top-tier.png`, each with a corresponding `.anim` path |
| Blue Moon overlays | `progress-bar-overlays/blue-moon/` tier textures; the animation paths are assigned in the constants table |
| Bracket images | `bracket-bm.png`, `bracket-rs.png` |
| Default animations | `bracket.anim`, `gradient.anim`, `grid.anim`, `mug.anim` |
| Mug frame | `mini-mug-frame.png`, `mini-mug-frame.anim`; states `INACTIVE`, `ACTIVE`, `MOVING` |
| Crown | `crown.png`, `crown.anim` |
| Champion topper | `champion-topper-bn4.png`, `champion-topper-bn45.png` and their `.anim` files |
| Title banner | `title-banners-bn4/title-banner.anim`; default state `TITLE`; default key `free-tourney` |
| Title banner keys | `free-tourney`, `den-battle`, `eagle`, `red-sun` |
| Tournament music | `/server/assets/tourney/music/bbn4_tournament_announcement.ogg` |
| Cheer sound | `/server/assets/tourney/sfx/cheer.ogg` |
| NPC root | `/server/assets/tourney/npc-navis-testing/` |
| Fallback mug | `/server/assets/tourney/npc-navis-testing/mug.png` |
| Last-resort mug | `/server/assets/tourney/npc-navis-testing/gutsman/mug.png` |

`sepia_properties` is `{ color_mode = 2, r = 202, g = 180, b = 155, a = 102 }` and is used by the UI's visual treatment for eliminated participants.

A configured path is not proof that the corresponding file is present in a deployed server asset directory. Verify the actual asset package if an image or animation is missing.

---

<a id="11-ui-coordinates--ui-poslua"></a>
## 11. UI coordinates — `ui-pos.lua`

Coordinates are fixed board-space values, not world coordinates.

### 11.1 Mugshot positions

| Round key | Slots | Approximate Y | Z |
|---|---:|---:|---:|
| `round0` | 8 | `132` | `4` |
| `round1` | 4 | `82` | `4` |
| `round2` | 2 | `56` | `4` |
| `round3` | 1 | `34` | `4` |

Exact X coordinates are stored in `UIPositions.mugshot_positions`. The round-0 layout is the fallback when `get_mugshot_positions(round)` cannot find the requested `roundN` key.

### 11.2 Progress bars

Progress bar coordinates are grouped into `bottom_tier`, `middle_tier`, and `top_tier`. The file has separate tables for:

- `progress_bar_positions` (Z = 2);
- `progress_bar_overlays` (Z = 3);
- `progress_bar_eliminated` (Z = 1).

The bottom tier has eight positions, middle tier four, and top tier two. `get_progress_bar_positions(tier)` appends `"_tier"` to the supplied tier name and returns an empty table when it cannot find a matching key.

### 11.3 Other UI positions

- Queue timer: `{x = 100, y = 20}`.
- Tournament tree: `{x = 0, y = 0, z = 0}`.
- Champion topper: `{x = 80, y = 40, z = 1}`.
- Title banner: `{x = 0, y = 0, z = 0}`.
- Crowns: `{x = 64, y = 48, z = 0}` and `{x = 176, y = 48, z = 0}`.
- Champion crown: `{x = 120, y = 36, z = 5}`.
- Background/grid: Z = `-2` / `-1`.

### 11.4 Position helper signatures

| Function | Signature | Behavior |
|---|---|---|
| `get_mugshot_positions(round)` | `number -> table` | Returns the `roundN` mugshot slot array or round-0 slots. |
| `get_progress_bar_positions(tier)` | `string -> table` | Returns the selected tier's progress bar positions or `{}`. |
| `get_progress_bar_index(round, match_index, winner_is_player1)` | `number, number, boolean -> number` | Calculates the participant bar index for rounds 1–3; falls back to `1` for other rounds. |

---

<a id="12-tiled-tournament-board-properties"></a>
## 12. Tiled Tournament Board properties

The runtime detects a board when its object type **or** class equals `Tournament Board`. The manager reads `object.custom_properties` and supports the property aliases in §6.2.

### 12.1 Minimal map setup

1. Add a Tiled object whose type or class is `Tournament Board`.
2. Give the object a stable object ID; queue identity uses area ID plus object ID.
3. Set the desired board behavior (`Board Type`) and visual settings (`Board Background`, optional title/banner).
4. Add the desired registration/scheduling and reward properties using the exact property names supported by the manager.
5. Ensure the server asset files referenced by `tournament-constants.lua` and `tournament-npcs.lua` are installed at those paths.

### 12.2 Board type values evidenced in code

The code explicitly branches on `hosted`, `full_wait`, `mixed_timer`, and `scheduled`. Values are lowercased before the branch. Other values are not documented here as supported modes because the source's explicit branching does not establish their intended semantics.

### 12.3 Configuration caveats

- Boolean properties should be entered in a representation accepted by the manager's `to_bool_or` helper.
- Numeric properties should be parseable by `tonumber`.
- A blank/unknown background key may not resolve to a configured asset. Use one of the keys listed in §10.1.
- Property aliases are case-sensitive Lua table keys as written; match the spelling shown above.
- The board's object ID is part of queue identity. Copying a map/object can create a separate queue when the object ID differs.

---

<a id="13-net-async-games-and-displayer-calls"></a>
## 13. `Net`, `Async`, `games`, and `Displayer` calls

This section lists API identifiers observed in the tournament files. It describes how this library uses them, not a replacement for the engine's API reference.

### 13.1 `Net` identifiers referenced

| Call | Observed use |
|---|---|
| `Net:on(...)` | Registers `player_join`, `object_interaction`, `battle_results`, `player_area_transfer`, `player_disconnect`, and `tick` listeners in `main.lua`. |
| `Net.get_player_area(player_id)` | Gets the player's current area for board interaction handling. |
| `Net.get_object_by_id(area_id, object_id)` | Resolves the interacted map object. |
| `Net.list_areas()` / `Net.list_objects(area_id)` | Board scanning and discovery. |
| `Net.is_player(player_id)` | Guards operations that require a valid player. |
| `Net.is_player_battling(player_id)` | Checks battle state before starting or coordinating battle flow. |
| `Net.get_player_name(player_id)` | Retrieves names for participants/viewers. |
| `Net.get_player_mugshot(player_id)` | Obtains player mugshot data for the bracket. |
| `Net.get_player_health(player_id)` / `Net.get_player_max_health(player_id)` | Captures battle-related HP state. |
| `Net.set_player_health(...)` / `Net.set_player_max_health(...)` | Restores or adjusts HP when the battle flow requires it. |
| `Net.get_player_money(player_id)` / `Net.set_player_money(...)` | Used by reward logic where applicable. |
| `Net.message_player(player_id, message)` | Sends informational messages. This is a direct `Net` call in the source; awaitable prompts use the `Async` namespace. |
| `Net.has_asset(player_id, path)` / `Net.provide_asset_for_player(player_id, path)` | UI asset checks/provisioning. |
| `Net.fade_player_camera(...)` | Fades a player's camera for transitions. |
| `Net.lock_player_input(player_id)` / `Net.unlock_player_input(player_id)` | Prevents or restores input during tournament UI/battle transitions. |
| `Net.toggle_player_hud(player_id, enabled)` | Hides/restores HUD as part of presentation flow. |
| `Net.get_song(area_id)` / `Net.set_song(area_id, path)` | Saves/sets/restores area music around tournament announcements. |
| `Net.play_sound_for_player(player_id, path)` | Plays a sound for a player. |
| `Net.get_area_name(area_id)` / `Net.set_area_name(area_id, name)` | Temporarily manages the displayed area name during announcement presentation. |
| `Net.get_area_custom_property(...)` | Reads area-level custom configuration where used. |

The argument details shown here reflect observed call sites. Optional argument tables and exact engine semantics should be checked against the project's runtime API implementation/documentation.

### 13.2 `Async` identifiers referenced

| Call | Observed use |
|---|---|
| `Async.promisify(co)` | Converts a coroutine into the promise form used by local `async` wrappers. |
| `Async.await(value)` | Awaits a promise/value in local `await` wrappers. |
| `Async.sleep(seconds)` | Yields between animation/flow steps without a blocking busy loop. |
| `Async.quiz_player(...)` | Used for player prompts/choices in tournament interactions. |
| `Async.initiate_pvp(...)` | Starts a PvP battle from flow logic. |
| `Async.initiate_encounter(...)` | Starts an encounter for a player-versus-NPC match. |

Do not substitute a bare `quiz_player` for `Async.quiz_player` in these call sites. The code explicitly uses the `Async` namespace for the quiz operation.

### 13.3 `games` and `Displayer`

`tournament-ui.lua` imports `scripts/net-games/main` as `games` and `scripts/displayer/displayer` as `Displayer`. The tournament code calls:

- `games.add_ui_element(...)`
- `games.update_ui_element(...)`
- `games.remove_ui_element(...)`
- `Displayer.Text(...)`

The bracket is drawn as UI elements with IDs that the tournament module tracks. Text is tracked separately for cleanup. Use the net-games and displayer README/source for the authoritative signatures and lifecycle rules for these calls.

### 13.4 Event payloads

The tournament module explicitly reads these event fields:

- `player_join`: `event.player_id`
- `object_interaction`: `event.player_id`, `event.object_id`, optional `event.button`
- `battle_results`: `event.player_id` and the full event forwarded as battle data
- `player_area_transfer`: `event.player_id`
- `player_disconnect`: `event.player_id`
- `tick`: `event.delta_time`

The manager/flow may inspect additional fields in `battle_data`; validate the exact field names against the runtime event implementation when changing battle-result interpretation. The code's use of `event.health`, `event.time`, or similar fields in another subsystem should not automatically be assumed to apply here.

---

<a id="14-lifecycle-cleanup-and-defensive-behavior"></a>
## 14. Lifecycle, cleanup, and defensive behavior

### 14.1 Input and visual cleanup

Tournament presentation can lock player input and alter HUD, camera fade, music, and area-name display. The UI/flow code contains close/restore paths; when modifying presentation sequences, verify every early return and timeout also reaches the relevant cleanup path.

### 14.2 Disconnect order

`main.lua` deliberately calls `TournamentUI.invalidate_player_visual_jobs(player_id)` before `TournamentManager.handle_player_disconnect(player_id)`. The source comment says not to call native sprite cleanup after the player object is gone. Preserve that order unless the runtime lifecycle contract changes.

### 14.3 Periodic cleanup

The `tick` listener performs two maintenance tasks:

- every 30 accumulated seconds: `TournamentManager.cleanup_orphaned_tournaments()`;
- every 60 accumulated seconds: `TournamentManager.cleanup_expired_queues()`.

The code resets each timer to zero after the threshold rather than repeatedly subtracting the threshold. A large tick delta therefore causes one cleanup call for that threshold check, not a catch-up loop.

### 14.4 Defensive checks observed

- Event callbacks check `event` and required identifiers before acting.
- Object interactions validate object type/class before dispatch.
- `State.add_participant` validates tournament existence, capacity, participant ID, duplicate IDs, and existing player registration.
- Core initialization verifies the tournament exists and has exactly eight participants.
- Flow checks player validity and battle state before battle operations.
- UI tracks per-player visual IDs and invalidates asynchronous visual jobs by epoch.
- Battle result recording rejects missing records/matches and already-completed matches.

These checks do not imply every external API can never fail. Runtime calls and asset presence remain deployment dependencies.

---

<a id="15-end-to-end-flow"></a>
## 15. End-to-end flow

1. **Startup:** `main.lua` loads net-games, initializes the manager, then registers server event handlers.
2. **Board discovery:** the manager scans areas/objects for Tournament Board objects and creates or updates queues keyed by area/object ID.
3. **Interaction:** `object_interaction` validates the event and board object, then dispatches to `handle_board_interaction`.
4. **Registration/spectating:** manager logic updates the board queue, participant registration, or spectator lists according to queue/tournament state.
5. **Tournament creation:** a queue start creates a tournament through core/state, selects participants/NPCs where applicable, and builds the bracket when eight participants are present.
6. **Presentation:** UI draws the bracket for participants and spectators; assets are checked/provided and per-player visuals are tracked.
7. **Battles:** flow coordinates player readiness, PvP/encounter initiation, result handling, timeouts, and NPC matchup outcomes.
8. **Result/visual update:** state records the battle, round completion/advancement updates the bracket, and flow moves/tints participant visuals.
9. **Completion:** the champion is announced; manager completion logic handles queue finalization and configured rewards.
10. **Cleanup:** queue/tournament state, NPC selection state, UI elements, input/HUD/music presentation state, and stale records are cleaned through their respective modules.

This sequence summarizes the architecture; exact branches differ by board type, participant mix, and tournament configuration.

---

<a id="16-observed-limitations-and-maintenance-notes"></a>
## 16. Observed limitations and maintenance notes

1. **State is in-memory in this library.** The state module's tournament maps and ID counter are module-local tables; this code does not itself persist tournaments to disk or a database.
2. **Eight participants are required for bracket initialization.** `TournamentCore.initialize_tournament` returns `false` unless the participant array has exactly eight entries.
3. **The NPC `weight` field is not used by the simple random picker.** `get_random_npc` chooses an index uniformly; the weight is participant metadata. Do not document it as weighted selection unless selection code changes.
4. **Asset paths are literal deployment assumptions.** Missing assets can still prevent the expected visual from appearing; configured paths alone do not prove availability.
5. **Tiled property names are string keys.** The manager accepts aliases but does not perform a general case-insensitive property lookup.
6. **Player removal is cross-module.** Clearing the player-to-tournament map is not equivalent to closing UI, removing a queue entry, removing a spectator, or terminating a battle. Use the manager/flow lifecycle paths.
7. **`get_all_tournaments()` exposes the live internal table.** Callers should avoid mutating it directly.
8. **Randomness uses `math.random`.** The source shuffles participants and selects NPC roster entries with the Lua RNG. This document does not assume a particular seeding policy beyond what is visible in this module.
9. **The source imports other project libraries.** Tournament behavior depends on the net-games/displayer APIs and server runtime methods; their full contracts live outside this directory.
10. **Runtime verification remains separate.** This is a code-based reference. Battle initiation, visual rendering, audio restoration, and scheduler behavior should be exercised in the actual server before treating them as tested.

---

<a id="17-cross-reference"></a>
## 17. Cross-reference

| If you are changing… | Start here | Also inspect |
|---|---|---|
| Startup/event payloads | `main.lua` | Runtime event API; manager handler |
| Tiled board setup | `tournament-manager.lua` → `apply_board_properties` | Map's custom properties; `tournament-constants.lua` |
| Queue/schedule behavior | `tournament-manager.lua` | `SETTINGS`, queue helpers, `init()` |
| Bracket/match data | `tournament-state.lua` | `tournament-core.lua` |
| Best-of series | `tournament-core.lua`, `tournament-state.lua` | `tournament-flow.lua` battle result paths |
| PvP or NPC encounter | `tournament-flow.lua` | `Async` runtime API, `tournament-npcs.lua` |
| NPC roster/uniqueness | `tournament-npcs.lua` | `tournament-state.lua` cleanup |
| Mugshots/positions | `tournament-ui.lua`, `ui-pos.lua` | Participant `mugshot` fields, asset files |
| UI assets/theme/title | `tournament-constants.lua` | `tournament-ui.lua`, deployed assets |
| UI artifacts after disconnect | `main.lua`, `tournament-ui.lua` | Manager/flow cleanup |
| Winner reward behavior | `tournament-manager.lua` | Player money APIs and tournament config |
| Music/fades/HUD/input | `tournament-ui.lua`, `tournament-flow.lua` | `Net` runtime API |

---

**Documentation rule:** When adding or changing an API, update this README from the implementation itself. Keep runtime-specific `Net`/`Async` contracts distinct from Lua 5.2 language features, and label unverified engine behavior as unverified rather than guessing.
