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
		def initialize(handle, str, actions)
			super handle, nil	
			self.finished = false
			@str = str
			@handle = handle
			@action_manager = ActionManager.new @handle, actions
			@action_manager.restart
			@evalued = false
		end

		# Prepare the condition for check and execution.
		# @return [void]
		def prepare
			self.finished = false
			@evalued = false
			@action_manager.restart
		end

		# Update the actual action if the condition is satisfied and is executing.
		# @return [void]
		def update
			@evalued = true if eval(@str)
			@action_manager.update if @evalued
			finish if !@evalued || @action_manager.finished
		end

		# Finish the internal ActionManager.
		# @return [void]
		def finish
			super
			@action_manager.restart
			@evalued = false
		end

		# Draw any content that the current action of action manager contains.
		# @param [Camera] camera Main Camera of your project.
		# @return [void]
		def draw(camera)
			@action_manager.draw(camera) if @evalued
		end
	end
end
