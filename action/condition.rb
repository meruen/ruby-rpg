# encoding: utf-8

load 'action_manager.rb'

class Condition < Action
	attr_accessor :str, :evalued, :action_manager
	
	def initialize(handle, str, actions)
		super handle, nil	
		self.finished = false
		@str = str
		@handle = handle
		@action_manager = ActionManager.new @handle, actions
		@action_manager.restart
		@evalued = false
	end

	def prepare
		self.finished = false
		@evalued = false
		@action_manager.restart
	end

	def update
		@evalued = true if eval(@str)
		@action_manager.update if @evalued
		finish if !@evalued || @action_manager.finished
	end

	def finish
		super
		@action_manager.restart
		@evalued = false
	end

	def draw(camera)
		@action_manager.draw(camera) if @evalued
	end
end
