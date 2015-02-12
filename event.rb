# encoding: utf-8

require 'gosu'
load 'character.rb'
load 'action/message.rb'
load 'action_manager.rb'

# General class to build humanoid events. Events can have to ways to be activated. Pressing a key or touching.
class Event < Character
	# @return [Integer] Z order.
	attr_accessor :z
	# @return [ActionManager] ActionManager with a list of actions to execute when the event be activated.
	attr_accessor :action_manager
	# @return [true/false] True if the event is actually activated.
	attr_reader :activated

	# @param [Gamebox] handle Main Gamebox.
	# @param [String] filename Path to humanoid sprite.
	# @param [Integer] hblock Horizontal block of count of sprite.
	# @param [Integer] x X coordinate of Event.
	# @param [Integer] y Y coordinate of Event.
	# @param [Integer] speed Movement speed.
	# @param [true/false] visible Visibility of Event.	
	def initialize(handle, filename, hblock = 4, x = 0, y = 0, speed = 2, visible = true)
		super handle, filename, hblock, x, y, speed, visible, false	
		@z = 0
		@action_manager = ActionManager.new @handle
		@activated = false
	end

	# @!group Callbacks
	# Callback to execute when Character collide with an Event.
	# @param [Direction] direction Direction that Character have when touch.
	# @return [void]
	def on_touch(direction)
						
	end

	# Callback to execute when Character is colliding and press the action key.
	# @param [Direction] character Character pressing.
	# @param [true/false] look True if the Event must look to Character when act.
	# @return [void]
	def on_press(character, look = true)
		@character = character
		direction = character.direction
		if !@activated
			@activated = true
			@action_manager.restart
			character.sensitive = false
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
	# @!endgroup

	# Set the ActionManager. Use to change the actions that will be executed when Event is activated.
	# @param [ActionManager] action_manager ActionManager.
	# @return [void]
	def set_action(action_manager)
		@action_manager = action_manager
		@action_manager.current_action_index = 0
	end

	# Update the current action and check if Event is still activated.
	# @return [void]
	def update
		super
		if @action_manager.current_action == nil
			@activated = false
			@character.sensitive = true
			@action_manager.restart
		end
		@action_manager.update if @activated		
	end

	# Draw the current action if is activated and the graphics of Event.
	# @return [void]
	def draw
		super @z
		@action_manager.draw @handle.map.camera if @activated and !@action_manager.finished
	end
end
