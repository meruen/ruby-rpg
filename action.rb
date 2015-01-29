# encoding: utf-8

require 'gosu'

class Action
	attr_accessor :finished, :handle
	attr_accessor :ini_func, :upd_func, :drw_func

	def initialize(handle, ini_func = nil, upd_func = nil, drw_func = nil)
		@handle = handle
		@finished = false
		@upd_func = upd_func
		@drw_func = drw_func
		@ini_func = ini_func
		ini_func if ini_func != nil
	end
	
	def prepare

	end

	def update
		upd_func if upd_func != nil
	end

	def draw(camera)
		drw_func if drw_func != nil
	end

	def finish
		@finished = true
	end
end
