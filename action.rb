# encoding: utf-8

require 'gosu'

# Action class is a single drawable component that is handled by ActionManager.
class Action < GameObject
	# @return [true/false] true if the action is actually finished.
	attr_accessor :finished
	# @return [Proc] function that will be executed before the initialization of action.
	attr_accessor :ini_func
	# @return [Proc] function that will be executed before the update of action.
	attr_accessor :upd_func
	# @return [Proc] function that will be executed before the draw of action.
	attr_accessor :drw_func

	# @param [Gamebox] handle Main Gamebox class.
	# @param [Proc] ini_func function that will be executed before the initialization of action.
	# @param [Proc] upd_func function that will be executed before the update method of action.
	# @param [Proc] drw_func function that will be executed before the draw method of action.
	def initialize(handle, ini_func = nil, upd_func = nil, drw_func = nil)
		super handle
		@finished = false
		@upd_func = upd_func
		@drw_func = drw_func
		@ini_func = ini_func
		ini_func if ini_func != nil
	end

	# This function serves only to be overrided. Always is called before the execution of the action.
	# @return [void]	
	def prepare

	end

	# Update method.
	# @return [void]
	def update
		upd_func if upd_func != nil
	end

	# Draw method.
	# @param [Camera] camera Main camera.
	# @return [void]
	def draw(camera)
		drw_func if drw_func != nil
	end

	# Call method finish if the action is terminated.
	# @return [void]
	def finish
		@finished = true
	end
end
