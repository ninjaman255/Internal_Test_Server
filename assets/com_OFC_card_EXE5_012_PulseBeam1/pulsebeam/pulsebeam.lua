local print_debug = false

local AUDIO_DAMAGE_ENEMY = Engine.load_audio(_folderpath.."sfx/EXE5_18.ogg", true)
local AUDIO_DAMAGE_OBS = Engine.load_audio(_folderpath.."sfx/EXE5_136.ogg", true)

local PULSESHOT_TEXTURE = Engine.load_texture(_folderpath.."gfx/pulseshot.grayscaled.png")
local PULSESHOT_ANIMPATH = _folderpath.."gfx/pulseshot.animation"
local PULSESPREAD_TEXTURE = Engine.load_texture(_folderpath.."gfx/pulsespread.grayscaled.png") -- never flip?
local PULSESPREAD_ANIMPATH = _folderpath.."gfx/pulsespread.animation"
local PULSEBEAM_PALETTE = Engine.load_texture(_folderpath.."gfx/palette/pulsebeam.png")

local PULSESHOT_AUDIO = Engine.load_audio(_folderpath.."sfx/EXE5_89.ogg", true)
local PULSESPREAD_AUDIO = Engine.load_audio(_folderpath.."sfx/EXE5_61.ogg", true)

local function debug_print(text)
    if print_debug then
        print("[PulseBeam] "..text)
    end
end

local pulsebeam = {}

local function graphic_init(g_type, x, y, texture, animation, state, anim_playback, layer, user, facing, flip)
    flip = flip or false
    facing = facing or nil
    
    local graphic = nil
    if g_type == "artifact" then 
        graphic = Battle.Artifact.new()
    elseif g_type == "spell" then 
        graphic = Battle.Spell.new(user:get_team())
    end

    if layer then
        graphic:sprite():set_layer(layer)
    end
    graphic:never_flip(flip)
    if texture then
        graphic:set_texture(texture, false)
    end
    if facing then
        graphic:set_facing(facing)
    end
    --[[
    if user:get_facing() == Direction.Left then 
        x = x * -1
    end]]
    graphic:set_offset(x, y)
    if animation then
        graphic:get_animation():load(animation)
    end
    if state then
        graphic:get_animation():set_state(state)
    end
    graphic:get_animation():refresh(graphic:sprite())
    if anim_playback then
        graphic:get_animation():set_playback(anim_playback)
    end

    return graphic
end

local function create_pulse_spread(user, props, field, spawn_tile)
	local pulsespread = graphic_init("spell", 0, 0, false, false, false, false, false, user, user:get_facing())
    pulsespread:set_hit_props(
        HitProps.new(
            props.damage,
            Hit.Impact | Hit.Flinch | Hit.Stun,
            props.element,
            user:get_context(),
            Drag.None
        )
    )
	pulsespread.frames = 0
	pulsespread.update_func = function(self)
		spawn_tile:attack_entities(self)
		self:erase()
	end
	pulsespread.attack_func = function(self, other)
        if Battle.Obstacle.from(other) == nil then
            if Battle.Player.from(user) ~= nil then
                Engine.play_audio(AUDIO_DAMAGE_ENEMY, AudioPriority.Low)
            end
        else
            Engine.play_audio(AUDIO_DAMAGE_OBS, AudioPriority.Low)
        end
	end
	field:spawn(pulsespread, spawn_tile)
	return pulsespread
end

