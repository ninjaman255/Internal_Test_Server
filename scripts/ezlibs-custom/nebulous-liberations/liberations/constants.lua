-- constants.lua
-- Centralised definitions for custom properties and constants used in liberations.

local Constants = {}

-- Defaults used when a Liberation Config object omits optional settings.
Constants.Defaults = {
    MaxOrderPoints = 9,
}

-- Map custom property keys
Constants.CustomProperties = {
    RespawnArea = "Respawn Area",
    WaitingArea = "Waiting Area",
    LiberationMapFileName = "Liberation Map File Name",
    LiberationTileset = "Liberation Tileset",
    MaxOrderPoints = "Max Order Points",
    LiberationEncounters = "Liberation Encounters",
    TargetPhaseCount = "Target Phase Count",
    TargetPlayerCount = "Target Player Count",
    MinimumTargetPhaseCount = "Minimum Target Phase Count",
    BackgroundTexture = "Background Texture",
    BackgroundAnimation = "Background Animation",
    BackgroundVelX = "Background Vel X",
    BackgroundVelY = "Background Vel Y",
    Song = "Song",
    VictoryLapSong = "Victory Lap Song",
    EncounterMusic = "Encounter Music",
    MusicPath = "Path",
    MusicLoopStart = "Loop Start",
    MusicLoopEnd = "Loop End",
    HonorHPMem = "Honor HPMem",
    Compress = "Compress",
    Decompress = "Decompress",
    Boss = "Boss",
    BossID = "Boss ID",
    BossID1 = "Boss ID 1",
    BossID2 = "Boss ID 2",
    Type = "Type",
    SpawnMode = "Spawn Mode",
    TriggerBoss = "Trigger Boss",
    SpawnOffsetX = "Spawn Offset X",
    SpawnOffsetY = "Spawn Offset Y",
    SpawnOffsetZ = "Spawn Offset Z",
    AutoFacePlayer = "Auto Face Player",
    BossHealthOverride = "Boss Health Override",
    OWBotEncounter = "OW Bot Encounter",
    OWEncounterPool = "OW Encounter Pool",
    EncounterMode = "Encounter Mode",
    EncounterCategory = "Encounter Category",
    EnemyConfig = "Enemy Config",
    MaxHP = "Max HP",
    StartingHP = "Starting HP",
    OWScale = "OW Scale",
    BattleScale = "Battle Scale",
    LegacyBossEncounter = "Boss Encounter",
    DarkHoleLiberationEncounters = "Liberation Encounters",
    MinionHealthOverride = "Minion Health Override",
    Scale = "scale",
    SpawnEnabled = "Spawn Enabled",
    BossDisplayName = "Boss Display Name",
    Shared = "Shared",
    Spawns = "Spawns",
    Direction = "Direction",
    GateKey = "Gate Key",
    GateID = "Gate ID",
    isBoss = "isBoss",
    Message = "Message",
    EncounterPath = "Encounter Path",
    SpecificLoot = "Specific Loot",
    DamageTrap = "Damage Trap",
    StunTrap = "Stun Trap",
    TrapMessage = "Trap Message",
    DamageDealt = "Damage Dealt",
    Money = "Money",
    NextSpawn = "Next Spawn",
    FacingDirection = "Facing Direction",
    GateToRemove = "Gate To Remove",
    LiberationMapName = "Liberation Map Name",
}

-- Panel types and their GID ranges (filled at runtime)
Constants.PanelTypes = {
    DarkPanel = "Dark Panel",
    DarkHole = "Dark Hole",
    DarkHoleBuffedVirus = "Dark Hole Buffed Virus",
    IndestructiblePanel = "Indestructible Panel",
    ItemPanel = "Item Panel",
    PanelGate = "Panel Gate",
    BonusPanel = "Bonus Panel",
    TrapPanel = "Trap Panel",
}

-- Panel types that can be liberated
Constants.LiberatablePanelTypes = {
    Constants.PanelTypes.DarkPanel,
    Constants.PanelTypes.ItemPanel,
    Constants.PanelTypes.DarkHole,
    Constants.PanelTypes.BonusPanel,
    Constants.PanelTypes.TrapPanel,
}

-- Panel types that are walkable (for enemy movement)
Constants.WalkablePanelTypes = {
    Constants.PanelTypes.DarkPanel,
    Constants.PanelTypes.ItemPanel,
    Constants.PanelTypes.TrapPanel,
}

-- Panel types that trigger shadowstep invisibility
Constants.ShadowstepPanelTypes = {
    Constants.PanelTypes.DarkPanel,
    Constants.PanelTypes.ItemPanel,
    Constants.PanelTypes.TrapPanel,
}

-- Loot animation names (used in maps)
Constants.LootAnimations = {
    Heart = "HEART",
    Chip = "CHIP",
    Money = "MONEY",
    BugFrag = "BUGFRAG",
    OrderPoint = "ORDER_POINT",
    Invincibility = "INVINCIBILITY",
    MajorHit = "MAJOR_HIT",
    Key = "KEY",
}

-- Ability internal names (matching item IDs)
Constants.AbilityIDs = {
    LongSwrd = "LongSwrd",
    WideSwrd = "WideSwrd",
    OldSaber = "OldSaber",
    HevyShld = "HevyShld",
    HexScyth = "HexScyth",
    NumGadgt = "NumGadgt",
    GutsHamr = "GutsHamr",
    ShdwShoe = "ShdwShoe",
}

-- Asset paths for preloading
Constants.PreloadAssets = {
    -- Shared THICK font remains available for other mission UI consumers.
    "/server/assets/net-games/fonts/separated/fonts_thick.png",
    "/server/assets/net-games/fonts/separated/fonts_thick.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/ui/options-ui.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/ui/options-ui.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/attack indicator.tsx",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/tiles/selected tile.tsx",

    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/blur.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/blur.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/explosion.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/explosion.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/paralyze.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/paralyze.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/recover.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/effects/recover.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/item.png",
    "/server/assets/ezlibs-custom/nebulous-liberations/bots/item.animation",
    "/server/assets/ezlibs-custom/nebulous-liberations/sound effects/hurt.ogg",
    "/server/assets/ezlibs-custom/nebulous-liberations/sound effects/explode.ogg",
    "/server/assets/ezlibs-custom/nebulous-liberations/sound effects/paralyze.ogg",
    "/server/assets/ezlibs-custom/nebulous-liberations/sound effects/recover.ogg",
    "/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.animation",
    "/server/assets/net-games/meters/liberation-order-points/points-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/points-3slice.animation",
    "/server/assets/net-games/meters/liberation-order-points/point-total-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/point-total-3slice.animation",
}

-- HP world bots need only one numeral each, not the full 64x128 THICK atlas.
-- These 6x10 images are pixel-exact crops of the THICK frames and retain
-- matching THICK_0 .. THICK_9 animation state names.
local HP_DIGIT_ASSET_ROOT = "/server/assets/net-games/fonts/separated/hp-digits/"
for digit = 0, 9 do
    local base = HP_DIGIT_ASSET_ROOT .. "fonts_thick_digit_" .. tostring(digit)
    Constants.PreloadAssets[#Constants.PreloadAssets + 1] = base .. ".png"
    Constants.PreloadAssets[#Constants.PreloadAssets + 1] = base .. ".animation"
end

return Constants
