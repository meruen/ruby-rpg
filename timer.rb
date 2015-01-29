# encoding: utf-8

require 'gosu'

class Timer
	attr_accessor :is_loop, :interval

	def initialize(interval, is_loop = true, quick_start = true)
		@interval = interval
		@is_loop = is_loop
		start if quick_start	
	end

	def start
		@milliseconds_before = Gosu::milliseconds
	end

	def reached?
		if Gosu::milliseconds - @milliseconds_before >= @interval
			@milliseconds_before = Gosu::milliseconds
			return true
		end
		return false
	end
end
