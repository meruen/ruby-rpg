# encoding: utf-8

load 'action.rb'

class ActionManager < Action
	attr_accessor :action, :current_action, :current_action_index

	def initialize(handle, action = nil, _ = nil)
		super handle, nil
		self.handle = handle
		if action != nil
			@action = action
		else
			@action = Array.new
		end
		@current_action_index = 0
		@current_action = @action[0]
	end

	def get_action(index)
		return @action[index]
	end

	def push(action)
		@action.push action
		@current_action = action if @current_action == nil && @current_action_index == 0
	end

	def restart
		@current_action_index = 0
		@current_action = @action[@current_action_index]
		self.finished = false
	end

	def update
		super
		@current_action = @action[@current_action_index]
		if @current_action != nil
			@current_action.update
			if @current_action.finished
				@current_action_index += 1
				@action[@current_action_index - 1].prepare if @action[@current_action_index - 1] != nil
			end
			
		else
			self.finish
		end
	end

	def draw(camera)
		super camera
		@current_action.draw(camera) if @current_action != nil
	end
end
