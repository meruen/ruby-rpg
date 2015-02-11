# encoding: utf-8

load 'action_manager.rb'

module Act
	# This class serves to use conditions inside an action. By this way, you can check something before start to execute another ActionManager.
	class Condition < Action
		# @return [String] Evaluation string.
		attr_accessor :str
		# @return [true/false] True if result of evaluation is true.
		attr_accessor :evalued
		# @return [ActionManager] Action manager containing the actions that will be executed when the condition is satisfied.
		attr_accessor :action_manager
	
		# @param [Gamebox] handle Main Gamebox.
		# @param [String] str Evaluation string.
		# @param [Array] actions Array of actions that will be putted on ActionManager.
		def initialize(handle, str, actions, else_actions = nil)
			super handle, nil	
			self.finished = false
			@str = str
			@handle = handle
			@action_manager = ActionManager.new @handle, actions
			@action_manager.restart
			@evalued = false
			@else_action_manager = ActionManager.new @handle, else_actions
		end

		# Prepare the condition for check and execution.
		# @return [void]
		def prepare
			self.finished = false
			@evalued = false
			@action_manager.restart
			@else_action_manager.restart if @else_action_manager.action != nil
		end

		# Update the actual action if the condition is satisfied and is executing.
		# @return [void]
		def update
			@evalued = true if eval(@str)
			@action_manager.update if @evalued
			@else_action_manager.update if (!@evalued && @else_action_manager != nil)
			el = @else_action_manager != nil ? @else_action_manager.finished : false
			finish if @action_manager.finished || el
		end

		# Finish the internal ActionManager.
		# @return [void]
		def finish
			super
			@action_manager.restart
			@else_action_manager.restart if @else_action_manager != nil
			@evalued = false
		end

		# Draw any content that the current action of action manager contains.
		# @param [Camera] camera Main Camera of your project.
		# @return [void]
		def draw(camera)
			if @evalued then @action_manager.draw(camera) else 
				if @else_action_manager.action != nil then @else_action_manager.draw(camera) end
			end
		end
	end
end
