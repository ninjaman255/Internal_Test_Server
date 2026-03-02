-- Timer System with Global and Player-specific Timers

Timer = {}
Timer.__index = Timer

function Timer:init()
    self.timers = {} -- Player-specific timers
    self.countdowns = {} -- Player-specific countdowns
    self.global_timers = {} -- Global timers for all players
    self.global_countdowns = {} -- Global countdowns for all players
    self.player_data = {} -- Track player states

    -- Handle player joining
    Net:on("player_join", function(event)
        local ok, err = pcall(function()
            self:handlePlayerJoin(event.player_id)
        end)
        if not ok then
            print("Error in player_join:", err)
        end
    end)

    -- Handle timer updates every tick
    Net:on("tick", function(event)
        local ok, err = pcall(function()
            local delta = event.delta_time or 0
            self:updateTimers(delta)
        end)
        if not ok then
            print("Error in tick:", err)
        end
    end)

    -- Handle player leaving
    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
            self:handlePlayerLeave(event.player_id)
        end)
        if not ok then
            print("Error in player_disconnect:", err)
        end
    end)

    return self
end

function Timer:handlePlayerJoin(player_id)
    -- Initialize player data
    self.player_data[player_id] = {
        connected = true,
        join_time = os.time()
    }

    -- Initialize player-specific timers
    self.timers[player_id] = {}
    self.countdowns[player_id] = {}

    -- Sync global timers with new player
    self:syncGlobalTimers(player_id)
end

function Timer:handlePlayerLeave(player_id)
    -- Clean up player-specific timers
    self.timers[player_id] = nil
    self.countdowns[player_id] = nil
    self.player_data[player_id] = nil
end

function Timer:updateTimers(delta)
    if delta == nil or delta <= 0 then
        return
    end

    -- Update player-specific timers
    for player_id, player_timers in pairs(self.timers) do
        for timer_id, timer_data in pairs(player_timers) do
            if timer_data and not timer_data.paused then
                timer_data.elapsed = (timer_data.elapsed or 0) + delta
                timer_data.current = timer_data.elapsed

                Net:emit("timer_update", {
                    player_id = player_id,
                    timer_id = timer_id,
                    current = timer_data.current
                })

                if timer_data.duration and timer_data.elapsed >= timer_data.duration then
                    if timer_data.callback then
                        timer_data.callback(player_id, timer_id, timer_data.elapsed)
                    end
                    if not timer_data.loop then
                        self.timers[player_id][timer_id] = nil
                        Net:emit("timer_remove", {
                            player_id = player_id,
                            timer_id = timer_id
                        })
                    else
                        timer_data.elapsed = 0
                    end
                end
            end
        end
    end

    -- Update player-specific countdowns
    for player_id, player_countdowns in pairs(self.countdowns) do
        for countdown_id, countdown_data in pairs(player_countdowns) do
            if countdown_data and not countdown_data.paused then
                local previous_floor = math.floor(countdown_data.remaining or 0)
                countdown_data.remaining = (countdown_data.remaining or 0) - delta
                countdown_data.current = math.max(0, countdown_data.remaining)

                local current_floor = math.floor(countdown_data.current)
                if current_floor ~= previous_floor then
                    Net:emit("countdown_update", {
                        player_id = player_id,
                        countdown_id = countdown_id,
                        current = countdown_data.current
                    })
                end

                if countdown_data.remaining <= 0 then
                    if countdown_data.callback then
                        countdown_data.callback(player_id, countdown_id, 0)
                    end
                    if not countdown_data.loop then
                        self.countdowns[player_id][countdown_id] = nil
                        Net:emit("countdown_remove", {
                            player_id = player_id,
                            countdown_id = countdown_id
                        })
                    else
                        countdown_data.remaining = countdown_data.duration or 0
                        countdown_data.current = countdown_data.remaining
                        Net:emit("countdown_update", {
                            player_id = player_id,
                            countdown_id = countdown_id,
                            current = countdown_data.current
                        })
                    end
                end
            end
        end
    end

    -- Update global timers
    for timer_id, timer_data in pairs(self.global_timers) do
        if timer_data and not timer_data.paused then
            timer_data.elapsed = (timer_data.elapsed or 0) + delta
            timer_data.current = timer_data.elapsed

            self:emitToAllPlayers("timer_global_update", {
                timer_id = timer_id,
                current = timer_data.current
            })

            if timer_data.duration and timer_data.elapsed >= timer_data.duration then
                if timer_data.callback then
                    timer_data.callback(nil, timer_id, timer_data.elapsed)
                end
                if not timer_data.loop then
                    self.global_timers[timer_id] = nil
                    self:emitToAllPlayers("timer_global_remove", {timer_id = timer_id})
                else
                    timer_data.elapsed = 0
                end
            end
        end
    end

    -- Update global countdowns
    for countdown_id, countdown_data in pairs(self.global_countdowns) do
        if countdown_data and not countdown_data.paused then
            local previous_floor = math.floor(countdown_data.remaining or 0)
            countdown_data.remaining = (countdown_data.remaining or 0) - delta
            countdown_data.current = math.max(0, countdown_data.remaining)

            local current_floor = math.floor(countdown_data.current)
            if current_floor ~= previous_floor then
                print("Emitting global countdown update for ID:", countdown_id, "current:", countdown_data.current)
                self:emitToAllPlayers("countdown_global_update", {
                    countdown_id = countdown_id,
                    current = countdown_data.current
                })
            end

            if countdown_data.remaining <= 0 then
                if countdown_data.callback then
                    countdown_data.callback(nil, countdown_id, 0)
                end
                if not countdown_data.loop then
                    self.global_countdowns[countdown_id] = nil
                    self:emitToAllPlayers("countdown_global_remove", {countdown_id = countdown_id})
                else
                    countdown_data.remaining = countdown_data.duration or 0
                    countdown_data.current = countdown_data.remaining
                    print("Emitting global countdown update for ID:", countdown_id, "current:", countdown_data.current)
                    self:emitToAllPlayers("countdown_global_update", {
                        countdown_id = countdown_id,
                        current = countdown_data.current
                    })
                end
            end
        end
    end
