-- Sound driver for FootBomb round events.
--
-- Reacts to semantic round events by playing sounds. All timing lives in the
-- round's event emitters; this module only decides WHAT to play, not WHEN.
-- Adding a new sound effect is a one-line addition here — no changes needed
-- to `resolve_round_winner` or any animation code.
--
-- The driver is attached once per round (see `SfxDriver.attach`). It does NOT
-- subscribe to per-instance lifecycle events; those are handled centrally in
-- main.lua. The driver only cares about round-phase events.
local SfxDriver = {}

-- Path constants kept here so audio tweaks stay out of main.lua.
local SFX = {
    THUD      = "/server/assets/net-game-footbomb/sfx/item-thud.ogg",
    EXPLOSION = "/server/assets/net-game-footbomb/sfx/explosion.ogg",
}

-- Attach listeners to a round event bus.
--
-- Parameters:
--   round_events         : EzBus instance for this round
--   event_names          : ROUND_EVENT table from main.lua
--   play_sound_for_inst  : function(instance_id, path, reason)
--   instance_id          : the current round's instance id
--   file_exists          : optional function(path) -> boolean; when supplied,
--                          used to skip obvious missing-file plays at the
--                          event level instead of logging a failure inside
--                          play_sound_for_inst. Optional so callers that don't
--                          need it can omit the 5th argument.
--
-- All listeners are safe to call multiple times per round; they only fire
-- once per event emit, and the bus is destroyed at round end.
function SfxDriver.attach(round_events, event_names, play_sound_for_inst, instance_id, file_exists)
    if type(round_events) ~= "table" or type(event_names) ~= "table"
        or type(play_sound_for_inst) ~= "function" then
        return
    end

    local function safe_play(path, reason)
        if type(file_exists) == "function" and not file_exists(path) then
            return
        end
        play_sound_for_inst(instance_id, path, reason)
    end

    -- Kicker kicks the ball: this is the impact of the launch.
    -- Note: main.lua now emits BOMB_LAUNCHED in the same server tick as the
    -- bomb's first movement keyframe (after the response-planning block), so
    -- this THUD lands with the visual launch rather than the kicker arrival.
    round_events:on(event_names.BOMB_LAUNCHED, function()
        safe_play(SFX.THUD, "bomb-launch")
    end)

    -- The bomb reached the defender's Ball point during a catch.
    round_events:on(event_names.BOMB_CATCH_CONTACT, function(payload)
        local reason = (payload and payload.match) and "matching-jump-contact"
            or "center-catch-contact"
        safe_play(SFX.THUD, reason)
    end)

    -- No THUD is played on defender landing. THUD is reserved for the kick
    -- itself and for actual bomb/defender catch contact only.

    -- Kicker wins: the bomb detonates.
    round_events:on(event_names.BOMB_EXPLODING, function()
        safe_play(SFX.EXPLOSION, "bomb-explode")
    end)
end

return SfxDriver