-- tournament-manager.lua
local TournamentManager = {}

local TournamentCore = require("scripts/net-game-tourney/tournament-core")
local TournamentFlow = require("scripts/net-game-tourney/tournament-flow")
local TournamentUI = require("scripts/net-game-tourney/tournament-ui")
local tournament_npcs = require("scripts/net-game-tourney/tournament-npcs")

local async = function(fn)
    local co = coroutine.create(fn)
    return Async.promisify(co)
end

local await = function(value)
    return Async.await(value)
end

local SETTINGS = {
    scheduled_enabled = true,
    default_schedule_every_hours = 1,
    default_schedule_start_minute = 0,
    default_schedule_start_second = 0,
    default_schedule_hour_offset = 0,
    registration_lead_seconds = 10 * 60,
    five_min_warning_seconds = 5 * 60,
    start_grace_seconds = 10,
    npc_only_tournaments_enabled = true,
    battle_timeout_seconds = 10 * 60,
    auto_start_when_full = false,   -- global fallback (only used if board has no explicit type)
    manual_start_enabled = false,
}

local waiting_queues = {}
local all_queued_players = {}
local waiting_spectator_queue = {}
local spectator_tournaments = {}
local active_interactions = {}
local last_scheduler_second = nil
local initialized = false

local function board_key(area_id, object_id)
    return tostring(area_id) .. ":" .. tostring(object_id)
end

local function to_bool_or(value, fallback)
    if value == nil then return fallback end
    if type(value) == "boolean" then return value end

    local s = tostring(value):lower()
    if s == "true" or s == "yes" or s == "1" or s == "on" then return true end
    if s == "false" or s == "no" or s == "0" or s == "off" then return false end
    return fallback
end

local function clamp_int(value, fallback, min_value, max_value)
    local n = math.floor(tonumber(value) or fallback or 0)
    if min_value ~= nil and n < min_value then n = min_value end
    if max_value ~= nil and n > max_value then n = max_value end
    return n
end

-- NEW: helper to determine if a board type uses scheduled start
local function is_scheduled_based(board_type)
    if not board_type then return SETTINGS.scheduled_enabled end
    local t = board_type:lower()
    return t == "scheduled" or t == "mixed_timer"
end

-- NEW: helper to determine if a board type should auto‑start when full (per‑board)
local function should_auto_start_on_full(board_type)
    if not board_type then return SETTINGS.auto_start_when_full end
    local t = board_type:lower()
    -- hosted boards never auto‑start; they wait for the host
    if t == "hosted" then return false end
    return t == "full_wait" or t == "mixed_timer" or (t == "scheduled" and SETTINGS.auto_start_when_full)
end

