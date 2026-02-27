local pulsebeam = include("pulsebeam/pulsebeam.lua")

local DAMAGE = 70

pulsebeam.codes = {"F","P","T"}
pulsebeam.shortname = "PlsBeam1"
pulsebeam.damage = DAMAGE
pulsebeam.time_freeze = false
pulsebeam.element = Element.None
pulsebeam.description = "Sonic atk\nsprds whn\nhits obj!"
pulsebeam.long_description = "A sonic attack ahead! Spreads around when it hits an object!"
pulsebeam.can_boost = true
pulsebeam.card_class = CardClass.Standard
pulsebeam.limit = 4
pulsebeam.mb = 14

function package_init(package) 
    package:declare_package_id("com.OFC.card.EXE5-012-PulseBeam1")
    package:set_icon_texture(Engine.load_texture(_modpath.."icon.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
	package:set_codes(pulsebeam.codes)

    local props = package:get_card_props()
    props.shortname = pulsebeam.shortname
    props.damage = pulsebeam.damage
    props.time_freeze = pulsebeam.time_freeze
    props.element = pulsebeam.element
    props.description = pulsebeam.description
    props.long_description = pulsebeam.long_description
    props.can_boost = pulsebeam.can_boost
	props.card_class = pulsebeam.card_class
	props.limit = pulsebeam.limit
end

card_create_action = pulsebeam.card_create_action