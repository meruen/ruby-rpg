# encoding: utf-8

require 'gosu'
load 'character.rb'
load 'action/message.rb'
load 'action_manager.rb'

class Event < Character
	attr_accessor :z, :action_manager
	attr_reader :activated

	def initialize(handle, filename, hblock = 4, x = 0, y = 0, speed = 2, visible = true)
		super handle, filename, hblock, x, y, speed, visible, false	
		@z = 0
		@action_manager = ActionManager.new @handle
		@activated = false
	end

	def on_touch(direction)
						
	end

	def on_press(direction, look = true)
		if !@activated
			@activated = true
			@action_manager.restart
		end
		case direction
			when Direction::TOP
				@direction = Direction::BOT
			when Direction::BOT
				@direction = Direction::TOP
			when Direction::LEF
				@direction = Direction::RIG
			when Direction::RIG
				@direction = Direction::LEF
			else
				puts "[ERROR] Unknown direction #{direction}"
		end if look
	end

	def set_action(action_manager)
		@action_manager = action_manager
		@action_manager.current_action_index = 0
	end

	def update
		super
		@activated = false if @action_manager.current_action == nil
		@action_manager.update if @activated		
	end

	def draw
		super @z
		#@actions[@actual_action].draw(@handle.map.camera) if @actions[@actual_action] != nil && @activated
		@action_manager.draw @handle.map.camera if @activated
		
	end
end