local function apply_board_properties(queue, object)
    if not queue or not object then return end

    local props = object.custom_properties or {}

    queue.name = props["Tournament Name"]
        or props["Name"]
        or queue.name
        or "WCity Tournament"

    queue.theme = props["Board Background"]
        or props["Tournament Background"]
        or props["board_theme"]
        or queue.theme
        or "red_orange_bn4"

    queue.title = props["Board Title"]
        or props["board_title"]
        or queue.title

    queue.title_banner_key = props["Tournament Title"]
        or props["Tournament Title Banner"]
        or props["Title Banner"]
        or queue.title_banner_key

    queue.npc_pool_key = props["Tournament NPC Pool"]
        or props["NPC Pool"]
        or queue.npc_pool_key
        or "default"

    queue.pvp_mode = props["Tournament PVP Mode"]
        or props["PVP Mode"]
        or queue.pvp_mode
        or "auto"

    queue.force_pvp_hp = to_bool_or(
        props["Tournament Force PVP HP"] or props["Force PVP HP"],
        queue.force_pvp_hp
    )

    queue.schedule_every_hours = tonumber(
        props["Tournament Every Hours"]
        or props["Every Hours"]
        or props["Schedule Every Hours"]
    ) or queue.schedule_every_hours or SETTINGS.default_schedule_every_hours

    queue.schedule_hour_offset = tonumber(
        props["Tournament Hour Offset"]
        or props["Schedule Hour Offset"]
        or props["Hour Offset"]
    ) or queue.schedule_hour_offset or SETTINGS.default_schedule_hour_offset

    queue.schedule_start_minute = tonumber(
        props["Tournament Start Minute"]
        or props["Start Minute"]
    ) or queue.schedule_start_minute or SETTINGS.default_schedule_start_minute

    queue.schedule_start_second = tonumber(
        props["Tournament Start Second"]
        or props["Start Second"]
    ) or queue.schedule_start_second or SETTINGS.default_schedule_start_second

    queue.registration_lead_seconds = tonumber(
        props["Registration Lead Seconds"]
        or props["Tournament Registration Seconds"]
        or props["Registration Seconds"]
    ) or queue.registration_lead_seconds or SETTINGS.registration_lead_seconds

    queue.battle_timeout_seconds = tonumber(
        props["Tournament Battle Timeout Seconds"]
        or props["Battle Timeout Seconds"]
        or props["Match Timeout Seconds"]
    ) or queue.battle_timeout_seconds or SETTINGS.battle_timeout_seconds

    queue.winner_money_reward = math.max(0, math.floor(tonumber(
        props["Tournament Money Reward"]
        or props["Money Reward"]
        or props["Winner Money"]
    ) or queue.winner_money_reward or 0))

    queue.winner_gp_reward = math.max(0, math.floor(tonumber(
        props["Tournament GP Reward"]
        or props["GP Reward"]
        or props["Winner GP"]
    ) or queue.winner_gp_reward or 0))

    queue.deduct_opposing_team_gp = to_bool_or(
        props["Tournament GP Stakes"]
        or props["Deduct Opposing Team GP"]
        or props["GP Stakes"],
        queue.deduct_opposing_team_gp or false
    )

    -- NEW: read Board Type (case‑insensitive)
    local board_type_raw = props["Board Type"]
        or props["board_type"]
        or props["Type"]
    if board_type_raw then
        queue.board_type = tostring(board_type_raw):lower()
    else
        queue.board_type = nil   -- nil means "scheduled" with fallback to global settings
    end
end

local function get_or_create_queue(area_id, object_id, object)
    local key = board_key(area_id, object_id)
    local queue = waiting_queues[key]

    if not queue then
        queue = {
            key = key,
            board_id = tostring(object_id),
            area_id = area_id,
            players = {},
            waiting_spectators = {},
            host_id = nil,
            status = "waiting",
            active_tournament_id = nil,
            created_time = os.time(),
            board_type = nil,   -- will be set by apply_board_properties
        }
        waiting_queues[key] = queue
    end

    apply_board_properties(queue, object)
    return queue
end

local function get_queue_schedule_period(queue)
    local hours = tonumber(queue.schedule_every_hours or SETTINGS.default_schedule_every_hours) or 1
    if hours <= 0 then hours = 1 end
    return math.max(60, math.floor(hours * 60 * 60))
end

local function get_queue_schedule_times(queue, now)
    now = math.floor(tonumber(now or os.time()) or os.time())

    local period = get_queue_schedule_period(queue)
    local period_hours = math.max(1, math.floor(period / 3600))

    local hour_offset = clamp_int(
        queue.schedule_hour_offset or SETTINGS.default_schedule_hour_offset,
        0,
        0,
        23
    ) % period_hours

    local minute = clamp_int(
        queue.schedule_start_minute or SETTINGS.default_schedule_start_minute,
        0,
        0,
        59
    )

    local second = clamp_int(
        queue.schedule_start_second or SETTINGS.default_schedule_start_second,
        0,
        0,
        59
    )

    local date = os.date("*t", now)
    local day_start = os.time({
        year = date.year,
        month = date.month,
        day = date.day,
        hour = 0,
        min = 0,
        sec = 0,
    })

    local first_today = day_start + (hour_offset * 3600) + (minute * 60) + second
    local prev = first_today

    if prev > now then prev = prev - period end

    local steps = math.floor((now - prev) / period)
    prev = prev + (steps * period)
    if prev > now then prev = prev - period end

    return prev, prev + period, period
end

local function seconds_until_next_scheduled_tournament(queue)
    if SETTINGS.scheduled_enabled ~= true then return 0 end
    local _, next_start = get_queue_schedule_times(queue, os.time())
    return math.max(0, next_start - os.time())
