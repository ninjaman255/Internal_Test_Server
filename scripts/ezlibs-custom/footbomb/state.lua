-- FootBomb state store.
-- Mutable match/NPC/player registries live here instead of in the entry point.
-- Keep this module data-only so main.lua remains responsible for game behavior.
local State = {
    -- area_id -> actor_id -> NPC reference
    npc_refs = {},

    -- player_id -> true while an NPC/match interaction is being handled
    pending_interactions = {},

    -- source area -> waiting VS Player match
    waiting_matches = {},

    -- player_id -> bot/cursor/camera/input representation
    player_representations = {},

    -- instance_id -> bot slot records
    instance_bots = {},

    -- instance_id -> named Player 1/2 spawn positions
    instance_spawn_points = {},

    -- Rotating deterministic NPC direction choice index
    npc_direction_sequence_index = 0,
}

return State
