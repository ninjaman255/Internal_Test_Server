-- constants.lua
-- Centralised definitions for custom properties and constants used in liberations.

local Constants = {}

-- Map custom property keys
Constants.CustomProperties = {
    RespawnArea = "Respawn Area",
    WaitingArea = "Waiting Area",
    LiberationMapFileName = "Liberation Map File Name",
    LiberationTileset = "Liberation Tileset",
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
    HonorHPMem = "Honor HPMem",
    Compress = "Compress",
    Decompress = "Decompress",
    Boss = "Boss",
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
    GateToRemove = "Gate To Remove",
    LiberationMapName = "Liberation Map Name",
}

-- Panel types and their GID ranges (filled at runtime)
Constants.PanelTypes = {
    DarkPanel = "Dark Panel",
    DarkHole = "Dark Hole",
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
    "/server/assets/NebuLibsAssets/bots/blur.png",
    "/server/assets/NebuLibsAssets/bots/blur.animation",
    "/server/assets/NebuLibsAssets/bots/explosion.png",
    "/server/assets/NebuLibsAssets/bots/explosion.animation",
    "/server/assets/NebuLibsAssets/bots/paralyze.png",
    "/server/assets/NebuLibsAssets/bots/paralyze.animation",
    "/server/assets/NebuLibsAssets/bots/recover.png",
    "/server/assets/NebuLibsAssets/bots/recover.animation",
    "/server/assets/NebuLibsAssets/bots/item.png",
    "/server/assets/NebuLibsAssets/bots/item.animation",
    "/server/assets/NebuLibsAssets/sound effects/hurt.ogg",
    "/server/assets/NebuLibsAssets/sound effects/explode.ogg",
    "/server/assets/NebuLibsAssets/sound effects/paralyze.ogg",
    "/server/assets/NebuLibsAssets/sound effects/recover.ogg",
    "/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/base-guage-3slice.animation",
    "/server/assets/net-games/meters/liberation-order-points/points-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/points-3slice.animation",
    "/server/assets/net-games/meters/liberation-order-points/point-total-3slice.png",
    "/server/assets/net-games/meters/liberation-order-points/point-total-3slice.animation",
}

return Constants