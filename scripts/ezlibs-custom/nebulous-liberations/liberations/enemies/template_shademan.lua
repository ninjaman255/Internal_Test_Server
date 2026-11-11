-- Registered overworld template. Legacy constructor module remains for compatibility.
return function(EnemyTemplates)
EnemyTemplates.register("ShadeMan", {
    battle_name = "ShadeMan",
    health = 600,
    max_health = 600,
    texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/shademan.png",
    animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/shademan.animation",
    shape = { {1} },
    shape_offset_x = 0,
    shape_offset_y = -1,
    attack_damage = 60,
    ai_type = "ranged",  -- custom AI will be implemented separately
    is_boss = true,
    mug = {
        texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.png",
        animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.animation",
    },
    death_message = "Grr! I can't\nbelieve I've been\ndisgraced again...!\nGyaaaahh!!",
    preload_assets = { "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/shademan.animation", "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/shademan.png", "/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.png","/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.animation",}
})
end
