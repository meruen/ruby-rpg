# encoding: utf-8

require 'gosu'

class Key
	attr_accessor :gosukey, :gosu_last_state, :gosu_state	

	PRESS ||= 0
	RELEASE ||= 1
	PRESSING ||= 2
	RELEASED ||= 3

	def initialize(gosukey)
		@gosukey = gosukey
		@gosu_last_state = @gosu_state = false
	end

	def state
		return PRESS if @gosu_state && !@gosu_last_state
		return PRESSING if @gosu_state && @gosu_last_state
		return RELEASE if !@gosu_state && @gosu_last_state
		return RELEASED if !@gosu_state && @gosu_last_state
	end
end
