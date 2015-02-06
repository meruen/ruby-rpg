# encoding: utf-8

load 'action.rb'
load 'timer.rb'
load 'mod/ctime.rb'

module Act
	# Action that wait some time and then finish.
	class Wait < Action
		# @return [Integer] Time to wait (in milliseconds)
		attr_accessor :interval

		# @param [Gamebox] handle Main Gamebox.
		# @param [Integer] interval Time to wait (in milliseconds)
		def initialize(handle, interval)
			super handle, nil
			@interval = interval
			@timer = Timer.new interval
			prepare
		end

		# Check if the time has passed, and finish.
		# @return [void]
		def update
			super
			finish if @timer.reached?	
		end
	end
end