local function create_pulse_shot(user, props, spawn_tile)
	local pulseshot = graphic_init("spell", 0, -24*2, PULSESHOT_TEXTURE, PULSESHOT_ANIMPATH, "0", Playback.Loop, -3, user, user:get_facing())
	pulseshot:store_base_palette(PULSEBEAM_PALETTE)
	pulseshot:set_palette(pulseshot:get_base_palette())
    pulseshot:set_hit_props(
        HitProps.new(
            props.damage,
            Hit.Impact | Hit.Flinch,
            props.element,
            user:get_context(),
            Drag.None
        )
    )
	pulseshot.x_coord = pulseshot:get_offset().x
	pulseshot.y_coord = pulseshot:get_offset().y
	pulseshot.ready_to_spread = false
	pulseshot.spread_tile = nil
    local round = function(val)
        if facing == Direction.Right then
            return math.floor(val)
        else
            return math.ceil(val)
        end
    end
    local tileWidth = spawn_tile:width()/2
    local tileXspeed = round(tileWidth/2.5)
    local tileXspeed2 = round(tileWidth/20)
	local delete_self = nil
	pulseshot.on_spawn_func = function()
        Engine.play_audio(PULSESHOT_AUDIO, AudioPriority.Low)
	end
	pulseshot.update_func = function(self)
		if delete_self then
			--[[
			if self:get_tile() == self.spread_tile then
				if self.x_coord == 0 then
        			Engine.play_audio(PULSESPREAD_AUDIO, AudioPriority.Low)
					local spread_fx = graphic_init("artifact", 0, 0, PULSESPREAD_TEXTURE, PULSESPREAD_ANIMPATH, "0", Playback.Once, -3, user, user:get_facing(), true)
					spread_fx:store_base_palette(PULSEBEAM_PALETTE)
					spread_fx:set_palette(spread_fx:get_base_palette())
					spread_fx:get_animation():on_complete(function() spread_fx:erase() end)
					self:get_field():spawn(spread_fx, self.spread_tile)
					for i=0, 7 do create_pulse_spread(user, props, self:get_field(), self.spread_tile:get_tile(2^i,1)) end
				else
					if (self:get_facing() == Direction.Right and self.x_coord > 0) or (self:get_facing() == Direction.Left and self.x_coord < 0) then self:erase() end
				end
			end]]
			if type(delete_self) ~= "number" then
				delete_self = 7
			end
			if delete_self > -2 then
				delete_self = delete_self-1
				if delete_self == 0 then
        			Engine.play_audio(PULSESPREAD_AUDIO, AudioPriority.Low)
					local spread_fx = graphic_init("artifact", 0, 0, PULSESPREAD_TEXTURE, PULSESPREAD_ANIMPATH, "0", Playback.Once, -3, user, user:get_facing(), true)
					spread_fx:store_base_palette(PULSEBEAM_PALETTE)
					spread_fx:set_palette(spread_fx:get_base_palette())
					spread_fx:get_animation():on_complete(function() spread_fx:erase() end)
					self:get_field():spawn(spread_fx, self.spread_tile)
					for i=0, 7 do create_pulse_spread(user, props, self:get_field(), self.spread_tile:get_tile(2^i,1)) end
				elseif delete_self < 0 then
					self:erase()
				end
			end
		else
			self:get_tile():attack_entities(self)
		end
        if self:get_facing() == Direction.Right then
			if delete_self then
        		self.x_coord = self.x_coord + tileXspeed2
			else
        		self.x_coord = self.x_coord + tileXspeed
			end
            if round(self.x_coord) >= tileWidth then
                if self:get_tile(Direction.Right, 1) == nil then
                    self:erase()
                else
                    self:teleport(self:get_tile(Direction.Right, 1), ActionOrder.Immediate)
					self.x_coord = -(self.x_coord - tileXspeed)
                end
            end
        elseif self:get_facing() == Direction.Left then
			if delete_self then
        		self.x_coord = self.x_coord - tileXspeed2
			else
        		self.x_coord = self.x_coord - tileXspeed
			end
            if round(self.x_coord) <= -tileWidth then
                if self:get_tile(Direction.Left, 1) == nil then
                    self:erase()
                else
                    self:teleport(self:get_tile(Direction.Left, 1), ActionOrder.Immediate)
					self.x_coord = -(self.x_coord + tileXspeed)
                end
            end
        end
        self:set_offset(self.x_coord,self.y_coord)
	end
	pulseshot.collision_func = function(self, other)
        if Battle.Obstacle.from(other) ~= nil then
			self.spread_tile = other:get_tile()
			if type(delete_self) ~= "number" then
				delete_self = true
			end
        else
			self:erase()
        end
	end
	pulseshot.attack_func = function(self, other)
        if Battle.Obstacle.from(other) == nil then
            if Battle.Player.from(user) ~= nil then
                Engine.play_audio(AUDIO_DAMAGE_ENEMY, AudioPriority.Low)
            end
        else
            Engine.play_audio(AUDIO_DAMAGE_OBS, AudioPriority.Low)
        end
	end
	pulseshot.delete_func = function(self, other)
	end
	pulseshot.can_move_to_func = function(tile)
		return true
	end
	user:get_field():spawn(pulseshot, spawn_tile)
	return pulseshot
end

pulsebeam.card_create_action = function(user, props)
    debug_print("in create_card_action()!")
    local action = Battle.CardAction.new(user, "PLAYER_SHOOTING")
	action:set_lockout(make_async_lockout(0.5))
    local frame1 = {1,0.0} --(+)1 frame
    local frame2 = {2,0.033}
    local frame3 = {3,0.033}
    local frame4 = {4,0.1} --(-)1 frame
    local frame_sequence = make_frame_data({frame1, frame2, frame3, frame4})
    action:override_animation_frames(frame_sequence)
    action.execute_func = function(self, user)
        debug_print("in custom card action execute_func()!")
        user:toggle_counter(true)
        local buster = self:add_attachment("BUSTER")
        local buster_sprite = buster:sprite()
        buster_sprite:set_texture(user:get_texture(), true)
        buster_sprite:set_layer(-1)
        buster_sprite:enable_parent_shader(true)
        local buster_anim = buster:get_animation()
        buster_anim:copy_from(user:get_animation())
        buster_anim:set_state("BUSTER")
        buster_anim:refresh(buster_sprite)
		self:add_anim_action(2, function()
            local tile = user:get_tile(user:get_facing(), 1)
            create_pulse_shot(user, props, tile)
		end)
		self:add_anim_action(4, function()
			user:toggle_counter(false)
		end)
	end
	action.action_end_func = function()
        debug_print("in custom card action action_end_func()!")
		user:toggle_counter(false)
	end
    return action
end

return pulsebeam