# encoding: utf-8
# character.rb

require 'gosu'
load 'mod/Direction.rb'
load 'mod/State.rb'

class Character
	attr_accessor :x, :y, :speed, :block_x, :block_y, :visible
	attr_reader :img
	attr_accessor :sensitive, :direction, :state

	VBLOCK ||= 4
	BLOCK_SIZE ||= 32

	def initialize(handle, filename, hblock = 4, x = 0, y = 0, speed = 2, visible = true, sensitive = true)
		@energy = 400
		@speed = speed
		@sensitive = sensitive
		@state = State::IDLE
		@direction = Direction::BOT
		@hblock = hblock
		@handle = handle
		@filename = filename
		@anim = Hash.new
		@keys = Hash.new
		@visible = visible
		set_img filename, hblock
		set_position x, y
	end

	def set_img(filename, hblock)
		@img = Gosu::Image.new @handle, filename, false
		@m_anim = Gosu::Image.load_tiles @handle, filename, @img.width / hblock, @img.height / VBLOCK, true
		
		@anim[State::MOV] = Hash.new
		@anim[State::MOV][Direction::BOT] = @m_anim[0, hblock]
		@anim[State::MOV][Direction::LEF] = @m_anim[hblock, hblock]
		@anim[State::MOV][Direction::RIG] = @m_anim[hblock * 2, hblock]
		@anim[State::MOV][Direction::TOP] = @m_anim[hblock * 3, hblock]
		@anim[State::IDLE] = Hash.new
		@anim[State::IDLE][Direction::BOT] = @m_anim[0]
		@anim[State::IDLE][Direction::LEF] = @m_anim[hblock]
		@anim[State::IDLE][Direction::RIG] = @m_anim[hblock * 2]
		@anim[State::IDLE][Direction::TOP] = @m_anim[hblock * 3]
		@quad_w = @m_anim[0].width / 2
		@quad_h = @m_anim[0].height / 2
	end

	def set_position(x, y)
		@x = x
		@y = y
	end

	def quaded?
		py = @y - @quad_w - BLOCK_SIZE
		return true if (@x % BLOCK_SIZE == 0 && @y % BLOCK_SIZE == 0)
		return false
	end

	def read_keys
		@keys[Gosu::KbLeft] = @handle.button_down? Gosu::KbLeft
		@keys[Gosu::KbRight] = @handle.button_down? Gosu::KbRight
		@keys[Gosu::KbUp] = @handle.button_down? Gosu::KbUp
		@keys[Gosu::KbDown] = @handle.button_down? Gosu::KbDown
		
		
		if @handle.button_down?(Gosu::KbZ) && @energy > 0
			@speed = 4 if quaded?
			@energy -= 1 if @speed == 4
		else
			@speed = 2
		end
	end

	def update
		
		read_keys
		if @sensitive
		case @state
			when State::IDLE
				@frame = @anim[@state][@direction]
				if @keys[Gosu::KbUp]
					@direction = Direction::TOP
					@state = State::MOV if @handle.map.can_advance? @x, @y, @direction
				elsif @keys[Gosu::KbDown]
					@direction = Direction::BOT
					@state = State::MOV if @handle.map.can_advance? @x, @y, @direction
				elsif @keys[Gosu::KbLeft]
					@direction = Direction::LEF
					@state = State::MOV if @handle.map.can_advance? @x, @y, @direction
				elsif @keys[Gosu::KbRight]
					@direction = Direction::RIG 
					@state = State::MOV if @handle.map.can_advance? @x, @y, @direction
				end
			when State::MOV
				@frame = @anim[@state][@direction][Gosu::milliseconds / 200 % @hblock]
				case @direction
					when Direction::TOP
						@y -= @speed
						@state = State::IDLE if (quaded? && !@keys[Gosu::KbUp]) || (not @handle.map.can_advance? @x, @y, @direction)
					when Direction::BOT
						@y += @speed
						@state = State::IDLE if (quaded? && !@keys[Gosu::KbDown]) || (not @handle.map.can_advance? @x, @y, @direction)
					when Direction::LEF
						@x -= @speed
						@state = State::IDLE if (quaded? && !@keys[Gosu::KbLeft]) || (not @handle.map.can_advance? @x, @y, @direction)
					when Direction::RIG		
						@x += @speed
						@state = State::IDLE if (quaded? && !@keys[Gosu::KbRight]) || (not @handle.map.can_advance? @x, @y, @direction)
					else
				end	
						
		end
		else
			case @state
				when State::IDLE
					@frame = @anim[@state][@direction]
				when State::MOV
					@frame = @anim[@state][@direction][Gosu::milliseconds / 200 % @hblock]
				else
			end
		end
	end

	def draw(z = 0)
		@frame.draw @x - @handle.map.camera.x, @y - @handle.map.camera.y - @quad_h, z if visible?
	end

	def visible?
		return @visible
	end
end
