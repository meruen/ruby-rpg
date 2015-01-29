# encoding: utf-8

require 'gosu'

class Codeblock < Action
	attr_accessor :block

	def initialize(handle, block)
		super handle, nil
		@block = block
	end

	def update
		@block.call
		finish
	end
end