end

-- Helper function to emit to all connected players (with error protection)
function Timer:emitToAllPlayers(event_name, data)
    for player_id, _ in pairs(self.player_data) do
        local event_data = {}
        for k, v in pairs(data) do event_data[k] = v end
        event_data.player_id = player_id  -- add player_id to the data
        local ok, err = pcall(Net.emit, Net, event_name, event_data)
        if not ok then
            print("Error emitting", event_name, "to", player_id, ":", err)
        end
    end
end

-- PLAYER TIMER/COUNTDOWN MANAGEMENT

function Timer:pausePlayerTimer(player_id, timer_id)
    if self.timers[player_id] and self.timers[player_id][timer_id] then
        self.timers[player_id][timer_id].paused = true
    end
end

function Timer:resumePlayerTimer(player_id, timer_id)
    if self.timers[player_id] and self.timers[player_id][timer_id] then
        self.timers[player_id][timer_id].paused = false
    end
end

function Timer:pausePlayerCountdown(player_id, countdown_id)
    if self.countdowns[player_id] and self.countdowns[player_id][countdown_id] then
        self.countdowns[player_id][countdown_id].paused = true
    end
end

function Timer:resumePlayerCountdown(player_id, countdown_id)
    if self.countdowns[player_id] and self.countdowns[player_id][countdown_id] then
        self.countdowns[player_id][countdown_id].paused = false
    end
end

function Timer:removePlayerTimer(player_id, timer_id)
    Net:emit("timer_remove", { player_id = player_id, timer_id = timer_id })
    self.timers[player_id][timer_id] = nil
end

function Timer:removePlayerCountdown(player_id, countdown_id)
    Net:emit("countdown_remove", { player_id = player_id, countdown_id = countdown_id })
    self.countdowns[player_id][countdown_id] = nil
end

-- Global Timer Methods
function Timer:createGlobalTimer(timer_id, duration, callback, loop)
    loop = loop or false
    self.global_timers[timer_id] = {
        duration = duration,
        callback = callback,
        loop = loop,
        elapsed = 0,
        current = 0,
        paused = false
    }

    self:emitToAllPlayers("timer_global_create", {
        timer_id = timer_id,
        duration = duration,
        loop = loop
    })

    self:emitToAllPlayers("timer_global_update", {
        timer_id = timer_id,
        current = 0
    })
end

function Timer:createGlobalCountdown(countdown_id, duration, callback, loop)
    loop = loop or false
    self.global_countdowns[countdown_id] = {
        duration = duration,
        callback = callback,
        loop = loop,
        remaining = duration,
        current = duration,
        paused = false
    }

    self:emitToAllPlayers("countdown_global_create", {
        countdown_id = countdown_id,
        duration = duration,
        loop = loop
    })

    self:emitToAllPlayers("countdown_global_update", {
        countdown_id = countdown_id,
        current = duration
    })
end

function Timer:pauseGlobalTimer(timer_id)
    if self.global_timers[timer_id] then
        self.global_timers[timer_id].paused = true
        self:emitToAllPlayers("timer_global_pause", {timer_id = timer_id})
    end
end

function Timer:resumeGlobalTimer(timer_id)
    if self.global_timers[timer_id] then
        self.global_timers[timer_id].paused = false
        self:emitToAllPlayers("timer_global_resume", {timer_id = timer_id})
    end
