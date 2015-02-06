# encoding: utf-8

require 'gosu'

module Act
	# Codeblock it's basically a way to execute common ruby instructions inside an action.
	class Codeblock < Action
		# @return [Proc] Ruby function.
		attr_accessor :block

		# @param [Gamebox] handle Main Gamebox.
		# @param [Proc] block Ruby function.
		def initialize(handle, block)
			super handle, nil
			@block = block
		end

		# This method runs only one time by execution calling the ruby function and finish.
		# @return [void]
		def update
			@block.call
			finish
		end
	end
end