end

local function tournament_registration_is_open(queue)
    if SETTINGS.scheduled_enabled ~= true then return true end

    -- For instant and hosted boards, registration is always open
    if queue.board_type == "instant" or queue.board_type == "hosted" then
        return true
    end

    local lead = tonumber(queue.registration_lead_seconds or SETTINGS.registration_lead_seconds) or 600
    return seconds_until_next_scheduled_tournament(queue) <= lead
end

local function format_duration(seconds)
    seconds = math.max(0, math.ceil(tonumber(seconds or 0) or 0))
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60

    if minutes > 0 then
        return string.format("%dm %02ds", minutes, secs)
    end

    return tostring(secs) .. "s"
end

local function queue_player_index(queue, player_id)
    for i, pid in ipairs(queue.players or {}) do
        if pid == player_id then return i end
    end
    return nil
end

local function remove_player_from_queue(player_id, quiet)
    local key = all_queued_players[player_id]
    if not key then return false end

    local queue = waiting_queues[key]
    all_queued_players[player_id] = nil

    if not queue then return false end

    local index = queue_player_index(queue, player_id)
    if index then table.remove(queue.players, index) end

    if queue.host_id == player_id then
        queue.host_id = queue.players[1]
    end

    if not quiet and Net.is_player(player_id) then
        pcall(Net.message_player, player_id, "You left the tournament queue.")
    end

    return true
end

local function remove_waiting_spectator(player_id, quiet)
    local key = waiting_spectator_queue[player_id]
    if not key then return false end

    local queue = waiting_queues[key]
    waiting_spectator_queue[player_id] = nil

    if queue and queue.waiting_spectators then
        queue.waiting_spectators[player_id] = nil
    end

    if not quiet and Net.is_player(player_id) then
        pcall(Net.message_player, player_id, "You will not automatically spectate the next tournament.")
    end

    return true
end

local function prune_busy_queue_participants(queue)
    if not queue then return end

    for i = #queue.players, 1, -1 do
        local player_id = queue.players[i]
        local remove = not Net.is_player(player_id)

        if not remove and Net.is_player_battling then
            local ok, battling = pcall(Net.is_player_battling, player_id)
            remove = ok and battling == true
        end

        if remove then
            all_queued_players[player_id] = nil
            table.remove(queue.players, i)
        end
    end

    if queue.host_id and not queue_player_index(queue, queue.host_id) then
        queue.host_id = queue.players[1]
    end

    for player_id in pairs(queue.waiting_spectators or {}) do
        local remove = not Net.is_player(player_id)

        if not remove and Net.is_player_battling then
            local ok, battling = pcall(Net.is_player_battling, player_id)
            remove = ok and battling == true
        end

        if remove then
            queue.waiting_spectators[player_id] = nil
            waiting_spectator_queue[player_id] = nil
        end
    end
end

local function message_queue(queue, message)
    for _, player_id in ipairs(queue.players or {}) do
        if Net.is_player(player_id) then
            pcall(Net.message_player, player_id, message)
        end
    end

    for player_id in pairs(queue.waiting_spectators or {}) do
        if Net.is_player(player_id) then
            pcall(Net.message_player, player_id, message)
        end
    end
end

