# encoding: utf-8

load 'action.rb'

# The ActionManager class is the way to manage a list of Actions that will be executed by an Event. Basically you need to use the method 'push' to add the actions that you want to be executed in the properly order, so the ActionManager will execute the actions one after another.
class ActionManager < Action
	# @return [Array] the main array that contais the Actions that will be executed.
	attr_accessor :action
	# @return [Action] action that are being executed right now.
	attr_accessor :current_action
	# @return [Integer] relative index of the action in the :action array.
	attr_accessor :current_action_index

	# @param [Gamebox] handle Main Gamebox.
	# @param [Array] action An array populated with instances of Actions.
	def initialize(handle, action = nil)
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

	# Gives an action from the array.
	# @param [Integer] index Index of the action on the Array. It's the same of self.action[index].
	# @return [Action] the Action located at the index.
	def get_action(index)
		return @action[index]
	end
	
	# Append a new Action at the main array of actions.
	# @param [Action] action the Action that will be placed at the end of the action array.
	# @return [void]
	def push(action)
		@action.push action
		@current_action = action if @current_action == nil && @current_action_index == 0
	end

	# Restart all the actions and unfinish the ActionManager. So you can run all the actions again and again from the beginning.
	# @return [void]
	def restart
		@action[0].prepare if @action[0] != nil
		@current_action_index = 0
		@current_action = @action[@current_action_index]
		self.finished = false
	end

	# Update the current action and check if that was finished. If was, go to the next action on array. If doesn't have more actions on array, finish the action manager.
	# @return [void]
	def update
		super
		@current_action = @action[@current_action_index]
		if @current_action != nil
			@current_action.update
			if @current_action.finished
				@current_action_index += 1
				#@action[@current_action_index - 1].prepare if @action[@current_action_index - 1] != nil
				@action[@current_action_index].prepare if @action[@current_action_index] != nil
			end	
		else
			self.finish
		end
	end

	# Call the draw method of the current_action.
	# @param [Camera] camera Main Camera of your project.
	# @return [void]
	def draw(camera)
		super camera
		@current_action.draw(camera) if @current_action != nil && !@current_action.finished
	end
end
