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
--
-- All listeners are safe to call multiple times per round; they only fire
-- once per event emit, and the bus is destroyed at round end.
function SfxDriver.attach(round_events, event_names, play_sound_for_inst, instance_id)
    if type(round_events) ~= "table" or type(event_names) ~= "table"
        or type(play_sound_for_inst) ~= "function" then
        return
    end

    -- Kicker kicks the ball: this is the impact of the launch.
    round_events:on(event_names.BOMB_LAUNCHED, function()
        play_sound_for_inst(instance_id, SFX.THUD, "bomb-launch")
    end)

    -- The bomb reached the defender's Ball point during a catch.
    round_events:on(event_names.BOMB_CATCH_CONTACT, function(payload)
        local reason = (payload and payload.match) and "matching-jump-contact"
            or "center-catch-contact"
        play_sound_for_inst(instance_id, SFX.THUD, reason)
    end)

    -- The defender's jump animation reached its extended landing frame.
    -- Fires once per jump (Left/Right only; Up has no arc).
    round_events:on(event_names.DEFENDER_LANDING_FRAME, function()
        play_sound_for_inst(instance_id, SFX.THUD, "defender-landing")
    end)

    -- Kicker wins: the bomb detonates.
    round_events:on(event_names.BOMB_EXPLODING, function()
        play_sound_for_inst(instance_id, SFX.EXPLOSION, "bomb-explode")
    end)
end

return SfxDriver