end

function Timer:pauseGlobalCountdown(countdown_id)
    if self.global_countdowns[countdown_id] then
        self.global_countdowns[countdown_id].paused = true
        self:emitToAllPlayers("countdown_global_pause", {countdown_id = countdown_id})
    end
end

function Timer:resumeGlobalCountdown(countdown_id)
    if self.global_countdowns[countdown_id] then
        self.global_countdowns[countdown_id].paused = false
        self:emitToAllPlayers("countdown_global_resume", {countdown_id = countdown_id})
    end
end

function Timer:removeGlobalTimer(timer_id)
    if not timer_id then
        print("Warning: Attempted to remove global timer with nil ID")
        return
    end
    self.global_timers[timer_id] = nil
    self:emitToAllPlayers("timer_global_remove", {timer_id = timer_id})
end

function Timer:removeGlobalCountdown(countdown_id)
    if not countdown_id then
        print("Warning: Attempted to remove global countdown with nil ID")
        return
    end
    self.global_countdowns[countdown_id] = nil
    self:emitToAllPlayers("countdown_global_remove", {countdown_id = countdown_id})
end

function Timer:getGlobalTimer(timer_id)
    return self.global_timers[timer_id] and self.global_timers[timer_id].current or 0
end

function Timer:getGlobalCountdown(countdown_id)
    return self.global_countdowns[countdown_id] and self.global_countdowns[countdown_id].current or 0
end

-- Sync methods for new players
function Timer:syncGlobalTimers(player_id)
    for timer_id, timer_data in pairs(self.global_timers) do
        Net:emit("timer_global_create", {
            player_id = player_id,
            timer_id = timer_id,
            duration = timer_data.duration,
            loop = timer_data.loop,
            current = timer_data.current
        })

        if timer_data.paused then
            Net:emit("timer_global_pause", {player_id = player_id, timer_id = timer_id})
        end
    end

    for countdown_id, countdown_data in pairs(self.global_countdowns) do
        Net:emit("countdown_global_create", {
            player_id = player_id,
            countdown_id = countdown_id,
            duration = countdown_data.duration,
            loop = countdown_data.loop,
            current = countdown_data.current
        })

        if countdown_data.paused then
            Net:emit("countdown_global_pause", {player_id = player_id, countdown_id = countdown_id})
        end
    end
end

function Timer:createPlayerTimer(player_id, timer_id, duration, callback, loop)
    if not self.timers[player_id] then
        self.timers[player_id] = {}
    end

    loop = loop or false
    self.timers[player_id][timer_id] = {
        duration = duration,
        callback = callback,
        loop = loop,
        elapsed = 0,
        current = 0,
        paused = false
    }

    Net:emit("timer_create", {
        player_id = player_id,
        timer_id = timer_id,
        duration = duration,
        loop = loop
    })

    Net:emit("timer_update", {
        player_id = player_id,
        timer_id = timer_id,
        current = 0
    })
end

function Timer:createPlayerCountdown(player_id, countdown_id, duration, callback, loop)
    if not self.countdowns[player_id] then
        self.countdowns[player_id] = {}
    end

    loop = loop or false
    self.countdowns[player_id][countdown_id] = {
        duration = duration,
        callback = callback,
        loop = loop,
        remaining = duration,
        current = duration,
        paused = false
    }

    Net:emit("countdown_create", {
        player_id = player_id,
        countdown_id = countdown_id,
        duration = duration,
        loop = loop
    })

    Net:emit("countdown_update", {
        player_id = player_id,
        countdown_id = countdown_id,
        current = duration
    })
end

-- Additional utility methods
function Timer:getAllGlobalTimers()
    return self.global_timers
end

function Timer:getAllGlobalCountdowns()
    return self.global_countdowns
end

function Timer:clearAllGlobalTimers()
    for timer_id, _ in pairs(self.global_timers) do
        self:removeGlobalTimer(timer_id)
    end
end

function Timer:clearAllGlobalCountdowns()
    for countdown_id, _ in pairs(self.global_countdowns) do
        self:removeGlobalCountdown(countdown_id)
    end
end

function Timer:getPlayerTimer(player_id, timer_id)
    if self.timers[player_id] and self.timers[player_id][timer_id] then
        return self.timers[player_id][timer_id].current or 0
    end
    return 0
end

function Timer:getPlayerCountdown(player_id, countdown_id)
    if self.countdowns[player_id] and self.countdowns[player_id][countdown_id] then
        return self.countdowns[player_id][countdown_id].current or 0
    end
    return 0
end

-- Initialize the timer system
local timerSystem = setmetatable({}, Timer)
timerSystem:init()

return timerSystem