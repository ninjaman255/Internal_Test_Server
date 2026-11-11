-- Registered overworld template. Legacy constructor module remains for compatibility.
return function(EnemyTemplates)
EnemyTemplates.register("BlizzardMan", {
    battle_name = "BlizzardMan",
    health = 400,
    max_health = 400,
    texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/blizzardman.png",
    animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/blizzardman.animation",
    shape = { {1,1,1}, {1,0,1}, {1,1,1}, {1,1,1} },
    shape_offset_x = 0,
    shape_offset_y = -2,
    attack_damage = 40,
    attack_texture = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.png",
    attack_animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.animation",
    ai_type = "simple_charge",
    is_boss = true,
    mug = {
        texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.png",
        animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.animation",
    },
    death_message = "Woosh!\nI can't believe\nit. I can't lose.\nNOOOO!",
    preload_assets = { "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.png", "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.animation" },
})
end