local function queue_summary(queue)
    local lines = {
        tostring(queue.name or "Tournament"),
        string.format("Players: %d/8", #(queue.players or {})),
    }

    if SETTINGS.scheduled_enabled and queue.board_type ~= "instant" and queue.board_type ~= "hosted" then
        lines[#lines + 1] = "Starts in " .. format_duration(seconds_until_next_scheduled_tournament(queue))
    end

    for i, player_id in ipairs(queue.players or {}) do
        local name = Net.is_player(player_id) and Net.get_player_name(player_id) or tostring(player_id)
        lines[#lines + 1] = tostring(i) .. ". " .. tostring(name)
    end

    return table.concat(lines, "\n")
end

local function grant_winner_rewards(tournament, champion)
    if not tournament or not champion or champion.type ~= "player" or not Net.is_player(champion.id) then
        return
    end

    local money = math.max(0, math.floor(tonumber(tournament.config.winner_money_reward) or 0))
    local gp = math.max(0, math.floor(tonumber(tournament.config.winner_gp_reward) or 0))

    if money > 0 then
        if Net.get_player_money and Net.set_player_money then
            local current = tonumber(Net.get_player_money(champion.id) or 0) or 0
            pcall(Net.set_player_money, champion.id, current + money)
            pcall(Net.message_player, champion.id, string.format("Tournament prize: +%d$!", money))
        else
            print("UNIMPLEMENTED")
        end
    end

    if gp > 0 then
        print("UNIMPLEMENTED")
    end

    if tournament.config.deduct_opposing_team_gp == true then
        print("UNIMPLEMENTED")
    end
end

local function finish_queue_tournament(queue_key, tournament_id, champion, error_reason)
    local queue = waiting_queues[queue_key]
    local tournament = TournamentCore.get_tournament(tournament_id)

    if tournament and champion then
        grant_winner_rewards(tournament, champion)
    end

    if tournament then
        for player_id in pairs(tournament.spectators or {}) do
            if spectator_tournaments[player_id] == tournament_id then
                spectator_tournaments[player_id] = nil
            end
        end
    end

    if queue then
        queue.status = "waiting"
        queue.active_tournament_id = nil
        queue.host_id = nil
        queue.players = {}
        queue.waiting_spectators = {}
        queue.created_time = os.time()
    end

    if error_reason then
        print("[Tournament Manager] Tournament ended with error: " .. tostring(error_reason))
    end
end


local function create_tournament_from_queue(queue, automatic)
    prune_busy_queue_participants(queue)

    local npc_only = #queue.players == 0
    if npc_only and not (automatic and SETTINGS.npc_only_tournaments_enabled) then
        return nil, "Nobody is registered."
    end

    if queue.npc_pool_key and queue.npc_pool_key ~= "default" then
        -- The target repository exposes one direct-ZIP NPC pool only.
        print("UNIMPLEMENTED")
    end

    local tournament_id = TournamentCore.create_tournament({
        host_id = queue.host_id,
        name = queue.name,
        theme = queue.theme,
        title = queue.title,
        title_banner_key = queue.title_banner_key,
        type = "scheduled",
        board_id = queue.board_id,
        area_id = queue.area_id,
        pvp_mode = queue.pvp_mode or "auto",
        force_pvp_hp = queue.force_pvp_hp,
        battle_timeout_seconds = queue.battle_timeout_seconds or SETTINGS.battle_timeout_seconds,
        winner_money_reward = queue.winner_money_reward or 0,
        winner_gp_reward = queue.winner_gp_reward or 0,
        deduct_opposing_team_gp = queue.deduct_opposing_team_gp == true,
        npc_only = npc_only,
    })

    if not tournament_id then
        return nil, "Could not create tournament."
    end

    for _, player_id in ipairs(queue.players) do
        if Net.is_player(player_id) then
            local mug = Net.get_player_mugshot(player_id)
            local added = TournamentCore.add_participant(tournament_id, {
                id = player_id,
                type = "player",
                name = Net.get_player_name(player_id) or tostring(player_id),
                mugshot = mug and mug.texture_path or nil,
                weight = 50,
            })

            if not added then
                TournamentCore.cleanup_tournament(tournament_id)
                return nil, "Could not add a registered player."
            end
        end
    end

    local tournament = TournamentCore.get_tournament(tournament_id)
    local slots_needed = 8 - #tournament.participants

    if slots_needed > 0 then
        local npcs = tournament_npcs.get_unique_random_npcs(tournament_id, slots_needed)
        for _, npc in ipairs(npcs) do
            if not TournamentCore.add_participant(tournament_id, npc) then
                TournamentCore.cleanup_tournament(tournament_id)
                return nil, "Could not fill tournament with NPCs."
            end
        end
    end

    if not TournamentCore.initialize_tournament(tournament_id) then
        TournamentCore.cleanup_tournament(tournament_id)
        return nil, "Could not initialize tournament."
    end

    tournament = TournamentCore.get_tournament(tournament_id)
    tournament.config.on_complete = function(id, champion, error_reason)
        finish_queue_tournament(queue.key, id, champion, error_reason)
    end

    for _, player_id in ipairs(queue.players) do
        all_queued_players[player_id] = nil
    end

    for player_id in pairs(queue.waiting_spectators or {}) do
        waiting_spectator_queue[player_id] = nil

        if Net.is_player(player_id) then
            TournamentCore.add_spectator(
                tournament_id,
                player_id,
                Net.get_player_name(player_id) or tostring(player_id)
            )
            spectator_tournaments[player_id] = tournament_id
        end
    end

    queue.players = {}
    queue.waiting_spectators = {}
    queue.status = "running"
    queue.active_tournament_id = tournament_id

    return tournament_id, nil
end


local function start_queue_tournament(queue, automatic)
    if not queue or queue.status ~= "waiting" then return false end

    local tournament_id, err = create_tournament_from_queue(queue, automatic)
    if not tournament_id then
        print("[Tournament Manager] Start failed: " .. tostring(err))
        return false
    end

    print(string.format(
        "[Tournament Manager] Tournament %s started (id=%d)",
        tostring(queue.name or "Tournament"),
        tournament_id
    ))

    TournamentFlow.run_tournament(tournament_id)
    return true
end

local function add_player_to_queue(queue, player_id)
    if queue.status ~= "waiting" then
        return false, "This tournament has already started."
    end

    if not tournament_registration_is_open(queue) then
        return false, "Registration is closed. Next tournament starts in "
            .. format_duration(seconds_until_next_scheduled_tournament(queue)) .. "."
    end

    if all_queued_players[player_id] then
        return false, "You are already registered for a tournament."
    end

    if waiting_spectator_queue[player_id] then
        return false, "You are already waiting to spectate a tournament."
    end

    if TournamentCore.is_player_in_tournament(player_id) or spectator_tournaments[player_id] then
        return false, "You are already in a tournament."
    end

    if Net.is_player_battling then
        local ok, battling = pcall(Net.is_player_battling, player_id)
        if ok and battling == true then
            return false, "You cannot register while battling."
        end
    end

    if #queue.players >= 8 then
        return false, "This tournament is full."
    end

    queue.players[#queue.players + 1] = player_id
    all_queued_players[player_id] = queue.key
    queue.host_id = queue.host_id or player_id

    -- NEW: after adding, check if we should auto‑start based on board type
    local board_type = queue.board_type
    local player_count = #queue.players

    -- 1. Instant: start immediately after first registration
    if board_type == "instant" and player_count >= 1 then
        start_queue_tournament(queue, true)
    -- 2. Full_wait / mixed_timer: start when 8 players are reached
    elseif should_auto_start_on_full(board_type) and player_count >= 8 then
        start_queue_tournament(queue, true)
    -- 3. Fallback: global auto_start_when_full (only if board_type is nil or "scheduled")
    elseif (board_type == nil or board_type == "scheduled") and SETTINGS.auto_start_when_full and player_count >= 8 then
        start_queue_tournament(queue, true)
    end

    return true
end

local function add_waiting_spectator(queue, player_id)
    if queue.status ~= "waiting" then
        return false, "This tournament has already started."
    end

    if all_queued_players[player_id] then
        return false, "You are registered to play. Withdraw first."
    end

    if waiting_spectator_queue[player_id] then
        return false, "You are already waiting to spectate a tournament."
    end

    if TournamentCore.is_player_in_tournament(player_id) or spectator_tournaments[player_id] then
        return false, "You are already in a tournament."
    end

    queue.waiting_spectators[player_id] = true
    waiting_spectator_queue[player_id] = queue.key
    return true
end

local function run_scheduled_start(queue)
    if not queue or queue.status ~= "waiting" then return false end

    prune_busy_queue_participants(queue)

    if #queue.players > 0 then
        return start_queue_tournament(queue, true)
    end

    if SETTINGS.npc_only_tournaments_enabled then
        return start_queue_tournament(queue, true)
    end

    return false
end

-- MODIFIED: update_scheduler now only runs for scheduled-based boards
local function update_scheduler()
    if SETTINGS.scheduled_enabled ~= true then return end

    local now = os.time()
    if last_scheduler_second == now then return end
    last_scheduler_second = now

    for _, queue in pairs(waiting_queues) do
        prune_busy_queue_participants(queue)

        -- Skip boards that don't use scheduled start
        if not is_scheduled_based(queue.board_type) then
            goto continue
        end

        local prev_start, next_start = get_queue_schedule_times(queue, now)
        local seconds_to_next = math.max(0, next_start - now)
        local registration_lead = tonumber(queue.registration_lead_seconds or SETTINGS.registration_lead_seconds) or 600
        local five_min = tonumber(SETTINGS.five_min_warning_seconds or 300) or 300
        local grace = tonumber(SETTINGS.start_grace_seconds or 10) or 10

        if queue.status == "waiting"
            and seconds_to_next <= registration_lead
            and queue._last_registration_open_announce_at ~= next_start
        then
            queue._last_registration_open_announce_at = next_start
            print("[Tournament Manager] Registration open: " .. tostring(queue.name or queue.key))
            message_queue(queue, "Tournament registration is now open.")
        end

        if queue.status == "waiting"
            and seconds_to_next <= five_min
            and queue._last_five_min_announce_at ~= next_start
        then
            queue._last_five_min_announce_at = next_start
            message_queue(queue, "Tournament starts in 5 minutes.")
        end

        if now >= prev_start
            and (now - prev_start) <= grace
            and queue._last_start_attempt_at ~= prev_start
        then
            queue._last_start_attempt_at = prev_start
            run_scheduled_start(queue)
        end

        ::continue::
    end
end

local function scan_tournament_boards()
    local areas = Net.list_areas and Net.list_areas() or {}

    for _, area_id in ipairs(areas) do
        local objects = Net.list_objects and Net.list_objects(area_id) or {}

        for _, object_id in next, objects do
            local object = Net.get_object_by_id(area_id, object_id)

            if object and (object.type == "Tournament Board" or object.class == "Tournament Board") then
                local resolved_id = object.id or object_id
                get_or_create_queue(area_id, resolved_id, object)
            end
        end
    end
end

local function spectate_active_tournament(queue, player_id)
    local tournament_id = queue and queue.active_tournament_id
    local tournament = tournament_id and TournamentCore.get_tournament(tournament_id) or nil

    if not tournament then
        return false, "Tournament not found."
    end

    if TournamentCore.is_player_in_tournament(player_id) then
        local participant = nil
        for _, p in ipairs(tournament.participants or {}) do
            if p.type == "player" and p.id == player_id then
                participant = p
                break
            end
        end

        if participant and participant.eliminated then
            participant.spectating = true
            participant.wants_updates = true
            return true, nil
        end

        return false, "You are already playing in this tournament."
    end

    if spectator_tournaments[player_id] then
        return false, "You are already spectating a tournament."
    end

    TournamentCore.add_spectator(
        tournament_id,
        player_id,
        Net.get_player_name(player_id) or tostring(player_id)
    )
    spectator_tournaments[player_id] = tournament_id

    pcall(Net.message_player, player_id, "You are now spectating the tournament.")
    return true, nil
end

-- MODIFIED: handle_board_interaction with new quiz options for hosted type
function TournamentManager.handle_board_interaction(player_id, board_object, area_id)
    return async(function()
        if active_interactions[player_id] then return end
        active_interactions[player_id] = true

        local function done()
            active_interactions[player_id] = nil
        end

        if not Net.is_player(player_id) or not board_object or not board_object.id then
            done()
            return
        end

        local queue = get_or_create_queue(area_id, board_object.id, board_object)
        prune_busy_queue_participants(queue)

        pcall(Net.message_player, player_id, queue_summary(queue))
        await(Async.sleep(0.1))

        if queue.status == "running" then
            local choice = await(Async.quiz_player(player_id, "Spectate", "Cancel"))
            if choice == 0 then
                local ok, err = spectate_active_tournament(queue, player_id)
                if not ok then pcall(Net.message_player, player_id, err) end
            end
            done()
            return
        end

        -- If player is already registered, offer withdraw or (if host) start
        if all_queued_players[player_id] == queue.key then
            local options = {"Stay Registered", "Withdraw"}
            -- If this player is the host and board type is "hosted", add "Start" option
            local is_host = (queue.host_id == player_id and queue.board_type == "hosted")
            if is_host then
                options[#options + 1] = "Start"
            else
                options[#options + 1] = "Cancel"
            end
            local choice = await(Async.quiz_player(player_id, table.unpack(options)))
            -- choice 0 = Stay Registered, 1 = Withdraw, 2 = Start/Cancel
            if choice == 1 then
                remove_player_from_queue(player_id, false)
            elseif choice == 2 and is_host then
                -- Host starts the tournament
                pcall(Net.message_player, player_id, "Tournament starting...")
                start_queue_tournament(queue, true)
            end
            done()
            return
        end

        -- If player is waiting to spectate, offer to stop
        if waiting_spectator_queue[player_id] == queue.key then
            local choice = await(Async.quiz_player(player_id, "Keep Spectating", "Stop Spectating", "Cancel"))
            if choice == 1 then
                remove_waiting_spectator(player_id, false)
            end
            done()
            return
        end

        -- Registration is closed -> offer to spectate next
        if not tournament_registration_is_open(queue) then
            local choice = await(Async.quiz_player(player_id, "Spectate Next", "Cancel"))
            if choice == 0 then
                local ok, err = add_waiting_spectator(queue, player_id)
                if ok then
                    pcall(Net.message_player, player_id, "You will spectate when the tournament starts.")
                else
                    pcall(Net.message_player, player_id, err)
                end
            end
            done()
            return
        end

        -- Registration is open – main options
        local options = {"Register", "Spectate Next"}
        options[#options + 1] = "Cancel"
        local choice = await(Async.quiz_player(player_id, table.unpack(options)))

        if choice == 0 then
            local ok, err = add_player_to_queue(queue, player_id)
            if ok then
                pcall(Net.message_player, player_id, "You are registered for the tournament.")
                -- The auto‑start logic inside add_player_to_queue will handle starting if needed
            else
                pcall(Net.message_player, player_id, err)
            end
        elseif choice == 1 then
            local ok, err = add_waiting_spectator(queue, player_id)
            if ok then
                pcall(Net.message_player, player_id, "You will spectate when the tournament starts.")
            else
                pcall(Net.message_player, player_id, err)
            end
        end

        done()
    end)
end

function TournamentManager.handle_player_disconnect(player_id)
    active_interactions[player_id] = nil
    remove_player_from_queue(player_id, true)
    remove_waiting_spectator(player_id, true)

    local tournament_id = spectator_tournaments[player_id]
    if tournament_id then
        TournamentCore.remove_spectator(tournament_id, player_id)
        spectator_tournaments[player_id] = nil
    end

    TournamentFlow.handle_player_disconnect(player_id)
    TournamentCore.handle_player_disconnect(player_id)
end

function TournamentManager.handle_player_area_transfer(player_id)
    if all_queued_players[player_id] then
        remove_player_from_queue(player_id, true)
    end

    if waiting_spectator_queue[player_id] then
        remove_waiting_spectator(player_id, true)
    end
end

function TournamentManager.cleanup_orphaned_tournaments()
    TournamentCore.cleanup_orphaned_tournaments()
end

function TournamentManager.cleanup_expired_queues()
    scan_tournament_boards()
    for _, queue in pairs(waiting_queues) do
        prune_busy_queue_participants(queue)
    end
end

function TournamentManager.handle_battle_result(player_id, battle_data)
    -- Async.initiate_pvp/initiate_encounter promises are the authoritative source
    -- for tournament match results. The server-wide battle_results event is not
    -- used to resolve tournament matches.
end

function TournamentManager.configure(values)
    for key, value in pairs(values or {}) do
        SETTINGS[key] = value
    end
end

function TournamentManager.scan_tournament_boards()
    scan_tournament_boards()
end

function TournamentManager.get_queue(area_id, object_id)
    return waiting_queues[board_key(area_id, object_id)]
end

function TournamentManager.init()
    if initialized then return end
    initialized = true

    print("[Tournament Manager] Initializing tournament system...")
    scan_tournament_boards()

    Net:on("tick", function()
        update_scheduler()
    end)
end

return TournamentManager