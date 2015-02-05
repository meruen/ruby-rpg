# encoding: utf-8

require 'gosu'

# The class Timer is a class used to make more easy the time operations with libgosu. Basically you set the interval that you want and with the 'reached?' function you can know if the interval is passed.
class Timer
	# @return [true/false] interval for the timer (in milliseconds).
	attr_accessor :interval

	# @param [Integer] interval Interval for the timer (in milliseconds).
	def initialize(interval)
		@interval = interval
		@is_loop = is_loop
		start	
	end

	# Start the countdown. If is already started, go back to the beginning.
	# @return [void]
	def start
		@milliseconds_before = Gosu::milliseconds
	end

	# Main function of the Timer. Return true if the time passed reach the interval.
	# @return [true/false]
	def reached?
		if Gosu::milliseconds - @milliseconds_before >= @interval
			@milliseconds_before = Gosu::milliseconds
			return true
		end
		return false
	end
end
