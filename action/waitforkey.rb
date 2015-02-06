# encoding: utf-8

load 'action.rb'

module Act
	# Single action to wait for a key and proceed.
	class WaitForKey < Action
		# @return [Integer] Gosu key.
		attr_accessor :key
		# @return [Gamebox] Main Gamebox.
		attr_accessor :handle

		# param [Gamebox] handle Main Gamebox.
		# param [Integer] key Gosu key.
		def initialize(handle ,key)
			super nil
			@handle = handle
			@key = key
		end

		# Check if is pressing, then finish.
		# @return [void]
		def update
			super
			finish if @handle.button_down? @key
		end
	end
end
